<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html lang="et">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <title>TODO List - Add Task</title>
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
                        max-width: 800px;
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
                        padding: 40px 30px;
                    }
                    
                    /* Form Styles */
                    .form-container {
                        max-width: 600px;
                        margin: 0 auto;
                    }
                    
                    .form-intro {
                        background-color: #f9f9f9;
                        padding: 20px;
                        border-radius: 5px;
                        margin-bottom: 30px;
                        border-left: 4px solid #cccccc;
                    }
                    
                    .form-group {
                        margin-bottom: 25px;
                    }
                    
                    label {
                        display: block;
                        margin-bottom: 8px;
                        color: #555;
                        font-weight: 600;
                        font-size: 14px;
                    }
                    
                    input[type="text"],
                    input[type="date"],
                    textarea,
                    select {
                        width: 100%;
                        padding: 12px 15px;
                        border: 2px solid #eeeeee;
                        border-radius: 5px;
                        font-size: 16px;
                        font-family: inherit;
                        background-color: #fafafa;
                        transition: all 0.3s ease;
                    }
                    
                    input[type="text"]:focus,
                    input[type="date"]:focus,
                    textarea:focus,
                    select:focus {
                        outline: none;
                        border-color: #888;
                        background-color: #ffffff;
                        box-shadow: 0 0 5px rgba(136,136,136,0.3);
                    }
                    
                    textarea {
                        min-height: 100px;
                        resize: vertical;
                        font-family: inherit;
                    }
                    
                    .form-hint {
                        font-size: 12px;
                        color: #666;
                        margin-top: 5px;
                    }
                    
                    /* Existing Subjects */
                    .existing-subjects {
                        margin-top: 10px;
                        padding: 15px;
                        background-color: #f0f0f0;
                        border-radius: 4px;
                    }
                    
                    .existing-subjects h4 {
                        color: #666;
                        font-size: 13px;
                        margin-bottom: 10px;
                        text-transform: uppercase;
                    }
                    
                    .subject-tags {
                        display: flex;
                        gap: 8px;
                        flex-wrap: wrap;
                    }
                    
                    .subject-tag {
                        display: inline-block;
                        padding: 4px 10px;
                        background-color: #eeeeee;
                        color: #555;
                        border-radius: 15px;
                        font-size: 12px;
                        font-weight: 500;
                        cursor: pointer;
                        transition: all 0.2s ease;
                        border: 1px solid #ddd;
                    }
                    
                    .subject-tag:hover {
                        background-color: #cccccc;
                        color: #333;
                    }
                    
                    /* Buttons */
                    .button-group {
                        display: flex;
                        gap: 15px;
                        justify-content: center;
                        margin-top: 30px;
                        flex-wrap: wrap;
                    }
                    
                    .btn {
                        padding: 15px 30px;
                        border: none;
                        border-radius: 5px;
                        font-size: 16px;
                        font-weight: 600;
                        cursor: pointer;
                        transition: all 0.3s ease;
                        text-decoration: none;
                        display: inline-block;
                        text-align: center;
                        min-width: 150px;
                    }
                    
                    .btn-primary {
                        background-color: #888;
                        color: #ffffff;
                    }
                    
                    .btn-primary:hover {
                        background-color: #666;
                        transform: translateY(-2px);
                        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
                    }
                    
                    .btn-secondary {
                        background-color: #eeeeee;
                        color: #333;
                        border: 2px solid #cccccc;
                    }
                    
                    .btn-secondary:hover {
                        background-color: #cccccc;
                        border-color: #aaa;
                    }
                    
                    /* Form validation styling */
                    .required {
                        color: #dc3545;
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
                        
                        .nav-buttons {
                            justify-content: center;
                        }
                        
                        .button-group {
                            flex-direction: column;
                            align-items: center;
                        }
                        
                        .btn {
                            width: 100%;
                            max-width: 300px;
                        }
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>➕ Add New Task</h1>
                    </div>
                    
                    <div class="navigation">
                        <div class="nav-buttons">
                            <a href="tasks.xml" class="nav-btn">🏠 Home</a>
                            <a href="todo_add.xml" class="nav-btn active">➕ Add Task</a>
                            <a href="todo_json.xml" class="nav-btn">📄 JSON</a>
                        </div>
                    </div>
                    
                    <div class="content">
                        <div class="form-container">
                            <div class="form-intro">
                                <p><strong>Создайте новую задачу</strong></p>
                                <p>Заполните форму ниже, чтобы добавить новую задачу в ваш список дел. Все поля, отмеченные звездочкой (*), обязательны для заполнения.</p>
                            </div>
                            
                            <form id="taskForm" onsubmit="return handleFormSubmit(event);">
                                <!-- ID будет автоматически сгенерирован -->
                                <input type="hidden" name="id" value="{count(tasks/task) + 1}"/>
                                
                                <div class="form-group">
                                    <label for="kuupaev">Kuupäev (Date Created) <span class="required">*</span></label>
                                    <input type="date" id="kuupaev" name="kuupaev" required="required" value="2025-12-03"/>
                                    <div class="form-hint">Дата создания задачи</div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="tahtaeg">Tähtaeg (Deadline) <span class="required">*</span></label>
                                    <input type="date" id="tahtaeg" name="tahtaeg" required="required"/>
                                    <div class="form-hint">Крайний срок выполнения задачи</div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="oppeaine">Õppeaine (Subject) <span class="required">*</span></label>
                                    <input type="text" id="oppeaine" name="oppeaine" placeholder="Введите название предмета" required="required" maxlength="50"/>
                                    <div class="form-hint">Учебный предмет или категория задачи</div>
                                    
                                    <div class="existing-subjects">
                                        <h4>Существующие предметы:</h4>
                                        <div class="subject-tags">
                                            <xsl:for-each select="tasks/task[not(oppeaine = preceding-sibling::task/oppeaine)]">
                                                <xsl:sort select="oppeaine"/>
                                                <span class="subject-tag" onclick="document.getElementById('oppeaine').value = this.textContent">
                                                    <xsl:value-of select="oppeaine"/>
                                                </span>
                                            </xsl:for-each>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="ylesanne">Ülesanne (Task Title) <span class="required">*</span></label>
                                    <input type="text" id="ylesanne" name="ylesanne" placeholder="Краткое название задачи" required="required" maxlength="100"/>
                                    <div class="form-hint">Краткое описание задачи</div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="info">Info (Additional Information)</label>
                                    <textarea id="info" name="info" placeholder="Дополнительная информация о задаче (опционально)..." maxlength="500"></textarea>
                                    <div class="form-hint">Подробное описание, заметки или дополнительная информация</div>
                                </div>
                                
                                <div class="button-group">
                                    <button type="button" class="btn btn-primary" onclick="handleFormSubmit(event)">💾 Create Task</button>
                                    <a href="tasks.xml" class="btn btn-secondary">❌ Cancel</a>
                                </div>
                            </form>
                            
                            <!-- Current Tasks Preview -->
                            <div style="margin-top: 40px; padding: 20px; background-color: #f9f9f9; border-radius: 5px;">
                                <h3 style="color: #666; margin-bottom: 15px;">📋 Current Tasks (<xsl:value-of select="count(tasks/task)"/>):</h3>
                                <div style="max-height: 200px; overflow-y: auto;">
                                    <xsl:for-each select="tasks/task">
                                        <xsl:sort select="id" data-type="number"/>
                                        <div style="padding: 8px 0; border-bottom: 1px solid #eee; display: flex; justify-content: space-between;">
                                            <span><strong><xsl:value-of select="ylesanne"/></strong> (<xsl:value-of select="oppeaine"/>)</span>
                                            <span style="color: #666;"><xsl:value-of select="tahtaeg"/></span>
                                        </div>
                                    </xsl:for-each>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <script><![CDATA[
                    // Автозаполнение предмета по клику на тег
                    function selectSubject(subject) {
                        document.getElementById('oppeaine').value = subject;
                    }
                    
                    // Обработка отправки формы
                    function handleFormSubmit(event) {
                        if (event) event.preventDefault();
                        
                        // Получаем данные формы
                        const kuupaev = document.getElementById('kuupaev').value;
                        const tahtaeg = document.getElementById('tahtaeg').value;
                        const oppeaine = document.getElementById('oppeaine').value;
                        const ylesanne = document.getElementById('ylesanne').value;
                        const info = document.getElementById('info').value;
                        
                        // Валидация
                        if (!kuupaev || !tahtaeg || !oppeaine || !ylesanne) {
                            alert('Заполните все обязательные поля!');
                            return false;
                        }
                        
                        const deadline = new Date(tahtaeg);
                        const created = new Date(kuupaev);
                        
                        if (deadline <= created) {
                            alert('Срок выполнения должен быть позже даты создания!');
                            return false;
                        }
                        
                        // Показываем превью и опции сохранения
                        showSaveOptions(kuupaev, tahtaeg, oppeaine, ylesanne, info);
                        return false;
                    }
                    
                    // Показать опции сохранения
                    function showSaveOptions(kuupaev, tahtaeg, oppeaine, ylesanne, info) {
                        const modal = `
                            <div id="saveModal" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000; display: flex; align-items: center; justify-content: center;">
                                <div style="background: white; padding: 30px; border-radius: 10px; max-width: 500px; width: 90%; box-shadow: 0 10px 30px rgba(0,0,0,0.3);">
                                    <h2 style="color: #444; margin-bottom: 20px;">💾 Сохранить задачу</h2>
                                    <div style="background: #f9f9f9; padding: 15px; border-radius: 5px; margin: 15px 0;">
                                        <p><strong>Предмет:</strong> ${oppeaine}</p>
                                        <p><strong>Задача:</strong> ${ylesanne}</p>
                                        <p><strong>Создана:</strong> ${kuupaev}</p>
                                        <p><strong>Срок:</strong> ${tahtaeg}</p>
                                        <p><strong>Детали:</strong> ${info || 'Без дополнительной информации'}</p>
                                    </div>
                                    <div style="text-align: center; margin-top: 20px;">
                                        <button onclick="saveToXML('${kuupaev}', '${tahtaeg}', '${oppeaine}', '${ylesanne}', '${info}')" style="background: #28a745; color: white; border: none; padding: 12px 20px; border-radius: 5px; margin-right: 10px; cursor: pointer;">📁 Сохранить в XML</button>
                                        <button onclick="downloadXML('${kuupaev}', '${tahtaeg}', '${oppeaine}', '${ylesanne}', '${info}')" style="background: #007bff; color: white; border: none; padding: 12px 20px; border-radius: 5px; margin-right: 10px; cursor: pointer;">💾 Скачать XML</button>
                                        <button onclick="closeModal()" style="background: #888; color: white; border: none; padding: 12px 20px; border-radius: 5px; cursor: pointer;">❌ Отмена</button>
                                    </div>
                                </div>
                            </div>
                        `;
                        document.body.insertAdjacentHTML('beforeend', modal);
                    }
                    
                    // Сохранить в XML (реальное сохранение)
                    function saveToXML(kuupaev, tahtaeg, oppeaine, ylesanne, info) {
                        const data = {
                            kuupaev: kuupaev,
                            tahtaeg: tahtaeg,
                            oppeaine: oppeaine,
                            ylesanne: ylesanne,
                            info: info
                        };
                        
                        // Отправляем AJAX-запрос
                        fetch('/save_task', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify(data)
                        })
                        .then(response => response.json())
                        .then(result => {
                            if (result.success) {
                                alert(`✅ Задача успешно сохранена!\nID: ${result.id}\n\nПерейдем на главную страницу.`);
                                closeModal();
                                window.location.href = 'tasks.xml';
                            } else {
                                alert(`❌ Ошибка сохранения: ${result.message}`);
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('❌ Ошибка сети при сохранении задачи');
                        });
                    }
                    
                    // Скачать как XML
                    function downloadXML(kuupaev, tahtaeg, oppeaine, ylesanne, info) {
                        const newId = Math.floor(Math.random() * 1000) + 7; // Новый ID
                        const xmlContent = `<?xml version="1.0" encoding="UTF-8"?>
<task>
    <id>${newId}</id>
    <kuupaev>${kuupaev}</kuupaev>
    <tahtaeg>${tahtaeg}</tahtaeg>
    <oppeaine>${oppeaine}</oppeaine>
    <ylesanne>${ylesanne}</ylesanne>
    <info>${info}</info>
</task>`;
                        
                        const blob = new Blob([xmlContent], { type: 'application/xml' });
                        const url = URL.createObjectURL(blob);
                        const a = document.createElement('a');
                        a.href = url;
                        a.download = `task-${newId}.xml`;
                        document.body.appendChild(a);
                        a.click();
                        document.body.removeChild(a);
                        URL.revokeObjectURL(url);
                        
                        closeModal();
                    }
                    
                    // Закрыть модальное окно
                    function closeModal() {
                        const modal = document.getElementById('saveModal');
                        if (modal) {
                            modal.remove();
                        }
                    }

                ]]></script>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
