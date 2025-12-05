<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html lang="et">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <title>TODO List - JSON Format</title>
                <style>
                    /* Reset and Base */
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }
                    
                    body {
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        background-color: #f5f5f5;
                        color: #333;
                        line-height: 1.6;
                        padding: 20px;
                    }
                    
                    .container {
                        max-width: 1000px;
                        margin: 0 auto;
                        background-color: #ffffff;
                        border-radius: 8px;
                        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                        overflow: hidden;
                    }
                    
                    .header {
                        background-color: #eeeeee;
                        padding: 30px;
                        border-bottom: 2px solid #cccccc;
                    }
                    
                    h1 {
                        color: #444;
                        font-weight: 300;
                        font-size: 2.5em;
                        text-align: center;
                    }
                    
                    .navigation {
                        background-color: #ffffff;
                        padding: 20px 30px;
                        border-bottom: 1px solid #eeeeee;
                    }
                    
                    .nav-buttons {
                        display: flex;
                        gap: 15px;
                        justify-content: center;
                        flex-wrap: wrap;
                    }
                    
                    .nav-btn {
                        display: inline-block;
                        padding: 12px 24px;
                        background-color: #eeeeee;
                        color: #333;
                        text-decoration: none;
                        border-radius: 5px;
                        font-weight: 500;
                        transition: all 0.3s ease;
                        border: 2px solid transparent;
                    }
                    
                    .nav-btn:hover {
                        background-color: #cccccc;
                        transform: translateY(-2px);
                    }
                    
                    .nav-btn.active {
                        background-color: #888;
                        color: #ffffff;
                        border-color: #666;
                    }
                    
                    .content {
                        padding: 30px;
                    }
                    
                    /* JSON Display */
                    .json-info {
                        background-color: #f0f8ff;
                        padding: 20px;
                        border-radius: 5px;
                        margin-bottom: 25px;
                        border-left: 4px solid #007bff;
                    }
                    
                    .json-container {
                        background-color: #2d3748;
                        color: #e2e8f0;
                        padding: 25px;
                        border-radius: 8px;
                        overflow-x: auto;
                        font-family: 'Courier New', 'Consolas', monospace;
                        font-size: 14px;
                        line-height: 1.5;
                        box-shadow: inset 0 2px 4px rgba(0,0,0,0.3);
                    }
                    
                    .json-output {
                        white-space: pre-wrap;
                        word-wrap: break-word;
                    }
                    
                    /* JSON Syntax Highlighting */
                    .json-key {
                        color: #81c784;
                        font-weight: 600;
                    }
                    
                    .json-string {
                        color: #ffcc80;
                    }
                    
                    .json-number {
                        color: #90caf9;
                    }
                    
                    .json-bracket {
                        color: #f48fb1;
                        font-weight: bold;
                    }
                    
                    .json-comma {
                        color: #e0e0e0;
                    }
                    
                    /* Controls */
                    .json-controls {
                        display: flex;
                        gap: 15px;
                        margin-bottom: 20px;
                        flex-wrap: wrap;
                        justify-content: center;
                    }
                    
                    .json-btn {
                        padding: 10px 20px;
                        background-color: #eeeeee;
                        color: #333;
                        border: none;
                        border-radius: 4px;
                        cursor: pointer;
                        font-weight: 500;
                        transition: all 0.2s ease;
                        text-decoration: none;
                        display: inline-block;
                    }
                    
                    .json-btn:hover {
                        background-color: #cccccc;
                    }
                    
                    .json-btn.primary {
                        background-color: #007bff;
                        color: #ffffff;
                    }
                    
                    .json-btn.primary:hover {
                        background-color: #0056b3;
                    }
                    
                    /* Stats */
                    .json-stats {
                        display: flex;
                        gap: 20px;
                        margin-bottom: 25px;
                        justify-content: center;
                        flex-wrap: wrap;
                    }
                    
                    .stat-item {
                        text-align: center;
                        padding: 15px 20px;
                        background-color: #f9f9f9;
                        border-radius: 5px;
                        min-width: 120px;
                    }
                    
                    .stat-number {
                        display: block;
                        font-size: 1.8em;
                        font-weight: 300;
                        color: #666;
                    }
                    
                    .stat-label {
                        color: #888;
                        font-size: 0.9em;
                    }
                    
                    /* Responsive */
                    @media (max-width: 768px) {
                        .container {
                            margin: 10px;
                            border-radius: 0;
                        }
                        
                        .header, .content, .navigation {
                            padding: 20px;
                        }
                        
                        h1 {
                            font-size: 2em;
                        }
                        
                        .nav-buttons, .json-controls {
                            justify-content: center;
                        }
                        
                        .json-container {
                            padding: 15px;
                            font-size: 12px;
                        }
                        
                        .json-stats {
                            flex-direction: column;
                        }
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>JSON Data Export</h1>
                    </div>
                    
                    <div class="navigation">
                        <div class="nav-buttons">
                            <a href="view.php?view=home" class="nav-btn">Home</a>
                            <a href="view.php?view=add" class="nav-btn">Lisa ülesanne</a>
                            <a href="view.php?view=json" class="nav-btn active">JSON</a>
                        </div>
                    </div>
                    
                    <div class="content">
                        <div class="json-info">
                            <p><strong>JSON Export</strong></p>
                            <p>Kõik ülesanded JSON formaadis. See formaat on mugav andmete eksportimiseks, API integreerimiseks või importimiseks teistesse süsteemidesse.</p>
                        </div>
                        
                        <!-- Statistics -->
                        <div class="json-stats">
                            <div class="stat-item">
                                <span class="stat-number"><xsl:value-of select="count(//task)"/></span>
                                <span class="stat-label">Total Tasks</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-number"><xsl:value-of select="count(oppeaasta/oppeaine)"/></span>
                                <span class="stat-label">Subjects</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-number"><xsl:value-of select="string-length(.)"/></span>
                                <span class="stat-label">Characters</span>
                            </div>
                        </div>
                        
                        <!-- Controls -->
                        <div class="json-controls">
                            <button class="json-btn primary" onclick="copyToClipboard()">Kopeeri JSON</button>
                            <button class="json-btn" onclick="downloadJSON()">Laadi alla</button>
                            <button class="json-btn" onclick="validateJSON()">Valideeri</button>
                        </div>
                        
                        <!-- JSON Output -->
                        <div class="json-container">
                            <div class="json-output" id="jsonOutput"><span class="json-bracket">{</span>
  <span class="json-key">"meta"</span>: <span class="json-bracket">{</span>
    <span class="json-key">"version"</span>: <span class="json-string">"1.0"</span><span class="json-comma">,</span>
    <span class="json-key">"generated"</span>: <span class="json-string">"2025-12-03"</span><span class="json-comma">,</span>
    <span class="json-key">"totalTasks"</span>: <span class="json-number"><xsl:value-of select="count(//task)"/></span><span class="json-comma">,</span>
    <span class="json-key">"subjects"</span>: <span class="json-number"><xsl:value-of select="count(oppeaasta/oppeaine)"/></span>
  <span class="json-bracket">}</span><span class="json-comma">,</span>
  <span class="json-key">"tasks"</span>: <span class="json-bracket">[</span><xsl:for-each select="//task">
    <span class="json-bracket">{</span>
      <span class="json-key">"id"</span>: <span class="json-number"><xsl:value-of select="id"/></span><span class="json-comma">,</span>
      <span class="json-key">"kuupaev"</span>: <span class="json-string">"<xsl:value-of select="kuupaev"/>"</span><span class="json-comma">,</span>
      <span class="json-key">"tahtaeg"</span>: <span class="json-string">"<xsl:value-of select="tahtaeg"/>"</span><span class="json-comma">,</span>
      <span class="json-key">"oppeaine"</span>: <span class="json-string">"<xsl:value-of select="oppeaine"/>"</span><span class="json-comma">,</span>
      <span class="json-key">"ylesanne"</span>: <span class="json-string">"<xsl:value-of select="ylesanne"/>"</span><span class="json-comma">,</span>
      <span class="json-key">"info"</span>: <span class="json-string">"<xsl:value-of select="info"/>"</span>
    <span class="json-bracket">}</span><xsl:if test="position() != last()"><span class="json-comma">,</span></xsl:if></xsl:for-each>
  <span class="json-bracket">]</span><span class="json-comma">,</span>
  <span class="json-key">"subjects"</span>: <span class="json-bracket">[</span><xsl:for-each select="oppeaasta/oppeaine">
    <span class="json-bracket">{</span>
      <span class="json-key">"name"</span>: <span class="json-string">"<xsl:value-of select="@name"/>"</span><span class="json-comma">,</span>
      <span class="json-key">"taskCount"</span>: <span class="json-number"><xsl:value-of select="count(.//task)"/></span>
    <span class="json-bracket">}</span><xsl:if test="position() != last()"><span class="json-comma">,</span></xsl:if></xsl:for-each>
  <span class="json-bracket">]</span>
<span class="json-bracket">}</span></div>
                        </div>
                        
                        <!-- Raw JSON for copying (hidden) -->
                        <textarea id="rawJSON" style="display: none;">{
  "meta": {
    "version": "1.0",
    "generated": "2025-12-03",
    "totalTasks": <xsl:value-of select="count(//task)"/>,
    "subjects": <xsl:value-of select="count(oppeaasta/oppeaine)"/>
  },
  "tasks": [<xsl:for-each select="//task">
    {
      "id": <xsl:value-of select="id"/>,
      "kuupaev": "<xsl:value-of select="kuupaev"/>",
      "tahtaeg": "<xsl:value-of select="tahtaeg"/>",
      "oppeaine": "<xsl:value-of select="oppeaine"/>",
      "ylesanne": "<xsl:value-of select="ylesanne"/>",
      "info": "<xsl:value-of select="info"/>"
    }<xsl:if test="position() != last()">,</xsl:if></xsl:for-each>
  ],
  "subjects": [<xsl:for-each select="oppeaasta/oppeaine">
    {
      "name": "<xsl:value-of select="@name"/>",
      "taskCount": <xsl:value-of select="count(.//task)"/>
    }<xsl:if test="position() != last()">,</xsl:if></xsl:for-each>
  ]
}</textarea>
                    </div>
                </div>
                
                <script><![CDATA[
                    function copyToClipboard() {
                        const textarea = document.getElementById('rawJSON');
                        textarea.style.display = 'block';
                        textarea.select();
                        document.execCommand('copy');
                        textarea.style.display = 'none';
                        
                        // Show feedback
                        const btn = event.target;
                        const originalText = btn.textContent;
                        btn.textContent = 'Kopeeritud!';
                        btn.style.backgroundColor = '#28a745';
                        
                        setTimeout(() => {
                            btn.textContent = originalText;
                            btn.style.backgroundColor = '';
                        }, 2000);
                    }
                    
                    function downloadJSON() {
                        const jsonContent = document.getElementById('rawJSON').value;
                        const blob = new Blob([jsonContent], { type: 'application/json' });
                        const url = URL.createObjectURL(blob);
                        const a = document.createElement('a');
                        a.href = url;
                        a.download = 'todo-tasks.json';
                        document.body.appendChild(a);
                        a.click();
                        document.body.removeChild(a);
                        URL.revokeObjectURL(url);
                        
                        // Show feedback
                        const btn = event.target;
                        const originalText = btn.textContent;
                        btn.textContent = '📥 Laadi allaed!';
                        btn.style.backgroundColor = '#007bff';
                        
                        setTimeout(() => {
                            btn.textContent = originalText;
                            btn.style.backgroundColor = '';
                        }, 2000);
                    }
                    
                    function validateJSON() {
                        try {
                            const jsonContent = document.getElementById('rawJSON').value;
                            JSON.parse(jsonContent);
                            
                            // Show success
                            const btn = event.target;
                            const originalText = btn.textContent;
                            btn.textContent = 'Kehtiv JSON!';
                            btn.style.backgroundColor = '#28a745';
                            
                            setTimeout(() => {
                                btn.textContent = originalText;
                                btn.style.backgroundColor = '';
                            }, 2000);
                            
                        } catch (error) {
                            alert('JSON validation error: ' + error.message);
                        }
                    }
                ]]></script>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

