using Gtk.ShortNames, Winston, Random, JLD, Suppressor

# Path to CSS Gtk-Style dataFile
global style_file = joinpath(dirname(Base.source_path()), "style2020.css")
global img = Gtk.Image(joinpath(dirname(Base.source_path()),
    "media\\mainlogo.png"))

# Environmental variable to allow Windows decorations
ENV["GTK_CSD"] = 0

# Initialization of main function
function EthylDynamic()
    # Suppress warnings
    #@suppress begin

        # CSS style
        global provider = CssProviderLeaf(filename = style_file)

        ################################################################################
        # Main Win
        ################################################################################
        mainWin = Window()
        # Properties for mainWin
        set_gtk_property!(mainWin, :title, "EthylDynamic")
        set_gtk_property!(mainWin, :window_position, 3)
        set_gtk_property!(mainWin, :accept_focus, true)
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
            nb = Notebook()
            set_gtk_property!(nb, :height_request, 700)
            screen = Gtk.GAccessor.style_context(nb)
            push!(screen, StyleProvider(provider), 600)

            ############################################################################
            # Tab 1 - Compounds
            ############################################################################
            vbox1 = Grid()
            set_gtk_property!(vbox1, :column_homogeneous, false)
            set_gtk_property!(vbox1, :row_homogeneous, false)
            set_gtk_property!(vbox1, :column_spacing, 10)
            set_gtk_property!(vbox1, :row_spacing, 10)
            set_gtk_property!(vbox1, :margin_top, 10)
            set_gtk_property!(vbox1, :margin_bottom, 20)
            set_gtk_property!(vbox1, :margin_left, 20)
            set_gtk_property!(vbox1, :margin_right, 20)

            # Frame for databank
            vbox1Frame1 = Frame("Databank")
            set_gtk_property!(vbox1Frame1, :width_request, 1160)
            set_gtk_property!(vbox1Frame1, :height_request, 310)
            set_gtk_property!(vbox1Frame1, :label_xalign, 0.50)

            # Frame for compouns
            vbox1Frame2 = Frame("Added Compounds")
            set_gtk_property!(vbox1Frame2, :width_request, 1160)
            set_gtk_property!(vbox1Frame2, :height_request, 310)
            set_gtk_property!(vbox1Frame2, :label_xalign, 0.50)

            ############################################################################
            # Datasheet vbox1
            gridDatabank = GtkGrid()
            set_gtk_property!(gridDatabank, :halign, 3)
            set_gtk_property!(gridDatabank, :valign, 3)

            # Frame with border to enhance the style
            frameDatabank = GtkFrame()
            set_gtk_property!(frameDatabank, :border_width, 1)

            # GtkListStore where the data is actually saved
            listDatabank = GtkListStore(Float64, String, Float64, Float64)

            # Data for example
            push!(listDatabank,(1,"Water",1,1))
            push!(listDatabank,(2,"Cerveza",4,6))
            push!(listDatabank,(3,"Alcohol",7,3))
            push!(listDatabank,(4,"Vocka",12,1))

            # Gtk TreeView to show the graphical element
            viewDatabank = GtkTreeView(GtkTreeModel(listDatabank))
            set_gtk_property!(viewDatabank, :enable_grid_lines, 3)

            # Window that allow scroll the TreeView
            scrollDatabank = GtkScrolledWindow(viewDatabank)
            set_gtk_property!(scrollDatabank, :width_request, 600)
            set_gtk_property!(scrollDatabank, :height_request, 250)
            selection1 = Gtk.GAccessor.selection(viewDatabank)
            selection1 = Gtk.GAccessor.mode(selection1,Gtk.GConstants.GtkSelectionMode.MULTIPLE)

            # Column definitions
            cel1 = GtkCellRendererText()
            c11 = GtkTreeViewColumn("ID", cel1, Dict([("text",0)]))
            c12 = GtkTreeViewColumn("Name", cel1, Dict([("text",1)]))
            c13 = GtkTreeViewColumn("MW", cel1, Dict([("text",2)]))
            c14 = GtkTreeViewColumn("Tc", cel1, Dict([("text",3)]))

            # Add column to TreeView
            push!(viewDatabank, c11, c12, c13, c14)

            # Add scrool window to the frame
            push!(frameDatabank, scrollDatabank)

            # Add frame to grid to allow halign & valign
            gridDatabank[1,1] = frameDatabank

            # Add to second frame in vbox1
            push!(vbox1Frame1, gridDatabank)

            # Allow to resize columns
            for c in [c11, c12, c13, c14]
                Gtk.GAccessor.resizable(c, true)
            end

            # Allow to sort columns
            for (i,c) in enumerate([c11, c12, c13, c14])
                Gtk.GAccessor.sort_column_id(c,i-1)
            end

            # Allow to reorder columns
            for (i,c) in enumerate([c11, c12, c13, c14])
                Gtk.GAccessor.reorderable(c, i)
            end

            ############################################################################
            # Datasheet vbox2
            gridComp = GtkGrid()
            set_gtk_property!(gridComp, :halign, 3)
            set_gtk_property!(gridComp, :valign, 3)

            # Frame with border to enhance the style
            frameComp = GtkFrame()
            set_gtk_property!(frameComp, :border_width, 1)

            # GtkListStore where the data is actually saved
            listComp = GtkListStore(Float64, String, Float64, Float64)

            # Data for example
            push!(listComp,(1,"Water",1,1))
            push!(listComp,(2,"Cerveza",4,6))
            push!(listComp,(3,"Alcohol",7,3))
            push!(listComp,(4,"Vocka",12,1))

            # Gtk TreeView to show the graphical element
            viewComp = GtkTreeView(GtkTreeModel(listComp))
            set_gtk_property!(viewComp, :enable_grid_lines, 3)

            # Window that allow scroll the TreeView
            scrollComp = GtkScrolledWindow(viewComp)
            set_gtk_property!(scrollComp, :width_request, 600)
            set_gtk_property!(scrollComp, :height_request, 250)
            selection2 = Gtk.GAccessor.selection(viewComp)
            selection2 = Gtk.GAccessor.mode(selection2,Gtk.GConstants.GtkSelectionMode.MULTIPLE)

            # Column definitions
            cel1 = GtkCellRendererText()
            c21 = GtkTreeViewColumn("ID", cel1, Dict([("text",0)]))
            c22 = GtkTreeViewColumn("Name", cel1, Dict([("text",1)]))
            c23 = GtkTreeViewColumn("MW", cel1, Dict([("text",2)]))
            c24 = GtkTreeViewColumn("Tc", cel1, Dict([("text",3)]))

            # Add column to TreeView
            push!(viewComp, c21, c22, c23, c24)

            # Add scrool window to the frame
            push!(frameComp, scrollComp)

            # Add frame to grid to allow halign & valign
            gridComp[1,1] = frameComp

            # Add to second frame in vbox1
            push!(vbox1Frame2, gridComp)

            # Allow to resize columns
            for c in [c21, c22, c23, c24]
                Gtk.GAccessor.resizable(c, true)
            end

            # Allow to sort columns
            for (i,c) in enumerate([c21, c22, c23, c24])
                Gtk.GAccessor.sort_column_id(c,i-1)
            end

            # Allow to reorder columns
            for (i,c) in enumerate([c21, c22, c23, c24])
                Gtk.GAccessor.reorderable(c, i)
            end

            ############################################################################
            vbox1[1, 1] = vbox1Frame1
            vbox1[1, 2] = vbox1Frame2

            push!(nb, vbox1, "Compounds")

            ############################################################################
            # Tab 2
            ############################################################################
            vbox2 = Grid()
            push!(nb, vbox2, "Equipments")

            ############################################################################
            # Tab 3
            ############################################################################
            vbox3 = Grid()
            push!(nb, vbox3, "Thermodynamics")

            ############################################################################
            # Tab 4
            ############################################################################
            vbox4 = Grid()
            push!(nb, vbox4, "Results")

            b1 = Button("Hola")
            vbox4[1, 1] = b1

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

            # Buttons for newGButtons
            newGEmpty = Grid()
            set_gtk_property!(newGEmpty, :width_request, 680)

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
            screen = Gtk.GAccessor.style_context(newGExit)
            push!(screen, StyleProvider(provider), 600)

            # Exit for newWin
            signal_connect(newGExit, :clicked) do widget
                destroy(newWin)
                destroy(mainWin)
            end

            # Back for newWin
            newGBack = Button("Back")
            set_gtk_property!(newGBack, :width_request, 100)
            screen = Gtk.GAccessor.style_context(newGBack)
            push!(screen, StyleProvider(provider), 600)

            # Next for newWin
            newGNext = Button("Next")
            set_gtk_property!(newGNext, :width_request, 100)
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
            Gtk.GAccessor.markup(label1,
                """<b>Dr. Kelvyn B. Sánchez Sánchez</b>
<i>Instituto Tecnológico de Celaya</i>\nkelvyn.baruc@gmail.com""")
            Gtk.GAccessor.justify(label1,
                Gtk.GConstants.GtkJustification.CENTER)
            Gtk.GAccessor.selectable(label1, true)

            label2 = Label("Hola")
            Gtk.GAccessor.markup(
                label2,
                """<b>Dr. Arturo Jimenez Gutierrez</b>
<i>Instituto Tecnológico de Celaya</i>\narturo@iqcelaya.itc.mx""")
            Gtk.GAccessor.justify(label2,
            Gtk.GConstants.GtkJustification.CENTER)
            Gtk.GAccessor.selectable(label2, true)

            label3 = Label("Hola")
            Gtk.GAccessor.markup(label3,
                """Free available at GitHub:
        <a href=\"https://github.com/JuliaChem/SimBioReactor.jl\"
        title=\"Clic to download\">https://github.com/JuliaChem/SimBioReactor.jl</a>""")
            Gtk.GAccessor.justify(label3,
                Gtk.GConstants.GtkJustification.CENTER)

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

#dataFile = joinpath(dirname(Base.source_path()), "dataBank.jld")
# t = 15
# z = [1,3]
# JLD.save(dataFile, "t", t, "arr", z)
# d =JLD.load(dataFile)
