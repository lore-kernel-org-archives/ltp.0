From: Li Wang <liwang@redhat.com>
Date: Wed, 3 Jul 2019 11:37:31 +0800
Subject: [LTP] [RFC PATCH] lib: add tst_no_corefile to avoid corefile
 dumping
In-Reply-To: <1168887917.31303999.1562083863754.JavaMail.zimbra@redhat.com>
References: <20190701100343.3406-1-liwang@redhat.com>
 <2137465502.31003797.1561978896804.JavaMail.zimbra@redhat.com>
 <CAEemH2foarWKGGkV1z6RogH6wsWV__aH8K1cOvG56_yq2WBLyg@mail.gmail.com>
 <1168887917.31303999.1562083863754.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2fXnn6-HtttkFHW0cGe8EeLS8vedKDdFxh4uxMx6g1yaQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jul 3, 2019 at 12:11 AM Jan Stancek <jstancek@redhat.com> wrote:

>
>
> ----- Original Message -----
> > On Mon, Jul 1, 2019 at 7:01 PM Jan Stancek <jstancek@redhat.com> wrote:
> >
> > >
> > >
> > > ----- Original Message -----
> > > > Signed-off-by: Li Wang <liwang@redhat.com>
> > > > Cc: Jan Stancek <jstancek@redhat.com>
> > > > ---
> > > >  include/tst_safe_macros.h                        | 16
> ++++++++++++++++
> > > >  testcases/kernel/security/umip/umip_basic_test.c |  2 ++
> > > >  testcases/kernel/syscalls/ipc/shmat/shmat01.c    | 16
> +++-------------
> > > >  3 files changed, 21 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> > > > index 53a888c80..110e2984f 100644
> > > > --- a/include/tst_safe_macros.h
> > > > +++ b/include/tst_safe_macros.h
> > > > @@ -394,6 +394,22 @@ static inline int safe_setrlimit(const char
> *file,
> > > const
> > > > int lineno,
> > > >  #define SAFE_SETRLIMIT(resource, rlim) \
> > > >       safe_setrlimit(__FILE__, __LINE__, (resource), (rlim))
> > > >
> > > > +/*
> > > > + * Crash is expected, avoid dumping corefile.
> > > > + * 1 is a special value, that disables core-to-pipe.
> > > > + * At the same time it is small enough value for
> > > > + * core-to-file, so it skips creating cores as well.
> > > > + */
> > > > +static inline void tst_no_corefile(void)
> > > > +{
> > > > +       struct rlimit r;
> > > > +
> > > > +       r.rlim_cur = 1;
> > > > +       r.rlim_max = 1;
> > > > +       SAFE_SETRLIMIT(RLIMIT_CORE, &r);
> > > > +       tst_res(TINFO, "Avoid dumping corefile in following test");
> > >
> > > I'm fine with helper func. Maybe I'd print also current pid.
> > > It could be little spammy if there are many children, but we could
> > > address that later (if needed) with a parameter to control verbosity.
> > >
> >
> > To add a parameter (int verbose) sounds good to me.
> >
> > Btw, should we add some note/comment in the
> > document(test-writing-guidelines.txt)? I take a rough look but not sure
> > which line is the best position for that.
>
> How about we extend "2.2.10 Signal handlers" to "2.2.10 Signals and signal
> handlers"
> and put a note there?


Good point.

Since that core file dumping is(sometimes) a response for signal SIGSEGV in
process, we purpose to change that behavior and avoid to generate a dump
that related to this topic.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190703/07ab69ce/attachment.htm>
