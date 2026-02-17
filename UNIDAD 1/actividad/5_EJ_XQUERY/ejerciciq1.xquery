(:~ 1. Crear una consulta XQuery para recuperar todos los libros cuyo precio sea mayor a
cincuenta euros. Mostrar los resultados ordenados por precio. ~:)
for $libro in /bib/libro
where number(normalize-space($libro/precio)) > 50
order by number(normalize-space($libro/precio))
return
  <resultado>
    <titulo>{ $libro/titulo/text() }</titulo>
    <precio>{ normalize-space($libro/precio/text()) }</precio>
  </resultado>

(:~ 2. Crear una consulta XQuery para recuperar todos los libros que hayan sido escritos por
más de un autor. Mostrar los resultados ordenados por el año de publicación del libro. ~:)

for $libro in /bib/libro
where count($libro/autor) > 1
order by $libro/@ano
return
  <resultado>
    <titulo>{ $libro/titulo/text() }</titulo>
    <anio>{ $libro/@ano }</anio>
    <numAutores>{ count($libro/autor) }</numAutores>
  </resultado>

(:~ 3. Crear una consulta XQuery para mostrar todos los libros de la editorial Morgan
Kaufmann. ~:)
for $libro in /bib/libro
where contains(lower-case($libro/editorial), "morgan kaufmann")
return
  <resultado>
    <titulo>{ $libro/titulo/text() }</titulo>
    <editorial>{ $libro/editorial/text() }</editorial>
  </resultado>

(:~ 4. Crear una consulta XQuery para mostrar todos los libros y sus autores. En caso de que
un libro tenga más de un autor, se mostrará el primero de ellos y después “y otros”. ~:)
for $libro in /bib/libro
let $autores := $libro/autor
return
  <resultado>
    <titulo>{ $libro/titulo/text() }</titulo>
    <autor>
      {
        if (count($autores) > 1)
        then concat($autores[1]/nombre, " ", $autores[1]/apellido, " y otros")
        else concat($autores[1]/nombre, " ", $autores[1]/apellido)
      }
    </autor>
  </resultado>

(:~ 5. Crear una consulta XQuery para mostrar todos aquellos libros de programación, es
decir, que contengan la palabra “programming” en su título. ~:)
for $libro in /bib/libro
where contains(lower-case($libro/titulo), "programming")
return
  <resultado>
    <titulo>{ $libro/titulo/text() }</titulo>
    <autor>
      {
        if ($libro/autor)
        then concat($libro/autor[1]/nombre, " ", $libro/autor[1]/apellido)
        else "Sin autor"
      }
    </autor>
  </resultado>
