/**
 * @jest-environment jsdom
 */

import React from 'react'
import { render, screen } from '@testing-library/react'
import PostsList from '../components/posts-list'

describe('Post list', () => {
    it('renders the list', () => {
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

        render(<PostsList posts={postList} />)

        const postItem = screen.getByText('aaa')

        expect(postItem).toBeInTheDocument()
    })
})