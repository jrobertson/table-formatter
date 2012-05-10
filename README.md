#Introducing the Table-formatter gem

<pre>sudo gem1.9.1 install table-formatter</pre>

    require 'table-formatter'
    labels = %w(Name Age Address Code)
    a = [['Bob', '20', '10, High Street','A342'],
         ['Jane', '23', '12/3, Lawn Market Court', 'B34F'],
         ['Bruce', '32', '63, Cotswalds Way', 'F34AD'],
         ['Michael', '49', '1, Hollwood Way', 'E234D'],
         ['Stephanie', '34', '2, Hampton Court','A234']]

    tfo = TableFormatter.new
    tfo.source = a
    tfo.labels = labels
    puts tfo.display


## output
<pre>
--------------------------------------------------------
| Name       | Age | Address                  | Code   |
--------------------------------------------------------
| Bob        | 20  | 10, High Street          | A342   |
| Jane       | 23  | 12/3, Lawn Market Court  | B34F   |
| Bruce      | 32  | 63, Cotswalds Way        | F34AD  |
| Michael    | 49  | 1, Hollwood Way          | E234D  |
| Stephanie  | 34  | 2, Hampton Court         | A234   |
--------------------------------------------------------
</pre>
