---
layout: null
sitemap: false
---
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
  xmlns:xhtml="http://www.w3.org/1999/xhtml">

  <xsl:output method="html" indent="yes" encoding="UTF-8" />

  <xsl:template match="/">
    <html>
      <head>
        <title>Sitemap — esahakulinen.fi</title>
        <style>
          * { margin: 0; padding: 0; box-sizing: border-box; }
          body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            color: #1a1a1a;
            background: #f5f3f0;
            padding: 2rem 1rem;
          }
          .container {
            max-width: 1000px;
            margin: 0 auto;
          }
          h1 {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.25rem;
            color: #1a1a1a;
          }
          p.description {
            color: #5c5c5c;
            font-size: 0.9rem;
            margin-bottom: 1.5rem;
          }
          table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.06);
          }
          th {
            text-align: left;
            padding: 0.75rem 1rem;
            background: #2a2826;
            color: #f5f3f0;
            font-size: 0.8rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.03em;
          }
          td {
            padding: 0.6rem 1rem;
            font-size: 0.85rem;
            border-bottom: 1px solid #eee;
          }
          tr:last-child td { border-bottom: none; }
          tr:hover td { background: #faf9f7; }
          a { color: #6b5e54; text-decoration: none; }
          a:hover { color: #524840; text-decoration: underline; }
          .lang-badge {
            display: inline-block;
            padding: 0.15rem 0.4rem;
            border-radius: 3px;
            font-size: 0.75rem;
            font-weight: 500;
            background: #eee;
            color: #5c5c5c;
          }
          .count {
            font-size: 0.85rem;
            color: #5c5c5c;
            margin-bottom: 1.5rem;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <h1>Sitemap</h1>
          <p class="description">This sitemap is used by search engines to discover pages on this site.</p>
          <p class="count">
            <xsl:value-of select="count(sitemap:urlset/sitemap:url)" /> URLs
          </p>
          <table>
            <thead>
              <tr>
                <th>URL</th>
                <th>Language</th>
                <th>Last modified</th>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="sitemap:urlset/sitemap:url">
                <tr>
                  <td>
                    <a href="{sitemap:loc}"><xsl:value-of select="sitemap:loc" /></a>
                  </td>
                  <td>
                    <xsl:choose>
                      <xsl:when test="contains(sitemap:loc, '/en/')">
                        <span class="lang-badge">EN</span>
                      </xsl:when>
                      <xsl:otherwise>
                        <span class="lang-badge">FI</span>
                      </xsl:otherwise>
                    </xsl:choose>
                  </td>
                  <td>
                    <xsl:if test="sitemap:lastmod">
                      <xsl:value-of select="substring(sitemap:lastmod, 1, 10)" />
                    </xsl:if>
                  </td>
                </tr>
              </xsl:for-each>
            </tbody>
          </table>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
