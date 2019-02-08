From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 8 Feb 2019 03:13:00 -0500 (EST)
Subject: [LTP] [PATCH] mprotect04: Support execute-only page access
 permissions
In-Reply-To: <CAE2F3rBSkosrHixJLVab2mMYmTf+OuG3HbCz_fb0drA3fvMRNQ@mail.gmail.com>
References: <20190207014055.166152-1-danielmentz@google.com>
 <444884877.101394412.1549523065054.JavaMail.zimbra@redhat.com>
 <CAE2F3rBSkosrHixJLVab2mMYmTf+OuG3HbCz_fb0drA3fvMRNQ@mail.gmail.com>
Message-ID: <1261056777.102052911.1549613580845.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Daniel Mentz" <danielmentz@google.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it, liwang@redhat.com, "peter maydell" <peter.maydell@linaro.org>, chrubis@suse.cz, "gux fnst"
> <gux.fnst@cn.fujitsu.com>
> Sent: Friday, 8 February, 2019 1:12:41 AM
> Subject: Re: [PATCH] mprotect04: Support execute-only page access permissions
> 
> On Wed, Feb 6, 2019 at 11:04 PM Jan Stancek <jstancek@redhat.com> wrote:
> > > +     /* Mark page readable on platforms that support execute-only page
> > > access
> > > +      * permissions. */
> > > +     if (exec_only_platform)
> > > +             mprotect(page_to_copy, page_sz, PROT_READ | PROT_EXEC);
> >
> > Is there a chance 2nd page will be something else than code?
> > E.g. some section that was previously also writeable.
> 
> Ok. I can see that concern. We could read /proc/$$/maps to determine
> if the 2nd page is writable, but that'd be a lot of work to implement.
> What about making the 2nd page writable (PROT_WRITE) just in case? Is
> that a solution you would support? Can you think of another solution?
> 

I'm thinking using another "(!page_present(page_to_copy))" check
for 2nd page as well.

Or making sure we never cross page boundary, then we
could drop 2nd page entirely:

---

diff --git a/testcases/kernel/syscalls/mprotect/Makefile b/testcases/kernel/syscalls/mprotect/Makefile
index bd617d806675..bc5c8bc10395 100644
--- a/testcases/kernel/syscalls/mprotect/Makefile
+++ b/testcases/kernel/syscalls/mprotect/Makefile
@@ -20,4 +20,6 @@ top_srcdir            ?= ../../../..

 include $(top_srcdir)/include/mk/testcases.mk

+mprotect04: CFLAGS += -falign-functions=64
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c b/testcases/kernel/syscalls/mprotect/mprotect04.c
index 60941a4220d5..6894b31fc528 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect04.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
@@ -133,7 +133,7 @@ static void testfunc_protnone(void)

 #ifdef __ia64__

-static char exec_func[] = {
+static char exec_func[] __attribute__ ((aligned (64))) = {
        0x11, 0x00, 0x00, 0x00, 0x01, 0x00, /* nop.m 0x0             */
        0x00, 0x00, 0x00, 0x02, 0x00, 0x80, /* nop.i 0x0             */
        0x08, 0x00, 0x84, 0x00,             /* br.ret.sptk.many b0;; */
@@ -237,14 +237,6 @@ static void *get_func(void *mem)
        }
        memcpy(mem, page_to_copy, page_sz);

-       /* copy 2nd page if possible */
-       mem += page_sz;
-       page_to_copy += page_sz;
-       if (page_present(page_to_copy))
-               memcpy(mem, page_to_copy, page_sz);
-       else
-               memset(mem, 0, page_sz);
-
        clear_cache(mem_start, copy_sz);

        /* return pointer to area where copy of exec_func resides */

