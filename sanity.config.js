/* eslint-disable no-undef */
import { defineConfig } from 'sanity'
import { structureTool } from 'sanity/structure'
import { schemaTypes } from './schemaTypes/index.js'
import { structure, singletonActions, singletonNewDocument } from './structure'
import CustomLayout from './components/CustomLayout.jsx'
import clientLogo from './components/clientLogo.jsx'
import { theme } from 'https://themer.sanity.build/api/hues?default=6b7280;lightest:f9fafb;darkest:111827&primary=18a1ad;lightest:f0feff;darkest:0d4f56&transparent=f2fcfe;100;darkest:e6f7fb&positive=779e43;lightest:f7f9f2;darkest:3d4f22&caution=f59e0b;lightest:fef3c7;darkest:92400e&critical=ef4444;lightest:fef2f2;darkest:991b1b'

// NOTE: no presentationTool/Live Preview plugin here on purpose — not in
// use for client projects right now. Add it back in when that's live.

export default defineConfig({
  name: 'default',

  // ── PER-CLIENT: set these two ──────────────────────────────────────────
  title: 'CLIENT_NAME', // e.g. 'C&J Custom Rods'
  subtitle: 'Powered by Latz Web Design',
  // projectId is set automatically by `npm create sanity@latest` — leave
  // as whatever it scaffolds in as, just confirm it landed here.
  projectId: 'PROJECT_ID',
  dataset: 'production',
  // ─────────────────────────────────────────────────────────────────────

  icon: clientLogo,
  theme: theme,
  releases: {
    enabled: false,
  },
  plugins: [
    structureTool({
      title: 'Edit Content',
      structure,
    }),
  ],
  schema: {
    types: schemaTypes,
  },
  document: {
    actions: singletonActions,
    newDocumentOptions: singletonNewDocument,
  },
  studio: {
    components: {
      layout: (props) => <CustomLayout {...props} cmsGuideUrl="/static/cms-guide.pdf" />,
    },
  },
})
