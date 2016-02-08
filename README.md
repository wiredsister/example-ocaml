# Example OCaml Meetup
Bread and butter OCaml program that makes an HTTP request and prints the response to the console.

To run, do:
`oasis setup`

then
`ocaml setup.ml -configure`

and then
`ocaml setup.ml -build`

if you `ls` in that directory you should see some new files, 
the most important being `main.byte`. That's your bytecode executable!

Now do
`./main.byte`
and you should see an HTTP Response headers and body printed out in your console.

# See Also

If you need help setting up or installing Oasis, Opam, or any other OCaml tooling check out: 
http://hyegar.com/blog/2015/10/19/so-you're-learning-ocaml/
