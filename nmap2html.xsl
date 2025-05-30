<?xml version="1.0" encoding="utf-8"?>
<!--
Nmap Bootstrap XSL
This software must not be used by military or secret service organisations.
Andreas Hontzia (@honze_net) & LRVT (@l4rm4nd) & Fabian Kopp (@dreizehnutters)
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:key name="serviceGroup" match="host/ports/port[state/@state='open'][service/@name and service/@conf &gt; 5]" use="concat(service/@name, '-', @protocol)"/>
  <xsl:key name="uniquePorts" match="port[state/@state='open']" use="@portid"/>
  <xsl:output method="html" encoding="utf-8" indent="yes" doctype-system="about:legacy-compat"/>
  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta name="referrer" content="no-referrer"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdn.datatables.net/v/bs5/jq-3.7.0/jszip-3.10.1/dt-2.3.1/b-3.2.3/b-colvis-3.2.3/b-html5-3.2.3/b-print-3.2.3/fh-4.0.2/datatables.min.css" rel="stylesheet" integrity="sha384-npHSxFxHOYzZ5rh7dTSWQz9iiFPD5EpGhraeLyrNOwAtnwNrZfEbDcA4aFwnYQKL" crossorigin="anonymous"/>
        <script src="https://cdn.datatables.net/v/bs5/jq-3.7.0/jszip-3.10.1/dt-2.3.1/b-3.2.3/b-colvis-3.2.3/b-html5-3.2.3/b-print-3.2.3/fh-4.0.2/datatables.min.js" integrity="sha384-AG5MJFbmBt6aryW6LS46cM1vt7UNBHkLZiCWbnKHdW3B+a3iZjlcZybzBx57ayaY" crossorigin="anonymous"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js" integrity="sha384-VFQrHzqBh5qiJIU0uGU5CIW3+OWpdGGJM9LBnGbuIH2mkICcFZ7lPd/AAtI7SNf7" crossorigin="anonymous"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js" integrity="sha384-/RlQG9uf0M2vcTw3CX7fbqgbj/h8wKxw7C3zu9/GxcBPRKOEcESxaxufwRXqzq6n" crossorigin="anonymous"/>
        <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.bundle.min.js" integrity="sha384-mZ3q69BYmd4GxHp59G3RrsaFdWDxVSoqd7oVYuWRm2qiXrduT63lQtlhdD9lKbm3" crossorigin="anonymous"/>
        <title>Company XYZ | Nmap Results</title>
      </head>
      <body>
        <nav id="mainNavbar" class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
          <div class="container-fluid">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation"/>
            <div class="collapse navbar-collapse" id="navbarNav">
              <ul class="navbar-nav me-auto">
                <li class="nav-item">
                  <a class="nav-link" href="#scannedhosts">Scanned Hosts</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#openservices">Open Services</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#webservices">Web Services</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#onlinehosts">Online Hosts</a>
                </li>
              </ul>
              <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                  <a class="nav-link" href="https://TODO.com/pentest">
                    <img src="data:image/gif;base64,R0lGODlhEAAQAMQAAORHHOVSKudfOulrSOp3WOyDZu6QdvCchPGolfO0o/XBs/fNwfjZ0frl3/zy7////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAkAABAALAAAAAAQABAAAAVVICSOZGlCQAosJ6mu7fiyZeKqNKToQGDsM8hBADgUXoGAiqhSvp5QAnQKGIgUhwFUYLCVDFCrKUE1lBavAViFIDlTImbKC5Gm2hB0SlBCBMQiB0UjIQA7" alt="Company XYZ" style="max-height: 40px; width: auto;"/>
                  </a>
                </li>
              </ul>
            </div>
          </div>
        </nav>
        <div class="container" style="min-width: fit-content; margin-left: 5%; margin-right: 5%;">
          <div id="jumbotron-container" class="bg-light p-4 rounded my-5 shadow-sm">
            <h2 class="display-6 text-primary">Port Scanning Results</h2>
            <h5 class="mb-3">
              <small class="text-muted">
                Nmap Version: <xsl:value-of select="/nmaprun/@version"/> <br/>
                Scan Duration: <xsl:value-of select="/nmaprun/@startstr"/> - <xsl:value-of select="/nmaprun/runstats/finished/@timestr"/>
              </small>
            </h5>
            <pre class="border rounded bg-white p-3 overflow-auto" style="white-space: pre-wrap; word-wrap: break-word;">
              <xsl:attribute name="text">
                <xsl:value-of select="/nmaprun/@args"/>
              </xsl:attribute>
              <xsl:value-of select="/nmaprun/@args"/>
            </pre>
            <div class="d-flex gap-3 my-3">
              <p class="mb-0">
                <b class="badge bg-info p-2"><xsl:value-of select="/nmaprun/runstats/hosts/@total"/> Hosts scanned</b>
              </p>
            </div>
            <div class="progress">
              <div class="progress-bar bg-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"><xsl:attribute name="style">width:<xsl:value-of select="/nmaprun/runstats/hosts/@up div /nmaprun/runstats/hosts/@total * 100"/>%;</xsl:attribute><xsl:value-of select="/nmaprun/runstats/hosts/@up"/> Hosts up</div>
              <div class="progress-bar bg-warning" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"><xsl:attribute name="style">width:<xsl:value-of select="/nmaprun/runstats/hosts/@down div /nmaprun/runstats/hosts/@total * 100"/>%;</xsl:attribute><xsl:value-of select="/nmaprun/runstats/hosts/@down"/> Hosts down</div>
            </div>
          </div>
          
          <h2 id="scannedhosts" class="fs-4 mt-5 mb-3 bg-light p-3 rounded">Scanned Hosts <xsl:if test="/nmaprun/runstats/hosts/@down &gt; 1024"><small class="text-muted">(offline hosts are hidden)</small></xsl:if></h2>
          <div class="table-responsive">
            <table id="table-overview" class="table table-striped table-hover align-middle" role="grid">
              <thead class="table-light">
                <tr>
                  <th scope="col">State</th>
                  <th scope="col">Mac</th>
                  <th scope="col">Vendor</th>
                  <th scope="col">OS</th>
                  <th scope="col">Address</th>
                  <th scope="col">Hostname</th>
                  <th scope="col">#Open TCP Ports</th>
                  <th scope="col">#Open UDP Ports</th>
                </tr>
              </thead>
              <tbody>
                <xsl:choose>
                  <xsl:when test="/nmaprun/runstats/hosts/@down &gt; 1024">
                    <xsl:for-each select="/nmaprun/host[status/@state='up']">
                      <tr>
                        <td>
                          <span class="badge bg-danger">
                            <xsl:if test="status/@state='up'">
                              <xsl:attribute name="class">badge bg-success</xsl:attribute>
                            </xsl:if>
                            <xsl:value-of select="status/@state"/>
                          </span>
                        </td>
                        <td>
                          <xsl:value-of select="address[@addrtype='mac']/@addr"/>
                        </td>
                        <td>
                          <xsl:value-of select="address[@addrtype='mac']/@vendor"/>
                        </td>
                        <td>
                          <xsl:value-of select="os/osmatch[1]/@name"/>
                        </td>
                        <td>
                          <a>
                            <xsl:attribute name="href">#onlinehosts-<xsl:value-of select="translate(address[@addrtype='ipv4']/@addr, '.', '-')"/></xsl:attribute>
                            <xsl:value-of select="address[@addrtype='ipv4']/@addr"/>
                          </a>
                        </td>
                        <td>
                          <xsl:value-of select="hostnames/hostname/@name"/>
                        </td>
                        <td>
                          <xsl:value-of select="count(ports/port[state/@state='open' and @protocol='tcp'])"/>
                        </td>
                        <td>
                          <xsl:value-of select="count(ports/port[state/@state='open' and @protocol='udp'])"/>
                        </td>
                      </tr>
                    </xsl:for-each>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:for-each select="/nmaprun/host">
                      <tr>
                        <td>
                          <span class="badge bg-warning">
                            <xsl:if test="status/@state='up'">
                              <xsl:attribute name="class">badge bg-success</xsl:attribute>
                            </xsl:if>
                            <xsl:value-of select="status/@state"/>
                          </span>
                        </td>
                        <td>
                          <xsl:value-of select="address[@addrtype='mac']/@addr"/>
                        </td>
                        <td>
                          <xsl:value-of select="address[@addrtype='mac']/@vendor"/>
                        </td>
                        <td>
                          <xsl:value-of select="os/osmatch[1]/@name"/>
                        </td>
                        <td>
                          <a>
                            <xsl:attribute name="href">#onlinehosts-<xsl:value-of select="translate(address[@addrtype='ipv4']/@addr, '.', '-')"/></xsl:attribute>
                            <xsl:value-of select="address[@addrtype='ipv4']/@addr"/>
                          </a>
                        </td>
                        <td>
                          <xsl:value-of select="hostnames/hostname/@name"/>
                        </td>
                        <td>
                          <xsl:value-of select="count(ports/port[state/@state='open' and @protocol='tcp'])"/>
                        </td>
                        <td>
                          <xsl:value-of select="count(ports/port[state/@state='open' and @protocol='udp'])"/>
                        </td>
                      </tr>
                    </xsl:for-each>
                  </xsl:otherwise>
                </xsl:choose>
              </tbody>
            </table>
          </div>
          
          <hr class="my-4"/>
          <h2 id="openservices" class="fs-4 mt-5 mb-3 bg-light p-3 rounded">Open Services</h2>
          <div class="my-4 row" style="margin: 20px 0;">
            <div id="serviceCounts" class="d-none">
              <xsl:for-each select="//port[state/@state='open']/service[@name and @conf &gt; 5]">
                <span class="service" data-service="{@name}"/>
              </xsl:for-each>
            </div>
            <div id="flex-container" class="d-flex flex-wrap gap-4 align-items-start">
              <div class="chart-container" style="flex: 1; max-width: 70%;">
                <canvas id="servicePieChart"/>
              </div>
              <div class="list-container">
                <h3 class="fs-5 mb-3">Top 5 Services</h3>
                <ul id="topServicesLedger" class="list-group" style="font-size: 16px; color: #333; font-weight: bold;">
                </ul>
              </div>
            </div>
          </div>
          <div class="table-responsive">
            <table id="table-services" class="table table-striped table-hover align-middle" role="grid">
              <thead class="table-light">
                <tr>
                  <th scope="col">Hostname</th>
                  <th scope="col">Address</th>
                  <th scope="col">Port</th>
                  <th scope="col">Protocol</th>
                  <th scope="col">Service</th>
                  <th scope="col">Product</th>
                  <th scope="col">Version</th>
                  <th scope="col">Extra</th>
                  <th scope="col">CPE</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="/nmaprun/host">
                  <xsl:for-each select="ports/port[state/@state='open']">
                    <tr>
                      <td>
                        <xsl:if test="count(../../hostnames/hostname) = 0">N/A</xsl:if>
                        <xsl:if test="count(../../hostnames/hostname) &gt; 0">
                          <xsl:value-of select="../../hostnames/hostname/@name"/>
                        </xsl:if>
                      </td>
                      <td>
                        <a href="#">
                          <xsl:attribute name="href">#onlinehosts-<xsl:value-of select="translate(../../address/@addr, '.', '-')"/></xsl:attribute>
                          <xsl:value-of select="../../address/@addr"/>
                        </a>
                      </td>
                      <td>
                        <xsl:value-of select="@portid"/>
                      </td>
                      <td>
                        <xsl:value-of select="@protocol"/>
                      </td>
                      <td>
                        <xsl:choose>
                          <xsl:when test="script[@id='ssl-cert']">
                            ssl/<xsl:if test="number(service/@conf) &gt; 5"><xsl:value-of select="service/@name"/></xsl:if>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:if test="number(service/@conf) &gt; 5"><xsl:value-of select="service/@name"/></xsl:if>
                          </xsl:otherwise>
                        </xsl:choose>
                      </td>
                      <td>
                        <xsl:value-of select="service/@product"/>
                      </td>
                      <td>
                        <xsl:value-of select="service/@version"/>
                      </td>
                      <td>
                        <xsl:value-of select="service/@extrainfo"/>
                      </td>
                      <td>
                        <xsl:value-of select="service/cpe"/>
                      </td>
                    </tr>
                  </xsl:for-each>
                </xsl:for-each>
              </tbody>
            </table>
          </div>
          
          <hr class="my-4"/>
          <h2 id="serviceinventory" class="fs-4 mt-5 mb-3 bg-light p-3 rounded">Service Inventory</h2>
          <div class="table-responsive">
            <table id="service-inventory" class="table table-striped table-hover table-bordered dataTable align-middle" role="grid">
              <thead class="table-light">
                <tr>
                  <th scope="col">Service Name</th>
                  <th scope="col">Ports</th>
                  <th scope="col">Protocol</th>
                  <th scope="col">Hosts</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="/nmaprun/host/ports/port[state/@state='open'][service/@name][generate-id() = generate-id(key('serviceGroup', concat(service/@name, '-', @protocol))[1])]">
                  <xsl:variable name="svcName" select="service/@name"/>
                  <xsl:variable name="proto" select="@protocol"/>
                  <xsl:variable name="svcKey" select="concat($svcName, '-', $proto)"/>
                  <tr>
                    <td>
                      <xsl:value-of select="$svcName"/>
                    </td>
                    <td>
                      <xsl:for-each select="/nmaprun/host/ports/port[state/@state='open'][service/@name = $svcName and @protocol = $proto][generate-id() = generate-id(key('uniquePorts', @portid)[1])]">
                        <xsl:sort select="@portid" data-type="number"/>
                        <xsl:value-of select="@portid"/>
                        <xsl:if test="position() != last()">, </xsl:if>
                      </xsl:for-each>
                    </td>
                    <td>
                      <xsl:value-of select="$proto"/>
                    </td>
                    <td>
                      <xsl:for-each select="/nmaprun/host[ports/port[state/@state='open'][service/@name = $svcName and @protocol = $proto]]">
                        <xsl:sort select="address[@addrtype='ipv4']/@addr"/>
                        <a>
                          <xsl:attribute name="href">
                            <xsl:text>#onlinehosts-</xsl:text>
                            <xsl:value-of select="translate(address[@addrtype='ipv4']/@addr, '.', '-')"/>
                          </xsl:attribute>
                          <xsl:value-of select="address[@addrtype='ipv4']/@addr"/>
                        </a>
                        <xsl:if test="hostnames/hostname">
                          <xsl:text> (</xsl:text>
                          <xsl:value-of select="hostnames/hostname/@name"/>
                          <xsl:text>)</xsl:text>
                        </xsl:if>
                        <xsl:if test="position() != last()">, </xsl:if>
                      </xsl:for-each>
                    </td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </div>
          
          <hr class="my-4"/>
          <h2 id="webservices" class="fs-4 mt-5 mb-3 bg-light p-3 rounded">Web Services</h2>
          <div class="table-responsive">
            <table id="web-services" class="table table-striped table-hover table-bordered align-middle dataTable" role="grid">
              <thead class="table-light">
                <tr>
                  <th scope="col">Hostname</th>
                  <th scope="col">Address</th>
                  <th scope="col">Port</th>
                  <th scope="col">Service</th>
                  <th scope="col">Product</th>
                  <th scope="col">Version</th>
                  <th scope="col">HTTP-Title</th>
                  <th scope="col">SSL Certificate</th>
                  <th scope="col">URL</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="/nmaprun/host">
                  <xsl:for-each select="ports/port[(@protocol='tcp') and (state/@state='open') and (starts-with(service/@name, 'http') or script[@id='ssl-cert'])]">
                    <tr>
                      <td>
                        <xsl:if test="count(../../hostnames/hostname) = 0">N/A</xsl:if>
                        <xsl:if test="count(../../hostnames/hostname) &gt; 0">
                          <xsl:value-of select="../../hostnames/hostname/@name"/>
                        </xsl:if>
                      </td>
                      <td>
                        <a>
                          <xsl:attribute name="href">#onlinehosts-<xsl:value-of select="translate(../../address/@addr, '.', '-')"/></xsl:attribute>
                          <xsl:value-of select="../../address/@addr"/>
                        </a>
                      </td>
                      <td>
                        <xsl:value-of select="@portid"/>
                      </td>
                      <td>
                        <xsl:choose>
                          <xsl:when test="script[@id='ssl-cert']">
                            ssl/<xsl:if test="number(service/@conf) &gt; 5"><xsl:value-of select="service/@name"/></xsl:if>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:if test="number(service/@conf) &gt; 5"><xsl:value-of select="service/@name"/></xsl:if>
                          </xsl:otherwise>
                        </xsl:choose>
                      </td>
                      <td>
                        <xsl:value-of select="service/@product"/>
                      </td>
                      <td>
                        <xsl:value-of select="service/@version"/>
                      </td>
                      <td>
                        <xsl:choose>
                          <xsl:when test="count(script[@id='http-title']/elem[@key='title']) &gt; 0">
                            <i>
                              <xsl:value-of select="script[@id='http-title']/elem[@key='title']"/>
                            </i>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:if test="count(script[@id='http-title']/@output) &gt; 0">
                              <i>
                                <xsl:value-of select="script[@id='http-title']/@output"/>
                              </i>
                            </xsl:if>
                          </xsl:otherwise>
                        </xsl:choose>
                      </td>
                      <td>
                        <table class="table table-sm table-borderless mb-0">
                          <xsl:if test="script/table[@key='subject']/elem[@key='commonName'] or script/table[@key='subject']/elem[@key='organizationName']">
                            <tr>
                              <td>Subject</td>
                              <td>
                                <i>
                                  <xsl:value-of select="script/table[@key='subject']/elem[@key='commonName']"/>
                                  <xsl:if test="script/table[@key='subject']/elem[@key='organizationName']">
                                    <xsl:text> – </xsl:text>
                                    <xsl:value-of select="script/table[@key='subject']/elem[@key='organizationName']"/>
                                  </xsl:if>
                                </i>
                              </td>
                            </tr>
                          </xsl:if>
                          <xsl:if test="script/table[@key='issuer']/elem[@key='commonName'] or script/table[@key='issuer']/elem[@key='organizationName']">
                            <tr>
                              <td>Issuer</td>
                              <td>
                                <i>
                                  <xsl:value-of select="script/table[@key='issuer']/elem[@key='commonName']"/>
                                  <xsl:if test="script/table[@key='issuer']/elem[@key='organizationName']">
                                    <xsl:text> – </xsl:text>
                                    <xsl:value-of select="script/table[@key='issuer']/elem[@key='organizationName']"/>
                                  </xsl:if>
                                </i>
                              </td>
                            </tr>
                          </xsl:if>
                          <xsl:if test="script/table[@key='validity']/elem[@key='notAfter']">
                            <tr>
                              <td>Expiry</td>
                              <td>
                                <i>
                                  <xsl:value-of select="script/table[@key='validity']/elem[@key='notAfter']"/>
                                </i>
                              </td>
                            </tr>
                          </xsl:if>
                          <xsl:if test="script/elem[@key='sig_algo']">
                            <tr>
                              <td>SigAlgo</td>
                              <td>
                                <i>
                                  <xsl:value-of select="script/elem[@key='sig_algo']"/>
                                </i>
                              </td>
                            </tr>
                          </xsl:if>
                        </table>
                      </td>
                      <xsl:choose>
                        <xsl:when test="count(service/@tunnel) &gt; 0 or service/@name = 'https' or service/@name = 'https-alt'">
                          <td>
                            <xsl:if test="count(../../hostnames/hostname) &gt; 0">
                              <a target="_blank" href="https://{../../hostnames/hostname/@name}:{@portid}">https://<xsl:value-of select="../../hostnames/hostname/@name"/>:<xsl:value-of select="@portid"/></a>
                            </xsl:if>
                            <xsl:if test="count(../../hostnames/hostname) = 0">
                              <a target="_blank" href="https://{../../address/@addr}:{@portid}">https://<xsl:value-of select="../../address/@addr"/>:<xsl:value-of select="@portid"/></a>
                            </xsl:if>
                          </td>
                        </xsl:when>
                        <xsl:otherwise>
                          <td>
                            <xsl:if test="count(../../hostnames/hostname) &gt; 0">
                              <a target="_blank" href="http://{../../hostnames/hostname/@name}:{@portid}">http://<xsl:value-of select="../../hostnames/hostname/@name"/>:<xsl:value-of select="@portid"/></a>
                            </xsl:if>
                            <xsl:if test="count(../../hostnames/hostname) = 0">
                              <a target="_blank" href="http://{../../address/@addr}:{@portid}">http://<xsl:value-of select="../../address/@addr"/>:<xsl:value-of select="@portid"/></a>
                            </xsl:if>
                          </td>
                        </xsl:otherwise>
                      </xsl:choose>
                    </tr>
                  </xsl:for-each>
                </xsl:for-each>
              </tbody>
            </table>
          </div>
          
          <hr class="my-4"/>
          <h2 id="onlinehosts" class="fs-4 mt-5 mb-3 bg-light p-3 rounded">Online Hosts</h2>
          <div class="accordion" id="accordionOnlineHosts">
            <xsl:for-each select="/nmaprun/host[status/@state='up']">
              <div class="accordion-item">
                <h2 class="accordion-header">
                  <xsl:attribute name="id">heading-<xsl:value-of select="translate(address/@addr, '.', '-')"/></xsl:attribute>
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse">
                    <xsl:attribute name="id">onlinehosts-<xsl:value-of select="translate(address/@addr, '.', '-')"/></xsl:attribute>
                    <xsl:attribute name="data-bs-target">#collapse-<xsl:value-of select="translate(address/@addr, '.', '-')"/></xsl:attribute>
                    <xsl:attribute name="aria-controls">collapse-<xsl:value-of select="translate(address/@addr, '.', '-')"/></xsl:attribute>
                    <xsl:value-of select="address[@addrtype='ipv4']/@addr"/>
                    <xsl:if test="address[@addrtype='mac']">
                      <xsl:text> (</xsl:text>
                      <xsl:value-of select="address[@addrtype='mac']/@addr"/>
                      <xsl:if test="address[@addrtype='mac']/@vendor">
                        <xsl:text> - </xsl:text>
                        <xsl:value-of select="address[@addrtype='mac']/@vendor"/>
                      </xsl:if>
                      <xsl:text>)</xsl:text>
                    </xsl:if>
                    <xsl:if test="count(hostnames/hostname) &gt; 0">
                      <xsl:text> - </xsl:text>
                      <xsl:value-of select="hostnames/hostname/@name"/>
                    </xsl:if>
                  </button>
                </h2>
                <div>
                  <xsl:attribute name="id">collapse-<xsl:value-of select="translate(address/@addr, '.', '-')"/></xsl:attribute>
                  <xsl:attribute name="class">accordion-collapse collapse</xsl:attribute>
                  <xsl:attribute name="aria-labelledby">heading-<xsl:value-of select="translate(address/@addr, '.', '-')"/></xsl:attribute>
                  <xsl:attribute name="data-bs-parent">#accordionOnlineHosts</xsl:attribute>
                  <div class="accordion-body">
                    <xsl:if test="count(hostnames/hostname) &gt; 0">
                      <h4 class="fs-6">Hostnames</h4>
                      <ul>
                        <xsl:for-each select="hostnames/hostname">
                          <li><xsl:value-of select="@name"/> (<xsl:value-of select="@type"/>)
                          </li>
                        </xsl:for-each>
                      </ul>
                    </xsl:if>
                    <h4 class="fs-6">Ports</h4>
                    <div class="table-responsive">
                      <table class="table table-striped table-bordered align-middle">
                        <thead>
                          <tr class="table-light">
                            <th>Port</th>
                            <th>Protocol</th>
                            <th>State</th>
                            <th>Reason</th>
                            <th>Service</th>
                            <th>Product</th>
                            <th>Version</th>
                            <th>Extra Info</th>
                            <th>CPE</th>
                            <th>Scripts</th>
                          </tr>
                        </thead>
                        <tbody>
                          <xsl:for-each select="ports/port">
                            <tr>
                              <td>
                                <xsl:value-of select="@portid"/>
                              </td>
                              <td>
                                <xsl:value-of select="@protocol"/>
                              </td>
                              <td>
                                <xsl:value-of select="state/@state"/>
                              </td>
                              <td>
                                <xsl:value-of select="state/@reason"/>
                              </td>
                              <td>
                                <xsl:choose>
                                  <xsl:when test="script[@id='ssl-cert']">
                                    ssl/<xsl:if test="number(service/@conf) &gt; 5"><xsl:value-of select="service/@name"/></xsl:if>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:if test="number(service/@conf) &gt; 5"><xsl:value-of select="service/@name"/></xsl:if>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </td>
                              <td>
                                <xsl:value-of select="service/@product"/>
                              </td>
                              <td>
                                <xsl:value-of select="service/@version"/>
                              </td>
                              <td>
                                <xsl:value-of select="service/@extrainfo"/>
                              </td>
                              <td>
                                <xsl:if test="count(service/cpe) &gt; 0">
                                  <a>
                                    <xsl:attribute name="href">
                            https://nvd.nist.gov/vuln/search/results?form_type=Advanced&amp;cves=on&amp;cpe_version=<xsl:value-of select="service/cpe"/>
                          </xsl:attribute>
                                    <xsl:value-of select="service/cpe"/>
                                  </a>
                                </xsl:if>
                              </td>
                              <td>
                                <xsl:if test="count(script) &gt; 0">
                                  <ul class="list-unstyled mb-0">
                                    <xsl:for-each select="script">
                                      <li>
                                        <strong>
                                          <xsl:value-of select="@id"/>
                                        </strong>
                                        <pre class="bg-light p-2 rounded">
                                          <xsl:value-of select="@output"/>
                                        </pre>
                                      </li>
                                    </xsl:for-each>
                                  </ul>
                                </xsl:if>
                              </td>
                            </tr>
                          </xsl:for-each>
                        </tbody>
                      </table>
                    </div>
                    <xsl:if test="count(os/osmatch) &gt; 0">
                      <h4 class="fs-6 mt-4">Operating System Detection</h4>
                      <xsl:for-each select="os/osmatch">
                        <h5>OS Details: <xsl:value-of select="@name"/> (<xsl:value-of select="@accuracy"/>%)</h5>
                        <xsl:for-each select="osclass">
                          <p><strong>Device Type:</strong><xsl:value-of select="@type"/><br/><strong>Running:</strong><xsl:value-of select="@vendor"/><xsl:value-of select="@osfamily"/><xsl:value-of select="@osgen"/>
                  (<xsl:value-of select="@accuracy"/>%)<br/>
                  <strong>OS CPE:</strong>
                  <xsl:if test="count(cpe) &gt; 0"><a><xsl:attribute name="href">
                        https://nvd.nist.gov/vuln/search/results?form_type=Advanced&amp;cves=on&amp;cpe_version=<xsl:value-of select="cpe"/>
                      </xsl:attribute><xsl:value-of select="cpe"/></a></xsl:if>
                          </p>
                        </xsl:for-each>
                      </xsl:for-each>
                    </xsl:if>
                  </div>
                </div>
              </div>
            </xsl:for-each>
          </div>
        </div>

        <hr class="my-3"/>
        <footer class="footer bg-light py-3">
          <div class="container">
            <p class="text-muted mb-0">
              This report was generated by or with the help of <a href="https://TODO.com" class="text-decoration-none">Company XYZ</a>.<br/>
              If you have questions or problems, do not hesitate <a href="mailto:team@TODO.de" class="text-decoration-none">contacting us</a>. </p>
          </div>
        </footer>
        <script>
        function initializeDataTable(selector) {
          const table = $(selector).DataTable({
            lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
            order: [[0, 'desc']],
            columnDefs: [
              { targets: [0], orderable: true },
              { targets: [1], type: 'ip-address' },
            ],
            dom: '&lt;"d-flex justify-content-between align-items-center mb-2"lfB&gt;rtip',

            stateSave: true,
            extend: 'collection',
            buttons: [
              {
                extend: 'copyHtml5',
                text: 'Copy',
                exportOptions: { orthogonal: 'export' },
                className: 'btn btn-light'
              },
              {
                extend: 'csvHtml5',
                text: 'CSV',
                fieldSeparator: ';',
                exportOptions: { orthogonal: 'export' },
                className: 'btn btn-light'
              },
              {
                extend: 'excelHtml5',
                text: 'Excel',
                autoFilter: true,
                exportOptions: { orthogonal: 'export' },
                className: 'btn btn-light'
              },
              {
                extend: 'pdfHtml5',
                text: 'PDF',
                orientation: 'landscape',
                pageSize: 'LEGAL',
                download: 'open',
                exportOptions: {
                },
                className: 'btn btn-light'
              },
              {
          text: 'JSON',
                className: 'btn btn-light',
          action: function (e, dt, node, config) {
            const headers = dt.columns().header().toArray().map(h =&gt; $(h).text().trim());

            const data = dt.rows({ search: 'applied' }).nodes().toArray().map(row =&gt; {
              const obj = {};
              $(row).find('td').each(function (i) {
                obj[headers[i]] = $(this).text().trim();
              });
              return obj;
            });

            const json = JSON.stringify(data, null, 2);
            const blob = new Blob([json], { type: 'application/json' });
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'table-export.json';
            a.click();
            URL.revokeObjectURL(url);
          }}]});
        }
        </script>
        <script>
          $(document).ready(function() {
              initializeDataTable('#table-services');
              initializeDataTable('#table-overview');
              initializeDataTable('#web-services');
              initializeDataTable('#service-inventory');


              $("a[href^='#onlinehosts-']").click(function(event) {
                  event.preventDefault();
                  $('html,body').animate({
                      scrollTop: ($(this.hash).offset().top - 60)
                  }, 500);
              });
          });
        </script>
        <script>
          document.addEventListener("DOMContentLoaded", function () {
            var serviceCounts = {};

            document.querySelectorAll("#serviceCounts .service").forEach(function (serviceElement) {
              var serviceName = serviceElement.getAttribute("data-service");
              if (serviceName) {
                serviceCounts[serviceName] = (serviceCounts[serviceName] || 0) + 1;
              }
            });

            var sortedServices = Object.entries(serviceCounts).sort((a, b) =&gt; b[1] - a[1]);

            var labels = sortedServices.map(service =&gt; service[0]);
            var data = sortedServices.map(service =&gt; service[1]);

            var ctx = document.getElementById("servicePieChart").getContext("2d");
            new Chart(ctx, {
              type: "pie",
              data: {
                labels: labels,
                datasets: [{
                  data: data,
                  backgroundColor: [
                    "#4dc9f6", "#f67019", "#f53794", "#537bc4", "#acc236",
                    "#166a8f", "#00a950", "#58595b", "#8549ba", "#ff6384"
                  ],
                }]
              },
              options: {
                responsive: true,
                legend: {
                  position: "bottom"
                },
                title: {
                  display: true,
                  text: "Service Distribution Across Hosts"
                }
              }
            });


        var ledger = document.getElementById("topServicesLedger");
        sortedServices.slice(0, 5).forEach(function ([service, count]) {
          var listItem = document.createElement("li");
          
          listItem.className = "list-group-item d-flex justify-content-between align-items-center";

          listItem.innerHTML = `
            <strong style="font-family: Arial, sans-serif; font-size: 16px;">${service}</strong>
            <span class="badge bg-primary rounded-pill ms-auto" style="font-size: 14px;">${count}</span>
          `;

          ledger.appendChild(listItem);
        });

          });
        </script>
        <script>console.log("Made by Company XYZ")</script>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
