open Lwt.Infix
open Cohttp_lwt_unix

let request =
  (* Client.get (Uri.of_string "http://api.coindesk.com/v1/bpi/currentprice/usd.json") *)
  Client.get (Uri.of_string "http://www.bitstamp.net/api/ticker/")
  >>= fun (resp, body)->
  let code = resp |> Response.status |> Cohttp.Code.code_of_status in
  Printf.printf "Response code: %d\n" code;
  Printf.printf "Headers: %s\n" (resp |> Response.headers |> Cohttp.Header.to_string);
  body |> Cohttp_lwt_body.to_string >|= fun body ->
  Printf.printf "Body of length: %d\n" (String.length body);
  Yojson.Basic.Util.member "time" body  |> Yojson.to_string


(* let time = *)
(*   ODate.Unix.From.seconds  *)

let () =
  let bitcoin_price = Lwt_main.run request in
  print_endline ("Received response\n" ^ bitcoin_price)
