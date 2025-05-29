<div align="center">
    <h1>Nmap Bootstrap XSL</h1>
    <p>An Nmap XSL implementation with Bootstrap.<br>
    Allows Nmap XML port scan results to be converted into beautiful HTML reports.</p>
</div>

## About
This project provides an XSL stylesheet that transforms Nmap XML scan results into interactive HTML reports using Bootstrap. The reports include filtering, sorting, and exporting capabilities, making it easier to analyze and share scan results.

## Features
- **Bootstrap Datatable**: Filters, search bars, and sorting for easy data manipulation
- **Export Functionality**: Export results as CSV, Excel, or PDF
- **Service Classification**: Automatically categorizes web services for better organization
- **HTTP/HTTPS Information**: Displays HTTP titles and SSL certificate details
- **Host Listing**: Detailed listing of scanned hosts and their properties
- **Service Indicators**: Shows whether services are encrypted (SSL/STARTTLS) or plaintext

## Example Report
Here's what the generated report looks like:
![Report Screenshot](./sample/image.png)

## Usage
### Converting Nmap XML to HTML
1. Download the XSL stylesheet:
   ```bash
   wget https://raw.githubusercontent.com/dreizehnutters/nmap-bootstrap-xsl/main/nmap-bootstrap.xsl
   ```
2. Convert your Nmap XML file to HTML:
   ```bash
   xsltproc -o report.html nmap-bootstrap.xsl your_scan.xml
   ```


## Acknowledgments
- Inspired by the work of [honze-net](https://github.com/honze-net) and their [nmap-bootstrap-xsl](https://github.com/honze-net/nmap-bootstrap-xsl) project
- Fork of [Haxxnet/nmap-bootstrap-xsl](https://github.com/Haxxnet/nmap-bootstrap-xsl)