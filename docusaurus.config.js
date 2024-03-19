// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require("prism-react-renderer").themes.github;
const darkCodeTheme = require("prism-react-renderer").themes.dracula;

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: "NeonFORGE Documentation",
  tagline: "Kubernetes for the rest of us!",
  url: "https://docs.neonforge.com",
    baseUrl: "/",

  onBrokenLinks: "throw",
  onBrokenMarkdownLinks: "warn",
  favicon: "img/favicon.png",

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: "nforgeio-docs", // Usually your GitHub org/user name.
  projectName: "nforgeio-docs.github.io", // Usually your repo name.
  deploymentBranch: "master",

  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang. For example, if your site is Chinese, you may want
  // to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: "en",
    locales: ["en"],
  },

  presets: [
    [
      "classic",
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve("./sidebars.js"),
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl: "https://github.com/nforgeio/documentation/edit/master/",
        },
        theme: {
          customCss: require.resolve("./src/css/custom.css"),
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      metadata: [
        {
          name: "keywords",
          content:
            "neon, neonforge, neonkube, neondesktop, neon-cli, kubernetes, documentation",
        },
      ],
          docs: {
            sidebar: {
              hideable: true,
          },
        },
        algolia: {
        // The application ID provided by Algolia
        appId: "RYA07XNW6G",

        // Public API key: it is safe to commit it
        apiKey: "2bbb75bbc651f3321c92bb8f239f88af",

        indexName: "neonforge",

        // Optional: see doc section below
        contextualSearch: true,

        // Optional: Specify domains where the navigation should occur through window.location instead on history.push. Useful when our Algolia config crawls multiple documentation sites and we want to navigate with window.location.href to them.
        // externalUrlRegex: 'external\\.com|domain\\.com',

        // Optional: Replace parts of the item URLs from Algolia. Useful when using the same search index for multiple deployments using a different baseUrl. You can use regexp or string in the `from` param. For example: localhost:3000 vs myCompany.com/docs
        // replaceSearchResultPathname: {
        //   from: '/docs/', // or as RegExp: /\/docs\//
        //   to: '/',
        // },

        // Optional: Algolia search parameters
        searchParameters: {},

        // Optional: path for search page that enabled by default (`false` to disable it)
        searchPagePath: "search",

        //... other Algolia params
      },
      colorMode: {
        defaultMode: "dark",
        disableSwitch: true,
        respectPrefersColorScheme: true,
      },
      navbar: {
        title: "NeonFORGE",
        logo: {
          alt: "NeonKUBE Logo",
          src: "img/favicon.png",
        },
        items: [
          {
            to: "/docs/neonkube",
            label: "NeonKUBE",
            position: "left",
          },
          {
            to: "/docs/neonsdk",
            label: "NeonSDK",
            position: "left",
          },
          {
            to: "/docs/operator-sdk",
            label: "OperatorSDK",
            position: "left",
          },
          {
            href: "https://github.com/nforgeio",
            position: "right",
            html: '<svg class="github_icon_header" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" width="30" height="30"><path d="M8 0c4.42 0 8 3.58 8 8a8.013 8.013 0 0 1-5.45 7.59c-.4.08-.55-.17-.55-.38 0-.27.01-1.13.01-2.2 0-.75-.25-1.23-.54-1.48 1.78-.2 3.65-.88 3.65-3.95 0-.88-.31-1.59-.82-2.15.08-.2.36-1.02-.08-2.12 0 0-.67-.22-2.2.82-.64-.18-1.32-.27-2-.27-.68 0-1.36.09-2 .27-1.53-1.03-2.2-.82-2.2-.82-.44 1.1-.16 1.92-.08 2.12-.51.56-.82 1.28-.82 2.15 0 3.06 1.86 3.75 3.64 3.95-.23.2-.44.55-.51 1.07-.46.21-1.61.55-2.33-.66-.15-.24-.6-.83-1.23-.82-.67.01-.27.38.01.53.34.19.73.9.82 1.13.16.45.68 1.31 2.69.94 0 .67.01 1.3.01 1.49 0 .21-.15.45-.55.38A7.995 7.995 0 0 1 0 8c0-4.42 3.58-8 8-8Z"></path></svg>',
          },
        ],
      },
      footer: {
        style: "dark",
        links: [
          {
            title: "Docs",
            items: [
              {
                label: "Getting Started",
                to: "/docs/neonkube",
              },
            ],
          },
          {
            title: "Community",
            items: [
              {
                label: "GitHub",
                href: "https://github.com/orgs/nforgeio",
              },
              {
                label: "Slack",
                href: "https://communityinviter.com/apps/neonforge/neonforge",
              },
              {
                label: "Linkedin",
                href: "https://www.linkedin.com/company/neonforge",
              },
            ],
          },
          {
            title: "More",
            items: [
              {
                label: "NeonKUBE",
                href: "https://neonkube.io/",
              },
            ],
          },
        ],
        copyright: `Copyright © 2005-${new Date().getFullYear()} NeonFORGE LLC.`,
      },
      prism: {
        theme: lightCodeTheme,
        darkTheme: darkCodeTheme,
        defaultLanguage: "csharp",
        additionalLanguages: [
          "powershell",
          "csharp",
          "aspnet",
          "markup",
          "cshtml",
          "docker",
          "json",
          "promql",
          "regex",
          "bash",
          "shell-session",
          "yaml",
        ],
      },
      mermaid: {
        theme: { light: "neutral", dark: "dark" },
      },
    }),
  plugins: [
    async function tailwind(context, options) {
      return {
        name: "docusaurus-tailwindcss",
        configurePostCss(postcssOptions) {
          // Appends TailwindCSS and AutoPrefixer.
          postcssOptions.plugins.push(require("tailwindcss"));
          postcssOptions.plugins.push(require("autoprefixer"));
          return postcssOptions;
        },
      };
    },
    //require.resolve("docusaurus-lunr-search"),
    [
      "@docusaurus/plugin-google-gtag",
      {
        trackingID: "G-N1JLG2HDHZ",
        anonymizeIP: true,
      },
    ],
    [
      "@docusaurus/plugin-ideal-image",
      {
        quality: 70,
        max: 1030, // max resized image's size.
        min: 100, // min resized image's size. if original is lower, use that size.
        steps: 5, // the max number of images generated between min and max (inclusive)
        disableInDev: false,
      },
    ],
  ],
  markdown: {
    mermaid: true,
    format: "mdx",
  },
  themes: ["@docusaurus/theme-mermaid"],
};

module.exports = config;
