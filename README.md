# Example of ocaml-caqti

:camel:

# Requirements

- [lwt](https://ocsigen.org/lwt/latest/manual/manual)
- [lwt_ppx](https://ocsigen.org/lwt/5.3.0/api/Ppx_lwt)
- [caqti](https://github.com/paurkedal/ocaml-caqti/)
- [caqti-lwt](https://opam.ocaml.org/packages/caqti-lwt/)
- [caqti-driver-postgresql](https://opam.ocaml.org/packages/caqti-driver-postgresql/)
- [ppx_yojson_conv](https://github.com/janestreet/ppx_yojson_conv)

# Setup

```bash
opam switch create . 5.0.0 --deps-only --with-test
```

To delete a locally created sandbox, execute the following command

```bash
opam switch remove .
```

# Run

```bash
docker compose up
dune exec ocaml_caqti_demo
```

Run tests.

```bash
 dune test
```
