using Gtk

ls = GtkListStore(String, Int, Bool, Bool)
push!(ls, ("Peter", 20, false, true))
push!(ls, ("Paul", 30, false, true))
push!(ls, ("Mary", 25, true, true))
insert!(ls, 2, ("Susanne", 35, true, true))

rTxt = GtkCellRendererText()
rTog = GtkCellRendererToggle()

c1 = GtkTreeViewColumn("Name", rTxt, Dict([("text", 0)]), sort_column_id = 0)
c2 = GtkTreeViewColumn("Age", rTxt, Dict([("text", 1)]), sort_column_id = 1)
c3 = GtkTreeViewColumn("Female", rTog, Dict([("active", 2)]), sort_column_id = 2)

tmFiltered = GtkTreeModelFilter(ls)
GAccessor.visible_column(tmFiltered, 3)
tv = GtkTreeView(GtkTreeModel(tmFiltered))
push!(tv, c1, c2, c3)

selection = GAccessor.selection(tv)

signal_connect(selection, "changed") do widget
  if hasselection(selection)
    currentIt = selected(selection)

    println(
      "Name: ",
      GtkTreeModel(tmFiltered)[currentIt, 1],
      " Age: ",
      GtkTreeModel(tmFiltered)[currentIt, 1],
    )
  end
end

ent = GtkEntry()

signal_connect(ent, "changed") do widget
  searchText = get_gtk_property(ent, :text, String)

  test = 0
  for l = 1:length(ls)
    showMe = true

    if length(searchText) > 0
      showMe = showMe && occursin(lowercase(searchText), lowercase(ls[l, 1]))
      test = test + showMe
    end

    empty!(ls)

  end
end

vbox = GtkBox(:v)
push!(vbox, ent, tv)

win = GtkWindow(vbox, "List View with Filter")
showall(win)
