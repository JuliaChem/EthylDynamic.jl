module EthylDynamic
  # Function to call the GUI
  export EthylDynamicGUI

  using Gtk, Gtk.ShortNames, JLD, Suppressor, CSV, Mustache, Dates
  import DataFrames

  # Path to CSS Gtk-Style dataFile
  global style_file = joinpath(dirname(Base.source_path()), "style2020.css")

  # Logo
  if Sys.iswindows()
    global image_path = joinpath(dirname(Base.source_path()), "media\\mainlogo.png")
  end

  if Sys.islinux()
    global image_path = joinpath(dirname(Base.source_path()), "media//mainlogo.png")
  end

  # General Settings
  global pathDataBase = joinpath(dirname(Base.source_path()), "database.csv")

  # Load default database
  global database = CSV.read(pathDataBase)

  # Include the main file .fl
  include("mainGUI_EthylDynamic.jl")
end
