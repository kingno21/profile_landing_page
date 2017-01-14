root = this

root.profile = {}

root.profile.body = React.createClass
  displayName: 'Profle body',

  getInitialState: ->
    root.profile.contain = @
    return { skills: [] }

  componentWillMount: ->
    self = @
    $.ajax({
      url: '/'
      method: 'get'
      dataType: 'json'
      success: (data, e) ->
        self.setState({ skills: data.skills })
    })

  render: ->
    skills = _.map @state.skills, (e, index) ->
      React.createElement(likedButton, { skill: e, key: index })

    return React.DOM.div(
      { className: 'profile container' },
      skills
    )


likedButton = React.createClass
  displayName: 'likedButton',

  getInitialState: ->
    return { skills: [], liked_count: 0 }

  onClick: (e) ->
    @setState({ liked_count: @state.liked_count + 1 })

  render: ->
    return React.DOM.div(
      { className: 'skills' },
      React.DOM.button({ className: 'liked_count', onClick: @onClick }, @state.liked_count),
      React.DOM.label(null, @props.skill.skill_name)
    )


$ ->
  ReactDOM.render(React.createElement(profile.body), document.getElementById('skill_container'));