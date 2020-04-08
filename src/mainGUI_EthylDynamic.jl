# Initialization of main function
function EthylDynamicGUI()
    # Suppress warnings
    #@suppress begin

    # Environmental variable to allow Windows decorations
    ENV["GTK_CSD"] = 0

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
    set_gtk_property!(mainWin, :visible, false)
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
        set_gtk_property!(newWin, :title, "EthylDynamic 1.0 - *Untitled")
        set_gtk_property!(newWin, :window_position, 3)
        set_gtk_property!(newWin, :height_request, 800)
        set_gtk_property!(newWin, :width_request, 1200)
        set_gtk_property!(newWin, :accept_focus, true)
        set_gtk_property!(newWin, :resizable, false)
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
        set_gtk_property!(tb3, :sensitive, false)

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

        # newNotebook
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

        vbox00 = Grid()
        set_gtk_property!(vbox00, :column_homogeneous, false)
        set_gtk_property!(vbox00, :row_homogeneous, false)
        set_gtk_property!(vbox00, :halign, 3)
        set_gtk_property!(vbox00, :valign, 3)
        set_gtk_property!(vbox00, :row_spacing, 20)

        vbox0 = Grid()
        set_gtk_property!(vbox0, :column_homogeneous, false)
        set_gtk_property!(vbox0, :row_homogeneous, false)
        set_gtk_property!(vbox0, :column_spacing, 10)
        set_gtk_property!(vbox0, :row_spacing, 10)
        set_gtk_property!(vbox0, :margin_top, 20)
        set_gtk_property!(vbox0, :margin_bottom, 20)
        set_gtk_property!(vbox0, :margin_left, 20)
        set_gtk_property!(vbox0, :margin_right, 20)
        set_gtk_property!(vbox0, :halign, 3)

        nameUser = Label("Username:")
        set_gtk_property!(nameUser, :name, "nameUser")
        screen = Gtk.GAccessor.style_context(nameUser)
        push!(screen, StyleProvider(provider), 600)

        nameUserEntry = Entry()
        screen = Gtk.GAccessor.style_context(nameUserEntry)
        push!(screen, StyleProvider(provider), 600)

        simName = Label("Simulation Name:")
        set_gtk_property!(simName, :name, "simName")
        screen = Gtk.GAccessor.style_context(simName)
        push!(screen, StyleProvider(provider), 600)

        simUserEntry = Entry()
        screen = Gtk.GAccessor.style_context(simUserEntry)
        push!(screen, StyleProvider(provider), 600)

        dirName = Label("Directory:")
        set_gtk_property!(dirName, :name, "dirName")
        screen = Gtk.GAccessor.style_context(dirName)
        push!(screen, StyleProvider(provider), 600)

        dirNameEntry = Entry()
        screen = Gtk.GAccessor.style_context(dirNameEntry)
        push!(screen, StyleProvider(provider), 600)

        compName = Label("Company:")
        set_gtk_property!(compName, :name, "compName")
        screen = Gtk.GAccessor.style_context(compName)
        push!(screen, StyleProvider(provider), 600)

        compNameEntry = Entry()
        screen = Gtk.GAccessor.style_context(compNameEntry)
        push!(screen, StyleProvider(provider), 600)

        dateName = Label("Date:")
        set_gtk_property!(dateName, :name, "dateName")
        set_gtk_property!(dateName, :width_request, 200)
        screen = Gtk.GAccessor.style_context(dateName)
        push!(screen, StyleProvider(provider), 600)

        dateNameEntry = Entry()
        set_gtk_property!(dateNameEntry, :editable, false)
        set_gtk_property!(dateNameEntry, :width_request, 700)
        screen = Gtk.GAccessor.style_context(dateNameEntry)
        push!(screen, StyleProvider(provider), 600)

        notesName = Label("Notes:")
        set_gtk_property!(notesName, :name, "notesName")
        screen = Gtk.GAccessor.style_context(notesName)
        push!(screen, StyleProvider(provider), 600)

        # TODO wrap text
        notesNameEntry = Entry()
        set_gtk_property!(notesNameEntry, :height_request, 200)
        screen = Gtk.GAccessor.style_context(notesNameEntry)
        push!(screen, StyleProvider(provider), 600)

        timenow = Dates.now()
        timenow1 = Dates.format(timenow, "dd u yyyy HH:MM:SS")
        set_gtk_property!(dateNameEntry, :text, timenow1)

        vbox0[1, 1] = nameUser
        vbox0[2, 1] = nameUserEntry
        vbox0[1, 2] = simName
        vbox0[2, 2] = simUserEntry
        vbox0[1, 3] = dirName
        vbox0[2, 3] = dirNameEntry
        vbox0[1, 4] = compName
        vbox0[2, 4] = compNameEntry
        vbox0[1, 5] = dateName
        vbox0[2, 5] = dateNameEntry
        vbox0[1, 6] = notesName
        vbox0[2, 6:12] = notesNameEntry

        vbox00[1:30, 1] = vbox0
        # Separador (decorator)
        sep0 = Frame()
        set_gtk_property!(sep0, :width_request, 1000)
        set_gtk_property!(sep0, :height_request, 0)

        #vbox00[1:12, 2] = sep0


        saveStartup = ToolButton("gtk-floppy")
        clearStartup = ToolButton("gtk-clear")

        vbox00[29, 3] = clearStartup
        vbox00[30, 3] = saveStartup

        push!(nbFrame0, vbox00)
        push!(nb, nbFrame0, "Startup")

        ############################################################################
        # Tab 1
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
        #set_gtk_property!(vbox1Frame1, :height_request, 340)
        set_gtk_property!(vbox1Frame1, :label_xalign, 0.50)
        set_gtk_property!(vbox1Frame1, :shadow_type, 0)

        # Frame for compouns
        vbox1Frame2 = Frame("Added Components")
        #set_gtk_property!(vbox1Frame2, :height_request, 280)
        set_gtk_property!(vbox1Frame2, :label_xalign, 0.50)
        set_gtk_property!(vbox1Frame2, :shadow_type, 0)

        # Separador (decorator)
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
        global listDatabank = ListStore(
            String,
            String,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
        )

        for i = 1:size(database)[1]
            push!(
                listDatabank,
                (
                 database[i, 1],
                 database[i, 2],
                 database[i, 3],
                 database[i, 4],
                 database[i, 5],
                 database[i, 6],
                 database[i, 7],
                 database[i, 8],
                 database[i, 9],
                ),
            )
        end

        # Gtk TreeView to show the graphical element
        global viewDatabank = TreeView(TreeModel(listDatabank))
        set_gtk_property!(viewDatabank, :enable_grid_lines, 3)
        set_gtk_property!(viewDatabank, :enable_search, true)
        screen = Gtk.GAccessor.style_context(viewDatabank)
        push!(screen, StyleProvider(provider), 600)

        # Window that allow scroll the TreeView
        scrollDatabank = ScrolledWindow(viewDatabank)
        set_gtk_property!(scrollDatabank, :width_request, 750)
        set_gtk_property!(scrollDatabank, :height_request, 250)
        selection1 = Gtk.GAccessor.selection(viewDatabank)

        # Column definitions
        cTxt1 = CellRendererText()

        c11 = TreeViewColumn("Molecule", cTxt1, Dict([("text", 0)]))
        c12 = TreeViewColumn("Name", cTxt1, Dict([("text", 1)]))
        c13 = TreeViewColumn("MW", cTxt1, Dict([("text", 2)]))
        c14 = TreeViewColumn("ω", cTxt1, Dict([("text", 3)]))
        c15 = TreeViewColumn("Tc [K]", cTxt1, Dict([("text", 4)]))
        c16 = TreeViewColumn("Pc [bar]", cTxt1, Dict([("text", 5)]))
        c17 = TreeViewColumn("Zc", cTxt1, Dict([("text", 6)]))
        c18 = TreeViewColumn("Vc [cm^3/mol]", cTxt1, Dict([("text", 7)]))
        c19 = TreeViewColumn("Tn [K]", cTxt1, Dict([("text", 8)]))

        # Add column to TreeView
        push!(viewDatabank, c11, c12, c13, c14, c15, c16, c17, c18, c19)

        # Add scrool window to the frame
        push!(frameDatabank, scrollDatabank)

        # Add frame to grid to allow halign & valign
        gridDatabank[1, 1] = frameDatabank

        # Buttons around TreeView of dataBank

        searchDatabank = Entry()
        set_gtk_property!(searchDatabank, :text, "Search component")

        loadDatabank = Button("Search")

        openDatabank = ToolButton("gtk-open")
        signal_connect(openDatabank, :clicked) do widget
            global pathDatabase = open_dialog_native("Pick a file", Null(), ("*.csv",))

            if ~isempty(pathDatabase)
                @sigatom selection1 = Gtk.GAccessor.selection(viewDatabank)
                @sigatom selection1 = Gtk.GAccessor.mode(
                    selection1,
                    Gtk.GConstants.GtkSelectionMode.NONE,
                )
                empty!(listDatabank)

                global database = CSV.read(pathDatabase)

                for i = 1:size(database)[1]
                    push!(
                        listDatabank,
                        (
                         database[i, 1],
                         database[i, 2],
                         database[i, 3],
                         database[i, 4],
                         database[i, 5],
                         database[i, 6],
                         database[i, 7],
                         database[i, 8],
                         database[i, 9],
                        ),
                    )
                end

                @sigatom selection1 = Gtk.GAccessor.selection(viewDatabank)
                @sigatom selection1 = Gtk.GAccessor.mode(
                    selection1,
                    Gtk.GConstants.GtkSelectionMode.SINGLE,
                )
            end
        end

        addDatabank = ToolButton("gtk-add")

        remDatabank = ToolButton("gtk-remove")
        signal_connect(remDatabank, :clicked) do widget
            if hasselection(selection1)
                global listDatabank
                currentIt = selected(selection1)
                deleteat!(listDatabank, currentIt)
            end
        end

        newDatabank = ToolButton("gtk-new")

        editDatabank = ToolButton("gtk-edit")

        selectDatabank = ToolButton("gtk-go-down")
        signal_connect(selectDatabank, :clicked) do widget
            if hasselection(selection1)
                global viewComp
                currentIt = selected(selection1)

                push!(
                    listComp,
                    (
                     listDatabank[currentIt, 1],
                     listDatabank[currentIt, 2],
                     listDatabank[currentIt, 3],
                     listDatabank[currentIt, 4],
                     listDatabank[currentIt, 5],
                     listDatabank[currentIt, 6],
                     listDatabank[currentIt, 7],
                     listDatabank[currentIt, 8],
                     listDatabank[currentIt, 9],
                    ),
                )

                selection2 = Gtk.GAccessor.selection(viewComp)
                selection2 = Gtk.GAccessor.mode(
                    selection2,
                    Gtk.GConstants.GtkSelectionMode.SINGLE,
                )
            end
        end

        # Functions to reacts to double click and add the selected component
        function activate_row_cb(widgetptr::Ptr, path::Ptr, column::Ptr, user_data)
            tv = convert(GtkTreeView, widgetptr)
            ls = user_data

            selection = Gtk.GAccessor.selection(tv)

            if hasselection(selection)
                global viewComp

                currentIt = selected(selection)
                push!(
                    listComp,
                    (
                     ls[currentIt, 1],
                     ls[currentIt, 2],
                     ls[currentIt, 3],
                     ls[currentIt, 4],
                     ls[currentIt, 5],
                     ls[currentIt, 6],
                     ls[currentIt, 7],
                     ls[currentIt, 8],
                     ls[currentIt, 9],
                    ),
                )

                global selection2 = Gtk.GAccessor.selection(viewComp)
                selection2 = Gtk.GAccessor.mode(
                    selection2,
                    Gtk.GConstants.GtkSelectionMode.SINGLE,
                )
            end
            nothing
        end

        # Call to activate_row_cb
        signal_connect(
            activate_row_cb,
            viewDatabank,
            "row-activated",
            Nothing,
            (Ptr{GtkTreePath}, Ptr{GtkTreeViewColumn}),
            false,
            listDatabank,
        )

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
        global listComp = ListStore(
            String,
            String,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
            Float64,
        )

        # Gtk TreeView to show the graphical element
        global viewComp = TreeView(TreeModel(listComp))
        set_gtk_property!(viewComp, :enable_grid_lines, 3)
        set_gtk_property!(viewComp, :enable_search, true)
        screen = Gtk.GAccessor.style_context(viewComp)
        push!(screen, StyleProvider(provider), 600)

        # Window that allow scroll the TreeView
        scrollComp = ScrolledWindow(viewComp)
        set_gtk_property!(scrollComp, :width_request, 750)
        set_gtk_property!(scrollComp, :height_request, 250)
        selection2 = Gtk.GAccessor.selection(viewComp)
        selection2 = Gtk.GAccessor.mode(
            selection2,
            Gtk.GConstants.GtkSelectionMode.SINGLE,
        )

        # Column definitions
        cTxt2 = CellRendererText()

        c21 = TreeViewColumn("Molecule", cTxt2, Dict([("text", 0)]))
        c22 = TreeViewColumn("Name", cTxt2, Dict([("text", 1)]))
        c23 = TreeViewColumn("MW", cTxt2, Dict([("text", 2)]))
        c24 = TreeViewColumn("ω", cTxt2, Dict([("text", 3)]))
        c25 = TreeViewColumn("Tc [K]", cTxt2, Dict([("text", 4)]))
        c26 = TreeViewColumn("Pc [bar]", cTxt2, Dict([("text", 5)]))
        c27 = TreeViewColumn("Zc", cTxt2, Dict([("text", 6)]))
        c28 = TreeViewColumn("Vc [cm^3/mol]", cTxt2, Dict([("text", 7)]))
        c29 = TreeViewColumn("Tn [K]", cTxt2, Dict([("text", 8)]))

        # Add column to TreeView
        push!(viewComp, c21, c22, c23, c24, c25, c26, c27, c28, c29)

        # Add scrool window to the frame
        push!(frameComp, scrollComp)

        # Buttons around TreeView of dataComp
        openComp = ToolButton("gtk-open")

        editComp = ToolButton("gtk-edit")

        saveComp = ToolButton("gtk-floppy")

        csvComp = ToolButton("gtk-redo")

        remComp = ToolButton("gtk-remove")
        signal_connect(remComp, :clicked) do widget
            if hasselection(selection2)
                global listComp
                currentIt = selected(selection2)
                deleteat!(listComp, currentIt)
            end
        end

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

        equitFrameFig = Frame()
        set_gtk_property!(equitFrameFig, :height_request, 500)

        # TreeView for Equitments
        listStreamsEquit = ListStore(String, String, String)
        push!(listStreamsEquit, ("R1", "Reactor1", "Reactor"))
        push!(listStreamsEquit, ("R2", "Reactor2", "Reactor"))
        push!(listStreamsEquit, ("R3", "Reactor3", "Reactor"))

        viewStreamsEquit = TreeView(TreeModel(listStreamsEquit))
        set_gtk_property!(viewStreamsEquit, :enable_grid_lines, 3)
        set_gtk_property!(viewStreamsEquit, :enable_search, true)

        # Window that allow scroll the TreeView
        scrollStreamsEquit = ScrolledWindow(viewStreamsEquit)
        set_gtk_property!(scrollStreamsEquit, :width_request, 350)
        set_gtk_property!(scrollStreamsEquit, :height_request, 250)
        selection5 = Gtk.GAccessor.selection(viewStreamsEquit)

        # Column definitions
        cTxtREs3 = CellRendererText()

        cResEquit1 = TreeViewColumn("ID", cTxtREs3, Dict([("text", 0)]))
        cResEquit2 = TreeViewColumn("Name", cTxtREs3, Dict([("text", 1)]))
        cResEquit3 = TreeViewColumn("Type", cTxtREs3, Dict([("text", 2)]))

        # Add column to TreeView
        push!(viewStreamsEquit, cResEquit1, cResEquit2, cResEquit3)

        # Frame for viewEquit
        equitFrameTree = Frame()
        set_gtk_property!(equitFrameTree, :height_request, 500)

        push!(equitFrameTree, scrollStreamsEquit)

        vbox2[1:2, 1] = equitFrameFig
        vbox2[3:5, 1] = equitFrameTree
        vbox2[1, 2] = vbox2Button1
        vbox2[2, 2] = vbox2Button2
        vbox2[3, 2] = vbox2Button3
        vbox2[4, 2] = vbox2Button4
        vbox2[5, 2] = vbox2Button5

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
        # push!(nb, nbFrame4, "Thermodynamics")

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
        set_gtk_property!(vbox6, :halign, 3)
        set_gtk_property!(vbox6, :valign, 3)

        # newNotebook
        global nbResults = Notebook()
        nbResultsFrameTable = Frame()
        set_gtk_property!(nbResults, :width_request, 1080)
        set_gtk_property!(nbResults, :height_request, 650)

        gridResTable = Grid()
        set_gtk_property!(gridResTable, :column_homogeneous, false)
        set_gtk_property!(gridResTable, :row_homogeneous, false)
        set_gtk_property!(gridResTable, :column_spacing, 50)
        set_gtk_property!(gridResTable, :row_spacing, 20)
        set_gtk_property!(gridResTable, :margin_top, 20)
        set_gtk_property!(gridResTable, :margin_bottom, 20)
        set_gtk_property!(gridResTable, :margin_left, 20)
        set_gtk_property!(gridResTable, :margin_right, 20)
        set_gtk_property!(gridResTable, :halign, 3)
        set_gtk_property!(gridResTable, :valign, 3)

        ##################################################################################
        # TreeView for Tables (nbResults)
        listBlocksREs = ListStore(String, String, String)

        viewBlocksRes = TreeView(TreeModel(listBlocksREs))
        set_gtk_property!(viewBlocksRes, :enable_grid_lines, 3)
        set_gtk_property!(viewBlocksRes, :enable_search, true)

        # Window that allow scroll the TreeView
        scrollBlocksRes = ScrolledWindow(viewBlocksRes)
        set_gtk_property!(scrollBlocksRes, :width_request, 350)
        set_gtk_property!(scrollBlocksRes, :height_request, 250)
        selection3 = Gtk.GAccessor.selection(viewBlocksRes)

        # Column definitions
        cTxtREs1 = CellRendererText()

        cRes1 = TreeViewColumn("ID", cTxtREs1, Dict([("text", 0)]))
        cRes2 = TreeViewColumn("Name", cTxtREs1, Dict([("text", 1)]))
        cRes3 = TreeViewColumn("Type", cTxtREs1, Dict([("text", 2)]))

        # Add column to TreeView
        push!(viewBlocksRes, cRes1, cRes2, cRes3)

        # Frame for viewBlocksRes
        frameBlocksRes = Frame("Table X. Block")
        set_gtk_property!(frameBlocksRes, :label_xalign, 0.50)
        set_gtk_property!(frameBlocksRes, :shadow_type, 0)

        frameViewBlocksRes = Frame()

        push!(frameBlocksRes, frameViewBlocksRes)
        push!(frameViewBlocksRes, scrollBlocksRes)

        ##################################################################################
        # TreeView for Tables (nbResults)
        listStreamsRes = ListStore(String, String, String)

        viewStreamsRes = TreeView(TreeModel(listStreamsRes))
        set_gtk_property!(viewStreamsRes, :enable_grid_lines, 3)
        set_gtk_property!(viewStreamsRes, :enable_search, true)

        # Window that allow scroll the TreeView
        scrollStreamsRes = ScrolledWindow(viewStreamsRes)
        set_gtk_property!(scrollStreamsRes, :width_request, 350)
        set_gtk_property!(scrollStreamsRes, :height_request, 250)
        selection4 = Gtk.GAccessor.selection(viewStreamsRes)

        # Column definitions
        cTxtREs2 = CellRendererText()

        cResStr1 = TreeViewColumn("ID", cTxtREs2, Dict([("text", 0)]))
        cResStr2 = TreeViewColumn("Name", cTxtREs2, Dict([("text", 1)]))
        cResStr3 = TreeViewColumn("Type", cTxtREs2, Dict([("text", 2)]))

        # Add column to TreeView
        push!(viewStreamsRes, cResStr1, cResStr2, cResStr3)

        # Frame for viewBlocksRes
        frameStreamsRes = Frame("Table X. Streams")
        set_gtk_property!(frameStreamsRes, :label_xalign, 0.50)
        set_gtk_property!(frameStreamsRes, :shadow_type, 0)

        frameViewStreamsRes = Frame()

        push!(frameStreamsRes, frameViewStreamsRes)
        push!(frameViewStreamsRes, scrollStreamsRes)

        ##################################################################################
        # TreeView for Tables (nbResults)
        listResTable = ListStore(String, String, String)

        viewResTable = TreeView(TreeModel(listResTable))
        set_gtk_property!(viewResTable, :enable_grid_lines, 3)
        set_gtk_property!(viewResTable, :enable_search, true)

        # Window that allow scroll the TreeView
        scrollResTable = ScrolledWindow(viewResTable)
        set_gtk_property!(scrollResTable, :width_request, 350)
        set_gtk_property!(scrollResTable, :height_request, 250)
        selection4 = Gtk.GAccessor.selection(viewResTable)

        # Column definitions
        cTxtREs3 = CellRendererText()

        cResTab1 = TreeViewColumn("Temperature", cTxtREs3, Dict([("text", 0)]))
        cResTab2 = TreeViewColumn("Pressure", cTxtREs3, Dict([("text", 1)]))
        cResTab3 = TreeViewColumn("XA Concentration", cTxtREs3, Dict([("text", 2)]))

        # Add column to TreeView
        push!(viewResTable, cResTab1, cResTab2, cResTab3)

        # Frame for viewBlocksRes
        frameResTable = Frame("Table X. Results")
        set_gtk_property!(frameResTable, :label_xalign, 0.50)
        set_gtk_property!(frameResTable, :shadow_type, 0)

        frameViewResTable = Frame()

        push!(frameResTable, frameViewResTable)
        push!(frameViewResTable, scrollResTable)

        ############
        gridResTable[1, 1] = frameBlocksRes
        gridResTable[1, 2] = frameStreamsRes
        gridResTable[2, 1:2] = frameResTable

        push!(nbResultsFrameTable, gridResTable)
        push!(nbResults, nbResultsFrameTable, "Tables")

        nbResultsFramePlots = Frame()
        push!(nbResults, nbResultsFramePlots, "Graphs")

        vbox6[1, 1] = nbResults

        push!(nbFrame6, vbox6)
        push!(nb, nbFrame6, "Results")

        ############################################################################
        # Tab 7
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
        set_gtk_property!(vbox7, :margin_bottom, 10)
        set_gtk_property!(vbox7, :margin_left, 20)
        set_gtk_property!(vbox7, :margin_right, 20)
        set_gtk_property!(vbox7, :halign, 3)

        labLogging = Label("Data Logging")
        frameLogging = Frame()
        set_gtk_property!(frameLogging, :name, "frameLogging")
        screen = Gtk.GAccessor.style_context(frameLogging)
        push!(screen, StyleProvider(provider), 600)

        scrollLogging = ScrolledWindow()
        set_gtk_property!(scrollLogging, :width_request, 1000)
        set_gtk_property!(scrollLogging, :height_request, 540)
        screen = Gtk.GAccessor.style_context(scrollLogging)
        push!(screen, StyleProvider(provider), 600)

        push!(frameLogging, scrollLogging)

        # Buttons for logging
        saveLog = ToolButton("gtk-floppy")
        remLog = ToolButton("gtk-clear")
        printLog = ToolButton("gtk-print")

        vbox7[12, 1] = labLogging
        vbox7[1:20, 2] = frameLogging
        vbox7[18, 3] = remLog
        vbox7[19, 3] = printLog
        vbox7[20, 3] = saveLog

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
        set_gtk_property!(newWin:visible, true)
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

    img = Gtk.Image(image_path)

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
