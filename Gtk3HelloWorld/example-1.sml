fun printHello () = print "Hello World\n"

fun activate app () =
  let
    val window = Gtk.ApplicationWindow.new app
    val () = Gtk.Window.setTitle window "Gtk3 SML"
    val () = Gtk.Window.setDefaultSize window (200, 200)

    val buttonBox = Gtk.ButtonBox.new Gtk.Orientation.HORIZONTAL
    val () = Gtk.Container.add window buttonBox

    val button = Gtk.Button.newWithLabel "Hello World"
    val _ = Signal.connect button (Gtk.Button.clickedSig, printHello)
    val () = Gtk.Container.add buttonBox button

    val () = Gtk.Widget.showAll window
  in
    ()
  end

fun main () =
  let
    val app = Gtk.Application.new (SOME "org.gtk.example", Gio.ApplicationFlags.FLAGS_NONE)
    val id = Signal.connect app (Gio.Application.activateSig, activate app)

    val argv = Utf8CPtrArrayN.fromList (CommandLine.name () :: CommandLine.arguments ())
    val status = Gio.Application.run app argv

    val () = Signal.disconnect app id
  in
    Giraffe.exit status
  end
    handle e => Giraffe.error 1 ["Uncaught exception\n", exnMessage e, "\n"]
