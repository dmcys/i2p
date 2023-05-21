#!bin/sh
fprefs() {
# Browser Configs to isolate the connection on browser and set the preferences of security to one best navigation more secure
echo -ne -n -e 'user_pref("app.update.lastUpdateTime.addon-background-update-timer", 0);
user_pref("app.update.lastUpdateTime.background-update-timer", 0);
user_pref("app.update.lastUpdateTime.browser-cleanup-thumbnails", 1684701493);
user_pref("app.update.lastUpdateTime.search-engine-update-timer", 0);
user_pref("app.update.lastUpdateTime.services-settings-poll-changes", 0);
user_pref("app.update.lastUpdateTime.xpi-signature-verification", 0);
user_pref("browser.bookmarks.addedImportButton", true);
user_pref("browser.bookmarks.restore_default_bookmarks", false);
user_pref("browser.contentblocking.category", "standard");
user_pref("browser.download.viewableInternally.typeWasRegistered.avif", true);
user_pref("browser.download.viewableInternally.typeWasRegistered.webp", true);
user_pref("browser.laterrun.bookkeeping.profileCreationTime", 1684701462);
user_pref("browser.laterrun.bookkeeping.sessionCount", 1);
user_pref("browser.laterrun.enabled", true);
user_pref("browser.migration.version", 128);
user_pref("browser.newtabpage.storageVersion", 1);
user_pref("browser.onboarding.seen-tourset-version", 5);
user_pref("browser.onboarding.tour-type", "new");
user_pref("browser.pageActions.persistedActions", "{\"ids\":[\"bookmark\"],\"idsInUrlbar\":[\"bookmark\"],\"idsInUrlbarPreProton\":[],\"version\":1}");
user_pref("browser.pagethumbnails.storage_version", 3);
user_pref("browser.proton.toolbar.version", 3);
user_pref("browser.security_level.noscript_inited", true);
user_pref("browser.security_level.security_custom", false);
user_pref("browser.security_level.security_slider", 4);
user_pref("browser.startup.couldRestoreSession.count", 1);
user_pref("browser.startup.homepage_override.buildID", "20230702070101");
user_pref("browser.startup.homepage_override.mstone", "102.11.0");
user_pref("browser.startup.homepage_override.torbrowser.version", "12.0.6");
user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"urlbar-container\",\"torbutton-button\",\"security-level-button\",\"new-identity-button\",\"save-to-pocket-button\",\"downloads-button\",\"fxa-toolbar-menu-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"],\"PanelUI-contents\":[\"home-button\",\"edit-controls\",\"zoom-controls\",\"new-window-button\",\"save-page-button\",\"print-button\",\"bookmarks-menu-button\",\"history-panelmenu\",\"find-button\",\"preferences-button\",\"add-ons-button\",\"developer-button\"],\"addon-bar\":[\"addonbar-closebutton\",\"status-bar\"]},\"seen\":[\"developer-button\",\"_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action\"],\"dirtyAreaCache\":[\"PersonalToolbar\",\"nav-bar\",\"TabsToolbar\",\"toolbar-menubar\"],\"currentVersion\":17,\"newElementCount\":1}");
user_pref("browser.urlbar.placeholderName.private", "DuckDuckGo");
user_pref("distribution.iniFile.exists.appversion", "102.11.0");
user_pref("distribution.iniFile.exists.value", false);
user_pref("doh-rollout.doneFirstRun", true);
user_pref("doh-rollout.home-region", "US");
user_pref("dom.security.https_only_mode_ever_enabled", true);
user_pref("dom.security.https_only_mode_ever_enabled_pbm", true);
user_pref("extensions.activeThemeID", "default-theme@mozilla.org");
user_pref("extensions.blocklist.pingCountVersion", 0);
user_pref("extensions.databaseSchema", 35);
user_pref("extensions.lastAppBuildId", "20230702070101");
user_pref("extensions.lastAppVersion", "102.11.0");
user_pref("extensions.lastPlatformVersion", "102.11.0");
user_pref("extensions.lastTorBrowserVersion", "12.0.6");
user_pref("extensions.systemAddonSet", "{\"schema\":1,\"addons\":{}}");
user_pref("extensions.torbutton.cookiejar_migrated", true);
user_pref("extensions.torbutton.pref_fixup_version", 1);
user_pref("extensions.torbutton.startup", true);
user_pref("extensions.webextensions.ExtensionStorageIDB.migrated.{73a6fe31-595d-460b-a920-fcc0f8843232}", true);
user_pref("extensions.webextensions.uuids", "{\"{73a6fe31-595d-460b-a920-fcc0f8843232}\":\"2f840fc6-54b7-4cc1-9395-084c1e1165d9\",\"onboarding@mozilla.org\":\"b488d689-61fe-47ec-a63b-3445318e8ae8\",\"default-theme@mozilla.org\":\"fb818878-72e9-4a42-9ffe-058a63785ac1\",\"ddg@search.mozilla.org\":\"de1ec715-25d6-4a7f-80ee-db9dfdf4cef2\",\"youtube@search.mozilla.org\":\"02994165-66f4-40fc-93ca-9cd4390d833f\",\"google@search.mozilla.org\":\"492581a6-25c6-4be6-b185-8da994f1e0cf\",\"blockchair@search.mozilla.org\":\"1c2cb8e6-b143-41d2-9a98-81089eb95e9a\",\"ddg-onion@search.mozilla.org\":\"99236701-74e5-479e-92ee-bcb4e8395cce\",\"blockchair-onion@search.mozilla.org\":\"410f8f7e-d41c-41bb-9d1b-c341978889ce\",\"startpage@search.mozilla.org\":\"2e21bff9-819c-4a55-b0ce-3b96c4fa584e\",\"twitter@search.mozilla.org\":\"9b4c6a52-8b31-4f2e-a1b9-161f87a47ee6\",\"wikipedia@search.mozilla.org\":\"d063054c-b852-40ea-84be-449d2fc7d6b3\",\"yahoo@search.mozilla.org\":\"30838f05-4e85-4f13-9649-41f5cb5117be\"}");
user_pref("gecko.handlerService.defaultHandlersVersion", 1);
user_pref("general.config.filename", false);
user_pref("intl.language_notification.shown", true);
user_pref("media.gmp.storage.version.observed", 1);
user_pref("pdfjs.enabledCache.state", true);
user_pref("pdfjs.migrationVersion", 2);
user_pref("places.history.enabled", false);
user_pref("privacy.history.custom", true);
user_pref("privacy.sanitize.pending", "[]");
user_pref("security.sandbox.content.tempDirSuffix", "52863b0b-32b2-4d81-91af-1bf7858a43b4");
user_pref("toolkit.startup.last_success", 1684701462);
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("torbrowser.migration.version", 1);
user_pref("accessibility.force_disabled", 1);
user_pref("app.normandy.first_run", false);
user_pref("app.normandy.api_url", "");
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.optoutstudies.enabled", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.update.auto", false);
user_pref("app.update.BITS.enabled", false);
user_pref("app.update.channel", "i2pdbrowser");
user_pref("app.update.disable_button.showUpdateHistory", true);
user_pref("app.update.enabled", false);
user_pref("app.update.interval", 0);
user_pref("app.update.service.enabled", false);
user_pref("app.update.url", "");
user_pref("beacon.enabled", false);
user_pref("breakpad.reportURL", "");
user_pref("browser.aboutHomeSnippets.updateUrl", "");
user_pref("browser.aboutwelcome.enabled", false);
user_pref("browser.cache.disk.capacity", 131072);
user_pref("browser.cache.offline.enable", false);
user_pref("browser.casting.enabled", false);
user_pref("browser.contentblocking.database.enabled", false);
user_pref("browser.contentblocking.report.lockwise.enabled", false);
user_pref("browser.contentblocking.report.monitor.enabled", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.download.manager.retention", 0);
user_pref("browser.download.useDownloadDir", false);
user_pref("browser.feeds.showFirstRunUI", false);
user_pref("browser.fixup.alternate.enabled", false);
user_pref("browser.formfill.enable", false);
user_pref("browser.formfill.expire_days", 0);
user_pref("browser.messaging-system.whatsNewPanel.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.asrouterfeed", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.newtabpage.activity-stream.default.sites", "http://i2pd.i2p/,http://333.i2p/,http://inr.i2p/,http://102chan.i2p/,http://flibusta.i2p/,http://fsoc.i2p/,http://lifebox.i2p/,http://onelon.i2p/,http://wiki.ilita.i2p/");
user_pref("browser.newtabpage.activity-stream.discoverystream.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.discoverystreamfeed", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.showSearch", true);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.newtabpage.activity-stream.topSitesRows", 2);
user_pref("browser.newtabpage.enhanced", false);
user_pref("browser.newtabpage.introShown", true);
user_pref("browser.onboarding.tour.onboarding-tour-addons.completed", true);
user_pref("browser.onboarding.tour.onboarding-tour-customize.completed", true);
user_pref("browser.onboarding.tour.onboarding-tour-default-browser.completed", true);
user_pref("browser.onboarding.tour.onboarding-tour-performance.completed", true);
user_pref("browser.onboarding.tour.onboarding-tour-private-browsing.completed", true);
user_pref("browser.onboarding.tour.onboarding-tour-screenshots.completed", true);
user_pref("browser.pagethumbnails.capturing_disabled", true);
user_pref("browser.ping-centre.telemetry", false);
user_pref("browser.places.smartBookmarksVersion", -1);
user_pref("browser.places.speculativeConnect.enabled", false);
user_pref("browser.reader.detectedFirstArticle", false);
user_pref("browser.region.network.url", "");
user_pref("browser.region.update.enabled", false);
user_pref("browser.rights.3.shown", true);
user_pref("browser.safebrowsing.appRepURL", "");
user_pref("browser.safebrowsing.blockedURIs.enabled", false);
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.gethashURL", "");
user_pref("browser.safebrowsing.keyURL", "localhost");
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.malware.reportURL", "");
user_pref("browser.safebrowsing.phishing.enabled", false);
user_pref("browser.safebrowsing.provider.google.appRepURL", "");
user_pref("browser.safebrowsing.provider.google.gethashURL", "");
user_pref("browser.safebrowsing.provider.google.lists", "");
user_pref("browser.safebrowsing.provider.google.reportURL", "");
user_pref("browser.safebrowsing.provider.google.updateURL", "");
user_pref("browser.safebrowsing.provider.mozilla.gethashURL", "");
user_pref("browser.safebrowsing.provider.mozilla.lists", "");
user_pref("browser.safebrowsing.provider.mozilla.updateURL", "");
user_pref("browser.safebrowsing.reportErrorURL", "");
user_pref("browser.safebrowsing.reportGenericURL", "");
user_pref("browser.safebrowsing.reportMalwareErrorURL", "");
user_pref("browser.safebrowsing.reportMalwareURL", "");
user_pref("browser.safebrowsing.reportPhishURL", "");
user_pref("browser.safebrowsing.reportURL", "");
user_pref("browser.safebrowsing.updateURL", "");
user_pref("browser.safebrowsing.warning.infoURL", "");
user_pref("browser.search.countryCode", "US");
user_pref("browser.search.defaultenginename", "YaCy 'legwork'");
user_pref("browser.search.defaultenginename.US", "YaCy 'legwork'");
user_pref("browser.search.geoSpecificDefaults", false);
user_pref("browser.search.geoSpecificDefaults.url", "");
user_pref("browser.search.geoip.url", "");
user_pref("browser.search.official", false);
user_pref("browser.search.order.1", "YaCy 'legwork'");
user_pref("browser.search.order.2", "");
user_pref("browser.search.order.3", "");
user_pref("browser.search.order.US.1", "YaCy 'legwork'");
user_pref("browser.search.order.US.2", "");
user_pref("browser.search.order.US.3", "");
user_pref("browser.search.redirectWindowsSearch", false);
user_pref("browser.search.region", "US");
user_pref("browser.search.searchEnginesURL", "");
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.search.update", false);
user_pref("browser.send_pings", false);
user_pref("browser.send_pings.require_same_host", true);
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.startup.homepage", "http://i2pd.i2p/");
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("browser.tabs.closeWindowWithLastTab", false);
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.translation.engine", "");
user_pref("browser.uitour.enabled", false);
user_pref("browser.urlbar.dnsResolveSingleWordsAfterSearch", 0);
user_pref("browser.urlbar.formatting.enabled", false);
user_pref("browser.urlbar.maxRichResults", 12);
user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.trimURLs", false);
user_pref("browser.usedOnWindows10", false);
user_pref("browser.usedOnWindows10.introURL", "");
user_pref("camera.control.face_detection.enabled", false);
user_pref("canvas.capturestream.enabled", false);
user_pref("captivedetect.canonicalURL", "");
user_pref("clipboard.autocopy", false);
user_pref("datareporting.healthreport.about.reportUrl", "");
user_pref("datareporting.healthreport.about.reportUrlUnified", "");
user_pref("datareporting.healthreport.documentServerURI", "");
user_pref("datareporting.healthreport.pendingDeleteRemoteData", true);
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.healthreport.service.firstRun", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.policy.firstRunTime", "0");
user_pref("datareporting.sessions.current.clean", true);
user_pref("device.sensors.enabled", false);
user_pref("devtools.chrome.enabled", false);
user_pref("devtools.debugger.force-local", true);
user_pref("devtools.debugger.remote-enabled", false);
user_pref("devtools.webide.autoinstallADBHelper", false);
user_pref("devtools.webide.autoinstallFxdtAdapters", false);
user_pref("devtools.webide.enabled", false);
user_pref("devtools.whatsnew.enabled", false);
user_pref("devtools.whatsnew.feature-enabled", false);
user_pref("dom.allow_cut_copy", false);
user_pref("dom.archivereader.enabled", false);
user_pref("dom.battery.enabled", false);
user_pref("dom.enable_performance", false);
user_pref("dom.enable_user_timing", false);
user_pref("dom.event.clipboardevents.enabled", false);
user_pref("dom.flyweb.enabled", false);
user_pref("dom.gamepad.enabled", false);
user_pref("dom.ipc.plugins.flash.subprocess.crashreporter.enabled", false);
user_pref("dom.ipc.plugins.reportCrashURL", false);
user_pref("dom.maxHardwareConcurrency", 2);
user_pref("dom.mozTCPSocket.enabled", false);
user_pref("dom.netinfo.enabled", false);
user_pref("dom.network.enabled", false);
user_pref("dom.push.enabled", false);
user_pref("dom.telephony.enabled", false);
user_pref("dom.vibrator.enabled", false);
user_pref("dom.vr.enabled", false);
user_pref("dom.webaudio.enabled", false);
user_pref("dom.webnotifications.enabled", false);
user_pref("dom.workers.enabled", false);
user_pref("experiments.enabled", false);
user_pref("experiments.manifest.uri", "");
user_pref("experiments.supported", false);
user_pref("extensions.abuseReport.enabled", false);
user_pref("extensions.autoDisableScopes", 0);
user_pref("extensions.blocklist.enabled", false);
user_pref("extensions.blocklist.url", "");
user_pref("extensions.getAddons.cache.enabled", false);
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("extensions.lazarus.showDonateNotification", false);
user_pref("extensions.pocket.enabled", false);
user_pref("extensions.screenshots.upload-disabled", true);
user_pref("extensions.shownSelectionUI", true);
user_pref("extensions.systemAddon.update.enabled", false);
user_pref("extensions.systemAddon.update.url", "");
user_pref("extensions.ui.lastCategory", "addons://list/extension");
user_pref("extensions.update.autoUpdateDefault", false);
user_pref("extensions.update.enabled", false);
user_pref("full-screen-api.approval-required", false);
user_pref("full-screen-api.warning.timeout", 0);
user_pref("general.buildID.override", "20100101");
user_pref("general.platform.override", "Win32");
user_pref("general.useragent.locale", "en-US");
user_pref("general.useragent.override", "Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101 Firefox/78.0");
user_pref("general.warnOnAboutConfig", false);
user_pref("geo.enabled", false);
user_pref("geo.wifi.logging.enabled", false);
user_pref("geo.wifi.uri", "");
user_pref("identity.fxaccounts.commands.enabled", false);
user_pref("identity.fxaccounts.enabled", false);
user_pref("intl.locale.matchOS", true);
user_pref("javascript.use_us_english_locale", true);
user_pref("keyword.enabled", false);
user_pref("lightweightThemes.update.enabled", false);
user_pref("loop.logDomains", false);
user_pref("marionette.enabled", false);
user_pref("media.eme.enabled", false);
user_pref("media.getusermedia.audiocapture.enabled", false);
user_pref("media.getusermedia.screensharing.enabled", false);
user_pref("media.gmp-eme-adobe.enabled", false);
user_pref("media.gmp-gmpopenh264.enabled", false);
user_pref("media.gmp-gmpopenh264.provider.enabled", false);
user_pref("media.gmp-manager.cert.checkAttributes", false);
user_pref("media.gmp-manager.url", "");
user_pref("media.navigator.enabled", false);
user_pref("media.navigator.video.enabled", false);
user_pref("media.peerconnection.enabled", false);
user_pref("media.peerconnection.ice.default_address_only", true);
user_pref("media.peerconnection.ice.no_host", true);
user_pref("media.peerconnection.identity.timeout", 1);
user_pref("media.peerconnection.turn.disable", true);
user_pref("media.peerconnection.use_document_iceservers", false);
user_pref("media.video_stats.enabled", false);
user_pref("media.webspeech.recognition.enable", false);
user_pref("media.webspeech.synth.enabled", false);
user_pref("messaging-system.rsexperimentloader.enabled", false);
user_pref("network.IDN.whitelist.i2p", true);
user_pref("network.IDN_show_punycode", true);
user_pref("network.allow-experiments", false);
user_pref("network.captive-portal-service.enabled", false);
user_pref("network.connectivity-service.enabled", false);
user_pref("network.cookie.prefsMigrated", true);
user_pref("network.dns.disableIPv6", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.gio.supported-protocols", "");
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("network.jar.open-unsafe-types", false);
user_pref("network.manage-offline-status", false);
user_pref("network.negotiate-auth.allow-insecure-ntlm-v1", false);
user_pref("network.notify.changed", false);
user_pref("network.predictor.enabled", false);
user_pref("network.predictor.enable-prefetch", false);
user_pref("network.prefetch-next", false);
user_pref("network.protocol-handler.expose-all", true);
user_pref("network.protocol-handler.external-default", false);
user_pref("network.protocol-handler.warn-external-default", true);
user_pref("network.proxy.allow_bypass", false);
user_pref("network.proxy.ftp", "127.0.0.1");
user_pref("network.proxy.ftp_port", 4444);
user_pref("network.proxy.http", "127.0.0.1");
user_pref("network.proxy.http_port", 4444);
user_pref("network.proxy.no_proxies_on", "localhost, 127.0.0.1");
user_pref("network.proxy.share_proxy_settings", true);
user_pref("network.proxy.socks_remote_dns", true);
user_pref("network.proxy.ssl", "127.0.0.1");
user_pref("network.proxy.ssl_port", 4444);
user_pref("network.proxy.type", 1);
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("network.trr.mode", 5);
user_pref("pdfjs.disabled", true);
user_pref("pdfjs.enableWebGL", false);
user_pref("permissions.default.camera", 2);
user_pref("permissions.default.desktop-notification", 2);
user_pref("permissions.default.geo", 2);
user_pref("permissions.default.microphone", 2);
user_pref("plugin.default_plugin_disabled", true);
user_pref("plugin.state.java", 0);
user_pref("plugin.state.libgnome-shell-browser-plugin", 0);
user_pref("plugins.click_to_play", true);
user_pref("plugins.load_appdir_plugins", false);
user_pref("plugins.update.notifyUser", false);
user_pref("plugins.update.url", "");
user_pref("privacy.cpd.offlineApps", true);
user_pref("privacy.firstparty.isolate", true);
user_pref("privacy.resistFingerprinting", true);
user_pref("privacy.sanitize.timeSpan", 0);
user_pref("privacy.spoof_english", 2);
user_pref("privacy.trackingprotection.enabled", true);
#user_pref("privacy.userContext.enabled", true);
user_pref("reader.parse-on-load.enabled", false);
user_pref("reader.parse-on-load.force-enabled", false);
user_pref("security.insecure_field_warning.contextual.enabled", false);
user_pref("security.insecure_password.ui.enabled", false);
user_pref("security.ssl.errorReporting.enabled", false);
user_pref("security.OCSP.enabled", 0);
user_pref("services.blocklist.update_enabled", false);
user_pref("services.settings.server", "");
user_pref("services.sync.enabled", false);
user_pref("services.sync.prefs.sync.browser.download.manager.scanWhenDone", false);
user_pref("services.sync.prefs.sync.browser.safebrowsing.enabled", false);
user_pref("services.sync.prefs.sync.browser.search.update", false);
user_pref("services.sync.prefs.sync.extensions.update.enabled", false);
user_pref("signon.autofillForms", false);
user_pref("signon.management.page.breach-alerts.enabled", false);
user_pref("signon.management.page.vulnerable-passwords.enabled", false);
user_pref("signon.rememberSignons", false);
user_pref("startup.homepage_welcome_url", "http://i2pd.i2p/");
user_pref("startup.homepage_welcome_url.additional", "about:blank");
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("toolkit.coverage.opt-out", true);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.optoutSample", false);
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("toolkit.telemetry.server", "");
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.unifiedIsOptIn", true);
user_pref("toolkit.telemetry.updatePing.enabled", true);
user_pref("toolkit.winRegisterApplicationRestart", false);
user_pref("torbrowser.settings.proxy.address", 127.0.0.1);
user_pref("torbrowser.settings.proxy.port", 4444);
user_pref("torbrowser.settings.proxy.enabled", true);
user_pref("torbrowser.settings.proxy.type", 2);
user_pref("webgl.disable-extensions", true);
user_pref("webgl.disable-fail-if-major-performance-caveat", true);
user_pref("webgl.disabled", true);
user_pref("webgl.enable-debug-renderer-info", false);
user_pref("webgl.min_capability_mode", true);' > ./user.js
}

fshortcut() {
echo -ne -n -e "#!/usr/bash
[Desktop Entry]
Type=Application
Name=I2P+
GenericName=I2P
Comment=I2P+
Categories=Network;i2p;privacy;
Exec=sh -c "~/i2p/runplain.sh"
Icon=/home/liveuser/i2p/logo1.png
StartupWMClass=I2P+ Start" > ~/i2p.desktop
}

read -p "You want install it on ArchLinux? y/n " option
if [ $option == "y" ]; then
#Arch Linux Build
  sudo pacman -S jdk8-openjdk
  sudo pacman -S ant
  sudo pacman -S gettext
  sudo ant installer-linux
  java -jar *.jar
  mkdir ~/i2p && cp -r ./launchers/macosx/images/*.png ~/i2p/logo1.png
  fshortcut
  read -p "You want install and configure one browser to run this i2p? y/n " option
      if [ $option == "y" ]; then
			read -p "You want install the Tor-Browser configured to I2P or Default firefox? y/n " option
				if [ $option == "y" ]; then
					  latest_version=$(curl -s https://dist.torproject.org/torbrowser/ | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | sort -V | tail -n 1)
					  wget https://dist.torproject.org/torbrowser/${latest_version}/tor-browser-linux64-${latest_version}\_ALL.tar.xz
					  tar -xf *.tar.xz
			          fprefs && sudo cp -r ./user.js ./tor-browser/Browser/TorBrowser/Data/Browser/profile.default/user.js
  			    else
				      fprefs && sudo cp -r ./user.js ~/.mozilla/firefox/*.default-release/user.js && sudo cp -r ./user.js ~/.mozilla/firefox/*.default/user.js
				fi
      else
	   echo "Skipping Browser installation..";
	  fi
else
  echo "Exiting..";
fi
