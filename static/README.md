# static/

Sanity Studio serves this folder as-is. Two files belong here per project:

- `client-logo.png` — the client's logo, referenced by `components/clientLogo.jsx`
- `cms-guide.pdf` — the generic "how to edit your site" guide, referenced by
  `CustomLayout.jsx`. Same file across every client project — keep a master
  copy somewhere permanent and drop it in here each time.

Neither file is in this template repo (binary assets don't belong in a code
template). Add both after scaffolding, before your first `npm run dev`.
