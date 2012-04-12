$keyboard=Array.[]("0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
	  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
	  "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
	  "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
 	  "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
	  ".", ",", "?", "!", "'", "\"", " ")
def mark_I_encoder(first_wheel_index,message_to_encode)
	mark_I_keyboard=$keyboard.clone
	mark_I_keyboard.rotate!(first_wheel_index)
    markI_encoded_message = message_to_encode.split(//).map{|z| mark_I_keyboard[$keyboard.index(z)]}.join
    return markI_encoded_message
end

#print mark_I_encoder(6,"Strong NE Winds!")

def mark_II_encoder(first_wheel_index,second_wheel_index,message_to_encode)
    mark_I_message=mark_I_encoder(first_wheel_index,message_to_encode).to_s
    mark_II_keyboard=$keyboard.clone
    mark_II_keyboard.rotate!(-2* second_wheel_index)
    mark_II_encoded_message = mark_I_message.split(//).map{|z| mark_II_keyboard[$keyboard.index(z)]}.join
    return mark_II_encoded_message
end

#print mark_II_encoder(9,3,"The Desert Fox will move 30 tanks to Calais at dawn")

def mark_IV_encoder(first_wheel_index,second_wheel_index,message_to_encode)
    input_array = message_to_encode.split(//)
    wheel_three_index= message_to_encode.split(//).map{|z|[$keyboard.index(z)]}.flatten!
    wheel_three_index.insert(0,0)
    output_array=[]
    for i in 0...input_array.length
        output_char = mark_II_encoder(first_wheel_index,second_wheel_index,input_array[i])
        output_array.push mark_I_encoder(2 * Integer(wheel_three_index[i]),output_char)
    end
    mark_IV_encoded_message = output_array.join
    return mark_IV_encoded_message
end

#print mark_IV_encoder(4,7,"The white cliffs of Alghero are visible at night")

def mark_IV_decoder(first_wheel_index,second_wheel_index,encoded_message)
    input_array = encoded_message.split(//)
    wheel_three_index=[0]
    output_array=[]
    for i in 0...input_array.length
        output_char = mark_I_encoder(-2 *Integer(wheel_three_index[i]),input_array[i]).to_s
        output_array.push mark_II_encoder(-first_wheel_index,-second_wheel_index,output_char).to_s
        wheel_three_index[i+1]=$keyboard.index(output_array[i])
    end
    mark_IV_decoded_message = output_array.join
    return mark_IV_decoded_message
end

#print mark_IV_decoder(7,2,"WZyDsL3u'0TfxP06RtSSF 'DbzhdyFIAu2 zF f5KE\"SOQTNA8A\"NCKPOKG5D9GSQE'M86IGFMKE6'K4pEVPK!bv83I")

def mark_IV_index_finder(encoded_message,hint)
    key_combinations =Array.new
    for i in 0...9
     for j in 0...9
      decoded_message=mark_IV_decoder(i,j,encoded_message)
      if (decoded_message.include? hint)
          index_combination =Array.new
          index_combination.push i,j
          key_combinations.push index_combination
          final_decoded_message = decoded_message
      end
     end
    end
    return [key_combinations,final_decoded_message]
end

#print mark_IV_index_finder("QT4e8MJYVhkls.27BL9,.MSqYSi'IUpAJKWg9Ul9p4o8oUoGy'ITd4d0AJVsLQp4kKJB2rz4dxfahwUa\"Wa.MS!k4hs2yY3k8ymnla.MOTxJ6wBM7sC0srXmyAAMl9t\"Wk4hs2yYTtH0vwUZp4a\"WhB2u,o6.!8Zt\"Wf,,eh5tk8WXv9UoM99w2Vr4!.xqA,5MSpWl9p4kJ2oUg'6evkEiQhC'd5d4k0qA'24nEqhtAQmy37il9p4o8vdoVr!xWSkEDn?,iZpw24kF\"fhGJZMI8nkI","BUNKER")



#curl -i -H "Accept: application/json" -X PUT -d '{"answer": "Yzxutm5TK5cotjy2"}' http://www.minisculuschallenge.com/14f7ca5f6ff1a5afb9032aa5e533ad95

#curl -i -H "Accept: application/json" -X PUT -d '{"answer": "Wkh2Ghvhuw2Ir.2zloo2pryh2632wdqnv2wr2Fdodlv2dw2gdzq"}' http://www.minisculuschallenge.com/2077f244def8a70e5ea758bd8352fcd8

#curl -i -H "Accept: application/json" -X PUT -d '{"answer": "JMl0kBp?20QixoivSc.2\"vvmls8KOk\"0jA,4kgt0OmUb,pm."}' http://www.minisculuschallenge.com/36d80eb0c50b49a509b49f2424e8c805

#curl -i -H "Accept: application/json" -X PUT -d '{"answer": "The rockets will strike at coordinates 49.977984 7.9257857 422979.83 5536735.81 on Oct. 7th"}' http://www.minisculuschallenge.com/4baecf8ca3f98dc13eeecbac263cd3ed

