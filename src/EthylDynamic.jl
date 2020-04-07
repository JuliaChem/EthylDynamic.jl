# Main module
module EthylDynamic
  # Function to call the GUI
  export EthylDynamicGUI


  using Gtk, Gtk.ShortNames, JLD, Suppressor, CSV, Mustache, Dates
  import DataFrames

  # Path to CSS Gtk-Style dataFile
  global style_file = joinpath(dirname(Base.source_path()), "style2020.css")
  global img = Gtk.Image(joinpath(dirname(Base.source_path()), "media\\mainlogo.png"))

  # General Settings
  global pathDataBase = joinpath(dirname(Base.source_path()), "database.csv")

  # Load default database
  global database = CSV.read(pathDataBase)

  # Environmental variable to allow Windows decorations
  ENV["GTK_CSD"] = 0
  # Include the main file .fl
  include("mainGUI_EthylDynamic.jl")
end
