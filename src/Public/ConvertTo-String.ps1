function ConvertTo-String {

    <#

    .SYNOPSIS
    Converts a mermaid definition to string.

    .DESCRIPTION
    Generates mermaid syntax for definitions created with this module.

    .INPUTS
    Mermaid diagram definition object.

    .OUTPUTS
    String.

    .EXAMPLE
    PS C:\> $diagram = New-MermaidDiagram -Type erDiagram
    PS C:\> $diagram | Add-MermaidRelation Exactly-one Customer places Zero-or-more Order
    PS C:\> $diagram | Add-MermaidRelation Exactly-one Order contains One-or-more LineItem
    PS C:\> $diagram | Add-MermaidRelation One-or-more Customer uses One-or-more DeliveryAddress -NonIdentifying
    PS C:\> $diagram | ConvertTo-MermaidString
    erDiagram
        Customer ||--o{ Order : places
        Order ||--|{ LineItem : contains
        Customer }|..|{ DeliveryAddress : uses

    Create a erDiagram, add a few relations and convert it to a diagram string.

    #>

    [CmdletBinding()]
    param (

        #region diagram

        # The diagram type.
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'erDiagram')]
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'flowchart')]
        [string] $Type,

        #region erDiagram

        # Collection of relations.
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'erDiagram')]
        [PsObject[]] $Relations,

        #end region
        #region flowchart

        # Orientation of the flowchart.
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'flowchart')]
        [string] $Orientation,

        # Collection of nodes for a flowchart.
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'flowchart')]
        [PsObject[]] $Nodes,

        # Collection of links for a flowchart.
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'flowchart')]
        [PsObject[]] $Links,

        #end region
        #endregion

        #region erRelation

        # First entity of the relation.
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'erRelation')]
        [string] $FirstEntity,

        # Relationship of the relation.
        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = 'erRelation')]
        [PSObject] $Relationship,

        # First second of the relation.
        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = 'erRelation')]
        [string] $SecondEntity,

        # Describes the relation.
        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = 'erRelation')]
        [string] $Label,

        #end region

        #region flowchartLink

        # Source node of the link.
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'flowchartLink')]
        [string] $SourceNode,

        # Destination node of the link.
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'flowchartLink')]
        [string] $DestinationNode,

        #endregion

        #region flowchartNode

        # Source node of the node.
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'flowchartNode')]
        [string] $Key,

        # Destination node of the node.
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'flowchartNode')]
        [string] $Name,

        #endregion

        #region erRelationship

        # Cardinality of the first entity.
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'erRelationship')]
        [string] $FirstCardinality,

        # Cardinality of the second entity.
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'erRelationship')]
        [string] $SecondCardinality,

        # Flags if one entity may exist without the other.
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'erRelationship')]
        [bool] $Identifying

        #end region
    )

    process {
        @(
            switch ($PSCmdlet.ParameterSetName) {
                erDiagram {
                    $Type | Write-Output
                    $Relations | ConvertTo-String | Write-Output
                }
                flowchart {
                    "$Type $Orientation" | Write-Output
                    $Nodes | ConvertTo-String | Write-Output
                    $Links | ConvertTo-String | Write-Output
                }
                erRelation {
                    if ( $SecondEntity ) {
                        Write-Output "    $FirstEntity $( $Relationship | ConvertTo-String ) $SecondEntity$( if ( $Label ) {" : $Label" })"
                    }
                    else {
                        Write-Output "    $FirstEntity"
                    }
                }
                flowchartLink {
                    Write-Output "    $SourceNode-->$DestinationNode"
                }
                flowchartNode {
                    Write-Output "    $Key[$Name]"
                }
                erRelationship {
                    $FirstCardinalityCode = switch ($FirstCardinality) {
                        Zero-or-one { '|o' }
                        Exactly-one { '||' }
                        Zero-or-more { '{o' }
                        One-or-more { '}|' }
                        Default {
                            Write-Error "'$_' is not supported for FirstCardinality."
                        }
                    }
                    $SecondCardinalityCode = switch ($SecondCardinality) {
                        Zero-or-one { 'o|' }
                        Exactly-one { '||' }
                        Zero-or-more { 'o{' }
                        One-or-more { '|{' }
                        Default {
                            Write-Error "'$_' is not supported for SecondCardinality."
                        }
                    }
                    $IdentifyingCode = if ( $Identifying ) { '--' } else { '..' }
                    Write-Output "$FirstCardinalityCode$IdentifyingCode$SecondCardinalityCode"
                }
                Default {
                    Write-Error "convert $_ is not supported."
                }
            }
        ) -join [Environment]::NewLine | Write-Output
    }
}
