
require "date"
# às hh/mm não funcionando

# @input_text = @input_text.sub(/(?<=amanh)ã/i, 'a')

def getDiasDatasRegex(text)
  data = []
  data2 = []
  # Tranforma ã em a
  text = text.sub(/(?<=amanh)ã/i, 'a')
  diaDataRegex = /((([0-2]?[0-9])|([3][0-1])) de ([a-zA-Z]{9}|[a-zA-Z]{8}|[a-zA-Z]{7}|[a-zA-Z]{6}|[a-zA-ZçÇ]{5}|[a-zA-Z]{4})( de [0-9]{4})?)|((([0-2][0-9])|([3][0-1]))\/(([0][1-9]|[1][0-2]))(\/([0-9]{4}))?)|(amanha|hoje|depois de amanha)/
  matchedText = text.match(diaDataRegex)
  data = String(matchedText).split(' ')
  data2 = String(matchedText).split('/')
  if(String(matchedText) == "hoje")
    data = String(Date.today).split('-', -1)
    matchedText = data[2] + "/" + data[1] + "/" + data[0]
  elsif(String(matchedText) == "amanha")
    data = String(Date.today+1).split('-', -1)
    matchedText = data[2] + "/" + data[1] + "/" + data[0]
  elsif(String(matchedText) == "depois de amanha")
    data = String(Date.today+2).split('-', -1)
    matchedText = data[2] + "/" + data[1] + "/" + data[0]
  elsif(data.length == 3)
    if(data[2].downcase == "janeiro")
      matchedText = data[0] + "/01/2022"
    elsif(data[2].downcase == "fevereiro")
      matchedText = data[0] + "/02/2022"
    elsif(data[2].downcase == "março")
      matchedText = data[0] + "/03/2022"
    elsif(data[2].downcase == "abril")
      matchedText = data[0] + "/04/2022"
    elsif(data[2].downcase == "maio")
      matchedText = data[0] + "/05/2022"
    elsif(data[2].downcase == "junho")
      matchedText = data[0] + "/06/2022"
    elsif(data[2].downcase == "julho")
      matchedText = data[0] + "/07/2022"
    elsif(data[2].downcase == "agosto")
      matchedText = data[0] + "/08/2022"
    elsif(data[2].downcase == "setembro")
      matchedText = data[0] + "/09/2022"
    elsif(data[2].downcase == "outubro")
      matchedText = data[0] + "/10/2022"
    elsif(data[2].downcase == "novembro")
      matchedText = data[0] + "/11/2022"
    elsif(data[2].downcase == "dezembro")
      matchedText = data[0] + "/12/2022"
    else
      matchedText = "Mês incorreto!"
    end
  elsif(data.length == 5)
    if(data[2].downcase == "janeiro")
      matchedText = data[0] + "/01/" + data[4]
    elsif(data[2].downcase == "fevereiro")
      matchedText = data[0] + "/02/" + data[4]
    elsif(data[2].downcase == "março")
      matchedText = data[0] + "/03/" + data[4]
    elsif(data[2].downcase == "abril")
      matchedText = data[0] + "/04/" + data[4]
    elsif(data[2].downcase == "maio")
      matchedText = data[0] + "/05/" + data[4]
    elsif(data[2].downcase == "junho")
      matchedText = data[0] + "/06/" + data[4]
    elsif(data[2].downcase == "julho")
      matchedText = data[0] + "/07/" + data[4]
    elsif(data[2].downcase == "agosto")
      matchedText = data[0] + "/08/" + data[4]
    elsif(data[2].downcase == "setembro")
      matchedText = data[0] + "/09/" + data[4]
    elsif(data[2].downcase == "outubro")
      matchedText = data[0] + "/10/" + data[4]
    elsif(data[2].downcase == "novembro")
      matchedText = data[0] + "/11/" + data[4]
    elsif(data[2].downcase == "dezembro")
      matchedText = data[0] + "/12/" + data[4]
    else
      matchedText = "Mês incorreto!"
    end 
  elsif(data2.length == 2)
    matchedText = String(matchedText) + "/2022"
  else 
    matchedText = String(matchedText)
  end
  return matchedText
end

def getHoursRegex(text)
  # tira espaço em branco entre ":"
  text = text.sub(/(?<=\s\d\d) \s (?=\d\d\s)/x, ":")
  # deixa no formato hh:mm 
  text = text.sub(/(?<=[\s\d]\d) \s (horas? \s )? e \s (?=\d\d)/x,":")
  # deixa x horas ou x hora para hh:mm
  text = text.sub(/(?<=[\s\d]\d) \s horas?/x,":00")
  text = text.sub(/[àá](?=s)/i, 'a')
  text = text.sub(/( (?<=as \s \d) (?=\s) ) | ( (?<=as \s \d\d) (?=\s) )/xi, ":00")
  dateRegex = /(((2[0-3])|([0-1]?)\d)(:| )(([0-5]\d)))|((24)(:| )(00))|(\d{1,2} horas?)|(às 24((:| )00)?)|(às ((([0-1]\d)|(2[0-3])|(\d))((:| )([0-5]\d))?))/
  matchedText = text.match(dateRegex)
  return matchedText
end


def getVerbRegex(text)
  verbRegex = /^([A-z])[A-záàâãéèêíïóôõöúçñ]+ com ([A-Z][A-záàâãéèêíïóôõöúçñ]+)(( e|,) ([A-Z][A-záàâãéèêíïóôõöúçñ]+))*/
  matchedText = text.match(verbRegex)
  return matchedText
end

def getNames(text)
  nameRegex = /[A-Z][A-záàâãéèêíïóôõöúçñ]+ | [A-Z][A-záàâãéèêíïóôõöúçñ]+ e [A-Z][A-záàâãéèêíïóôõöúçñ]+ /
  matchedText = text.split(/ /, 2)[1].match(nameRegex)
  return matchedText
end


def getTagRegex(text)
  tagRegex = /#[a-z]+/
  matchedText = text.match(tagRegex)
  return matchedText
end


def getOnlyValidTask(text)
  if(getVerbRegex(text) == nil || getTagRegex(text) == nil)
    return false
  else
    return true
  end
end

depoisDoNome = "com"

#text = "Agendar com José reunião às 10:00 30/10 #trabalho"

#Demonstrações dos regex funcionando
#puts "Dia: " + getDiasDatasRegex(text)
#puts getHoursRegex(text)
#puts getVerbRegex(text)
# puts getNameRegex(text)
#puts getTagRegex(text)
#puts getOnlyValidTask(text)
#input = ''

#### Looping para a digitação das tarefas
text = ""
while(text.downcase != "sair")
  puts("\nDigite sua tarefa: \n\n")
  text = gets.chomp()
  if(text != "sair")    
    puts "\nDia: " + getDiasDatasRegex(text)
    puts "Horário: " + String(getHoursRegex(text))
    puts "Tarefa: " + String(getVerbRegex(text))
    puts "Tag: " + String(getTagRegex(text))
    if /#{depoisDoNome}/.match(text)
      getNames(text)
      puts "Nome: " + String(getNames(text))
    end
    puts getOnlyValidTask(text)
  else
    puts "\nFIM"
  end
end

