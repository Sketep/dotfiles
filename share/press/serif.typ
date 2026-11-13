#import "$styledir$/common.typ": *
#show: press.with(
  font: "Source Serif 4", mono-font: "IBM Plex Mono", size: 12.5pt,
$if(title)$  title: [$title$],$endif$
$if(subtitle)$  subtitle: [$subtitle$],$endif$
$if(author)$  author: [$for(author)$$author$$sep$, $endfor$],$endif$
$if(date)$  date: [$date$],$endif$
)
$body$
