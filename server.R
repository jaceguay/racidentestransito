shinyServer(function (input, output) {
  color <- colorFactor(topo.colors(6), dados$tipo)
  output$mapa <- renderLeaflet({
    leaflet(dados) %>%
      setView(lng = -48.6874,
              lat = -26.9046,
              zoom = 12) %>%
      ## mapa fundo
      addProviderTiles("CartoDB.Positron", options = providerTileOptions(noWrap = TRUE)) %>%
      ## círculos
      addCircleMarkers(
        lng =  ~ longX,
        lat =  ~ latY,
        radius =  5,
        stroke = FALSE,
        fillOpacity = 0.5,
        color =  ~ color(tipo),
        # Popup content
        popup =  ~ paste("<b>",
                         tipo,
                         "</b><br/>",
                         "date: ",
                         as.character(data))
      ) %>%
      ##legenda
      addLegend(
        "bottomleft",
        pal = color,
        values =  ~ tipo,
        opacity = 1,
        title = "Tipo de ocorrências"
      )
  })
})