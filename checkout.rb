require 'yaml'


class CheckOut
  attr_reader :total,:items

  def initialize(rules)
    @rules = rules
    @total = 0
    @items = Hash.new()
  end
  
  def scan(item)
    compute_total_items(item)
		puts total
		return total	
	end

  def compute_total_items(item)
    if(items.has_key?item)
      items[item] = items[item] + 1
    elsif
      items[item] = 1
    end
    compute_total(@rules,items)
      
  end
  
  def compute_total(rules, items)
    @total = 0
    items.each do |item, count|
	item_rule = rules.select{|x| x['item'] == item}
	item_rule = Hash[*item_rule.flatten]
#	puts item_rule['set_size']
      	if item_rule.has_key?('user') || item_rule.has_key?('price_per_set')
		@total += count / item_rule['set_size'] * item_rule['price_per_set']
		@total += count % item_rule['set_size'] * item_rule['unit_price']
      	else
		@total += count * item_rule['unit_price']
      	end
    end
#    puts total.to_s 
  end
end


#items = "A"
#counter = 1
#rule_file = YAML.load_file('rule.yaml')
#c = CheckOut.new(rule_file)
#items.split(//).each { |item| c.scan(item) }

