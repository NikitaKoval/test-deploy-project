import React from 'react'
import renderer from 'react-test-renderer'
import PostsList from '../components/posts-list'

it('renders post list unchanged', () => {
    const postList = [
        {
            "id": 3,
            "text": "zzz",
            "timestamp": "2021-10-18T07:46:17.476166Z"
        },
        {
            "id": 2,
            "text": "bbb",
            "timestamp": "2021-10-18T07:45:35.627924Z"
        },
        {
            "id": 1,
            "text": "aaa",
            "timestamp": "2021-10-18T07:30:13.217922Z"
        }
    ]
    const tree = renderer.create(<PostsList posts={postList} />).toJSON()
    expect(tree).toMatchSnapshot()
})