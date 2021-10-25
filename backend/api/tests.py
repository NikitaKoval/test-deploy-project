from django.urls import reverse
from rest_framework.test import APITestCase

from .models import Post


class PostApiTest(APITestCase):
    def test_post_create(self):
        expected_post_text = 'test text'
        url = reverse('posts-list')
        self.client.post(url, {'text': expected_post_text})

        last_post = Post.objects.last()

        self.assertEqual(last_post.text, expected_post_text)

    def test_post_update(self):
        post = Post.objects.create(text='test_text')

        url = reverse('posts-detail', args=(post.id,))
        self.client.put(url, {'text': 'updated_text'})

        post.refresh_from_db()
        self.assertEqual(post.text, 'updated_text')
