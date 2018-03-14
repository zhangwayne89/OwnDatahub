scaled_rating-->基础评级
rule_rating-->智能评级（如果未命中智能评价规则，==基础评级；如果命中规则，==生成的智能评级）

命中规则由rule_rating_record_sid判断是否命中智能评价规则
final_rating-->如果rating_type为0，final_rating==rule_rating；如果为2，final_rating为人工认定评级
