From: Li Wang <liwang@redhat.com>
Date: Thu, 16 Jul 2020 11:19:49 +0800
Subject: [LTP] [PATCH 1/2] iopl: convert to new API
In-Reply-To: <20200715092923.GC7741@yuki.lan>
References: <20200709085237.10158-1-liwang@redhat.com>
 <20200715092923.GC7741@yuki.lan>
Message-ID: <CAEemH2edLfM9icD8o=ZJJ2GvkKvmBwH0hRXFb25E8390tuCNVA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jul 15, 2020 at 5:29 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> ...
> > +     /*
> > +      * Test the system call for possible privelege levels.
> > +      * As the privelge level for a normal process is 0,
> > +      * start by setting/changing the level to 0.
> > +      */
>
> This comment should be moved to the test description at the start of the
> test, right?
>

Agree, let's move it up.

> -#else /* __i386__ */
> > -
> > -#include "test.h"
> > -
> > -int TST_TOTAL = 0;
> > -
> > -int main(void)
> > -{
> > -     tst_resm(TPASS,
> > -              "LSB v1.3 does not specify iopl() for this
> architecture.");
> > -     tst_exit();
> > -}
> > +static struct tst_test test = {
> > +     .test_all = verify_iopl,
> > +     .needs_root = 1,
> > +     .cleanup = cleanup,
> > +};
> >
> > -#endif /* __i386__ */
> > +#else /* __i386__, __x86_64__*/
> > +TST_TEST_TCONF("LSB v1.3 does not specify iopl() for this architecture.
> (only for i386 or x86_64)");
> > +#endif /* __i386_, __x86_64__*/
> > diff --git a/testcases/kernel/syscalls/iopl/iopl02.c
> b/testcases/kernel/syscalls/iopl/iopl02.c
> > index 35d239268..747a1ca56 100644
> > --- a/testcases/kernel/syscalls/iopl/iopl02.c
> > +++ b/testcases/kernel/syscalls/iopl/iopl02.c
> > @@ -1,221 +1,82 @@
> > ...
> > +
> > +#if defined __i386__ || defined(__x86_64__)
> >
> >  #define INVALID_LEVEL 4              /* Invalid privilege level */
> >  #define EXP_RET_VAL -1
>
> Do we need to have macros for these? I doubt so...
>

Yes, we can delete the macros.


> +     if (i == 1) {
> > +             /* setup Non super-user for second test */
> > +             struct passwd *pw;
> > +             pw = SAFE_GETPWNAM("nobody");
>
> This should be put into the test setup, also the comment is useless.
>

Good point, it doesn't matter to run all the tests under non-super-user.


> > +             if (seteuid(pw->pw_uid) == -1) {
> > +                     tst_res(TWARN, "Failed to set effective"
> > +                                     "uid to %d", pw->pw_uid);
> > +                     return;
> >               }
> >       }
> >
> > -     /* cleanup and exit */
> > -     cleanup();
> > -
> > -     tst_exit();
> > -
> > -}
> > -
> > -/* setup1() - set up non-super user for second test case */
> > -int setup1(void)
> > -{
> > -     /* switch to "nobody" user */
> > -     if (seteuid(ltpuser->pw_uid) == -1) {
> > -             tst_resm(TWARN, "Failed to set effective"
> > -                      "uid to %d", ltpuser->pw_uid);
> > -             return 1;
> > +     TEST(iopl(tcases[i].level));
> > +
> > +     if ((TST_RET == EXP_RET_VAL) && (TST_ERR == tcases[i].exp_errno)) {
> > +             tst_res(TPASS, "Expected failure for %s, "
> > +                             "errno: %d", tcases[i].desc,
> > +                             TST_ERR);
>
> Please use TTERRNO to print TST_ERR. Also the tst_res() prints TPASS so
> we can omit the "Expected failure" as well and print it with something
> as:
>
>         tst_res(TPASS | TTERRNO, "%s", tcases[i].desc);
>
> > +     } else {
> > +             tst_res(TFAIL, "Unexpected results for %s ; "
> > +                             "returned %ld (expected %d), errno %d "
> > +                             "(expected errno  %d)",
> > +                             tcases[i].desc,
> > +                             TST_RET, EXP_RET_VAL,
> > +                             TST_ERR, tcases[i].exp_errno);
>
> Here as well, the TST_ERR should be printed with TTERRNO and the
> exp_errno should be printed with tst_strerrno(). We can do this with
> somethign as:
>
>         tst_res(TFAIL | TTERRNO,
>                 "%s returned %ld expected -1, expected %s got ",
>                 tcases[i].desc, tst_strerrno(tcases[i].exp_errno));
>

Quite good suggestions. I missed that TTERRNO.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200716/1b581360/attachment-0001.htm>
