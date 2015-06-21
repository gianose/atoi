#!/usr/bin/env ruby

require 'optparse' 

module AtoiMethods

	NILTO9 = {'48' => 0, '49' => 1, '50' => 2, '51' => 3, '52' => 4, '53' => 5, '54' => 6, '55' => 7, '56' => 8, '57' => 9} 
	BASE = 10.0

	# Utilized to convert and ASCII string representation of an integer to a integer.
	# @return [Fixnum] the integer representation of the ASCII string. 
	def atoi
		 _int = []; _sum = 0
		
		@ascii_string.each do |value| 
			_int.push(NILTO9[value])
		end
		
		e = _int.length 		
		puts e	
		_int.each do |value|
			_sum = _sum + ((value/BASE)/(1/(BASE**e))).floor
			e -= 1
		end	

	 	_sum
	end
	
	# Sudo constructor utilize to control to initialize the ascii_string instance method
	# @param args [String]
	def Atoi(args)
		parse(args)
			.verify
			.atoi
	end
	
	# User interface, providice instruction on how to utilize atoi.
  # @param args [String]
	def parse(args)
		help = nil
		
		option = OptionParser.new do |opts|
			opts.banner = "ASCII To Integer".center(60, '-')
			opts.separator ""
			opts.separator "Usage:"
			opts.separator "	Can be used to convert a ASCII string representation of a interger"
			opts.separator "  to an integer."
			opts.separator "Example"
			opts.separator "  ./atoi.rb -s [ASCII_STRING]"
			opts.separator "		e.g. ./atoi.rb -s '49 48'"
			opts.separator " "
			opts.on("-s ASCII_STRING", "--ascii_string ASCII_STRING", String, "The ASCII representation of a integer; e.g \'49 48\'", :REQUIRED){ |s| @ascii_string = s.split(' ') }
			opts.on("-h", "--help", "help"){puts option}
			help = opts.help
		end.parse!

		if @ascii_string.nil?; puts help; exit 1; end
		self
	end
  
	# Verifies that the provided ASCII values represent a number character with in the range 0-9	
	def verify
		@ascii_string.each do |value|
			raise ArgumentError, "#{value} is not an ASCII representation of number character with in the range 0-9" unless NILTO9.key?(value)   
		end
		self
	end
end

class Atoi; extend AtoiMethods; end

puts Atoi.Atoi(ARGV)
