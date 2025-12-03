<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <html lang="et">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <title>TODO List - Home</title>
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

                    /* Container */
                    .container {
                        max-width: 1200px;
                        margin: 0 auto;
                        background-color: #ffffff;
                        border-radius: 8px;
                        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                        overflow: hidden;
                    }

                    /* Header */
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

                    /* Navigation */
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

                    /* Content */
                    .content {
                        padding: 30px;
                    }



                    /* Table */
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
                        cursor: pointer;
                        position: relative;
                        user-select: none;
                    }

                    th:hover {
                        background-color: #e0e0e0;
                    }

                    th a {
                        color: #444;
                        text-decoration: none;
                        display: block;
                        width: 100%;
                        height: 100%;
                    }

                    th a:hover {
                        color: #222;
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

                    /* Task Priority Colors */
                    .task-id {
                        font-weight: 600;
                        color: #666;
                    }

                    .task-deadline {
                        font-weight: 500;
                    }

                    .task-subject {
                        background-color: #f0f0f0;
                        padding: 4px 8px;
                        border-radius: 3px;
                        font-weight: 500;
                    }

                    /* Filter Panel */
                    .filter-panel {
                        margin-top: 30px;
                        padding: 20px;
                        background-color: #f9f9f9;
                        border-radius: 5px;
                        border-top: 3px solid #cccccc;
                    }

                    .filter-title {
                        color: #666;
                        margin-bottom: 15px;
                        font-weight: 600;



                        flex-wrap: wrap;

                        background-color: #eeeeee;
                        color: #555;
                        text-decoration: none;
                        border-radius: 20px;
                        font-size: 13px;
                        font-weight: 500;
                        transition: all 0.2s ease;
                        border: 1px solid #ddd;

                    }

                    /* Stats */
                    .stats {
                        display: flex;
                        gap: 20px;
                        margin-bottom: 20px;
                        justify-content: center;
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
                        font-size: 2em;
                        font-weight: 300;
                        color: #666;
                    }

                    .stat-label {
                        color: #888;
                        font-size: 0.9em;
                    }

                    /* Sort Buttons */
                    .sort-panel {
                        margin-bottom: 20px;
                        padding: 15px;
                        background-color: #f9f9f9;
                        border-radius: 5px;
                    }

                    .sort-buttons {
                        display: flex;
                        gap: 10px;
                        flex-wrap: wrap;
                    }

                    .sort-btn {
                        display: inline-block;
                        padding: 10px 18px;
                        background-color: #eeeeee;
                        color: #444;
                        text-decoration: none;
                        border-radius: 4px;
                        font-size: 14px;
                        font-weight: 500;
                        transition: all 0.2s ease;
                        border: 1px solid #ddd;
                    }

                    .sort-btn:hover {
                        background-color: #cccccc;
                        border-color: #bbb;
                        transform: translateY(-1px);
                        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                    }

                    th a {
                        color: #444;
                        text-decoration: none;
                        display: block;
                        transition: color 0.2s ease;
                    }

                    th a:hover {
                        color: #222;
                        text-decoration: underline;
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

                        .nav-buttons, .sort-buttons {
                            justify-content: center;
                        }

                        .stats {
                            flex-direction: column;
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
                    <!-- Header -->
                    <div class="header">
                        <h1>TODO List</h1>
                    </div>

                    <!-- Navigation -->
                    <div class="navigation">
                        <div class="nav-buttons">
                            <a href="tasks.xml" class="nav-btn active">Avaleht</a>
                            <a href="todo_add.xml" class="nav-btn">Lisa ülesanne</a>
                            <a href="todo_json.xml" class="nav-btn">JSON</a>
                        </div>
                    </div>

                    <!-- Content -->
                    <div class="content">
                        <!-- Statistics -->
                        <div class="stats">
                            <div class="stat-item">
                                <span class="stat-number"><xsl:value-of select="count(tasks/task)"/></span>
                                <span class="stat-label">Ülesandeid kokku</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-number"><xsl:value-of select="count(tasks/task[not(oppeaine = preceding-sibling::task/oppeaine)])"/></span>
                                <span class="stat-label">Aineid</span>
                            </div>
                        </div>

                        <!-- Sort Buttons -->
                        <div class="sort-panel">
                            <div style="color: #666; margin-bottom: 10px; font-weight: 600;">Sorteeri:</div>
                            <div class="sort-buttons">
                                <a href="todo_sort_id.xml" class="sort-btn">ID järgi</a>
                                <a href="todo_sort_date.xml" class="sort-btn">Tähtaja järgi</a>
                                <a href="todo_sort_subject.xml" class="sort-btn">Õppeaine järgi</a>
                            </div>
                        </div>

                        <!-- Table -->
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th><a href="todo_sort_id.xml">ID ↕</a></th>
                                        <th>Kuupäev</th>
                                        <th><a href="todo_sort_date.xml">Tähtaeg ↕</a></th>
                                        <th><a href="todo_sort_subject.xml">Õppeaine ↕</a></th>
                                        <th>Ülesanne</th>
                                        <th>Info</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Default sorting by ID -->
                                    <xsl:apply-templates select="tasks/task">
                                        <xsl:sort select="id" data-type="number" order="ascending"/>
                                    </xsl:apply-templates>
                                </tbody>
                            </table>
                        </div>

                        <!-- Filter Panel -->

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
