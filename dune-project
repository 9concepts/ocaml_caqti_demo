(lang dune 3.6)

(name ocaml_caqti_demo)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "9sako6")

(maintainers "9sako6")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name ocaml_caqti_demo)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends
  ocaml
  ocaml-lsp-server
  ocamlformat
  dune
  lwt
  lwt_ppx
  (caqti
   (= 1.9.0))
  (caqti-lwt
   (= 1.9.0))
  (caqti-driver-postgresql
   (= 1.9.0))
  ppx_yojson_conv)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
