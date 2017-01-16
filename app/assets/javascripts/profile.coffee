root = this

root.profile = {}

@init = () ->
  data = JSON.parse($('#skills').val())
  root.userID = parseInt($('#user').val())
  root.profileID = parseInt($('#profile').val())
  ReactDOM.render(React.createElement(profile.body, {data: data, userID: root.userID}), document.getElementById('skill_container'));

root.profile.body = React.createClass
  displayName: 'Profle body',

  getInitialState: ->
    root.profile.contain = @
    if @props.data
      return { skills: @props.data }
    else
      return { skills: [] }

  render: ->
    skills = _.map @state.skills, (e, index) ->
      React.createElement(likedButton, { skill: e, key: index })

    return React.DOM.div(
      { className: 'profile container' },
      skills
    )


likedButton = React.createClass
  displayName: 'likeButton',

  getInitialState: ->
    return { like_count: @props.skill.like_count }

  onClick: (e) ->
    self = @
    if !_.isEqual(@props.skill.user_id, root.userID)
      $.ajax({
        url: "/profile/#{root.profileID}/update_like",
        method: 'post',
        dataType: 'json',
        data: {
          user_id: root.userID,
          skill_id: self.props.skill.id
        }
        success: (data, e) ->
          if !_.isEqual(data, self.props.skill)
            self.setState({ like_count: data.like_count })
      })

  render: ->
    return React.DOM.div(
      { className: 'skills' },
      React.DOM.button({ className: 'like_count', onClick: @onClick, value: @state.like_count }, @state.like_count),
      React.DOM.label(null, @props.skill.skill_name)
    )


