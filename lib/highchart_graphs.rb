
class HighchartGraphs
  
  attr_reader :keys
  attr_reader :values

  def initialize(keys, values)
    @keys = keys
    @values = values
  end
  
  # This method can be further customize 
  # to incorporate further inputs
  def draw
    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Weekly rate")
      f.xAxis(categories: @keys)
      f.series(name: "Week", data: @values)

      f.yAxis [
        {title: {text: "Rate", margin: 10} }]

      f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
      f.chart({defaultSeriesType: "line"})
    end
  end
end
