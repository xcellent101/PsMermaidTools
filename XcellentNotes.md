
# PsMermaidTools - HowTo

## Import PsMermaidTools
```pwsh
Import-Module -Name .\PsMermaidTools\src\PsMermaidTools.psm1
```

## Create a new diagram
```pwsh
$Diagram = New-Diagram -Flowchart -Title "MyChart" -Orientation "left-to-right"
```

## Add a Class
```pwsh
Add-FlowchartClass -Name "t1NodeStyle" -Diagram $Diagram -Style "fill:#ffb703,stroke:#bc6c25"
Add-FlowchartClass -Name "t0NodeStyle" -Diagram $Diagram -Style "fill:#8ecae6,stroke:#023047"
Add-FlowchartClass -Name "segNodeStyle" -Diagram $Diagram -Style "fill:#d9ead3,stroke:#023047"
Add-FlowchartClass -Name "exampleStyle" -Diagram $Diagram -Style "fill:#bbf,stroke:#f66,stroke-width:2px,color:#fff,stroke-dasharray: 5 5"
```
Mermaid Class & Styling documentation @ https://mermaid.js.org/syntax/flowchart.html#styling-a-node

## Add a Node
```pwsh
Add-FlowchartNode -Diagram $Diagram -Text "Node1" -Key "NodeId-1001" -Class "t1NodeStyle" -Shape "stadium"
Add-FlowchartNode -Diagram $Diagram -Text "Node2" -Key "NodeId-1002" -Class "t0NodeStyle" -Shape "round-edges"
```

### Different Shape Options
```pwsh
[ValidateSet(
            'rectangle',
            'round-edges',
            'stadium',
            'subroutine',
            'cylindrical',
            'circle',
            'asymmetric',
            'rhombus',
            'hexagon',
            'parallelogram',
            'parallelogram-alt',
            'trapezoid',
            'trapezoid-alt',
            'double-circle'
        )]
```

## Add Click to a Node (Optional)
```pwsh
Add-FlowchartClick -Diagram $Diagram -Node "NodeId-1001" -Url "https://www.google.com" -Tooltip "open url to google.com" -Target self
```

## Add a link
```pwsh
Add-FlowchartLink -Diagram $Diagram -Source "NodeId-1001" -Destination "NodeId-1002" -Text "This is the text on the link" -Line "dotted" -SourceHead "circle" -DestinationHead "cross"
```

### Add link options
```pwsh
# The link text.
[Parameter(Position = 2)]
[string] $Text
# The link style.
[Parameter()]
[ValidateSet('solid', 'dotted', 'thick')]
[string] $Line = 'solid'
# The head style to destination direction.
[Parameter()]
[ValidateSet('arrow', 'open', 'circle', 'cross')]
[string] $DestinationHead = 'arrow'
# The head style to destination direction.
[Parameter()]
[ValidateSet('arrow', 'open', 'circle', 'cross')]
[string] $SourceHead = 'open'
```

## Convert the diagrame to Mermaid Txt Code
```pwsh
$MermaidCode = $Diagram | ConvertTo-String
$MermaidCode | Out-File -Path .\myfile.txt
```

## Subgraph
Subgraphs doesnt really work at the current PsMermaidTools version 0.5
```pwsh
Add-FlowchartSubgraph -Diagram $Diagram -Key "Subgraph-1" -Title "my app in subgraph"
Add-FlowchartSubgraph -Diagram $Diagram -Key "Subgraph-2" -Title "my app in subgraph"

# Add link between Subgraphs
Add-FlowchartLink -Diagram $Diagram -Source "Subgraph-1" -Destination "Subgraph-2"
```

### MyFlowchart
```pwsh
#Create Diagram
$diagram = New-Diagram -Flowchart -Title "MyChart" -Orientation "left-to-right"

#Create subgraph1
$mySubgraph1 = New-FlowchartSubgraph -Title "mytitle" -key "subgraph1key" -Orientation left-to-right
#Add Node to subgraph1
$mySubgraph1 | Add-FlowchartNode -Key "node123" -Text "node 123"
#Add Subgraph1 to diagram
$diagram.Subgraphs += $mySubgraph1
#Create a link between two nodes in the subgraph (source & Destination is Key for node)
$mySubgraph1 | Add-FlowchartLink -Source "nodeXXX" -Destination "nodeYYY"

#Create subgraph2
$mySubgraph2 = New-FlowchartSubgraph -Title "mytitle2" -key "subgraph2key" -Orientation left-to-right
#Add Node to subgraph2
$mySubgraph2 | Add-FlowchartNode -Key "node333" -Text "node 333"
#Add Subgraph2 to diagram
$diagram.Subgraphs += $mySubgraph2
#Creating link between two subgraphs
$diagram | Add-FlowchartLink -Source "subgraph1key" -Destination "subgraph2key"

#Convert diagram to string
$diagram | ConvertTo-String
```