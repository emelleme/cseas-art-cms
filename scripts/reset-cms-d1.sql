PRAGMA defer_foreign_keys = on;
PRAGMA foreign_keys = off;

-- Shared database note:
-- cseas-db is also used by the main CurrentSeas app, so this reset only drops
-- CMS-owned tables and preserves non-CMS application tables.

DROP TABLE IF EXISTS content_taxonomies;
DROP TABLE IF EXISTS revisions;
DROP TABLE IF EXISTS media;
DROP TABLE IF EXISTS taxonomies;

DROP TABLE IF EXISTS ec_opcat_artworks;
DROP TABLE IF EXISTS ec_opcat_collections;

DROP TABLE IF EXISTS auth_challenges;
DROP TABLE IF EXISTS auth_tokens;
DROP TABLE IF EXISTS credentials;
DROP TABLE IF EXISTS oauth_accounts;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS allowed_domains;
DROP TABLE IF EXISTS audit_logs;
DROP TABLE IF EXISTS options;

DROP TABLE IF EXISTS _emdash_404_log;
DROP TABLE IF EXISTS _emdash_api_tokens;
DROP TABLE IF EXISTS _emdash_authorization_codes;
DROP TABLE IF EXISTS _emdash_bylines;
DROP TABLE IF EXISTS _emdash_collections;
DROP TABLE IF EXISTS _emdash_comments;
DROP TABLE IF EXISTS _emdash_content_bylines;
DROP TABLE IF EXISTS _emdash_cron_tasks;
DROP TABLE IF EXISTS _emdash_device_codes;
DROP TABLE IF EXISTS _emdash_fields;
DROP TABLE IF EXISTS _emdash_fts_opcat_artworks;
DROP TABLE IF EXISTS _emdash_fts_opcat_artworks_config;
DROP TABLE IF EXISTS _emdash_fts_opcat_artworks_data;
DROP TABLE IF EXISTS _emdash_fts_opcat_artworks_docsize;
DROP TABLE IF EXISTS _emdash_fts_opcat_artworks_idx;
DROP TABLE IF EXISTS _emdash_fts_opcat_collections;
DROP TABLE IF EXISTS _emdash_fts_opcat_collections_config;
DROP TABLE IF EXISTS _emdash_fts_opcat_collections_data;
DROP TABLE IF EXISTS _emdash_fts_opcat_collections_docsize;
DROP TABLE IF EXISTS _emdash_fts_opcat_collections_idx;
DROP TABLE IF EXISTS _emdash_menu_items;
DROP TABLE IF EXISTS _emdash_menus;
DROP TABLE IF EXISTS _emdash_migrations_lock;
DROP TABLE IF EXISTS _emdash_migrations;
DROP TABLE IF EXISTS _emdash_oauth_clients;
DROP TABLE IF EXISTS _emdash_oauth_tokens;
DROP TABLE IF EXISTS _emdash_rate_limits;
DROP TABLE IF EXISTS _emdash_redirects;
DROP TABLE IF EXISTS _emdash_sections;
DROP TABLE IF EXISTS _emdash_seo;
DROP TABLE IF EXISTS _emdash_taxonomy_defs;
DROP TABLE IF EXISTS _emdash_widget_areas;
DROP TABLE IF EXISTS _emdash_widgets;

DROP TABLE IF EXISTS _plugin_indexes;
DROP TABLE IF EXISTS _plugin_state;
DROP TABLE IF EXISTS _plugin_storage;

DELETE FROM sqlite_sequence
WHERE name IN (
  'content_taxonomies',
  'revisions',
  'media',
  'taxonomies',
  'ec_opcat_artworks',
  'ec_opcat_collections',
  'auth_challenges',
  'auth_tokens',
  'credentials',
  'oauth_accounts',
  'users',
  'allowed_domains',
  'audit_logs',
  'options',
  '_emdash_404_log',
  '_emdash_api_tokens',
  '_emdash_authorization_codes',
  '_emdash_bylines',
  '_emdash_collections',
  '_emdash_comments',
  '_emdash_content_bylines',
  '_emdash_cron_tasks',
  '_emdash_device_codes',
  '_emdash_fields',
  '_emdash_fts_opcat_artworks',
  '_emdash_fts_opcat_artworks_config',
  '_emdash_fts_opcat_artworks_data',
  '_emdash_fts_opcat_artworks_docsize',
  '_emdash_fts_opcat_artworks_idx',
  '_emdash_fts_opcat_collections',
  '_emdash_fts_opcat_collections_config',
  '_emdash_fts_opcat_collections_data',
  '_emdash_fts_opcat_collections_docsize',
  '_emdash_fts_opcat_collections_idx',
  '_emdash_menu_items',
  '_emdash_menus',
  '_emdash_migrations_lock',
  '_emdash_migrations',
  '_emdash_oauth_clients',
  '_emdash_oauth_tokens',
  '_emdash_rate_limits',
  '_emdash_redirects',
  '_emdash_sections',
  '_emdash_seo',
  '_emdash_taxonomy_defs',
  '_emdash_widget_areas',
  '_emdash_widgets',
  '_plugin_indexes',
  '_plugin_state',
  '_plugin_storage'
);

PRAGMA foreign_keys = on;
