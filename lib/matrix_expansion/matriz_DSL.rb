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

#modulo que agrupa la resolucion de la practica 12
module prct12
	module Operaciones
    	SUMA =            :suma
  		RESTA =           :resta
  		MULTIPLICACION =  :multiplicacion
  		DIVISION =        :division
	end

	module Output
  		CONSOLE = :console
  	end

  	class Matriz_DSL
  		

  	end
end



