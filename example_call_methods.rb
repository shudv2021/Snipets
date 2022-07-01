class Airplain

  def take_wing
  puts "One airplain flite"
  end
  
  def self.start
  puts "All airplains flite"
  end
end

airplain1=Airplain.new

Airplain.start

airplain1.take_wing

airplain1.method(:take_wing).call

airplain1.send(:take_wing)
