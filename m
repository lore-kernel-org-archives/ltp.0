From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Feb 2019 02:40:29 -0500 (EST)
Subject: [LTP] [PATCH v2] syscalls/mprotect: align exec_func to 64 bytes
In-Reply-To: <CAE2F3rDGdpO6XTZ5zn234W=+0KNYQ_AC1u=SeRK54TR7sZ7X6g@mail.gmail.com>
References: <e1b5efb3d806fa26da13d46247b46ea5d78271c4.1549922861.git.jstancek@redhat.com>
 <CAE2F3rDGdpO6XTZ5zn234W=+0KNYQ_AC1u=SeRK54TR7sZ7X6g@mail.gmail.com>
Message-ID: <1860110503.289115.1549957229806.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Two comments below. Otherwise, I'm fine with this. I reviewed this
> patch and found it to be working on an aarch64 platform.
> 
> On Mon, Feb 11, 2019 at 2:15 PM Jan Stancek <jstancek@redhat.com> wrote:
> >
> > exec_func() is dummy/empty function. Try to align it so we don't
> > need to worry about copying 2 pages. But also check that compiler
> > aligned it and there's sufficient space between start of func_exec
> > and end of page.
> >
> > This patch also removes copy_sz, which is now replaced with page_sz.
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  testcases/kernel/syscalls/mprotect/Makefile     |  2 +
> >  testcases/kernel/syscalls/mprotect/mprotect04.c | 55
> >  +++++++++++--------------
> >  2 files changed, 27 insertions(+), 30 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/mprotect/Makefile
> > b/testcases/kernel/syscalls/mprotect/Makefile
> > index bd617d806675..bc5c8bc10395 100644
> > --- a/testcases/kernel/syscalls/mprotect/Makefile
> > +++ b/testcases/kernel/syscalls/mprotect/Makefile
> > @@ -20,4 +20,6 @@ top_srcdir            ?= ../../../..
> >
> >  include $(top_srcdir)/include/mk/testcases.mk
> >
> > +mprotect04: CFLAGS += -falign-functions=64
> > +
> >  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> > diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c
> > b/testcases/kernel/syscalls/mprotect/mprotect04.c
> > index 60941a4220d5..0f7890dca03b 100644
> > --- a/testcases/kernel/syscalls/mprotect/mprotect04.c
> > +++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
> > @@ -55,7 +55,7 @@ int TST_TOTAL = ARRAY_SIZE(testfunc);
> >
> >  static volatile int sig_caught;
> >  static sigjmp_buf env;
> > -static unsigned int copy_sz;
> > +static unsigned int page_sz;
> >  typedef void (*func_ptr_t)(void);
> >
> >  int main(int ac, char **av)
> > @@ -88,7 +88,7 @@ static void setup(void)
> >  {
> >         tst_tmpdir();
> >         tst_sig(NOFORK, sighandler, cleanup);
> > -       copy_sz = getpagesize() * 2;
> > +       page_sz = getpagesize();
> >
> >         TEST_PAUSE;
> >  }
> > @@ -96,12 +96,9 @@ static void setup(void)
> >  static void testfunc_protnone(void)
> >  {
> >         char *addr;
> > -       int page_sz;
> >
> >         sig_caught = 0;
> >
> > -       page_sz = getpagesize();
> > -
> >         addr = SAFE_MMAP(cleanup, 0, page_sz, PROT_READ | PROT_WRITE,
> >                                          MAP_PRIVATE | MAP_ANONYMOUS, -1,
> >                                          0);
> >
> > @@ -133,7 +130,7 @@ static void testfunc_protnone(void)
> >
> >  #ifdef __ia64__
> >
> > -static char exec_func[] = {
> > +static char exec_func[] __attribute__ ((aligned (64))) = {
> >         0x11, 0x00, 0x00, 0x00, 0x01, 0x00, /* nop.m 0x0             */
> >         0x00, 0x00, 0x00, 0x02, 0x00, 0x80, /* nop.i 0x0             */
> >         0x08, 0x00, 0x84, 0x00,             /* br.ret.sptk.many b0;; */
> > @@ -210,42 +207,33 @@ typedef struct {
> >   * Copy page where &exec_func resides. Also try to copy subsequent page
> >   * in case exec_func is close to page boundary.
> >   */
> > -static void *get_func(void *mem)
> > +static void *get_func(void *mem, uintptr_t *func_page_offset)
> >  {
> >         uintptr_t page_sz = getpagesize();
> >         uintptr_t page_mask = ~(page_sz - 1);
> > -       uintptr_t func_page_offset;
> >         void *func_copy_start, *page_to_copy;
> >         void *mem_start = mem;
> >
> >  #ifdef USE_FUNCTION_DESCRIPTORS
> >         func_descr_t *opd =  (func_descr_t *)&exec_func;
> > -       func_page_offset = (uintptr_t)opd->entry & (page_sz - 1);
> > -       func_copy_start = mem + func_page_offset;
> > +       *func_page_offset = (uintptr_t)opd->entry & (page_sz - 1);
> > +       func_copy_start = mem + *func_page_offset;
> >         page_to_copy = (void *)((uintptr_t)opd->entry & page_mask);
> >  #else
> > -       func_page_offset = (uintptr_t)&exec_func & (page_sz - 1);
> > -       func_copy_start = mem + func_page_offset;
> > +       *func_page_offset = (uintptr_t)&exec_func & (page_sz - 1);
> > +       func_copy_start = mem + *func_page_offset;
> >         page_to_copy = (void *)((uintptr_t)&exec_func & page_mask);
> >  #endif
> > +       tst_resm(TINFO, "exec_func: %p, page_to_copy: %p",
> > +               &exec_func, page_to_copy);
> 
> This was previously inside the body of the if statement right below.
> Not sure if it was intended to always print this information, but I'm
> fine either way.

This was intentional, if we get a failure it seemed like good data.

> 
> >
> >         /* copy 1st page, if it's not present something is wrong */
> > -       if (!page_present(page_to_copy)) {
> > -               tst_resm(TINFO, "exec_func: %p, page_to_copy: %p\n",
> > -                       &exec_func, page_to_copy);
> > +       if (!page_present(page_to_copy))
> >                 tst_brkm(TBROK, cleanup, "page_to_copy not present\n");
> > -       }
> > -       memcpy(mem, page_to_copy, page_sz);
> >
> > -       /* copy 2nd page if possible */
> > -       mem += page_sz;
> > -       page_to_copy += page_sz;
> > -       if (page_present(page_to_copy))
> > -               memcpy(mem, page_to_copy, page_sz);
> > -       else
> > -               memset(mem, 0, page_sz);
> > +       memcpy(mem, page_to_copy, page_sz);
> >
> > -       clear_cache(mem_start, copy_sz);
> > +       clear_cache(mem_start, page_sz);
> >
> >         /* return pointer to area where copy of exec_func resides */
> >         return func_copy_start;
> > @@ -256,23 +244,30 @@ static void *get_func(void *mem)
> >  static void testfunc_protexec(void)
> >  {
> >         func_ptr_t func;
> > +       uintptr_t func_page_offset;
> >         void *p;
> >
> >         sig_caught = 0;
> >
> > -       p = SAFE_MMAP(cleanup, 0, copy_sz, PROT_READ | PROT_WRITE,
> > +       p = SAFE_MMAP(cleanup, 0, page_sz, PROT_READ | PROT_WRITE,
> >                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> >
> >  #ifdef USE_FUNCTION_DESCRIPTORS
> >         func_descr_t opd;
> > -       opd.entry = (uintptr_t)get_func(p);
> > +       opd.entry = (uintptr_t)get_func(p, &func_page_offset);
> >         func = (func_ptr_t)&opd;
> >  #else
> > -       func = get_func(p);
> > +       func = get_func(p, &func_page_offset);
> >  #endif
> >
> > +       if (func_page_offset + 64 >= page_sz) {
> 
> I'm wondering if this should be ">" not ">=". If the compiler decides
> to use the last 64 bytes in a page and locates the function at offset
> 0xfc0, then that's still ok: 0xfc0 + 0x40 == page_sz

Agreed, I'll make it '>'.

> 
> > +               SAFE_MUNMAP(cleanup, p, page_sz);
> > +               tst_brkm(TCONF, cleanup, "func too close to page boundary,
> > "
> > +                       "maybe your compiler ignores -falign-functions?");
> > +       }
> > +
> >         /* Change the protection to PROT_EXEC. */
> > -       TEST(mprotect(p, copy_sz, PROT_EXEC));
> > +       TEST(mprotect(p, page_sz, PROT_EXEC));
> >
> >         if (TEST_RETURN == -1) {
> >                 tst_resm(TFAIL | TTERRNO, "mprotect failed");
> > @@ -294,7 +289,7 @@ static void testfunc_protexec(void)
> >                 }
> >         }
> >
> > -       SAFE_MUNMAP(cleanup, p, copy_sz);
> > +       SAFE_MUNMAP(cleanup, p, page_sz);
> >  }
> >
> >  static void cleanup(void)
> > --
> > 1.8.3.1
> >
> 
