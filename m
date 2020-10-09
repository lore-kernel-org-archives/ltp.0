From: Li Wang <liwang@redhat.com>
Date: Fri, 9 Oct 2020 16:57:44 +0800
Subject: [LTP] [PATCH] syscalls: semop: Increase timeout for semop03
In-Reply-To: <888008428.17133303.1602068791070.JavaMail.zimbra@redhat.com>
References: <4bec407cc82038233c8977104ccd03b97ae3fc4c.1602048976.git.viresh.kumar@linaro.org>
 <888008428.17133303.1602068791070.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2eeFAiKXbP_shjz_8q5qp1-fQijLU2ZDQSUgojGevNYoA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Oct 7, 2020 at 7:06 PM Jan Stancek <jstancek@redhat.com> wrote:

>
>
> ----- Original Message -----
> > Sometimes the timeout happens before the signal is received and it
> > causes the test to fail with following error:
> >
> >  semop03.c:55: TFAIL: unexpected failure: EAGAIN/EWOULDBLOCK (11)
> >
> > Fix this by increasing the timeout to a sufficiently large value.
> >
> > Reported-by: Rachel Sibley <rasibley@redhat.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  testcases/kernel/syscalls/ipc/semop/semop03.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/testcases/kernel/syscalls/ipc/semop/semop03.c
> > b/testcases/kernel/syscalls/ipc/semop/semop03.c
> > index 89603f19d651..3a79ed38a904 100644
> > --- a/testcases/kernel/syscalls/ipc/semop/semop03.c
> > +++ b/testcases/kernel/syscalls/ipc/semop/semop03.c
> > @@ -71,7 +71,7 @@ static void setup(void)
> >       semop_supported_by_kernel(tv);
> >
> >       timeout.type = tv->ts_type;
> > -     tst_ts_set_sec(&timeout, 0);
> > +     tst_ts_set_sec(&timeout, 2);
> >       tst_ts_set_nsec(&timeout, 10000000);
> >
> >       SAFE_SIGNAL(SIGHUP, sighandler);
> > --
> > 2.25.0.rc1.19.g042ed3e048af
>
> Acked-by: Jan Stancek <jstancek@redhat.com>
>

Patch applied.


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201009/9fac53d4/attachment.htm>
