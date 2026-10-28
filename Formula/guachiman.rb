class Guachiman < Formula
  desc "Vigila la RAM y CPU desde la barra de menú, con foco en Claude Code"
  homepage "https://github.com/xklbr/guachiman"
  url "https://github.com/xklbr/guachiman/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "096a60c787a5a44067496a84dff4a5a7838990410f7f364d4749e24fac1475ae"
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
