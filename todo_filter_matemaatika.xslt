<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html lang="et">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <title>TODO List - Matemaatika Tasks</title>
                <style>
                    * { margin: 0; padding: 0; box-sizing: border-box; }
                    body { font-family: 'Segoe UI', sans-serif; background: #f5f5f5; color: #333; line-height: 1.6; padding: 20px; }
                    .container { max-width: 1200px; margin: 0 auto; background: #fff; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); overflow: hidden; }
                    .header { background: #eeeeee; padding: 30px; border-bottom: 2px solid #cccccc; }
                    h1 { color: #444; font-weight: 300; font-size: 2.5em; text-align: center; }
                    .navigation { background: #fff; padding: 20px 30px; border-bottom: 1px solid #eee; }
                    .nav-buttons { display: flex; gap: 15px; justify-content: center; flex-wrap: wrap; }
                    .nav-btn { display: inline-block; padding: 12px 24px; background: #eeeeee; color: #333; text-decoration: none; border-radius: 5px; font-weight: 500; transition: all 0.3s ease; border: 2px solid transparent; }
                    .nav-btn:hover { background: #cccccc; transform: translateY(-2px); }
                    .nav-btn.active { background: #888; color: #fff; border-color: #666; }
                    .content { padding: 30px; }
                    .filter-info { background: #fff3cd; padding: 15px 20px; margin-bottom: 25px; border-radius: 5px; border-left: 4px solid #ffc107; color: #856404; }
                    table { width: 100%; border-collapse: collapse; background: #fff; margin-top: 15px; }
                    th { background: #eeeeee; color: #444; padding: 15px 12px; text-align: left; font-weight: 600; border-bottom: 2px solid #ccc; }
                    th a { color: inherit; text-decoration: none; display: block; width: 100%; height: 100%; }
                    td { padding: 15px 12px; border-bottom: 1px solid #eee; color: #555; vertical-align: top; }
                    tr:nth-child(even) { background: #fafafa; }
                    tr:hover { background: #f0f0f0; }
                    .task-subject { font-weight: 600; color: #ffc107; background: #fff3cd; padding: 6px 10px; border-radius: 4px; border-left: 3px solid #ffc107; }
                    .no-results { text-align: center; padding: 40px 20px; color: #666; font-style: italic; }
                    @media (max-width: 768px) {
                        .container { margin: 10px; border-radius: 0; }
                        .header, .content, .navigation { padding: 20px; }
                        h1 { font-size: 2em; }
                        table { font-size: 14px; }
                        th, td { padding: 10px 8px; }
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>Matemaatika Tasks</h1>
                    </div>
                    
                    <div class="navigation">
                        <div class="nav-buttons">
                            <a href="tasks.xml" class="nav-btn active">Home</a>
                            <a href="todo_add.xml" class="nav-btn">Lisa ülesanne</a>
                            <a href="todo_json.xml" class="nav-btn">JSON</a>
                        </div>
                    </div>
                    
                    <div class="content">
                        <div class="filter-info">
                            Näidatakse ainult ülesanded aine: <strong>Matemaatika</strong>
                            (<xsl:value-of select="count(tasks/task[oppeaine = 'Matemaatika'])"/> / <xsl:value-of select="count(tasks/task)"/> ülesannet)
                        </div>
                        
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Kuupäev</th>
                                    <th>Tähtaeg</th>
                                    <th>Õppeaine</th>
                                    <th>Ülesanne</th>
                                    <th>Info</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:choose>
                                    <xsl:when test="count(tasks/task[oppeaine = 'Matemaatika']) > 0">
                                        <xsl:apply-templates select="tasks/task[oppeaine = 'Matemaatika']">
                                            <xsl:sort select="tahtaeg" order="ascending"/>
                                        </xsl:apply-templates>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <tr>
                                            <td colspan="6" class="no-results">
                                                Aine "Matemaatika" ülesandeid ei leitud
                                            </td>
                                        </tr>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </tbody>
                        </table>
                        
                        <div style="margin-top: 30px; text-align: center;">
                            <a href="tasks.xml" style="display: inline-block; padding: 12px 24px; background: #888; color: #fff; text-decoration: none; border-radius: 5px; font-weight: 500;">← Показать все ülesannetи</a>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="task">
        <tr>
            <td style="font-weight: 600; color: #666;"><xsl:value-of select="id"/></td>
            <td><xsl:value-of select="kuupaev"/></td>
            <td style="font-weight: 500;"><xsl:value-of select="tahtaeg"/></td>
            <td class="task-subject"><xsl:value-of select="oppeaine"/></td>
            <td><strong><xsl:value-of select="ylesanne"/></strong></td>
            <td><xsl:value-of select="info"/></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
