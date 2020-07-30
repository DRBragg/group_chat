import { Controller } from 'stimulus'
import consumer from 'channels/consumer'

export default class extends Controller {
  static targets = ['users']

  connect() {
    this.subscription = consumer.subscriptions.create(
      { channel: 'OnlineChannel' },
      {
        connected: this._connected.bind(this),
        disconnected: this._disconnected.bind(this),
        received: this._received.bind(this),
      }
    )
  }

  disconnect() {
    consumer.subscriptions.remove(this.subscription)
  }

  _connected() {}

  _disconnected() {}

  _received(data) {
    this.usersTargets.forEach((user) => {
      if (user.dataset.userId == data.id) {
        data.status === 'online' ? this.setUserOnline(user) : this.setUserOffline(user)
      }
    })
  }

  setUserOnline(userEl) {
    userEl.children[0].classList.remove('far', 'text-muted')
    userEl.children[0].classList.add('fas', 'text-success')
  }

  setUserOffline(userEl) {
    userEl.children[0].classList.remove('fas', 'text-success')
    userEl.children[0].classList.add('far', 'text-muted')
  }
}
