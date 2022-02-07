server <- function(input, output){
  
  # Tab Home
  # Category Plot
  output$cat_plot <- renderPlotly({
    trend_cat <- main %>% 
      group_by(category_id) %>% 
      summarise(Jumlah = n()) %>% 
      ungroup() %>% 
      arrange(desc(Jumlah)) %>% 
      mutate(label = glue("Category: {category_id}
                      {Jumlah} Video"))
    
    trend_cat_plot <- ggplot(trend_cat, aes(
      x = Jumlah, 
      y = reorder(category_id, Jumlah),
      text = label)) +
      geom_col(aes(fill = Jumlah)) +
      scale_fill_gradient(low = "#CC6600", high = "#660000") +
      theme_get() +
      labs(
        x = "Jumlah Video",
        y = NULL
      ) + 
      theme(
        legend.position = "none"
      )
    
    ggplotly(trend_cat_plot, tooltip="text")
  })
  
  # Data Overview
  output$main_data <- renderDataTable({
    datatable(cbind(main),
              extensions = c("FixedColumns", "FixedHeader", "Scroller"),
              options = list(
                searching = TRUE,
                autoWidth = TRUE,
                rownames = FALSE,
                scroller = TRUE,
                scrollX = TRUE,
                scrollY = "500px",
                fixedHeader = TRUE,
                class = 'cell-border stripe'
              )
            )
  })
  
  # Tab Tren
  # Top Views Channel
  output$top_views_channel <- renderValueBox({
    pop_chan_views <- main %>% 
      filter(category_id == input$category) %>% 
      group_by(channel_name) %>% 
      summarise(Avg_views = mean(view)) %>% 
      ungroup() %>% 
      arrange(desc(Avg_views)) %>%
      head(1)
    
    valueBox(
      pop_chan_views$channel_name, "Top Views", 
      color = "purple"
    )
  })
  # Populer Channel
  output$popular_channel <- renderValueBox({
    means_per_likes <- main %>% 
      filter(category_id == input$category) %>% 
      group_by(channel_name) %>% 
      summarise(avg_views_per_likes = round(mean(view/like))) %>% 
      ungroup() %>% 
      arrange(desc(avg_views_per_likes)) %>% 
      head(1)
    
    valueBox(
      means_per_likes$channel_name, "The Most Populer", 
      color = "purple"
    )
  })
  
  # Plotly Top Views
  output$top_views_plot <- renderPlotly({
    pop_chan_views <- main %>% 
      filter(category_id == input$category) %>% 
      group_by(channel_name) %>% 
      summarise(Avg_views = mean(view)) %>% 
      ungroup() %>% 
      arrange(desc(Avg_views)) %>%
      head(10) %>% 
      mutate(Avg_views = round(Avg_views/1000000, 2),
             label = glue("Channel: {channel_name}
                      {Avg_views} views")) 
    
    pop_chan_views_plot <- ggplot(pop_chan_views, aes(
      x = Avg_views, 
      y = reorder(channel_name, Avg_views),
      text = label)) +
      geom_col(aes(fill = Avg_views)) +
      scale_fill_gradient(low = "#CC6600", high = "#660000") +
      theme_get() +
      labs(
        x = "Average Views (in Millions)",
        y = NULL
      ) + 
      theme(
        legend.position = "none"
      )
    
    ggplotly(pop_chan_views_plot, tooltip="text")
  })
  
  # Popular Channel
  output$popular_plot <- renderPlotly({
    means_per_likes <- main %>% 
      filter(category_id == input$category) %>% 
      group_by(channel_name) %>% 
      summarise(avg_views_per_likes = round(mean(view/like))) %>% 
      ungroup() %>% 
      arrange(desc(avg_views_per_likes)) %>% 
      head(10) %>% 
      mutate(label = glue("Channel: {channel_name}
                      {avg_views_per_likes}"))
    
    means_per_likes_plot <- ggplot(means_per_likes, aes(
      x = avg_views_per_likes, 
      y = reorder(channel_name, avg_views_per_likes),
      text = label)) +
      geom_col(aes(fill = avg_views_per_likes)) +
      scale_fill_gradient(low = "#CC6600", high = "#660000") +
      theme_get() +
      labs(
        x = "Popularity (Views/Likes)",
        y = NULL
      ) + 
      theme(
        legend.position = "none"
      )
    
    ggplotly(means_per_likes_plot, tooltip="text")
  })
  
  # Activity Plot
  output$activity_plot <- renderPlotly({
    acitivty_tren <- main %>% 
      filter(category_id == input$category) %>% 
      group_by(publish_hour) %>% 
      summarise(Avg_views = mean(view)) %>% 
      mutate(Avg_views = round(Avg_views/1000000, 3),
             label = glue("At {publish_hour}
                      Avg Views {Avg_views}"))
    
    acitivty_tren_plot <- ggplot(acitivty_tren, aes(
      x = publish_hour,
      y = Avg_views)) +
      geom_line(group = 1, col = "red") +
      geom_point(aes(text = label), col = "black") +
      labs(
        x = "Publish Hour",
        y = "Mean Views (in Millions)"
      ) +
      theme_minimal()
    
    ggplotly(acitivty_tren_plot, tooltip = "text")
  })
  
  # Correlation Plot
  output$correlation_vlc_plot <- renderPlotly({
    corr_vlc <- main %>% 
      filter(category_id == input$category) %>% 
      group_by(channel_name) %>% 
      summarise(avg_views = round(mean(view)),
                avg_likes = round(mean(like)),
                avg_comments = round(mean(comment))) 
    
    corr_vlc_plot <- ggplot(corr_vlc, aes(
      x = avg_views, 
      y = avg_likes,
      size = avg_comments)) +
      geom_point(col = "#CC6600") +
      theme_get() +
      labs(
        x = "Views",
        y = "Likes",
        size = "Comments"
      ) 
    
    ggplotly(corr_vlc_plot)
  })
}