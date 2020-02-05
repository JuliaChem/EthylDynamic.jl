using Gtk, Gtk.ShortNames

function updateTreeView!(store::Gtk.GtkListStore, selection::Gtk.GtkTreeSelection, data::Array{T, 1}) where T <: Tuple
    if hasselection(selection)
        # Both of these segfaults the program
        #unselect!(selection, selected(selection))
        #unselectall!(selection)
    end

    # Segfaults because a selection is in use
    empty!(store)

    #for d in data
#        push!(store, d)
#    end
end

# Helper function to tree list, no problems here
function generateTreeView(header::Tuple, data::Array{T, 1}) where T <: Tuple
    tupleTypes = eltype(data).parameters
    store = GtkListStore(tupleTypes...)

    for d in data
        push!(store, d)
    end

    treeView = GtkTreeView(GtkTreeModel(store))

    cols = GtkTreeViewColumn[]

    for c in 1:length(tupleTypes)
        col = GtkTreeViewColumn(
            header[c],
            GtkCellRendererText(),
            Dict([("text", c - 1)])
        )

        push!(cols, col)
    end

    push!(treeView, cols...)

    return store, treeView
end

window = Window() |> (Frame() |> (box = Box(:v)))
store, tree = generateTreeView(("Foo", "Bar", "Baz"), [(1, 2, 3), (4, 5, 6), (7, 8, 9)])
push!(box, tree)

selection = GAccessor.selection(tree)

signal_connect(selection, "changed") do widget
    @sigatom updateTreeView!(store, selection, [(3, 4, 5), (2, 3, 1), (2, 4, 3)])
end

showall(window)

readline()
