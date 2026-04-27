import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:trufi_core_about/trufi_core_about.dart';
import 'package:trufi_core_fares/trufi_core_fares.dart';
import 'package:trufi_core_feedback/trufi_core_feedback.dart';
import 'package:trufi_core_home_screen/trufi_core_home_screen.dart';
import 'package:trufi_core_maps/trufi_core_maps.dart';
import 'package:trufi_core_navigation/trufi_core_navigation.dart';
import 'package:trufi_core_poi_layers/trufi_core_poi_layers.dart';
import 'package:trufi_core_routing/trufi_core_routing.dart'
    show
    RoutingEngineManager,
    IRoutingProvider,
    Otp28RoutingProvider,
    Otp15RoutingProvider,
    TrufiPlannerProvider,
    TrufiPlannerConfig;
import 'package:trufi_core_saved_places/trufi_core_saved_places.dart';
import 'package:trufi_core_search_locations/trufi_core_search_locations.dart';
import 'package:trufi_core_settings/trufi_core_settings.dart';
import 'package:trufi_core_transport_list/trufi_core_transport_list.dart';
import 'package:trufi_core_ui/trufi_core_ui.dart';
import 'package:trufi_core_utils/trufi_core_utils.dart' show OverlayManager;

// ============ CONFIGURATION ============
const _photonUrl = 'https://photon.trufi.app';
const _defaultCenter = LatLng(-16.409, -71.537); // Arequipa
const _appName = 'RutaLista AQP';
const _deepLinkScheme = 'trufiapp';
const _cityName = 'Arequipa';
const _countryName = 'Perú';
const _emailContact = 'info@trufi-association.org';
const _feedbackUrl = 'https://www.trufi-association.org/feedback/';
const _facebookUrl = 'https://facebook.com/trufiapp';
const _xTwitterUrl = 'https://x.com/trufiapp';
const _instagramUrl = 'https://instagram.com/trufiapp';

// Motores de Ruta
final List<IRoutingProvider> _routingEngines = [
  if (!kIsWeb)
    TrufiPlannerProvider(
      config: const TrufiPlannerConfig.local(
        gtfsAsset: 'assets/routing/arequipa.gtfs.zip',
      ),
    ),
];

  /*if (kIsWeb)
    TrufiPlannerProvider(
      config: const TrufiPlannerConfig.remote(
        serverUrl: 'https://planner.trufi.app',
      ),
    ),
  Otp28RoutingProvider(
    endpoint: 'https://otp281.trufi.app',
    displayName: 'OTP Arequipa High-Res',
  ),
  Otp15RoutingProvider(
    endpoint: 'https://otp150.trufi.app',
    displayName: 'OTP Standard',
  ),
];*/

// Motores de Mapa
final List<ITrufiMapEngine> _mapEngines = [
  // 1. MODO OFFLINE
  if (!kIsWeb)
    OfflineMapLibreEngine(
      engineId: 'offline_arequipa_V4',
      displayName: 'Arequipa Offline',
      displayDescription: 'Mapa local con máximo detalle',
      config: OfflineMapConfig(
        mbtilesAsset: 'assets/offline/arequipa.mbtiles',
        styleAsset: 'assets/offline/styles/osm-bright/style.json',
        spritesAssetDir: 'assets/offline/styles/osm-bright/',
        fontsAssetDir: 'assets/offline/fonts/',
        fontMapping: {
          'OpenSansRegular': 'Open Sans Regular',
          'OpenSansBold': 'Open Sans Bold',
          'OpenSansItalic': 'Open Sans Italic',
        },
        fontRanges: [
          '0-255', '256-511', '512-767', '768-1023',
          '1024-1279', '1280-1535',
        ],
      ),
    ),

  // 2. MODO ONLINE - CLARO
  const MapLibreEngine(
    engineId: 'osm_liberty',
    styleString: 'https://maps.trufi.app/styles/osm-liberty/style.json',
    displayName: 'Mapa Detallado',
    displayDescription: 'Incluye más puntos de interés',
  ),

  // 3. MODO ONLINE - OSCURO
  const MapLibreEngine(
    engineId: 'osm_dark',
    styleString: 'https://maps.trufi.app/styles/dark-matter/style.json',
    displayName: 'Modo Noche',
    displayDescription: 'Ideal para poca luz',
  ),
];

void main() {
  runTrufiApp(
    AppConfiguration(
      appName: _appName,
      deepLinkScheme: _deepLinkScheme,
      defaultLocale: const Locale('es'),
      themeConfig: const TrufiThemeConfig(),
      providers: [
        ChangeNotifierProvider(
          create: (_) => MapEngineManager(
            engines: _mapEngines,
            defaultCenter: _defaultCenter,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RoutingEngineManager(engines: _routingEngines),
        ),
        ChangeNotifierProvider(
          create: (_) => OverlayManager(
            managers: [
              OnboardingManager(
                overlayBuilder: (onComplete) => OnboardingSheet(onComplete: onComplete),
              ),
              PrivacyConsentManager(
                overlayBuilder: (onAccept, onDecline) => PrivacyConsentSheet(
                  onAccept: onAccept,
                  onDecline: onDecline,
                ),
              ),
            ],
          ),
        ),
        BlocProvider(
          create: (_) => SearchLocationsCubit(
            searchLocationService: PhotonSearchService(
              baseUrl: _photonUrl,
              biasLatitude: _defaultCenter.latitude,
              biasLongitude: _defaultCenter.longitude,
            ),
          ),
        ),
      ],
      screens: [
        HomeScreenTrufiScreen(
          config: HomeScreenConfig(
            appName: _appName,
            deepLinkScheme: _deepLinkScheme,
            poiLayersManager: POILayersManager(assetsBasePath: 'assets/pois'),
          ),
          onStartNavigation: (context, itinerary, locationService) {
            NavigationScreen.showFromItinerary(
              context,
              itinerary: itinerary,
              locationService: locationService,
              mapEngineManager: MapEngineManager.read(context),
            );
          },
          onRouteTap: (context, routeCode) {
            TransportDetailScreen.show(context, routeCode: routeCode);
          },
        ),
        SavedPlacesTrufiScreen(),
        TransportListTrufiScreen(),
        FaresTrufiScreen(
          config: FaresConfig(
            currency: 'S/.',
            lastUpdated: DateTime(2026, 4, 16),
            fares: [
              const FareInfo(
                transportType: 'Bus',
                icon: Icons.directions_bus,
                regularFare: '1.30',
                studentFare: '0.50',
              ),
            ],
          ),
        ),
        FeedbackTrufiScreen(config: FeedbackConfig(feedbackUrl: _feedbackUrl)),
        SettingsTrufiScreen(),
        AboutTrufiScreen(
          config: AboutScreenConfig(
            appName: _appName,
            cityName: _cityName,
            countryName: _countryName,
            emailContact: _emailContact,
          ),
        ),
      ],
    ),
  );
}
