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
                <script>
                <![CDATA[
                // Delete task function
                function deleteTask(taskId) {
                    if (!confirm('Kas olete kindel, et soovite selle ülesande kustutada?')) {
                        return;
                    }
                    
                    fetch('delete_task.php', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({ id: taskId })
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            alert('Ülesanne edukalt kustutatud!');
                            window.location.reload();
                        } else {
                            alert('Viga: ' + data.message);
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Kustutamine ebaõnnestus: ' + error);
                    });
                }
                
                // Sort table function
                function sortTable(column) {
                    const table = document.querySelector('tbody');
                    const rows = Array.from(table.querySelectorAll('tr'));
                    
                    rows.sort((a, b) => {
                        let aVal, bVal;
                        
                        switch(column) {
                            case 'id':
                                aVal = parseInt(a.cells[0].textContent);
                                bVal = parseInt(b.cells[0].textContent);
                                break;
                            case 'date':
                                aVal = new Date(a.cells[1].textContent);
                                bVal = new Date(b.cells[1].textContent);
                                break;
                            case 'deadline':
                                aVal = new Date(a.cells[2].textContent);
                                bVal = new Date(b.cells[2].textContent);
                                break;
                            case 'subject':
                                aVal = a.cells[3].textContent.toLowerCase();
                                bVal = b.cells[3].textContent.toLowerCase();
                                break;
                        }
                        
                        return aVal > bVal ? 1 : aVal < bVal ? -1 : 0;
                    });
                    
                    rows.forEach(row => table.appendChild(row));
                }
                
                // Filter by subject
                function filterBySubject(subject) {
                    const rows = document.querySelectorAll('tbody tr');
                    
                    rows.forEach(row => {
                        if (subject === 'all') {
                            row.style.display = '';
                        } else {
                            const subjectCell = row.cells[3].textContent;
                            row.style.display = subjectCell === subject ? '' : 'none';
                        }
                    });
                }
                
                // Update stats after filtering
                function updateStats() {
                    const visibleRows = document.querySelectorAll('tbody tr:not([style*="display: none"])');
                    const subjects = new Set();
                    
                    visibleRows.forEach(row => {
                        subjects.add(row.cells[3].textContent);
                    });
                    
                    document.querySelectorAll('.stat-number')[0].textContent = visibleRows.length;
                    document.querySelectorAll('.stat-number')[1].textContent = subjects.size;
                }
                ]]>
                </script>
                <div class="container">
                    <!-- Header -->
                    <div class="header">
                        <h1>TODO List</h1>
                    </div>

                    <!-- Navigation -->
                    <div class="navigation">
                        <div class="nav-buttons">
                            <a href="view.php?view=home" class="nav-btn active">Avaleht</a>
                            <a href="view.php?view=add" class="nav-btn">Lisa ülesanne</a>
                            <a href="view.php?view=json" class="nav-btn">JSON</a>
                        </div>
                    </div>

                    <!-- Content -->
                    <div class="content">
                        <!-- Statistics -->
                        <div class="stats">
                            <div class="stat-item">
                                <span class="stat-number"><xsl:value-of select="count(//task)"/></span>
                                <span class="stat-label">Ülesandeid kokku</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-number"><xsl:value-of select="count(oppeaasta/oppeaine)"/></span>
                                <span class="stat-label">Aineid</span>
                            </div>
                        </div>

                        <!-- Sort Buttons -->
                        <div class="sort-panel">
                            <div style="color: #666; margin-bottom: 10px; font-weight: 600;">Sorteeri:</div>
                            <div class="sort-buttons">
                                <button onclick="sortTable('id')" class="sort-btn" style="border: none; cursor: pointer;">ID järgi</button>
                                <button onclick="sortTable('deadline')" class="sort-btn" style="border: none; cursor: pointer;">Tähtaja järgi</button>
                                <button onclick="sortTable('subject')" class="sort-btn" style="border: none; cursor: pointer;">Õppeaine järgi</button>
                            </div>
                        </div>

                        <!-- Filter by Subject -->
                        <div class="sort-panel" style="margin-top: 20px;">
                            <div style="color: #666; margin-bottom: 10px; font-weight: 600;">Filtreeri õppeaine järgi:</div>
                            <div class="sort-buttons">
                                <button onclick="filterBySubject('all')" class="sort-btn" style="border: none; cursor: pointer;">Näita kõiki</button>
                                <xsl:for-each select="oppeaasta/oppeaine">
                                    <xsl:sort select="@name"/>
                                    <button onclick="filterBySubject('{@name}')" class="sort-btn" style="border: none; cursor: pointer;">
                                        <xsl:value-of select="@name"/>
                                    </button>
                                </xsl:for-each>
                            </div>
                        </div>

                        <!-- Table -->
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th style="cursor: pointer;" onclick="sortTable('id')">ID ↕</th>
                                        <th>Kuupäev</th>
                                        <th style="cursor: pointer;" onclick="sortTable('deadline')">Tähtaeg ↕</th>
                                        <th style="cursor: pointer;" onclick="sortTable('subject')">Õppeaine ↕</th>
                                        <th>Ülesanne</th>
                                        <th>Info</th>
                                        <th style="width: 80px; text-align: center;">Tegevused</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Default sorting by ID -->
                                    <xsl:apply-templates select="//task">
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
            <td style="text-align: center;">
                <button onclick="deleteTask({id})" style="padding: 6px 12px; background-color: #dc3545; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 13px; transition: background-color 0.2s;">
                    Kustuta
                </button>
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
