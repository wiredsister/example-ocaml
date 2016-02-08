open Lwt.Infix
open Cohttp_lwt_unix

(*** Here is an example of a bread and butter OCaml program
     that makes an HTTP GET request (using Cohttp) and then
     prints that to the screen.
***)

let request () =
  (* Some bitcoin price information. *)
  (* Client.get :
     ?ctx:Cohttp_lwt_unix.Client.ctx ->
     ?headers:Cohttp.Header.t ->
     Uri.t ->
     (Cohttp.Response.t * Cohttp_lwt_body.t) Lwt.t *)
  Client.get (Uri.of_string "http://www.bitstamp.net/api/ticker/")

  (*** Bind, or as some affectionally call shove: 'a Lwt.t -> (a' -> b' Lwt.t) -> 'b Lwt.t
     What we're doing here is shoving the thing inside the monad on the left of the >>=
     into the right side of the >>= then wrapping that result in a monad.
     Another way to think about this might be:
     "I don't know when the left side will happen, but when it does, do this with it."
  ***)
  >>= fun (resp, body) ->
  let code = resp |> Response.status |> Cohttp.Code.code_of_status in
  Printf.printf "Response code: %d\n" code;
  Printf.printf "Headers: %s\n" (resp |> Response.headers |> Cohttp.Header.to_string);
  body |> Cohttp_lwt_body.to_string >|= fun body ->
  Printf.printf "Body of length: %d\n" (String.length body);
  body

let () =
  (*** Lwt is a cooperative threading library in OCaml.
       Cooperative threads (A.K.A. non-premtive threads)
       typically yield control to another thread before they finish.
       People use Lwt for I/O, events, and ease of use.
       See also, async. ***)

  (* Lwt_main.run : 'a Lwt.t -> 'a *)
  (* run t calls the Lwt scheduler repeatedly until t terminates,
     then returns the value returned by the thread.
     If t fails with an exception the exception is raised. *)
  let bitcoin_price = Lwt_main.run (request ()) in
  print_endline ("Received response\n" ^ bitcoin_price)
