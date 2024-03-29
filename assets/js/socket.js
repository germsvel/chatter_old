// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket,
// and connect at the socket path in "lib/web/endpoint.ex".
//
// Pass the token on params as below. Or remove it
// from the params if you are not using authentication.
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {username: window.username}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/3" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket, _connect_info) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, connect to the socket:
socket.connect()

// Now that you are connected, you can join channels with a topic:
let roomName = window.roomName
let channel = socket.channel(`room:${roomName}`, {})

let messages = document.querySelector(".messages")
let chatInput = document.querySelector("#new-message")
let chatSubmit = document.querySelector("#send-new-message")

let addMessage = (author, message) => {
  let messageItem = document.createElement("li")
  messageItem.innerText = `${author}: ${message}`
  messages.appendChild(messageItem)
}

chatSubmit.addEventListener("click", event => {
  let message = chatInput.value
  channel.push("new_message", {body: message})
  chatInput.value = ""
})

channel.on("new_message", payload => {
  addMessage(payload.author, payload.body)
})

channel.join()
  .receive("ok", resp => {
    let history = resp.history

    for (let i in history) {
      let [author, message] = history[i]
      addMessage(author, message)
    }
  })
  .receive("error", resp => {})

export default socket
