class Board

  def initialize(arr, str, fil, col)
     @arr = arr
     @str = str
     @fil = fil
     @col = col
     @mat = complete_board!
  end

  def to_s
    matriz = @str.each_slice(@fil).to_a
  end

  def complete_board!
    arr = @str.split("")
    matriz = []
    #cambia las x a letras aleatorias
    arr.each do |x|
      if x == "X"
        arr[arr.index(x)] = (65 + rand(25)).chr
      end
    end
    #hace la matriz
    while !arr.empty?
      matriz << arr.pop(@col)
    end
    matriz.reverse!
  end

  def imprime
    @mat.each do |x|
      x.each do |y|
        print y.center(10, " ") + "|"
      end
      puts " "
      puts "----".center(88, "-")
    end 
  end

  def revisaFilas(word, arr)
    letras = word.split("")
    m = 0
    resp = false
    while m < arr.length && resp == false
      if (letras - arr[m]).empty?
        resp = true
      end
      m += 1
    end
    resp
  end

  def revisaColumnas(word, arr)
    revisaFilas(word, arr.transpose)
  end

  def recorreColumnas(lado, arr)
    p = 0 
    r = arr.length - 1
    aux = []
    if lado == "left"
      while p < arr.length
        p.times do
          arr[p] << ""
        end
        r.times do
          arr[p].unshift("")
        end
        aux << arr[p]
        p += 1
        r -= 1
      end
    else
      while p < arr.length
        r.times do
          arr[p] << ""
        end
        p.times do
          arr[p].unshift("")
        end
        aux << arr[p]
        p += 1
        r -= 1
      end
    end
    aux
  end

  def revisaDiagonales(word, arr)
    revisaColumnas(word, recorreColumnas("der", arr)) || revisaColumnas(word, recorreColumnas("izq", arr))
  end

  def include?(word)
    if revisaDiagonales(word, @mat) == true || revisaColumnas(word, @mat) == true || revisaFilas(word, @mat) == true
      puts "#{word} is included"
    else
      puts "#{word} is not included"
    end
  end

end
