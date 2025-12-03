<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <!-- Parameter for filtering by subject -->
    <xsl:param name="filterSubject" select="'Matemaatika'"/>

    <xsl:template match="/">
        <html lang="et">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <title>TODO List - Filter by <xsl:value-of select="$filterSubject"/></title>
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
                        max-width: 1200px;
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

                    .filter-info {
                        background-color: #d1ecf1;
                        padding: 15px 20px;
                        margin-bottom: 25px;
                        border-radius: 5px;
                        border-left: 4px solid #17a2b8;
                        color: #0c5460;
                    }

                    .filter-controls {
                        background-color: #f9f9f9;
                        padding: 20px;
                        margin-bottom: 25px;
                        border-radius: 5px;
                        border-left: 4px solid #cccccc;
                    }

                    .filter-title {
                        color: #666;
                        margin-bottom: 15px;
                        font-weight: 600;
                    }

                    .filter-options {
                        display: flex;
                        gap: 10px;
                        flex-wrap: wrap;
                    }

                    .filter-btn {
                        display: inline-block;
                        padding: 8px 15px;
                        background-color: #eeeeee;
                        color: #444;
                        text-decoration: none;
                        border-radius: 20px;
                        font-size: 13px;
                        font-weight: 500;
                        transition: all 0.2s ease;
                        border: 1px solid #ddd;
                    }

                    .filter-btn:hover {
                        background-color: #cccccc;
                        border-color: #bbb;
                    }

                    .filter-btn.active {
                        background-color: #17a2b8;
                        color: #ffffff;
                        border-color: #17a2b8;
                    }

                    .table-container {
                        overflow-x: auto;
                    }

                    table {
                        width: 100%;
                        border-collapse: collapse;
                        background-color: #ffffff;
                    }

                    th {
                        background-color: #eeeeee;
                        color: #444;
                        padding: 15px 12px;
                        text-align: left;
                        font-weight: 600;
                        border-bottom: 2px solid #cccccc;
                    }

                    th a {
                        color: inherit;
                        text-decoration: none;
                        display: block;
                        width: 100%;
                        height: 100%;
                    }

                    td {
                        padding: 15px 12px;
                        border-bottom: 1px solid #eeeeee;
                        color: #555;
                        vertical-align: top;
                    }

                    tr:nth-child(even) {
                        background-color: #fafafa;
                    }

                    tr:hover {
                        background-color: #f0f0f0;
                    }

                    .task-id {
                        font-weight: 600;
                        color: #666;
                    }

                    .task-deadline {
                        font-weight: 500;
                    }

                    .task-subject {
                        font-weight: 600;
                        color: #17a2b8;
                        background-color: #d1ecf1;
                        padding: 6px 10px;
                        border-radius: 4px;
                        font-size: 1.1em;
                        border-left: 3px solid #17a2b8;
                    }

                    .no-results {
                        text-align: center;
                        padding: 40px 20px;
                        color: #666;
                        font-style: italic;
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

                        .nav-buttons, .filter-options {
                            justify-content: center;
                        }

                        table {
                            font-size: 14px;
                        }

                        th, td {
                            padding: 10px 8px;
                        }
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>Filter: <xsl:value-of select="$filterSubject"/></h1>
                    </div>

                    <div class="navigation">
                        <div class="nav-buttons">
                            <a href="tasks.xml" class="nav-btn active">Avaleht</a>
                            <a href="todo_add.xml" class="nav-btn">Lisa ülesanne</a>
                            <a href="todo_json.xml" class="nav-btn">JSON</a>
                        </div>
                    </div>

                    <div class="content">
                        <div class="filter-info">
                            Näidatakse ainult selle aine ülesandeid: <strong><xsl:value-of select="$filterSubject"/></strong>
                            (<xsl:value-of select="count(tasks/task[oppeaine = $filterSubject])"/> / <xsl:value-of select="count(tasks/task)"/> ülesannet)
                        </div>

                        <div class="filter-controls">
                            <div class="filter-title">Teised ained:</div>
                            <div class="filter-options">
                                <xsl:for-each select="tasks/task[not(oppeaine = preceding-sibling::task/oppeaine)]">
                                    <xsl:sort select="oppeaine"/>
                                    <a href="todo_filter_{translate(oppeaine, 'ABCDEFGHIJKLMNOPQRSTUVWXYZÆØÅ ', 'abcdefghijklmnopqrstuvwxyzæøå_')}.xml" class="filter-btn">
                                        <xsl:if test="oppeaine = $filterSubject">
                                            <xsl:attribute name="class">filter-btn active</xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="oppeaine"/> (<xsl:value-of select="count(../../task[oppeaine = current()/oppeaine])"/>)
                                    </a>
                                </xsl:for-each>
                                <a href="tasks.xml" class="filter-btn">Näita kõiki</a>
                            </div>
                        </div>

                        <div class="table-container">
                            <xsl:choose>
                                <xsl:when test="count(tasks/task[oppeaine = $filterSubject]) > 0">
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
                                            <xsl:apply-templates select="tasks/task[oppeaine = $filterSubject]">
                                                <xsl:sort select="tahtaeg" order="ascending"/>
                                            </xsl:apply-templates>
                                        </tbody>
                                    </table>
                                </xsl:when>
                                <xsl:otherwise>
                                    <div class="no-results">
                                        <h3>Tulemusi ei leitud</h3>
                                        <p>Aine "<xsl:value-of select="$filterSubject"/>" ülesandeid ei leitud.</p>
                                        <br/>
                                        <a href="tasks.xml" style="color: #17a2b8; text-decoration: none;">← Вернуться к полному списку</a>
                                    </div>
                                </xsl:otherwise>
                            </xsl:choose>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="task">
        <tr>
            <td class="task-id"><xsl:value-of select="id"/></td>
            <td><xsl:value-of select="kuupaev"/></td>
            <td class="task-deadline"><xsl:value-of select="tahtaeg"/></td>
            <td class="task-subject"><xsl:value-of select="oppeaine"/></td>
            <td><strong><xsl:value-of select="ylesanne"/></strong></td>
            <td><xsl:value-of select="info"/></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
