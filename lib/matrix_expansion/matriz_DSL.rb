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
                    puts "Opción incorrecta", op_type
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
          @modo_resultado = :densa
        when "dispersa"
          @modo_resultado = :dispersa
        when "auto"
          @modo_resultado = :auto
        when "console"
          @modo = :console
        when "file"
          @modo = :file
        when "none"
          @modo = :none
        else
          puts "Opción incorrecta", opc
      end
    end
    
    end
end
    