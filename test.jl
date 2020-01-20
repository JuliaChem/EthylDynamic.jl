using Gtk
ENV["GTK_CSD"] = 0
f5 = GtkGrid()
ls = GtkListStore(Float64, Float64, Float64, Float64) # Definir tipo de dato para la lista

# Configuración de parte gráfica
tabla = GtkTreeView(GtkTreeModel(ls))
winScroll = GtkScrolledWindow(tabla)

# Configuracion de columnas
cel1 = GtkCellRendererText()
c1 = GtkTreeViewColumn("t", cel1, Dict([("text",0)]))
c2 = GtkTreeViewColumn("x", cel1, Dict([("text",1)]))
c3 = GtkTreeViewColumn("y", cel1, Dict([("text",2)]))
c4 = GtkTreeViewColumn("z", cel1, Dict([("text",3)]))

push!(tabla, c1, c2, c3, c4)
#push!(f5, winScroll)
f5[1,1]=winScroll
nb = GtkNotebook()
push!(nb, f5, "Compounds")
############################################################################
w = GtkWindow()
push!(w, nb)
showall(w)
