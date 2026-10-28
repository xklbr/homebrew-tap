class Guachiman < Formula
  desc "Vigila la RAM y CPU desde la barra de menú, con foco en Claude Code"
  homepage "https://github.com/xklbr/guachiman"
  url "https://github.com/xklbr/guachiman/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "9f8dd1c0ee79af4b051853cb213912d57ac9b5c0a5a401adf3a3ef437d412c6d"
  license "MIT"

  depends_on macos: :ventura

  def install
    system "make"
    prefix.install "build/Guachiman.app"
    bin.install_symlink prefix/"Guachiman.app/Contents/MacOS/Guachiman" => "guachiman"
  end

  service do
    run [opt_prefix/"Guachiman.app/Contents/MacOS/Guachiman"]
    keep_alive successful_exit: false
    process_type :interactive
  end

  def caveats
    <<~EOS
      La primera vez, macOS pedirá permiso para mostrar notificaciones: acéptalo.

      Si usas `brew services`, no actives también "Iniciar al encender" dentro de la app.
      (La app es de instancia única, así que no se duplicará.)
    EOS
  end

  test do
    assert_match "selftest OK", shell_output("#{bin}/guachiman --selftest")
  end
end
