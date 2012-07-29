class Songbook


  attr_accessor :input
  attr_accessor :output

  # \section{Ace Of Spades / Motorhead}\label{sec:ace_of_spades}

  def header
    process = @input.slice!(0..2)

    title = process[0].delete!( "**" ).strip
    artist = process[1].delete!( "**" ).strip
    notes = process[2].delete!( "**" ).strip

    output << "\\section{#{title} / #{artist}}\\label{sec:#{title.downcase.gsub(/[^a-z0-9]+/i, '_')}}\n"
    unless notes.empty?
      output << "{\\small #{notes}}\n"
    end
  end

  def chords
    space

    process = @input.take_while{ | arr | arr != "chords **" }
    process.delete_at(0)
    process.each do | chord |
      output << "\\#{chord}\n"
      @input.delete( chord )
    end
      @input.slice!(0..1)
  end

  def lyrics
    space

    @input.each do | lyric |
      unless lyric.nil? || lyric.strip == "**"
        output << lyric.gsub(/[\[]/, '\upchord{').gsub(/[\]]/, '}').gsub(/---/, '\hrulefill') + "\n\n"
      end
    end

  end

  def space
    output << "\n"
  end

  def initialize( filepath )

    @input = []
    @output = ""

    file = File.open(filepath, "r")
    file.each {|line| 
      unless line.strip.empty?
        @input.push( line.strip )
      end
    }

    @input.collect! { | line | line unless line[0..1] == "//"}


    # open file

    # get first three lines beginning with **

    # send to Header

    # get next lines between ** and **

    # send to Chords

    # get next lines between ** and **

    # send to Verse

  end



end

s = Songbook.new( "./example.txt" )
s.header
s.chords
s.lyrics
# puts s.input
puts s.output
