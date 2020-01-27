using Gtk.ShortNames, JLD, Suppressor
import DataFrames

# Path to CSS Gtk-Style dataFile
global style_file = joinpath(dirname(Base.source_path()), "style2020.css")
global img = Gtk.Image(joinpath(dirname(Base.source_path()), "media\\mainlogo.png"))

# Environmental variable to allow Windows decorations
ENV["GTK_CSD"] = 0

# Initialization of main function
function EthylDynamic()
    # Suppress warnings
    #@suppress begin

    # CSS style
    global provider = CssProviderLeaf(filename = style_file)

    ################################################################################
    # Min Win
    ################################################################################
    mainWin = Window()
    # Properties for mainWin
    set_gtk_property!(mainWin, :title, "EthylDynamic")
    set_gtk_property!(mainWin, :window_position, 3)
    set_gtk_property!(mainWin, :accept_focus, true)
    set_gtk_property!(mainWin, :resizable, false)
    screen = Gtk.GAccessor.style_context(mainWin)
    push!(screen, StyleProvider(provider), 600)

    ################################################################################
    # Grids
    ################################################################################
    # Properties for mainGrid
    mainGrid = Grid()
    set_gtk_property!(mainGrid, :column_spacing, 20)
    set_gtk_property!(mainGrid, :row_spacing, 20)
    set_gtk_property!(mainGrid, :margin_top, 30)
    set_gtk_property!(mainGrid, :margin_bottom, 20)
    set_gtk_property!(mainGrid, :margin_left, 20)
    set_gtk_property!(mainGrid, :margin_right, 20)
    set_gtk_property!(mainGrid, :column_homogeneous, true)
    set_gtk_property!(mainGrid, :row_homogeneous, false)

    ################################################################################
    # Main buttons
    ################################################################################
    # New simulation actions
    new = Button("New simulation")
    set_gtk_property!(new, :name, "new")
    set_gtk_property!(new, :width_request, 150)
    set_gtk_property!(new, :height_request, 80)
    screen = Gtk.GAccessor.style_context(new)
    push!(screen, StyleProvider(provider), 600)

    open = Button("Open simulation")
    set_gtk_property!(open, :name, "open")
    screen = Gtk.GAccessor.style_context(open)
    push!(screen, StyleProvider(provider), 600)

    tools = Button("Tools")
    set_gtk_property!(tools, :name, "tools")
    set_gtk_property!(tools, :width_request, 150)
    set_gtk_property!(tools, :height_request, 80)
    screen = Gtk.GAccessor.style_context(tools)
    push!(screen, StyleProvider(provider), 600)

    tutorial = Button("Tutorial")
    set_gtk_property!(tutorial, :name, "tutorial")
    set_gtk_property!(tutorial, :width_request, 150)
    set_gtk_property!(tutorial, :height_request, 80)
    screen = Gtk.GAccessor.style_context(tutorial)
    push!(screen, StyleProvider(provider), 600)

    about = Button("About")
    set_gtk_property!(about, :name, "about")
    set_gtk_property!(about, :width_request, 150)
    set_gtk_property!(about, :height_request, 80)
    screen = Gtk.GAccessor.style_context(about)
    push!(screen, StyleProvider(provider), 600)

    close = Button("Close")
    set_gtk_property!(close, :name, "close")
    screen = Gtk.GAccessor.style_context(close)
    push!(screen, StyleProvider(provider), 600)

    ################################################################################
    # New simulation window
    ################################################################################
    signal_connect(new, :clicked) do widget

        newWin = Window()
        # Properties for mainWin
        set_gtk_property!(newWin, :title, "EthylDynamic 1.0")
        set_gtk_property!(newWin, :window_position, 3)
        set_gtk_property!(newWin, :height_request, 800)
        set_gtk_property!(newWin, :width_request, 1200)
        set_gtk_property!(newWin, :accept_focus, true)
        set_gtk_property!(newWin, :resizable, false)
        #screen = Gtk.GAccessor.style_context(newWin)
        #push!(screen, StyleProvider(provider), 600)

        # Menu Icons
        tb1 = ToolButton("gtk-new")
        tb2 = ToolButton("gtk-open")
        tb3 = ToolButton("gtk-save")

        # Close toolbar
        tb4 = ToolButton("gtk-close")
        signal_connect(tb4, :clicked) do widget
            destroy(newWin)
        end
        signal_connect(newWin, "key-press-event") do widget, event
            if event.keyval == 65307
                destroy(newWin)
            end
        end

        # Toolbar
        newToolbar = Toolbar()
        set_gtk_property!(newToolbar, :height_request, 20)
        push!(newToolbar, SeparatorToolItem())
        push!(newToolbar, tb1)
        push!(newToolbar, tb2)
        push!(newToolbar, tb3)
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
        set_gtk_property!(vbox1Frame1, :height_request, 350)
        set_gtk_property!(vbox1Frame1, :label_xalign, 0.50)

        # Frame for compouns
        vbox1Frame2 = Frame("Added Compounds")
        set_gtk_property!(vbox1Frame2, :width_request, 800)
        set_gtk_property!(vbox1Frame2, :height_request, 300)
        set_gtk_property!(vbox1Frame2, :label_xalign, 0.50)

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
        set_gtk_property!(frameDatabank, :border_width, 1)

        # GtkListStore where the data is actually saved
        listDatabank = ListStore(Float64, String, Float64, Float64)

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
        selection1 = Gtk.GAccessor.mode(
            selection1,
            Gtk.GConstants.GtkSelectionMode.MULTIPLE,
        )

        # Column definitions
        cel1 = CellRendererText()
        c11 = TreeViewColumn("ID", cel1, Dict([("text", 0)]))
        c12 = TreeViewColumn("Name", cel1, Dict([("text", 1)]))
        c13 = TreeViewColumn("MW", cel1, Dict([("text", 2)]))
        c14 = TreeViewColumn("Tc", cel1, Dict([("text", 3)]))

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

        newDatabank = ToolButton("gtk-new")

        editDatabank = ToolButton("gtk-edit")

        saveDatabank = ToolButton("gtk-save-as")

        deleteDatabank = ToolButton("gtk-delete")
        # Close keyboard Esc
        signal_connect(deleteDatabank, :clicked) do widget
            empty!(listDatabank)
        end

        gridDataButtons[1, 1] = searchDatabank
        gridDataButtons[2, 1] = loadDatabank
        gridDataButtons[1:2, 2:7] = gridDatabank
        gridDataButtons[3, 2] = openDatabank
        gridDataButtons[3, 3] = newDatabank
        gridDataButtons[3, 4] = editDatabank
        gridDataButtons[3, 5] = addDatabank
        gridDataButtons[3, 6] = saveDatabank
        gridDataButtons[3, 7] = deleteDatabank

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
        set_gtk_property!(frameComp, :border_width, 1)

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

        addComp = ToolButton("gtk-add")

        newComp = ToolButton("gtk-new")

        editComp = ToolButton("gtk-edit")

        saveComp = ToolButton("gtk-save-as")

        deleteComp = ToolButton("gtk-delete")
        # Close keyboard Esc
        signal_connect(deleteComp, :clicked) do widget
            empty!(listComp)
        end

        # Add frame to grid to allow halign & valign
        gridComp[1, 1] = frameComp

        gridCompButtons[1:2, 1:6] = gridComp
        gridCompButtons[3, 1] = openComp
        gridCompButtons[3, 2] = newComp
        gridCompButtons[3, 3] = editComp
        gridCompButtons[3, 4] = addComp
        gridCompButtons[3, 5] = saveComp
        gridCompButtons[3, 6] = deleteComp

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
        vbox1[1, 2] = vbox1Frame2

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
        # Tab 6
        ############################################################################
        nbFrame6 = Frame()
        screen = Gtk.GAccessor.style_context(nbFrame6)
        push!(screen, StyleProvider(provider), 600)

        vbox6 = Grid()

        push!(nbFrame6, vbox6)
        push!(nb, nbFrame6, "Results")

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
            end
        end

        # Close keyboard Esc
        signal_connect(newGClose, :clicked) do widget
            destroy(newWin)
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
    end

        ############################################################################
        # Close mainWin
        ############################################################################
    signal_connect(mainWin, "key-press-event") do widget, event
        if event.keyval == 65307
            destroy(mainWin)
        end
    end

        # Close
    signal_connect(close, :clicked) do widget
        destroy(mainWin)
    end

        # TODO Checar texto y link
        ############################################################################
        # About mainWin
        ############################################################################
    signal_connect(about, :clicked) do widget
        aboutWin = Window()
        set_gtk_property!(aboutWin, :title, "About")
        set_gtk_property!(aboutWin, :window_position, 3)
        set_gtk_property!(aboutWin, :width_request, 100)
        screen = Gtk.GAccessor.style_context(aboutWin)
        push!(screen, StyleProvider(provider), 600)

        aboutGrid = Grid()
        set_gtk_property!(aboutGrid, :column_spacing, 30)
        set_gtk_property!(aboutGrid, :row_spacing, 30)
        set_gtk_property!(aboutGrid, :margin_bottom, 30)
        set_gtk_property!(aboutGrid, :margin_top, 30)
        set_gtk_property!(aboutGrid, :column_homogeneous, false)
        set_gtk_property!(aboutGrid, :row_homogeneous, false)
        set_gtk_property!(aboutGrid, :margin_left, 30)
        set_gtk_property!(aboutGrid, :margin_right, 30)

        closeAbout = Button("Close")
        set_gtk_property!(closeAbout, :name, "closeAbout")
        screen = Gtk.GAccessor.style_context(closeAbout)
        push!(screen, StyleProvider(provider), 600)
        signal_connect(closeAbout, :clicked) do widget
            destroy(aboutWin)
        end

        label1 = Label("Hola")
        Gtk.GAccessor.markup(
            label1,
            """<b>Dr. Kelvyn B. Sánchez Sánchez</b>
<i>Instituto Tecnológico de Celaya</i>\nkelvyn.baruc@gmail.com""",
        )
        Gtk.GAccessor.justify(label1, Gtk.GConstants.GtkJustification.CENTER)
        Gtk.GAccessor.selectable(label1, true)

        label2 = Label("Hola")
        Gtk.GAccessor.markup(
            label2,
            """<b>Dr. Arturo Jimenez Gutierrez</b>
<i>Instituto Tecnológico de Celaya</i>\narturo@iqcelaya.itc.mx""",
        )
        Gtk.GAccessor.justify(label2, Gtk.GConstants.GtkJustification.CENTER)
        Gtk.GAccessor.selectable(label2, true)

        label3 = Label("Hola")
        Gtk.GAccessor.markup(
            label3,
            """Free available at GitHub:
    <a href=\"https://github.com/JuliaChem/SimBioReactor.jl\"
    title=\"Clic to download\">https://github.com/JuliaChem/SimBioReactor.jl</a>""",
        )
        Gtk.GAccessor.justify(label3, Gtk.GConstants.GtkJustification.CENTER)

        aboutGrid[1:3, 1] = label1
        aboutGrid[4:6, 1] = label2
        aboutGrid[2:5, 2] = label3
        aboutGrid[3:4, 3] = closeAbout

        push!(aboutWin, aboutGrid)
        Gtk.showall(aboutWin)
    end

        # Label for main win
    mainlb1 = Label("Designed at Instituto Tecnológico de Celaya - 2020
    Support granted by the Conacyt-Secretaría de Energía-Hidrocarburos sectorial fund")
    Gtk.GAccessor.justify(mainlb1, Gtk.GConstants.GtkJustification.CENTER)
    screen = Gtk.GAccessor.style_context(mainlb1)
    push!(screen, StyleProvider(provider), 600)

    f1 = Frame()
    set_gtk_property!(f1, :margin_bottom, 0)
    set_gtk_property!(f1, :margin_top, 0)
    set_gtk_property!(f1, :margin_left, 0)
    set_gtk_property!(f1, :margin_right, 0)

    mainGrid[1:2, 1] = img
    mainGrid[1, 2] = new
    mainGrid[2, 2] = open
    mainGrid[1, 3] = tools
    mainGrid[2, 3] = tutorial
    mainGrid[1, 4] = about
    mainGrid[2, 4] = close
    mainGrid[1:2, 5] = mainlb1

    push!(f1, mainGrid)
    push!(mainWin, f1)
    Gtk.showall(mainWin)
    #end
end

dataFile = joinpath(dirname(Base.source_path()), "dataBank.jld")

dataBank = DataFrames.DataFrame()

dataBank.Compound = ["Water", "Methanol"]
dataBank.MW = [12, 32]

JLD.save(dataFile, "dataBankBackup", dataBank)
d = JLD.load(dataFile, "dataBankBackup")
