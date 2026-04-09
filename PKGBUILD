pkgname=md-remind
pkgver=0.0.1
pkgrel=1
arch=('any')
depends=('bash')
optdepends=('obsidian: obsidian modal support' 'xdg-utils: obsidian modal support')
source=('main.sh')
sha512sums=('SKIP')

package(){
	install -d "${pkgdir}/usr/local/bin"
	ln -s "$(dirname ${srcdir})/main.sh" "${pkgdir}/usr/local/bin/${pkgname}"
}

