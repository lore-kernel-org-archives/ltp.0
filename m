From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Oct 2020 09:32:54 -0700
Subject: [LTP] mmstress[1309]: segfault at 7f3d71a36ee8 ip
 00007f3d77132bdf sp 00007f3d71a36ee8 error 4 in
 libc-2.27.so[7f3d77058000+1aa000]
In-Reply-To: <CAHk-=whFb3wk0ff8jb3BCyoNvNJ1TSZxoYRKaAoW=Y43iQFNkw@mail.gmail.com>
References: <CA+G9fYvHze+hKROmiB0uL90S8h9ppO9S9Xe7RWwv808QwOd_Yw@mail.gmail.com>
 <CAHk-=wg5-P79Hr4iaC_disKR2P+7cRVqBA9Dsria9jdVwHo0+A@mail.gmail.com>
 <CA+G9fYv=DUanNfL2yza=y9kM7Y9bFpVv22Wd4L9NP28i0y7OzA@mail.gmail.com>
 <CA+G9fYudry0cXOuSfRTqHKkFKW-sMrA6Z9BdQFmtXsnzqaOgPg@mail.gmail.com>
 <CAHk-=who8WmkWuuOJeGKa-7QCtZHqp3PsOSJY0hadyywucPMcQ@mail.gmail.com>
 <CAHk-=wi=sf4WtmZXgGh=nAp4iQKftCKbdQqn56gjifxWNpnkxw@mail.gmail.com>
 <CAEUSe78A4fhsyF6+jWKVjd4isaUeuFWLiWqnhic87BF6cecN3w@mail.gmail.com>
 <CAHk-=wgqAp5B46SWzgBt6UkheVGFPs2rrE6H4aqLExXE1TXRfQ@mail.gmail.com>
 <20201023050214.GG23681@linux.intel.com>
 <356811ab-cb08-7685-ca01-fe58b5654953@rasmusvillemoes.dk>
 <CAHk-=whFb3wk0ff8jb3BCyoNvNJ1TSZxoYRKaAoW=Y43iQFNkw@mail.gmail.com>
Message-ID: <CAHk-=whGbM1E0BbSVvxGRj5nBaNRXXD-oKcgrM40s4gvYV_C+w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Oct 23, 2020 at 8:54 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Oct 23, 2020 at 12:14 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> >
> > That's certainly garbage. Now, I don't know if it's a sufficient fix (or
> > could break something else), but the obvious first step of rearranging
> > so that the ptr argument is evaluated before the assignment to __val_pu
>
> Ack. We could do that.
>
> I'm more inclined to just bite the bullet and go back to the ugly
> conditional on the size that I had hoped to avoid, but if that turns
> out too ugly, mind signing off on your patch and I'll have that as a
> fallback?

Actually, looking at that code, and the fact that we've used the
"register asm()" format forever for the get_user() side, I think your
approach is the right one.

I'd rename the internal ptr variable to "__ptr_pu", and make sure the
assignments happen just before the asm call (with the __val_pu
assignment being the final thing).

lso, it needs to be

        void __user *__ptr_pu;

instead of

        __typeof__(ptr) __ptr = (ptr);

because "ptr" may actually be an array, and we need to have the usual
C "array to pointer" conversions happen, rather than try to make
__ptr_pu be an array too.

So the patch would become something like the appended instead, but I'd
still like your sign-off (and I'd put you as author of the fix).

Narest, can you confirm that this patch fixes the issue for you?

                  Linus
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch
Type: application/octet-stream
Size: 862 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201023/2e2931c9/attachment.obj>
