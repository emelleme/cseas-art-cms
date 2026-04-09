/**
 * Simple password authentication middleware for emdash admin
 * Password: admin
 */

import type { MiddlewareHandler } from 'astro';

const ADMIN_PASSWORD = 'admin';
const SESSION_COOKIE = 'emdash_admin_session';
const SESSION_DURATION = 60 * 60 * 24; // 24 hours in seconds

export const authMiddleware: MiddlewareHandler = async ({ request, cookies, url }, next) => {
  // Only protect admin routes
  if (!url.pathname.startsWith('/admin')) {
    return next();
  }

  // Check for existing session
  const sessionCookie = cookies.get(SESSION_COOKIE);
  if (sessionCookie?.value === ADMIN_PASSWORD) {
    return next();
  }

  // Handle login form submission
  if (request.method === 'POST' && url.pathname === '/admin/login') {
    const formData = await request.formData();
    const password = formData.get('password');
    
    if (password === ADMIN_PASSWORD) {
      cookies.set(SESSION_COOKIE, ADMIN_PASSWORD, {
        httpOnly: true,
        secure: true,
        sameSite: 'lax',
        maxAge: SESSION_DURATION,
        path: '/admin'
      });
      
      return new Response(null, {
        status: 302,
        headers: {
          'Location': '/admin'
        }
      });
    }
  }

  // Redirect to login if not authenticated
  if (url.pathname !== '/admin/login') {
    return new Response(null, {
      status: 302,
      headers: {
        'Location': '/admin/login'
      }
    });
  }

  return next();
};