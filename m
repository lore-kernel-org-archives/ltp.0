From: Li Wang <liwang@redhat.com>
Date: Tue, 10 Nov 2015 17:19:52 +0800
Subject: [LTP] [PATCH] signal: add new testcase signal06.c
In-Reply-To: <1677708720.5562278.1447075773714.JavaMail.zimbra@redhat.com>
References: <1446899297-8052-1-git-send-email-liwang@redhat.com>
 <1677708720.5562278.1447075773714.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2f2sYe0t5F3Kh2Y7sYQkDW4uXoiHdvTv0gOHzWwWADXkg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Mon, Nov 9, 2015 at 9:29 PM, Jan Stancek <jstancek@redhat.com> wrote:

>
>
>
> Short summary what the problem is would be appreciated here.
>

ok, l will try.


>
> > +
> > +signal06: CFLAGS+=-O2 -lpthread
>
> just "-pthread"
>

ok.


>
> > + * Description:
> > + * These below commits fix the issue on v3.17-rc3-3 stable kernel:
>
> Here as well - short description what is the "issue".
>
ok.

>
> > + *
> > +#include "test.h"
> > +
> > +char *TCID = "signal06";
> > +int TST_TOTAL = 5;
> > +
> > +#if __x86_64__
> > +
> > +volatile double D;
> > +int FLAGE;
>
> FLAGE looks like it should be volatile too.
>

yeah, no problem.


>
> > +
> > +char altstack[4096 * 10] __attribute__((aligned(4096)));
> > +
> > +void test(double d)
> > +{
> > +     int loop = 1;
> > +     int pid = getpid();
> > +
> > +     D = d;
> > +     while (D == d && loop < 10000) {
>
> make "10000" DEFINE or at least a variable
>

yes.


>
> > +             /* sys_tkill(pid, SIGHUP); asm to avoid save/reload
> > +              * fp regs around c call */
> > +             asm ("" : : "a"(200), "D"(pid), "S"(1));
>
> If you include linux_syscall_numbers.h, you can be sure that __NR_tkill
> will be defined.
>

ok, sounds good.


> > +     } else {
> > +             tst_resm(TFAIL, "Bug Reproduced!");
> > +             exit(-1);
>
> Why not tst_exit()?
>

ok, good.


>
> > +             tst_count = 0;
> > +
> > +             for (i = 0; i < TST_TOTAL; i++) {
> > +
> > +                     sigaction(SIGSEGV, &sa, NULL);
> > +                     sigaltstack(&st, NULL);
> > +                     sa.sa_flags = SA_ONSTACK;
> > +                     sigaction(SIGHUP, &sa, NULL);
>
> Signal handler setup looks like it can be moved outside both loops.
>

yes, that's would be great.


>
> > +
> > +                     res = pthread_create(&pt, NULL, tfunc, NULL);
> > +                     if (res) {
> > +                             tst_brkm(TBROK, NULL, "pthread_create():
> %s",
> > +                                             tst_strerrno(res));
>
> If you use TEST(), then TRERRNO will print errno stored in TEST_RETURN.
>

yes.


>
> Regards,
> Jan
>
>
Thanks for reviewing this patch.  and then will sent V2.


-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151110/319d7071/attachment.html>
