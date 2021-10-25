export default function PostsList(props) {
    return (
        <ul>
            {props.posts.map((post) => <li key={post.id}>{post.text}<span>&nbsp;<small>{new Date(post.timestamp).toLocaleString()}</small></span></li>)}
        </ul>
    )
}