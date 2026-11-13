#import "$styledir$/common.typ": *
#show: press.with(
  font: "IBM Plex Sans", mono-font: "IBM Plex Mono", size: 12pt, justify: false,
$if(title)$  title: [$title$],$endif$
$if(subtitle)$  subtitle: [$subtitle$],$endif$
$if(author)$  author: [$for(author)$$author$$sep$, $endfor$],$endif$
$if(date)$  date: [$date$],$endif$
)
$body$
