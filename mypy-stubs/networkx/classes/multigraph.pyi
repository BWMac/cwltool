# Stubs for networkx.classes.multigraph (Python 3.5)
#
# NOTE: This dynamically typed stub was automatically generated by stubgen.

from typing import Any, Optional

from networkx.classes.graph import Graph

class MultiGraph(Graph):
    edge_key_dict_factory: Any = ...
    def __init__(self, incoming_graph_data: Optional[Any] = ..., **attr) -> None: ...
    @property
    def adj(self): ...
    def new_edge_key(self, u, v): ...
    def add_edge(self, u_for_edge, v_for_edge, key: Optional[Any] = ..., **attr): ...
    def add_edges_from(self, ebunch_to_add, **attr): ...
    def remove_edge(self, u, v, key: Optional[Any] = ...): ...
    def remove_edges_from(self, ebunch): ...
    def has_edge(self, u, v, key: Optional[Any] = ...): ...
    @property
    def edges(self): ...
    def get_edge_data(self, u, v, key: Optional[Any] = ..., default: Optional[Any] = ...): ...
    @property
    def degree(self): ...
    def is_multigraph(self): ...
    def is_directed(self): ...
    def fresh_copy(self): ...
    def copy(self, as_view: bool = ...): ...
    def to_directed(self, as_view: bool = ...): ...
    def to_undirected(self, as_view: bool = ...): ...
    def subgraph(self, nodes): ...
    def number_of_edges(self, u: Optional[Any] = ..., v: Optional[Any] = ...): ...
