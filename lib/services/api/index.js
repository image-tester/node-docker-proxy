/**
 * Start Docker Proxy
 *
 * node bin/docker-proxy.js start
 *
 * sudo DEBUG=docker.proxy DOCKER_HOSTNAME=208.52.164.213 DOCKER_PORT=16423 supervisor -w ./ -- bin/docker-proxy.js start -p 80
 *
 * @todo It may be better to wait (and verify) for Docker Daemon connection to be stablished before starting.
 *
 * @param settings
 * @param settings.port
 * @param settings.host
 * @param settings.limit
 */
require( '../../docker-proxy' ).create( function serviceHandler( error, service ) {

  var settings = service.settings;
  var app = service.app;

  settings.set({
    name: 'api',
    cluster: false
  });

  service.startServer( 16000, null, function serverReady() {
    service.log.info( 'Primary Docker Proxy web server started on %s:%s.', this.address().address, this.address().port );
  });

  app.use( service.apiMiddleware({
    version: 1.2
  }));

  app.once( 'service:ready', function() {
    service.log.info( 'API Service loaded.' );
  });

  // watchSettings();
  // startBroker();

}, module );