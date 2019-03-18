From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Mar 2019 18:51:58 +0100
Subject: [LTP] [PATCH v3] syscall: Add userfaultfd testcase
In-Reply-To: <100593127.9468868.1552688247623.JavaMail.zimbra@redhat.com>
References: <20190315094558.17139-1-camann@suse.com>
 <100593127.9468868.1552688247623.JavaMail.zimbra@redhat.com>
Message-ID: <20190318175158.GA3892@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Christian, Jan,

> ----- Original Message -----
> > This tests the userfaultfd syscall to handle pagefault events.
> > It does so by registering a userfaultfd object to the address of
> > a memory page. In a second thread it handles the event and writes
> > data in the monitored memory page to indicate success.

> > Signed-off-by: Christian Amann <camann@suse.com>

> Acked-by: Jan Stancek <jstancek@redhat.com>

> Couple small nits below (no need to repost).

> syscall -> syscalls in subject

> > +
> > +static int userfaultfd(int flags)

> If glibc ever provides func, my money would be on this :-).
> But looking at HEAD, we're safe now.
Yes, I'd be for changing the name, see 651895c9f ("getcpu01: Rename getcpu to
avoid conflict with glibc >= 2.29" :)

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Nice work! Would it be possible to fix warnings?

userfaultfd01.c: In function ‘handle_thread’:
userfaultfd01.c:50:9: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  uffd = (int) arg;
         ^
userfaultfd01.c:80:1: warning: no return statement in function returning non-void [-Wreturn-type]
 }
 ^
In file included from userfaultfd01.c:19:
userfaultfd01.c: In function ‘run’:
userfaultfd01.c:108:19: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    handle_thread, (void *) uffd);
                   ^
../../../../include/tst_safe_pthread.h:39:70: note: in definition of macro ‘SAFE_PTHREAD_CREATE’
  safe_pthread_create(__FILE__, __LINE__, thread_id, attr, thread_fn, arg)
                                                                      ^~~

Kind regards,
Petr
