#let print-bibliography() = [
  = Литература
  #list(
    [Бхаргава А. Грокаем алгоритмы, 2-е изд. – СПб: Питер, 2024. – 352 с.],
    [Вирт Н. Алгоритмы + структуры данных = программы. – М.: Мир, 1985. – 406 с.],
    [Кнут Д.Э. Искусство программирования, том 3. Сортировка и поиск, 2-е изд. – М.: ООО «И.Д. Вильямс», 2018. – 832 с.],
    [Седжвик Р. Фундаментальные алгоритмы на C++. Анализ/Структуры данных/Сортировка/Поиск. – К.: Издательство «Диасофт», 2001. – 688 с.],
    [Алгоритмы – всё об алгоритмах / Хабр [Электронный ресурс]. URL: https://habr.com/ru/hub/algorithms/ (дата обращения 05.02.2025).]
  )
]

#let template(doc) = [
  #set text(
    lang: "ru",
    font: "Times New Roman",
    size: 14pt,
  ) 
  #set page(
    paper: "a4",
    margin: (left: 3cm, right: 1cm, top: 2cm, bottom: 2cm),
    numbering: "1"
  )

  #set table(
    stroke: 0.5pt + luma(0), // Черные тонкие линии
    inset: 4pt,              // Отступы в ячейках
    align: horizon + center, // Центрирование текста по горизонтали и вертикали
  )
  #set heading(
    numbering: "1."
  )
  #show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )
  #show raw: set text(font: "JetBrainsMono NF")
  #show raw.where(block: true): block.with(
    fill: luma(240),
    inset: 10pt,
    radius: 4pt,
  )
  #show raw.where(block: true): code => {
    show raw.line: line => {
      text(fill: gray)[#line.number]
      h(1em)
      line.body
    }
    code
  }
    #outline(title: [Содержание])
    #pagebreak()
    #doc
    #print-bibliography()
]
#let admonition(title, body, type: "info") = {
  // Настройки стилей в зависимости от типа
  let styles = (
    info: (fill: luma(240), stroke: blue, icon: sym.checkmark, title: "Инфо"),
    success: (fill: luma(245), stroke: green, icon: sym.checkmark, title: "Успех"),
    warning: (fill: luma(250), stroke: yellow, icon: sym.checkmark, title: "Внимание"),
    error: (fill: luma(250), stroke: red, icon: sym.aleph, title: "Ошибка"),
    tip: (fill: luma(240), stroke: teal, icon: sym.circle.filled, title: "Совет"),
  ).at(type)

  block(
    fill: styles.fill,
    stroke: (left: 4pt + styles.stroke), // Цветная полоска слева
    inset: 12pt,
    radius: 4pt,
    spacing: 6pt,
    [
      // Заголовок с иконкой
      #text(fill: styles.stroke, weight: "bold")[
        #styles.icon #h(6pt) #(title)
      ]
      #h(0pt) // Разрыв строки
      #body
    ]
  )
}

#let info(title, body) = admonition(title, body, type: "info")
#let success(title, body) = admonition(title, body, type: "success")
#let warning(title, body) = admonition(title, body, type: "warning")
#let error(title, body) = admonition(title, body, type: "error")
#let tip(title, body) = admonition(title, body, type: "tip")

