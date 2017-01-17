root = this

root.profile = {}

@show_hide = () ->
  if root.profile.contain.state.visibility == 'show'
    root.profile.contain.setState({ visibility: 'hide' })
  else
    root.profile.contain.setState({ visibility: 'show' })

@init = () ->
  skills = JSON.parse($('#own_skills').val())
  root.userID = parseInt($('#user').val())
  root.profileID = parseInt($('#profiles').val())
  ReactDOM.render(React.createElement(profile.body, {data: skills, userID: root.userID}), document.getElementById('skill_container'));

  tmp_skills = JSON.parse($('#tmp_skills').val())
  ReactDOM.render(React.createElement(profile.skill_tree, {data: tmp_skills}), document.getElementById('tmp_skill_container'));

root.profile.skill_tree = React.createClass
  displayName: 'Skill Tree',

  getInitialState: ->
    root.profile.tmp_skill = @
    if @props.data
      return { skills: @props.data }
    else
      return { skills: [] }

  onClick: (e) ->
    $('#skill_submit_form').toggle()

  render: ->
    skills = _.map @state.skills, (e, index) ->
      React.createElement(tmpSkill, { skill: e, key: index })

    return React.DOM.div(
      { className: 'skill_container' },
      React.DOM.h3(null, 'Skills'),
      React.DOM.ul(null, skills, React.DOM.li(null, React.DOM.button({ onClick: @onClick }, '+'))),
      React.createElement(skillForm)
    )

skillForm = React.createClass
  displayName: 'skills submit form',

  getInitialState: ->
    return { skill_name: '', short_form: '' }

  onClick: (e)->
    self = @
    $.ajax({
      url: '/template_skill'
      type: 'post'
      dataType: 'json'
      data: {
        template_skill: {
          skill_name: @state.skill_name.replace(/\b\w/g, (l) -> l.toUpperCase())
          short_form: @state.short_form
        }
      }
      success: (data, e) ->
        if data
          root.profile.tmp_skill.setState((preStep, props) ->
            return {skills: preStep.skills.concat(data)}
          )

        self.setState({ skill_name: '', short_form: ''})
        self.hide()
    })

  hide: ->
    $('#skill_submit_form').hide()


  componentDidMount: ->
    self = @
    input = document.getElementById('input_skill')
    new Awesomplete input, {
      list: [
        'Java', 'C', 'C++', 'Ruby', 'Ruby on Rails', 'Html', 'Javascript',
        'Artificial Intelligence', 'Machine Learning', 'Node.js', 'CSS', 'Scala',
        'Python', 'Deep Learning', 'C#', 'Slim', 'SASS', 'SCSS', 'Perl', 'Program Manager',
        'Quality Enginneer'
      ]
    }

    window.addEventListener("awesomplete-selectcomplete", (e) ->
      self.setState({ skill_name: e.target.value })
    , false);

  set_skill_name: (e)->
    @setState({ skill_name: e.target.value })

  set_short_form: (e) ->
    @setState({ short_form: e.target.value })

  render: ->
    return React.DOM.div(
        { id: 'skill_submit_form', hidden: true },
        React.DOM.div(
          null,
          React.DOM.label(null, 'Skill Name'),
          React.DOM.input({ className: 'skill_name', id: 'input_skill', onChange: @set_skill_name, placeholder: 'Skill Name', value: @state.skill_name }),
        ),
        React.DOM.div(
          null,
          React.DOM.label(null, 'Short Form'),
          React.DOM.input({ className: 'short_form', onChange: @set_short_form, placeholder: 'Short Form', value: @state.short_form}),

        ),
        React.DOM.button({ onClick: @onClick }, 'Submit')
    )




tmpSkill = React.createClass
  displayName: 'Template Skills',

  onClick: (e) ->
    self = @
    $.ajax({
      type: 'post'
      url: "/profiles/#{root.profileID}/update_profile/#{self.props.skill.id}"
      data: {
        added_user_id: root.userID
      }
    })

  render: ->
    return React.DOM.li(
      { className: 'skill' },
      React.DOM.button({ className: 'skill_link', onClick: @onClick}, @props.skill.short_form)
    )

root.profile.body = React.createClass
  displayName: 'Profle body',

  getInitialState: ->
    root.profile.contain = @
    if @props.data
      data = @props.data.sort((a,b) ->
        return  b.like_count - a.like_count
      )
      return { skills: data, visibility: 'show' }
    else
      return { skills: [], visibility: 'show' }

  render: ->
    self = @
    skills = _.map @state.skills, (e, index) ->
      if self.state.visibility == 'hide'
        if e.added_user_id == root.userID
          React.createElement(likedButton, { skill: e, key: index, order: index })
      else
         React.createElement(likedButton, { skill: e, key: index, order: index })

    return React.DOM.div(
      { className: 'profiles container' },
      skills
    )


likedButton = React.createClass
  displayName: 'likeButton',

  onClick: (e) ->
    self = @
    if !_.isEqual(@props.skill.user_id, root.userID)
      $.ajax({
        url: "/profiles/#{root.profileID}/update_like",
        method: 'post',
        dataType: 'json',
        data: {
          user_id: root.userID,
          skill_id: self.props.skill.id
        }
        success: (data, e) ->
          if !_.isEqual(data, self.props.skill)
            root.profile.contain.setState((preStep, props) ->
              arr = preStep.skills
              arr[arr.indexOf(self.props.skill)] = data
              tmp_data = arr.sort((a,b) ->
                return  b.like_count - a.like_count
              )
              return { skills: tmp_data }
            )
      })

  render: ->
    if @props.order < 6
      liked_user = _.map @props.skill.liked_user.slice(0, 10), (e, index) ->
        React.DOM.label({ key: index, className: 'liked_user_label' }, e.user_name)

      return React.DOM.div(
        { className: 'skills' },
        React.DOM.button({ className: 'like_count', onClick: @onClick, value: @props.skill.like_count }, @props.skill.like_count),
        React.DOM.a({ href: "/skills/#{@props.skill.id}"}, @props.skill.skill_name),
        liked_user
      )

    else
      return React.DOM.div(
        { className: 'skills' },
        React.DOM.button({ className: 'like_count', onClick: @onClick, value: @props.skill.like_count }, @props.skill.like_count),
        React.DOM.a({ href: "/skills/#{@props.skill.id}"}, @props.skill.skill_name),
      )


