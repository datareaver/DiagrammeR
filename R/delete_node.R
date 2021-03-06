#' Delete a node from an existing graph object
#' @description From a graph object of class 'gv_graph', delete an existing node by specifying its node ID.
#' @param graph a graph object of class 'gv_graph' that is created using 'graphviz_graph'.
#' @param node a node ID for the node to be deleted from the graph.
#' @return a graph object of class 'gv_graph'.
#' @export delete_node

delete_node <- function(graph,
                        node){

  # Verify that 'node' is given as a single value
  node_is_single_value <- ifelse(length(node) == 1, TRUE, FALSE)

  # Stop function if node not a single value
  if (node_is_single_value == FALSE){

    stop("Only a single node can be added using 'add_node'")
  }

  # Determine whether node to delete is in the graph
  if (node_is_single_value == TRUE){

    can_delete_node_id <- ifelse(node %in% get_nodes(graph), TRUE, FALSE)
  }

  # Modify graph if node is available
  if (node_is_single_value & can_delete_node_id){

    # Create a revised node data frame
    revised_nodes_df <- graph$nodes_df[-which(graph$nodes_df$nodes == node),]

    # Create a revised edge data frame
    revised_edges_df <- graph$edges_df[-which((graph$edges_df$edge_from == node) |
                                         (graph$edges_df$edge_to == node)),]

    # Create a revised graph and return that graph
    gv_graph <-
      graphviz_graph(nodes_df = revised_nodes_df,
                     edges_df = revised_edges_df)

    return(gv_graph)
  }
}
