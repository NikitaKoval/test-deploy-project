// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
import getConfig from 'next/config'

const { publicRuntimeConfig } = getConfig()

const baseUrl = !!publicRuntimeConfig.baseUrl ? publicRuntimeConfig.baseUrl : ''

export async function getPosts() {
  const response = await fetch(baseUrl+'/api/v1/posts/')
  return await response.json();
}

export async function sendPost(post) {
  const response = await fetch(baseUrl+'/api/v1/posts/', {
    method: "POST",
    body: JSON.stringify({
      text: post
    }),
    headers: {
      'Content-Type': 'application/json'
    }
  });

  return await response.json();
}