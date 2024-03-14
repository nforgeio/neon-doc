/**
 * Creating a sidebar enables you to:
 - create an ordered group of docs
 - render a sidebar for each doc of that group
 - provide next/previous navigation

 The sidebars can be generated from the filesystem, or explicitly defined here.

 Create as many sidebars as you want.
 */

// @ts-check

/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
  // By default, Docusaurus generates a sidebar from the docs folder structure
  neonkube: [
    {
      type: "autogenerated",
      dirName: "neonkube",
    },
    {
      type: "category",
      label: "References",
      items: [
        {
          type: "link",
          href: "/docs/references/neon-cli", // document ID
          label: "NEONCLI Commands", // sidebar label
        },
        {
          type: "link",
          label: "NEONKUBE API Reference",
          href: "https://api-docs.neonforge.com/neonkube/api/Neon.Kube.html",
        },
      ],
    },
  ],
  neonsdk: [
    {
      type: "autogenerated",
      dirName: "neonsdk",
    },
    {
      type: "category",
      label: "References",
      items: [
        {
          type: "link",
          label: "API Reference",
          href: "https://api-docs.neonforge.com/neonsdk/api/Neon.html",
        },
      ],
    },
  ],
  operatorsdk: [
    {
      type: "autogenerated",
      dirName: "operator-sdk",
    },
  ],

  // But you can create a sidebar manually
  /*
  tutorialSidebar: [
    'intro',
    'hello',
    {
      type: 'category',
      label: 'Tutorial',
      items: ['tutorial-basics/create-a-document'],
    },
  ],
   */
};

module.exports = sidebars;
