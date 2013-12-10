#
# = matrix_DSL.rb
#  
#    Autores::   Teno González Dos Santos,  Albano José Yanes Reyes
#    Fecha:: 27/11/2013 
#    Asignatura:: Lenguajes y Paradigmas de Programación
#    Curso:: Tercero de Grado en Ingeniería Informática
#    Universidad de la Laguna
#
#  == Practica 12:  Lenguaje de Dominio Específico
#          <b>Diseñar y desarrollar un <em>DSL</em> interno para trabajar con matrices.</b>
#          <b>Utilizar Gemnasium para comprobar las dependencias de la aplicación desarrollada.</b>
#
#  === Modulo Operationes
#           Para el manejo de las operaciones de las matrices
#  === Modulo Output 
#           Para el manejo de las salidas
#  === Clase matriz_DSL
#        Definicion de la clase Matriz_DSL compuesta por:
#

require "./lib/matrix_expansion/matrix.rb"
require "./lib/matrix_expansion/matrix_dispersa.rb"
require "./lib/matrix_expansion/matrix_densa.rb"
require "./lib/matrix_expansion/matrix.rb"

module MatrixExpansion
    class MatrizDSL < Matriz
        attr_accessor :result
        
        def initialize(op_type, &block)
            raise ArgumentError , 'Tipo invalido' unless op_type.is_a? String
            
            @operands = []
            @result_mode = :auto
            @result = nil
            @mode = :console
            @operation = :mostrar
            
            
            case op_type
                when "suma"
                    @operation = :suma
                when "resta"
                    @operation = :resta
                when "producto"
                    @operation = :producto
                when "mostrar"
                    @operation = :mostrar
                else
                    puts "Opcion incorrecta", op_type
            end
            
            if block_given?  
                if block.arity == 1
                    yield self
                else
                    instance_eval &block 
                end
            end
            
            ejecucion
        end
        
        
        protected
        def operand (matriz)
            raise ArgumentError , 'Tipo invalido' unless matriz.is_a? Array
          
            @operands << Matriz_Densa.read(matriz)
        end
        
        def option(opcion)
            raise ArgumentError , 'Tipo invalido' unless opcion.is_a? String
            opc = opcion.downcase
          
            case opc
                when "densa"
                    @result_mode = :densa
                when "dispersa"
                    @result_mode = :dispersa
                when "auto"
                    @result_mode = :auto
                when "console"
                    @mode = :console
                when "file"
                    @mode = :file
                when "none"
                    @mode = :none
                else
                puts "Opcion incorrecta", opc
            end
        end
        
        def ejecucion
            case @operation
                when :mostrar
                    raise RuntimeError , 'Numero de operandos invalidos' unless @operands.size() == 1
                    
                    @result = @operands[0] # Densa
                    if(@result_mode == :dispersa)
                        @result = Matriz_Dispersa.densa_a_dispersa(@operands[0])
                    elsif(@result_mode == :auto)
                        if(@result.null_percent > 0.6) # Pasar a dispersa si tiene más de un 60% de elementos nulos
                            @result = Matriz_Dispersa.densa_a_dispersa(@operands[0])
                        end
                    end
                
                    if(@mode == :console)
                        puts @result.to_s
                    elsif(@mode == :file)
                        File.open('output.me', 'w') { |file| file.write(@result.to_s) }
                    end
                else
                    puts "Opcion incorrecta", @operation
            end
        end
    end
end



ejemplo = MatrixExpansion::MatrizDSL.new("mostrar") do 
    option "densa" 
    option "console"
    
    operand [[1,2,3],[4,5,6],[7,8,9]]  
end
    