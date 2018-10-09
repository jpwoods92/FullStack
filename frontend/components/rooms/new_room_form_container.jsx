import { connect } from 'react-redux'
import { createMembership } from '../../actions/room_mebership_actions'
import { closeModal } from '../../actions/modal_actions'
import NewRoomForm from './new_room_form'

const mapStateToProps = state => ({
  currentUserId: state.session.currentUserId
})

const mapDispatchToProps = dispatch => ({
  createMembership: (userIds) => dispatch(createMembership(userIds)),
  closeModal: () => dispatch(closeModal())
})

export default connect(mapStateToProps, mapDispatchToProps)(NewRoomForm)
