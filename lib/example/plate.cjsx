{Surface}    = ReactCanvas
dataManager  = require './dataManager.coffee'
OrdinalScale = require '../javascripts/util/OrdinalScale.coffee'
Axis         = require '../javascripts/views/Axis.cjsx'
Wells        = require './Wells.cjsx'

###
Renders a plate given the number of rows/columns
###
Plate = React.createClass
  render: ->
    <Surface
      top    = 0
      left   = 0
      width  = {@state.columnScale.range[1] + @ORIGIN.x}
      height = {@state.rowScale.range[1] + @ORIGIN.y}
    >
      {@renderColumnLabels()}
      {@renderRowLabels()}
      {@renderWells()}
    </Surface>

  displayName: 'Plate'
  ORIGIN: {x: 50, y: 50} # will need to be parameterized

  # The scales are in state even though they do not currently change during component lifecycle
  getInitialState: ->
    columnScale = new OrdinalScale
      domain: [1..@props.numColumns]
      range: [0, window.innerWidth - 100]
    rowScale = new OrdinalScale
      domain: [1..@props.numRows]
      range: [0, 300]

    {columnScale, rowScale}

  renderWells: ->
    <Wells
      origin      = @ORIGIN
      rowScale    = @state.rowScale
      columnScale = @state.columnScale
    />

  renderColumnLabels: ->
    <Axis
      origin       = @ORIGIN
      scale        = @state.columnScale
      axis         = 'x'
      placement    = 'above'
      direction    = 'right'
      showAxisLine = true
    />

  renderRowLabels: ->
    <Axis
      origin       = @ORIGIN
      scale        = @state.rowScale
      axis         = 'y'
      placement    = 'left'
      direction    = 'down'
      showAxisLine = true
    />

module.exports = Plate