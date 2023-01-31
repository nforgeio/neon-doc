// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require('prism-react-renderer/themes/github');
const darkCodeTheme = require('prism-react-renderer/themes/dracula');

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'neonFORGE Documentation',
  tagline: 'Explanation and usage information for neonFORGE projects.',
  url: 'https://docs.neonforge.com',
  baseUrl: '/',
  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',
  favicon: 'img/favicon.png',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'nforgeio-docs', // Usually your GitHub org/user name.
  projectName: 'nforgeio-docs.github.io', // Usually your repo name.
  deploymentBranch: 'master',

  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang. For example, if your site is Chinese, you may want
  // to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/nforgeio/documentation/edit/master/',
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      colorMode: {
        defaultMode: 'dark',
        disableSwitch: true,
        respectPrefersColorScheme: true,
      },
      navbar: {
        title: 'neonFORGE',
        logo: {
          alt: 'NeonKUBE Logo',
          src: 'img/favicon.png',
        },
        items: [
          {
            to: '/docs/neonkube', 
            label: 'neonKUBE', 
            position: 'left'
          },
          {
            to: '/docs/neonsdk', 
            label: 'neonSDK', 
            position: 'left'
          },
          {
            href: 'https://github.com/nforgeio',
            label: 'GitHub',
            position: 'right',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Docs',
            items: [
              {
                label: 'Getting Started',
                to: '/docs/category/getting-started',
              },
            ],
          },
          {
            title: 'Community',
            items: [
              {
                label: 'GitHub',
                href: 'https://github.com/orgs/nforgeio',
              },
              {
                label: 'Slack',
                href: 'https://communityinviter.com/apps/neonforge/neonforge',
              },
              {
                label: 'Linkedin',
                href: 'https://www.linkedin.com/company/neonforge',
              },
            ],
          },
          {
            title: 'More',
            items: [
              {
                label: 'neonKUBE',
                href: 'https://neonkube.io/',
              }
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} NEONFORGE LLC.`,
      },
      prism: {
        theme: lightCodeTheme,
        darkTheme: darkCodeTheme,
        additionalLanguages: ['powershell', 'csharp'],
      },
    }),
    plugins: [
      require.resolve('docusaurus-lunr-search'),
      [
        '@docusaurus/plugin-google-gtag',
        {
          trackingID: 'G-N1JLG2HDHZ',
          anonymizeIP: true,
        },
      ],
    ]
};

module.exports = config;
