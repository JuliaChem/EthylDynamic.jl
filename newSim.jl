newWin = Window()
# Properties for mainWin
set_gtk_property!(newWin, :title, "EthylDynamic 1.0")
set_gtk_property!(newWin, :window_position, 3)
set_gtk_property!(newWin, :height_request, 800)
set_gtk_property!(newWin, :width_request, 1200)
set_gtk_property!(newWin, :accept_focus, true)
set_gtk_property!(newWin, :resizable, false)

set_gtk_property!(mainWin, :visible, false)
#screen = Gtk.GAccessor.style_context(newWin)
#push!(screen, StyleProvider(provider), 600)

# Menu Icons
tb1 = ToolButton("gtk-new")
set_gtk_property!(tb1, :label, "New")
set_gtk_property!(tb1, :tooltip_markup, "Create a new simulation environment")

tb2 = ToolButton("gtk-open")
set_gtk_property!(tb2, :label, "Open")
set_gtk_property!(tb2, :tooltip_markup, "Open a simulation file")

tb3 = ToolButton("gtk-floppy")
set_gtk_property!(tb3, :label, "Save as")
set_gtk_property!(
    tb3,
    :tooltip_markup,
    "Save the current state environment to a JLD file",
)

# Close toolbar
tb4 = ToolButton("gtk-close")
set_gtk_property!(tb4, :label, "Close")
set_gtk_property!(tb4, :tooltip_markup, "Close current simulation environment")

signal_connect(tb4, :clicked) do widget
    destroy(newWin)
    set_gtk_property!(mainWin, :visible, true)
end
signal_connect(newWin, "key-press-event") do widget, event
    if event.keyval == 65307
        destroy(newWin)
        set_gtk_property!(mainWin, :visible, true)
    end
end

tb5 = ToolButton("gtk-media-previous")
set_gtk_property!(tb5, :label, "Back")
set_gtk_property!(tb5, :tooltip_markup, "Go to previous tab")

tb6 = ToolButton("gtk-media-next")
set_gtk_property!(tb6, :label, "Next")
set_gtk_property!(tb6, :tooltip_markup, "Go to next tab")

tb7 = ToggleToolButton("gtk-media-play")
set_gtk_property!(tb7, :label, "Run (auto)")
set_gtk_property!(tb7, :tooltip_markup, "Solve the simulation environment")

tb8 = ToolButton("gtk-preferences")
set_gtk_property!(tb8, :label, "Tools")
set_gtk_property!(tb8, :tooltip_markup, "Simulation environtment tools")


# Toolbar
newToolbar = Toolbar()
set_gtk_property!(newToolbar, :height_request, 20)
set_gtk_property!(newToolbar, :toolbar_style, 2)
push!(newToolbar, SeparatorToolItem())
push!(newToolbar, tb1)
push!(newToolbar, tb2)
push!(newToolbar, tb3)
push!(newToolbar, SeparatorToolItem())
push!(newToolbar, tb5)
push!(newToolbar, tb6)
push!(newToolbar, tb7)
push!(newToolbar, SeparatorToolItem())
push!(newToolbar, tb8)
push!(newToolbar, SeparatorToolItem())
push!(newToolbar, tb4)
push!(newToolbar, SeparatorToolItem())

gridToolbar = Grid()
set_gtk_property!(gridToolbar, :column_homogeneous, true)
set_gtk_property!(gridToolbar, :row_homogeneous, false)

frameToolbar = Frame()
push!(frameToolbar, newToolbar)
gridToolbar[1, 1] = frameToolbar

# Notebook
global nb = Notebook()
set_gtk_property!(nb, :tab_pos, 0)
screen = Gtk.GAccessor.style_context(nb)
push!(screen, StyleProvider(provider), 600)

############################################################################
# Tab 0 - User properties
############################################################################
nbFrame0 = Frame()
screen = Gtk.GAccessor.style_context(nbFrame0)
push!(screen, StyleProvider(provider), 600)

vbox0 = Grid()
set_gtk_property!(vbox0, :column_homogeneous, false)
set_gtk_property!(vbox0, :row_homogeneous, false)
set_gtk_property!(vbox0, :column_spacing, 10)
set_gtk_property!(vbox0, :row_spacing, 10)
set_gtk_property!(vbox0, :margin_top, 10)
set_gtk_property!(vbox0, :margin_bottom, 20)
set_gtk_property!(vbox0, :margin_left, 20)
set_gtk_property!(vbox0, :margin_right, 20)
set_gtk_property!(vbox0, :halign, 3)

push!(nbFrame0, vbox0)
push!(nb, nbFrame0, "Startup")

############################################################################
# Tab 1 - Compounds
############################################################################
nbFrame1 = Frame()
screen = Gtk.GAccessor.style_context(nbFrame1)
push!(screen, StyleProvider(provider), 600)

vbox1 = Grid()
set_gtk_property!(vbox1, :column_homogeneous, false)
set_gtk_property!(vbox1, :row_homogeneous, false)
set_gtk_property!(vbox1, :column_spacing, 10)
set_gtk_property!(vbox1, :row_spacing, 10)
set_gtk_property!(vbox1, :margin_top, 10)
set_gtk_property!(vbox1, :margin_bottom, 20)
set_gtk_property!(vbox1, :margin_left, 20)
set_gtk_property!(vbox1, :margin_right, 20)
set_gtk_property!(vbox1, :halign, 3)

# Frame for databank
vbox1Frame1 = Frame("Databank")
set_gtk_property!(vbox1Frame1, :width_request, 880)
set_gtk_property!(vbox1Frame1, :height_request, 340)
set_gtk_property!(vbox1Frame1, :label_xalign, 0.50)
set_gtk_property!(vbox1Frame1, :shadow_type, 0)

# Frame for compouns
vbox1Frame2 = Frame("Added Compounds")
set_gtk_property!(vbox1Frame2, :width_request, 800)
set_gtk_property!(vbox1Frame2, :height_request, 280)
set_gtk_property!(vbox1Frame2, :label_xalign, 0.50)
set_gtk_property!(vbox1Frame2, :shadow_type, 0)

sep = Frame()
set_gtk_property!(sep, :width_request, 1000)
set_gtk_property!(sep, :height_request, 0)
############################################################################
# Datasheet vbox1Frame1
gridDatabank = Grid()
set_gtk_property!(gridDatabank, :halign, 3)
set_gtk_property!(gridDatabank, :valign, 3)

# Grid for Buttons around TreeView dataBank
gridDataButtons = Grid()
set_gtk_property!(gridDataButtons, :halign, 3)
set_gtk_property!(gridDataButtons, :valign, 3)
set_gtk_property!(gridDataButtons, :column_homogeneous, false)
set_gtk_property!(gridDataButtons, :row_homogeneous, false)
set_gtk_property!(gridDataButtons, :column_spacing, 10)
set_gtk_property!(gridDataButtons, :row_spacing, 10)

# Frame with border to enhance the style
frameDatabank = Frame()

# GtkListStore where the data is actually saved
global listDatabank = ListStore(Float64, String, Float64, Float64)

# Data for example
push!(listDatabank, (1, "Water", 1, 1))
push!(listDatabank, (2, "Cerveza", 4, 6))
push!(listDatabank, (3, "Alcohol", 7, 3))
push!(listDatabank, (4, "Vocka", 12, 1))

# Gtk TreeView to show the graphical element
viewDatabank = TreeView(TreeModel(listDatabank))
set_gtk_property!(viewDatabank, :enable_grid_lines, 3)
set_gtk_property!(viewDatabank, :enable_search, true)
screen = Gtk.GAccessor.style_context(viewDatabank)
push!(screen, StyleProvider(provider), 600)

# Window that allow scroll the TreeView
scrollDatabank = ScrolledWindow(viewDatabank)
set_gtk_property!(scrollDatabank, :width_request, 600)
set_gtk_property!(scrollDatabank, :height_request, 250)
selection1 = Gtk.GAccessor.selection(viewDatabank)

signal_connect(selection1, "changed") do widget
    if hasselection(selection1)
        currentIt = selected(selection1)

        println(
            "Name: ",
            TreeModel(listDatabank)[currentIt, 1],
            " Age: ",
            TreeModel(listDatabank)[currentIt, 1],
        )
    end
end

# Column definitions
cTxt1 = CellRendererText()

c11 = TreeViewColumn("ID", cTxt1, Dict([("text", 0)]))
c12 = TreeViewColumn("Name", cTxt1, Dict([("text", 1)]))
c13 = TreeViewColumn("MW", cTxt1, Dict([("text", 2)]))
c14 = TreeViewColumn("Tc", cTxt1, Dict([("text", 3)]))

# Add column to TreeView
push!(viewDatabank, c11, c12, c13, c14)

# Add scrool window to the frame
push!(frameDatabank, scrollDatabank)

# Add frame to grid to allow halign & valign
gridDatabank[1, 1] = frameDatabank

# Buttons around TreeView of dataBank

searchDatabank = Entry()
set_gtk_property!(searchDatabank, :text, "Search component")

loadDatabank = Button("Search")

openDatabank = ToolButton("gtk-open")

addDatabank = ToolButton("gtk-add")

remDatabank = ToolButton("gtk-remove")

newDatabank = ToolButton("gtk-new")

editDatabank = ToolButton("gtk-edit")

selectDatabank = ToolButton("gtk-go-down")

saveDatabank = ToolButton("gtk-floppy")

clearDatabank = ToolButton("gtk-clear")

csvDatabank = ToolButton("gtk-redo")

printDatabank = ToolButton("gtk-print")

# Close keyboard Esc
signal_connect(clearDatabank, :clicked) do widget
    # Avoid julia session breaks
    @sigatom selection1 = Gtk.GAccessor.selection(viewDatabank)
    @sigatom selection1 = Gtk.GAccessor.mode(
        selection1,
        Gtk.GConstants.GtkSelectionMode.NONE,
    )
    empty!(listDatabank)
end

gridDataButtons[2, 1] = searchDatabank
gridDataButtons[3, 1] = loadDatabank
gridDataButtons[2:3, 2:8] = gridDatabank
gridDataButtons[1, 2] = openDatabank
gridDataButtons[1, 3] = newDatabank
gridDataButtons[1, 4] = editDatabank
gridDataButtons[1, 5] = saveDatabank
gridDataButtons[1, 6] = csvDatabank

gridDataButtons[4, 2] = remDatabank
gridDataButtons[4, 3] = addDatabank
gridDataButtons[4, 4] = selectDatabank
gridDataButtons[4, 5] = clearDatabank
gridDataButtons[4, 6] = printDatabank

# Add to second frame in vbox1
push!(vbox1Frame1, gridDataButtons)

# Allow to resize columns
for c in [c11, c12, c13, c14]
    Gtk.GAccessor.resizable(c, true)
end

# Allow to sort columns
for (i, c) in enumerate([c11, c12, c13, c14])
    Gtk.GAccessor.sort_column_id(c, i - 1)
end

# Allow to reorder columns
for (i, c) in enumerate([c11, c12, c13, c14])
    Gtk.GAccessor.reorderable(c, i)
end

############################################################################
# Datasheet vboxFrame2
gridComp = Grid()
set_gtk_property!(gridComp, :halign, 3)
set_gtk_property!(gridComp, :valign, 3)

# Grid for Buttons around TreeView viewComp
gridCompButtons = Grid()
set_gtk_property!(gridCompButtons, :halign, 3)
set_gtk_property!(gridCompButtons, :valign, 3)
set_gtk_property!(gridCompButtons, :column_homogeneous, false)
set_gtk_property!(gridCompButtons, :row_homogeneous, false)
set_gtk_property!(gridCompButtons, :column_spacing, 10)
set_gtk_property!(gridCompButtons, :row_spacing, 10)

# Frame with border to enhance the style
frameComp = Frame()

# GtkListStore where the data is actually saved
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
screen = Gtk.GAccessor.style_context(viewComp)
push!(screen, StyleProvider(provider), 600)

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

# Add scrool window to the frame
push!(frameComp, scrollComp)

# Buttons around TreeView of dataComp
openComp = ToolButton("gtk-open")

editComp = ToolButton("gtk-edit")

saveComp = ToolButton("gtk-floppy")

csvComp = ToolButton("gtk-redo")

remComp = ToolButton("gtk-remove")

addComp = ToolButton("gtk-add")

clearComp = ToolButton("gtk-clear")

printComp = ToolButton("gtk-print")

# Close keyboard Esc
signal_connect(clearComp, :clicked) do widget
    # Avoid julia session breaks
    selection2 = Gtk.GAccessor.selection(viewComp)
    selection2 = Gtk.GAccessor.mode(
        selection2,
        Gtk.GConstants.GtkSelectionMode.NONE,
    )
    empty!(listComp)
end

# Add frame to grid to allow halign & valign
gridComp[1, 1] = frameComp

gridCompButtons[2:3, 1:6] = gridComp
gridCompButtons[1, 1] = openComp
gridCompButtons[1, 2] = editComp
gridCompButtons[1, 3] = saveComp
gridCompButtons[1, 4] = csvComp
gridCompButtons[4, 1] = remComp
gridCompButtons[4, 2] = addComp
gridCompButtons[4, 3] = clearComp
gridCompButtons[4, 4] = printComp

# Add to second frame in vbox1
push!(vbox1Frame2, gridCompButtons)

# Allow to resize columns
for c in [c21, c22, c23, c24]
    Gtk.GAccessor.resizable(c, true)
end

# Allow to sort columns
for (i, c) in enumerate([c21, c22, c23, c24])
    Gtk.GAccessor.sort_column_id(c, i - 1)
end

# Allow to reorder columns
for (i, c) in enumerate([c21, c22, c23, c24])
    Gtk.GAccessor.reorderable(c, i)
end

############################################################################
vbox1[1, 1] = vbox1Frame1
vbox1[1, 2] = sep
vbox1[1, 3] = vbox1Frame2

push!(nbFrame1, vbox1)
push!(nb, nbFrame1, "Compounds")

############################################################################
# Tab 2
############################################################################
nbFrame2 = Frame()
screen = Gtk.GAccessor.style_context(nbFrame2)
push!(screen, StyleProvider(provider), 600)

vbox2 = Grid()
set_gtk_property!(vbox2, :column_homogeneous, true)
set_gtk_property!(vbox2, :row_homogeneous, false)
set_gtk_property!(vbox2, :column_spacing, 20)
set_gtk_property!(vbox2, :row_spacing, 20)
set_gtk_property!(vbox2, :margin_top, 30)
set_gtk_property!(vbox2, :margin_bottom, 30)
set_gtk_property!(vbox2, :margin_left, 30)
set_gtk_property!(vbox2, :margin_right, 30)
set_gtk_property!(vbox2, :halign, 3)

push!(nbFrame2, vbox2)
push!(nb, nbFrame2, "Equipments")


vbox2Button1 = Button("Separators")
set_gtk_property!(vbox2Button1, :name, "Separators")
set_gtk_property!(vbox2Button1, :width_request, 100)
set_gtk_property!(vbox2Button1, :height_request, 80)
screen = Gtk.GAccessor.style_context(vbox2Button1)
push!(screen, StyleProvider(provider), 600)

vbox2Button2 = Button("Columns")
set_gtk_property!(vbox2Button2, :name, "Columns")
set_gtk_property!(vbox2Button2, :width_request, 100)
set_gtk_property!(vbox2Button2, :height_request, 80)
screen = Gtk.GAccessor.style_context(vbox2Button2)
push!(screen, StyleProvider(provider), 600)

vbox2Button3 = Button("Heat Exchangers")
set_gtk_property!(vbox2Button3, :name, "Exchangers")
set_gtk_property!(vbox2Button3, :width_request, 100)
set_gtk_property!(vbox2Button3, :height_request, 80)
screen = Gtk.GAccessor.style_context(vbox2Button3)
push!(screen, StyleProvider(provider), 600)

vbox2Button4 = Button("Tanks")
set_gtk_property!(vbox2Button4, :name, "Tanks")
set_gtk_property!(vbox2Button4, :always_show_image, true)
set_gtk_property!(vbox2Button4, :width_request, 100)
set_gtk_property!(vbox2Button4, :height_request, 80)
screen = Gtk.GAccessor.style_context(vbox2Button4)
push!(screen, StyleProvider(provider), 600)

vbox2Button5 = Button("Reactors")
set_gtk_property!(vbox2Button5, :name, "Reactors")
set_gtk_property!(vbox2Button5, :width_request, 100)
set_gtk_property!(vbox2Button5, :height_request, 80)
screen = Gtk.GAccessor.style_context(vbox2Button5)
push!(screen, StyleProvider(provider), 600)

vbox2[1, 1] = vbox2Button1
vbox2[2, 1] = vbox2Button2
vbox2[3, 1] = vbox2Button3
vbox2[4, 1] = vbox2Button4
vbox2[5, 1] = vbox2Button5


############################################################################
# Tab 3 - Flowsheet
############################################################################
nbFrame3 = Frame()
screen = Gtk.GAccessor.style_context(nbFrame3)
push!(screen, StyleProvider(provider), 600)

vbox3 = Grid()
set_gtk_property!(vbox3, :column_homogeneous, false)
set_gtk_property!(vbox3, :row_homogeneous, false)
set_gtk_property!(vbox3, :column_spacing, 10)
set_gtk_property!(vbox3, :row_spacing, 10)
set_gtk_property!(vbox3, :margin_top, 10)
set_gtk_property!(vbox3, :margin_bottom, 20)
set_gtk_property!(vbox3, :margin_left, 20)
set_gtk_property!(vbox3, :margin_right, 20)
set_gtk_property!(vbox3, :halign, 3)

push!(nbFrame3, vbox3)
push!(nb, nbFrame3, "Flowsheet")

############################################################################
# Tab 4
############################################################################
nbFrame4 = Frame()
screen = Gtk.GAccessor.style_context(nbFrame4)
push!(screen, StyleProvider(provider), 600)

vbox4 = Grid()

push!(nbFrame4, vbox4)
push!(nb, nbFrame4, "Thermodynamics")

############################################################################
# Tab 5 - Security
############################################################################
nbFrame5 = Frame()
screen = Gtk.GAccessor.style_context(nbFrame5)
push!(screen, StyleProvider(provider), 600)

vbox5 = Grid()
set_gtk_property!(vbox5, :column_homogeneous, false)
set_gtk_property!(vbox5, :row_homogeneous, false)
set_gtk_property!(vbox5, :column_spacing, 10)
set_gtk_property!(vbox5, :row_spacing, 10)
set_gtk_property!(vbox4, :margin_top, 10)
set_gtk_property!(vbox5, :margin_bottom, 20)
set_gtk_property!(vbox5, :margin_left, 20)
set_gtk_property!(vbox5, :margin_right, 20)

push!(nbFrame5, vbox5)
push!(nb, nbFrame5, "Security")

############################################################################
# Tab 6 - Results
############################################################################
nbFrame6 = Frame()
screen = Gtk.GAccessor.style_context(nbFrame6)
push!(screen, StyleProvider(provider), 600)

vbox6 = Grid()

push!(nbFrame6, vbox6)
push!(nb, nbFrame6, "Results")

############################################################################
# Tab 0 - User properties
############################################################################
nbFrame7 = Frame()
screen = Gtk.GAccessor.style_context(nbFrame7)
push!(screen, StyleProvider(provider), 600)

vbox7 = Grid()
set_gtk_property!(vbox7, :column_homogeneous, false)
set_gtk_property!(vbox7, :row_homogeneous, false)
set_gtk_property!(vbox7, :column_spacing, 10)
set_gtk_property!(vbox7, :row_spacing, 10)
set_gtk_property!(vbox7, :margin_top, 10)
set_gtk_property!(vbox7, :margin_bottom, 20)
set_gtk_property!(vbox7, :margin_left, 20)
set_gtk_property!(vbox7, :margin_right, 20)
set_gtk_property!(vbox7, :halign, 3)

push!(nbFrame7, vbox7)
push!(nb, nbFrame7, "Data Logging")

gridToolbar[1, 2] = nb
push!(newWin, gridToolbar)

############################################################################
# Buttons for newWin
############################################################################
newGButtons = Grid()
set_gtk_property!(newGButtons, :column_homogeneous, false)
set_gtk_property!(newGButtons, :width_request, 1160)
set_gtk_property!(newGButtons, :height_request, 20)
set_gtk_property!(newGButtons, :column_spacing, 20)
set_gtk_property!(newGButtons, :margin_top, 20)
set_gtk_property!(newGButtons, :margin_bottom, 20)
set_gtk_property!(newGButtons, :margin_left, 20)
set_gtk_property!(newGButtons, :margin_right, 20)
set_gtk_property!(newGButtons, :valign, 3)

# Buttons for newGButtons
newGEmpty = Grid()
set_gtk_property!(newGEmpty, :width_request, 680)
set_gtk_property!(newGEmpty, :valign, 3)

newLabel = Label("Designed at Instituto Tecnológico de Celaya - 2020
Support granted by the Conacyt-Secretaría de Energía-Hidrocarburos sectorial fund")
Gtk.GAccessor.justify(newLabel, Gtk.GConstants.GtkJustification.CENTER)
screen = Gtk.GAccessor.style_context(newLabel)
push!(screen, StyleProvider(provider), 600)
newGEmpty[1, 1] = newLabel

# Close newWin
newGClose = Button("Close")
set_gtk_property!(newGClose, :name, "newGClose")
set_gtk_property!(newGClose, :width_request, 100)
set_gtk_property!(newGClose, :height_request, 32)
screen = Gtk.GAccessor.style_context(newGClose)
push!(screen, StyleProvider(provider), 600)

signal_connect(newWin, "key-press-event") do widget, event
    if event.keyval == 65307
        destroy(newWin)
        set_gtk_property!(mainWin, :visible, true)
    end
end

# Close keyboard Esc
signal_connect(newGClose, :clicked) do widget
    destroy(newWin)
    set_gtk_property!(mainWin, :visible, true)
end

# Exit newWin
newGExit = Button("Exit")
set_gtk_property!(newGExit, :name, "newGExit")
set_gtk_property!(newGExit, :width_request, 100)
set_gtk_property!(newGExit, :height_request, 32)
screen = Gtk.GAccessor.style_context(newGExit)
push!(screen, StyleProvider(provider), 600)

    # Exit for newWin
signal_connect(newGExit, :clicked) do widget
    destroy(newWin)
    destroy(mainWin)
end

    # Back for newWin
newGBack = Button("Back")
set_gtk_property!(newGBack, :name, "newGBack")
set_gtk_property!(newGBack, :width_request, 100)
set_gtk_property!(newGBack, :height_request, 32)
signal_connect(newGBack, :clicked) do widget
    global nb
    idTab = get_gtk_property(nb, :page, Int)

    if idTab !== 0
        global idTab = idTab - 1
        set_gtk_property!(nb, :page, idTab)
        set_gtk_property!(newGNext, :sensitive, false)
    end

    if idTab == 0
        set_gtk_property!(newGBack, :sensitive, false)
    end
end

screen = Gtk.GAccessor.style_context(newGBack)
push!(screen, StyleProvider(provider), 600)

    # Next for newWin
newGNext = Button("Next")
set_gtk_property!(newGNext, :name, "newGNext")
set_gtk_property!(newGNext, :width_request, 100)
set_gtk_property!(newGNext, :height_request, 32)
signal_connect(newGNext, :clicked) do widget
    global nb
    idTab = get_gtk_property(nb, :page, Int)

    if idTab !== 3
        global idTab = idTab + 1
        set_gtk_property!(nb, :page, idTab)
        set_gtk_property!(newGBack, :sensitive, true)
    end

    if idTab == 3
        set_gtk_property!(newGNext, :sensitive, false)
    end
end

screen = Gtk.GAccessor.style_context(newGNext)
push!(screen, StyleProvider(provider), 600)

newGButtons[1, 1] = newGEmpty
newGButtons[2, 1] = newGBack
newGButtons[3, 1] = newGNext
newGButtons[4, 1] = newGClose
newGButtons[5, 1] = newGExit

gridToolbar[1, 3] = newGButtons

Gtk.showall(newWin)
