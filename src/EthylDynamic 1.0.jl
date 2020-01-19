using Gtk.ShortNames, Winston, Random, JLD, Suppressor

global style_file = joinpath(dirname(Base.source_path()), "style2020.css")
global img = Gtk.Image(joinpath(dirname(Base.source_path()),
    "media\\mainlogo.png"))
# Environmental variable to allow Windows decorations
ENV["GTK_CSD"] = 0

# Initialization of main fuction
function EthylDynamic()
    # Suppress warnings
    #@suppress begin

        # CSS style
        global provider = CssProviderLeaf(filename = style_file)

        ############################################################################
        # Grids
        ############################################################################
        mainWin = Window()
        # Properties for mainWin
        set_gtk_property!(mainWin, :title, "EthylDynamic")
        set_gtk_property!(mainWin, :window_position, 3)
        set_gtk_property!(mainWin, :accept_focus, true)
        screen = Gtk.GAccessor.style_context(mainWin)
        push!(screen, StyleProvider(provider), 600)

        ############################################################################
        # Grids
        ############################################################################
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

        ############################################################################
        # Main buttons
        ############################################################################
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

        ############################################################################
        # Signal Connect
        ############################################################################
        # New simulation button
        signal_connect(new, :clicked) do widget

            newWin = Window()
            # Properties for mainWin
            set_gtk_property!(newWin, :title, "EthylDynamic 1.0")
            set_gtk_property!(newWin, :window_position, 3)
            set_gtk_property!(newWin, :height_request, 800)
            set_gtk_property!(newWin, :width_request, 1200)
            set_gtk_property!(newWin, :accept_focus, true)
            screen = Gtk.GAccessor.style_context(newWin)
            push!(screen, StyleProvider(provider), 600)

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

            newToolbar = Toolbar()
            set_gtk_property!(newToolbar, :height_request, 20)
            push!(newToolbar, SeparatorToolItem())
            push!(newToolbar, tb1)
            push!(newToolbar, tb2)
            push!(newToolbar, tb3)
            push!(newToolbar, SeparatorToolItem())
            push!(newToolbar, tb4)
            push!(newToolbar, SeparatorToolItem())

            newG = Grid()
            set_gtk_property!(newG, :column_homogeneous, true)
            set_gtk_property!(newG, :row_homogeneous, false)

            newFrame1 = Frame()
            push!(newFrame1, newToolbar)
            newG[1, 1] = newFrame1

            nb = Notebook()
            set_gtk_property!(nb, :height_request, 760)
            screen = Gtk.GAccessor.style_context(nb)
            push!(screen, StyleProvider(provider), 600)

            # Tab 1
            vbox1 = Grid()
            push!(nb, vbox1, "Compounds")

            # Tab 2
            vbox2 = Grid()
            push!(nb, vbox2, "Equipments")

            # Tab 3
            vbox3 = Grid()
            push!(nb, vbox3, "Thermodynamics")

            # Tab 4
            vbox4 = Grid()
            push!(nb, vbox4, "Results")

            b1 = Button("Hola")
            vbox4[1, 1] = b1

            newFrame2 = Frame()
            newG[1, 2] = nb
            push!(newWin, newG)

            Gtk.showall(newWin)
        end

        # Close
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
        # About
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
