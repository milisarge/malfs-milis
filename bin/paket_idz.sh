grep -rli '${PKGMK_BUILDVER}' * | xargs -i@ sed -i 's/${PKGMK_BUILDVER}/#$version-/g' @
