using Gtk.ShortNames

listComp = ListStore(Float64, String, Float64, Float64)

# Data for example
push!(listComp, (1, "Water", 1, 1))
push!(listComp, (2, "Cerveza", 4, 6))
push!(listComp, (3, "Alcohol", 7, 3))
push!(listComp, (4, "Vocka", 12, 1))

# Gtk TreeView to show the graphical element
viewComp = TreeView(TreeModel(listComp))
set_gtk_property!(viewComp, :enable_grid_lines, 3)
set_gtk_property!(viewComp, :enable_search, true)

# Window that allow scroll the TreeView
scrollComp = ScrolledWindow(viewComp)
set_gtk_property!(scrollComp, :width_request, 600)
set_gtk_property!(scrollComp, :height_request, 250)
selection2 = Gtk.GAccessor.selection(viewComp)
selection2 = Gtk.GAccessor.mode(
    selection2,
    Gtk.GConstants.GtkSelectionMode.MULTIPLE,
)

# Column definitions
cel1 = CellRendererText()
c21 = TreeViewColumn("ID", cel1, Dict([("text", 0)]))
c22 = TreeViewColumn("Name", cel1, Dict([("text", 1)]))
c23 = TreeViewColumn("MW", cel1, Dict([("text", 2)]))
c24 = TreeViewColumn("Tc", cel1, Dict([("text", 3)]))

# Add column to TreeView
push!(viewComp, c21, c22, c23, c24)

w = Window(scrollComp)

Gtk.showall(w)
