
(0..50).each do |n|
	prefix = 'test'
	name = prefix + n.to_s
	email = name + "@test.com"
	ps = prefix * 2
	User.create(name: name, password: ps, email: email)
end

[
	['Java', 'java'],
	['Javascript', 'JS'],
	['C', 'C'],
	['C++', 'C++'],
	['C#', 'C#'],
	['Python', 'PY'],
	['Ruby', 'RB'],
	['Scala', 'Scala'],
].each do |e|
	TemplateSkill.create(skill_name: e[0], short_form: e[1])
end