using Gtk.ShortNames

ls = ListStore(String, Int, Bool, Bool)
push!(ls,("Peter",20,false,true))
push!(ls,("Paul",30,false,true))
push!(ls,("Mary",25,true,true))
insert!(ls, 2, ("Susanne",35,true,true))

rTxt = CellRendererText()
rTog = CellRendererToggle()

c1 = TreeViewColumn("Name", rTxt, Dict([("text",0)]), sort_column_id=0)
c2 = TreeViewColumn("Age", rTxt, Dict([("text",1)]), sort_column_id=1)
c3 = TreeViewColumn("Female", rTog, Dict([("active",2)]), sort_column_id=2)

tmFiltered = TreeModelFilter(ls)
Gtk.GAccessor.visible_column(tmFiltered,3)
tv = TreeView(TreeModel(tmFiltered))
push!(tv, c1, c2, c3)

scrollWin = ScrolledWindow(tv)

selection = Gtk.GAccessor.selection(tv)

signal_connect(selection, "changed") do widget
  if hasselection(selection)
    currentIt = selected(selection)
    println(currentIt[1])

    println("Name: ", TreeModel(tmFiltered)[currentIt,1],
            " Age: ", TreeModel(tmFiltered)[currentIt,1])
  end
end

ent = Entry()

signal_connect(ent, "changed") do widget
  searchText = get_gtk_property(ent, :text, String)

  for l=1:length(ls)
    showMe = true

    if length(searchText) > 0
      showMe = showMe && occursin(lowercase(searchText), lowercase(ls[l,1]))
    end

    ls[l,4] = showMe
  end
end

vbox = Box(:v)
push!(vbox,ent,scrollWin)

win = Window(vbox, "List View with Filter")
Gtk.showall(win)
