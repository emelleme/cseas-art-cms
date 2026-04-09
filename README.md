# Reality Tokens CMS

Collection Management System for Reality Tokens - CAT-721 NFTs with spatial grounding.

Built with [emdash CMS](https://github.com/emdash-cms/emdash) on Cloudflare Workers.

## Overview

This CMS manages Reality Token collections and artworks for the CurrentSeas platform. Reality Tokens are a fresh take on NFTs where tokens are tied to covenants of ownership via the CAT-721 protocol on OPCAT Layer, enabling trustless management of digital twins.

## Features

- **Collection Management**: Create and manage art collections with metadata
- **Artwork Management**: Add artworks with images, 3D models, and spatial data
- **CAT-721 Integration**: Track on-chain contract addresses, token IDs, and covenant hashes
- **Spatial Grounding**: Store geo-location data for XR experiences and scavenger hunts
- **3D Model Support**: Upload and manage GLB/GLTF models for AR/VR display
- **Gaussian Splats**: Support for photorealistic 3D splat rendering

## Collections Schema

### opcat_collections
| Field | Type | Description |
|-------|------|-------------|
| name | string | Collection name |
| slug | string | URL-friendly identifier |
| subtitle | string | Collection subtitle |
| description | portableText | Rich text description |
| theme_gradient | string | CSS gradient for theming |
| featured_model | file | Main 3D model (GLB) |
| opcat_contract | string | CAT-721 contract address |
| minter_type | select | "open" or "closed" minter |
| covenant_preview | json | Attestation data preview |
| status | select | "draft", "live", "archived" |

### opcat_artworks
| Field | Type | Description |
|-------|------|-------------|
| title | string | Artwork title |
| slug | string | URL-friendly identifier |
| collection | relation | Parent collection |
| featured_image | image | Main artwork image |
| model_3d | file | Individual 3D model |
| splat_url | url | Gaussian splat URL |
| description | portableText | Rich text description |
| cat721_token_id | string | On-chain token ID |
| cat721_txid | string | Mint transaction ID |
| covenant_hash | string | Covenant attestation hash |
| geo_location | json | { lat, lng, radius } |
| xr_settings | json | AR/VR configuration |
| fractional_holders | json | Holder distribution |
| attributes | json | NFT attributes array |
| content_type | string | MIME type |
| content_body | text | Content URI or data |
| status | select | "draft", "live", "minted" |

## Setup

### Prerequisites

- Node.js 18+
- pnpm
- Wrangler CLI (for Cloudflare Workers)

### Installation

```bash
# Install dependencies
pnpm install

# Login to Cloudflare
wrangler login

# Seed the database with initial data
wrangler d1 execute cseas-db --file=seed/seed.json
```

### Development

```bash
# Start local dev server
pnpm dev

# Build for production
pnpm build

# Deploy to Cloudflare Workers
pnpm deploy
```

### Database

The CMS uses the shared `cseas-db` D1 database (ID: `bda5f0c8-a6b3-4951-b794-0f0b59fc96a4`).

Media files are stored in the `cseas-assets` R2 bucket.

## Admin Access

The admin panel is protected with simple password authentication.

- **URL**: `https://your-cms-domain.com/admin`
- **Password**: `admin`

To change the password, edit `src/middleware/auth.ts`.

## API

The main CurrentSeas app fetches gallery data from the CMS via:

```
GET /api/gallery              - All collections
GET /api/gallery?collection=sea-sirens  - Specific collection
GET /api/gallery?collection=sea-sirens&artwork=triton  - Specific artwork
```

## CAT-721 Integration

This CMS is designed to work with the CAT-721 protocol via OPCAT Layer:

- **Open Minter**: Anyone can mint tokens from the collection
- **Closed Minter**: Only the issuer can mint tokens

Future integration with Catena wallet will enable:
- Direct minting from the gallery page
- Fractional ownership management
- Covenant-based transfer restrictions

## Architecture

```
┌─────────────────────────────────────────┐
│         Reality Tokens CMS              │
│         (Cloudflare Workers)            │
├─────────────────────────────────────────┤
│  Astro + emdash CMS                     │
│  ├── Admin UI (React)                   │
│  ├── API Routes                         │
│  └── D1 Database (cseas-db)             │
│  └── R2 Storage (cseas-assets)          │
└─────────────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────┐
│         CurrentSeas App                 │
│         (11ty + Twig + Alpine)          │
├─────────────────────────────────────────┤
│  /gallery page                          │
│  ├── Fetches from CMS API               │
│  ├── Renders 3D models                  │
│  └── CAT-721 token info                 │
└─────────────────────────────────────────┘
```

## License

MIT