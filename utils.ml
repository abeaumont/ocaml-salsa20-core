let of_hex s =
  let l = String.length s in
  if l mod 2 <> 0 then
    invalid_arg "Odd-length string"
  else
    let int_of_hex = function
        | 'A' .. 'F' as x -> Char.code x - Char.code 'A' + 10
        | 'a' .. 'f' as x -> Char.code x - Char.code 'a' + 10
        | '0' .. '9' as x -> Char.code x - Char.code '0'
        | _ -> invalid_arg "Non-hexadecimal digit"
    and cs = Cstruct.create (l / 2) in
    let rec loop i =
      if i = l then
        cs
      else
        let msn = int_of_hex s.[i]
        and lsn = int_of_hex s.[i + 1] in
        (Cstruct.set_uint8 cs (i / 2) (msn lsl 4 + lsn);
         loop  (i + 2)) in
    loop 0
