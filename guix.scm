(use-modules (gnu packages autotools)
             (gnu packages guile)
             (gnu packages guile-wm)
             (guix gexp)
             (guix git-download)
             (guix packages)
             (guix utils))

(define-public my-guile-xcb
  (let ((commit "fde68ddca1850e0310f456aa76a88bb99408a29e")
        (revision "1"))
    (package
      (inherit guile-xcb)
      (name "my-guile-xcb")
      (version (git-version "1.3" revision commit))
      (home-page "https://github.com/lechner/guile-xcb")
      (source
       (origin
         (method git-fetch)
         (uri
          (git-reference
           (url "https://github.com/lechner/guile-xcb")
           (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32
           "0px7k5zqw8k521r82lhdqdwagskbvy8xfczzp43pajww5pamf2h6"))))

      (native-inputs
       (modify-inputs (package-native-inputs guile-xcb)
         (prepend autoconf automake)
         (replace "guile" guile-3.0)))

      (arguments
       (substitute-keyword-arguments (package-arguments guile-xcb)
         ((#:configure-flags flags)
          '(list
            (string-append
             "--with-guile-site-dir="
             (assoc-ref %outputs "out")
             "/share/guile/site/3.0")
            (string-append
             "--with-guile-site-ccache-dir="
             (assoc-ref %outputs "out")
             "/lib/guile/3.0/site-ccache"))))))))

(define-public my-guile-wm
  (let ((commit "c0dc2d6787cdf60c7a53f470a085786b4c1675a0")
        (revision "1"))
    (package
      (inherit guile-wm)
      (name "my-guile-wm")
      (version (git-version "1.0" revision commit))
      (home-page "https://github.com/lechner/guile-wm/releases")
      (source
       (origin
         (method git-fetch)
         (uri
          (git-reference
           (url "https://github.com/lechner/guile-wm")
           (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32
           "1xa4pjzhskcmfxw6caqdjiliv4fdlhdqawd0cjsf58mwjswms75f"))
         (snippet
          #~(begin
              (symlink "README.md" "README")))
         ))
      (native-inputs
       (modify-inputs (package-native-inputs guile-wm)
         (prepend autoconf automake)
         (replace "guile" guile-3.0)
         (replace "guile-xcb" my-guile-xcb)))
      (inputs
       (modify-inputs (package-inputs guile-wm)
         (replace "guile" guile-3.0)
         (replace "guile-xcb" my-guile-xcb)))

      (arguments
       (substitute-keyword-arguments
           (package-arguments guile-wm)
         ((#:configure-flags flags)
          '(list (string-append "--datadir="
                                (assoc-ref %outputs "out")
                                "/share/guile/site/3.0")))
         ((#:phases phases)
	  `(modify-phases ,phases
	     (add-after 'unpack 'patch-shebang
	       (lambda* (#:key inputs #:allow-other-keys)
		 (substitute* "guile-wm"
		   (("/usr/bin/guile3")
		    (search-input-file inputs "bin/guile"))))))))))))

my-guile-wm
