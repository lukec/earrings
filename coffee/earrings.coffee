$( ->
    EllipseWalls = (paper, x, y, x2, y2, size, type) ->
        paper.ellipse(x, y, x2, y2).attr type
        if size != 0
          paper.ellipse(x, y, x2-size, y2-size).attr type
    
    ONE_MM_IN_PX   =  4
    ONE_CM_IN_PX   = 38

    # Brushes
    ATTR_CUT_FIRST  = { fill: "none", stroke: "#000", "stroke-width": "5" }
    ATTR_CUT_SECOND = { fill: "none", stroke: "#00F", "stroke-width": "5" }
    ATTR_CUT_LAST   = { fill: "none", stroke: "#F00", "stroke-width": "5" }
    ATTR_ETCH 	    = { fill: "none", stroke: "#0F0", "stroke-width": "5" }

    InnerCircles = (paper, size_x, size_y) ->
        rings = 8
        lineThickness = ONE_MM_IN_PX*2
        object_size = size_y / 2 / rings
        
        for i in [0..rings]
            EllipseWalls( paper,
                size_x/2 - (object_size*i), size_y/2,
                size_x/2- (object_size*i), size_y/2- (object_size*i),
                lineThickness, ATTR_CUT_FIRST )

            
    WORKING_AREA_HEIGHT	= ONE_CM_IN_PX * 15
    WORKING_AREA_WIDTH	= ONE_CM_IN_PX * 15
            
    # Paper, It should be a little bit bigger so we can put the sizing chart on the screen. 
    PAPER_HEIGHT 	= WORKING_AREA_HEIGHT
    PAPER_WIDTH		= WORKING_AREA_HEIGHT
    
    # Creates canvas 
    paper = Raphael 40, 40, PAPER_WIDTH, PAPER_HEIGHT

    InnerCircles paper, ONE_CM_IN_PX*6, ONE_CM_IN_PX*6
    
    #/ Create the download link. 
    svgString = paper.toSVG()
    $('#downloadLink').download('mySvg.svg').type('image/svg+xml')
    bb = new(window.BlobBuilder || WebKitBlobBuilder)
    bb.append svgString
    blob = bb.getBlob 'image/svg+xml'
    a.href = (window.URL || webkitURL).createObjectURL blob
)()
