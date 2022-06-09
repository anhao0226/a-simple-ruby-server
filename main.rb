# 函数生命 
def h(name = 'chris') 
    puts "Hello #{name}!";
end

h
h() 
h("Zhang")

class Greeter

    attr_accessor :name

    def initialize(name = "World")
        @name = name;
    end

    def say_hi
        puts "Hi #{@name}!"
    end

    def say_bye
        puts "Bye #{@name}, come back soon."
    end
end

g = Greeter.new("Pat")

g.say_hi

g.say_bye

# 输入对象的方法(不包括继承的方法)
puts Greeter.instance_methods(false)

# respond_to
puts g.respond_to?("say_hi")


# 修改名称
g.name = "Betty";
g.say_hi

# attr_accessor 生成两个函数( name(get), name=(set))
puts Greeter.instance_methods(false);



