#let callout-kinds = (
  note: (rgb("#0969da"), "Note"),
  tip: (rgb("#1a7f37"), "Tip"),
  important: (rgb("#8250df"), "Important"),
  warning: (rgb("#9a6700"), "Warning"),
  caution: (rgb("#cf222e"), "Caution"),
)
#let callout(kind, body) = {
  let (c, label) = callout-kinds.at(kind)
  block(width: 100%, breakable: true, fill: c.lighten(93%), stroke: (left: 3pt + c),
    inset: (x: 12pt, y: 9pt), radius: (right: 3pt))[
    #block(below: 0.6em, text(fill: c, weight: "bold", size: 0.9em, label))
    #body
  ]
}

#let horizontalrule = block(above: 1.4em, below: 1.4em,
  line(length: 100%, stroke: 0.8pt + luma(150)))

#let press(
  font: "Source Serif 4",
  mono-font: "Source Code Pro",
  size: 12.5pt,
  accent: rgb("#1f3a68"),
  margin: 0.6in,
  justify: true,
  head-weight: "semibold",
  h1-rule: false,
  h2-smallcaps: false,
  table-style: "filled", // "grid" | "zebra" | "filled"
  title: none, subtitle: none, author: none, date: none,
  doc,
) = {
  if title != none { set document(title: title) }

  set page(paper: "us-letter", margin: margin, footer: context {
    set text(size: 0.85em, fill: luma(90))
    align(center, counter(page).display())
  })
  set text(font: font, size: size, lang: "en", hyphenate: justify)
  set par(justify: justify, leading: 0.68em, spacing: 1.1em)
  set list(indent: 0.5em, marker: ([•], [◦], [–]))
  set enum(indent: 0.5em)

  // code
  show raw: set text(font: mono-font, size: 1.1em)
  show raw.where(block: true): it => block(width: 100%, fill: luma(247),
    stroke: 0.5pt + luma(222), inset: 10pt, radius: 3pt, it)
  show raw.where(block: false): box.with(fill: luma(239), inset: (x: 3pt),
    outset: (y: 2.5pt), radius: 2pt)

  // task-list checkboxes (pandoc emits ☐ / ☒); drawn so no font fallback is needed
  let cb(checked) = box(width: 0.8em, height: 0.8em, baseline: 0.1em, radius: 1.5pt,
    stroke: 0.7pt + (if checked { accent } else { luma(90) }),
    fill: if checked { accent } else { none },
    if checked { place(curve(stroke: (paint: white, thickness: 0.12em, cap: "round", join: "round"),
      curve.move((0.18em, 0.42em)), curve.line((0.35em, 0.6em)), curve.line((0.63em, 0.2em)))) })
  show "☐": cb(false)
  show "☒": cb(true)

  show link: set text(fill: accent)
  show quote.where(block: true): it => block(stroke: (left: 2pt + accent.lighten(60%)),
    inset: (left: 12pt, y: 3pt), text(fill: luma(60), it.body))

  // tables (column widths/alignment come from the Lua filter)
  show table: set par(justify: false)
  set table(inset: (x: 8pt, y: 6pt))
  show table.cell.where(y: 0): set text(weight: "bold",
    fill: if table-style == "filled" { white } else { black })
  set table(stroke: 0.5pt + luma(170),
    fill: (x, y) => if y == 0 { accent.lighten(88%) }) if table-style == "grid"
  set table(stroke: (x, y) => if y == 0 { (bottom: 1pt + accent) } else { none },
    fill: (x, y) => if y > 0 and calc.even(y) { luma(243) }) if table-style == "zebra"
  set table(stroke: (x, y) => (bottom: 0.4pt + luma(210)),
    fill: (x, y) => if y == 0 { accent }) if table-style == "filled"
  show table.hline: none

  // headings: same font as body, sizes strictly decreasing from title
  let sizes = (2.0, 1.6, 1.3, 1.12, 1.0)  // title, h1..h4
  show heading: set text(fill: accent, weight: head-weight)
  show heading: it => {
    let lvl = calc.min(it.level, 4)
    let sz = size * sizes.at(lvl)
    let body = if lvl == 2 and h2-smallcaps { smallcaps(text(tracking: 0.04em, it.body)) }
      else if lvl == 4 { emph(it.body) } else { it.body }
    let ruled = lvl == 1 and h1-rule
    block(width: 100%, above: if lvl == 1 { 1.6em } else { 1.3em }, below: 0.7em,
      sticky: true,
      inset: if ruled { (bottom: 0.3em) } else { 0pt },
      stroke: if ruled { (bottom: 0.6pt + accent) } else { none },
      text(size: sz, body))
  }

  // title block
  if title != none {
    block(below: 1.4em, width: 100%)[
      #text(size: size * sizes.at(0), weight: head-weight, fill: accent, title)
      #if subtitle != none { v(-0.5em); text(size: size * 1.15, fill: luma(60), subtitle) }
      #if author != none or date != none {
        v(-0.3em)
        text(fill: luma(50), (author, date).filter(x => x != none).join([ #h(0.3em)·#h(0.3em) ]))
      }
      #v(-0.3em)
      #line(length: 100%, stroke: 1.2pt + accent)
    ]
  }
  doc
}
