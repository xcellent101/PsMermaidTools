function New-FlowchartSubgraph {

    <#

    .SYNOPSIS
    Creates a new Flowchart Subgraph.

    .DESCRIPTION
    Creates and returns a new Flowchart Subgraph definition, that can be populated and later exported.

    .INPUTS
    None.

    .OUTPUTS
    Flowchart Subgraph definition object.

    .EXAMPLE
    PS C:\> $FlowchartSubgraph = New-FlowchartSubgraph -Title "my subgraph title" -Key "subgraph1" -Orientation "top-to-bottom"
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

    .LINK
    https://mermaid-js.github.io/mermaid/#/README?id=diagram-types

    #>

    param (
        # The mermaid diagram type.
        [Parameter( Mandatory, Position = 0 )]
        [string] $Key,

        # The diagram orientation.
        [Parameter( Position = 1 )]
        [ValidateSet('top-to-bottom', 'top-down', 'bottom-to-top', 'right-to-left', 'left-to-right')]
        [string] $Orientation,

        # The diagram title.
        [string] $Title
    )

    $definition = [PSCustomObject]@{}
       
    if ( $Title ) {
        $definition | Add-Member Title $Title
    }

    if ( $Orientation ) {
        $definition | Add-Member Orientation $Orientation
    }

    $definition | Add-Member Nodes @()
    $definition | Add-Member Links @()
    $definition | Add-Member Clicks @()
    $definition | Add-Member Key $Key

    Write-Output $definition
}

