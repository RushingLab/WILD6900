.onLoad <- function(libname="WILD3810", pkgname="WILD3810") {
  options(digits = 4)
  library(ggplot2)
  theme_spacelab <- function(base_size = 12, base_family = "") {
    half_line <- base_size / 2
    theme(
      # Elements in this first block aren't used directly, but are inherited
      # by others
      line = element_line(
        size = 0.5, linetype = 1, colour = "black",
        lineend = "butt", color ="#f89406"
      ),
      rect = element_rect(fill = "white", colour = "black", size = 0.5, linetype = 1),
      text = element_text(
        family = base_family, face = "plain", colour = "black",
        size = base_size,
        hjust = 0.5, vjust = 0.5, angle = 0, lineheight = 0.9, margin = margin(),
        debug = FALSE
      ),
      axis.text = element_text(size = rel(0.8), color = "#999999"),
      axis.title = element_text(size = rel(0.8), color = "#999999", vjust = 0.35),
      strip.text = element_text(size = rel(0.8)),

      axis.line = element_line(size = 0.8, color = "#999999"),
      axis.line.x = NULL,
      axis.line.y = NULL,
      axis.text.x = element_text(
        size = base_size * 1.2, lineheight = 0.9,
        margin = margin(t = 0.8 * half_line / 2), vjust = 1
      ),
      axis.text.x.top = element_text(margin = margin(b = 0.8 * half_line / 2), vjust = 0),
      axis.text.y = element_text(
        size = base_size * 1.2, lineheight = 0.9,
        margin = margin(r = 0.8 * half_line / 2), vjust = 0.5
      ),
      axis.text.y.right = element_text(margin = margin(l = 0.8 * half_line / 2), hjust = 0),
      axis.ticks = element_line(size = 0.2, color = "#999999"),
      axis.title.x = element_text(
        size = base_size * 1.8, vjust = 0.3,
        margin = margin(t = 10, b = 0.8 * half_line / 2)
      ),
      axis.title.x.top = element_text(margin = margin(b = half_line), vjust = 0),
      axis.title.y = element_text(
        size = base_size * 1.8, angle = 90, vjust = 1,
        margin = margin(r = 10, l = 0.8 * half_line / 2)
      ),
      axis.title.y.right = element_text(angle = -90, margin = margin(l = half_line), vjust = 0),
      axis.ticks.length = grid::unit(0.3, "lines"),

      legend.background = element_rect(colour = NA),
      legend.spacing = unit(0.4, "cm"),
      legend.spacing.x = NULL,
      legend.spacing.y = NULL,
      legend.margin = margin(
        half_line, half_line, half_line,
        half_line
      ),
      legend.box.margin = margin(0, 0, 0, 0, "cm"),
      legend.box.background = element_blank(),
      legend.box.spacing = unit(0.4, "cm"),
      legend.key = element_rect(colour = "#999999"),
      legend.key.size = grid::unit(1.2, "lines"),
      legend.key.height = NULL,
      legend.key.width = NULL,
      legend.text = element_text(size = base_size, color = "#999999"),
      legend.text.align = NULL,
      legend.title = element_blank(),
      legend.title.align = NULL,
      legend.position = "right",
      legend.direction = NULL,
      legend.justification = "center",
      legend.box = NULL,

      panel.background = element_rect(colour = NA),
      panel.border = element_rect(fill = NA, color = NA, size = .5),
      panel.grid = element_blank(),
      panel.grid.minor = element_blank(),
      panel.spacing = grid::unit(half_line, "pt"),
      panel.ontop = FALSE,
      panel.spacing.x = NULL,
      panel.spacing.y = NULL,


      strip.background = element_rect(colour = NA),
      strip.text.x = element_text(size = base_size * 1.6, margin = margin(t = half_line, b = half_line), face = "bold", color = "#999999"),
      strip.text.y = element_text(size = base_size * 1.6, angle = -90, margin = margin(l = half_line, r = half_line), face = "bold", color = "#999999"),
      strip.switch.pad.grid = unit(0.1, "cm"),
      strip.switch.pad.wrap = unit(0.1, "cm"),
      strip.placement = "inside",

      plot.tag = element_text(
        size = rel(1.2), color = "#999999",
        hjust = 0.5, vjust = 0.5
      ),
      plot.tag.position = 'topleft',

      plot.background = element_rect(colour = NA),
      plot.title = element_text(color = "#999999",
        size = base_size * 2, hjust = 0, face = "bold",
        vjust = 2, margin = margin(b = half_line * 1.2)
      ),
      plot.subtitle = element_text(color = "#999999",
        size = base_size * 1.2, hjust = 0,
        vjust = 2, margin = margin(b = half_line * 0.9)
      ),
      plot.caption = element_text(color = "#999999",
        size = rel(0.9), hjust = 1,
        vjust = 2, margin = margin(t = half_line * 0.9)
      ),
      plot.margin = margin(
        half_line, half_line, half_line,
        half_line
      ), complete = TRUE
    )
  }


  theme_set(theme_spacelab())
  update_geom_defaults("point", list(size = 3))
  update_geom_defaults("line", list(size = 0.8))
}
