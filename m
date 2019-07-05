From: Li Wang <liwang@redhat.com>
Date: Fri, 5 Jul 2019 11:26:29 +0800
Subject: [LTP] [PATCH v2] lib: add tst_no_corefile to avoid corefile
 dumping
In-Reply-To: <2030850327.31633394.1562227719657.JavaMail.zimbra@redhat.com>
References: <20190703072417.24091-1-liwang@redhat.com>
 <2030850327.31633394.1562227719657.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2dca-3dTXZyng+i060OnC4LoJjy=z9RLzCMUFs9=2K1qA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 4, 2019 at 4:08 PM Jan Stancek <jstancek@redhat.com> wrote:

>
> I'd rephrase it to:
>
>    If a crash (e.g. triggered by signal SIGSEGV) is expected in testing,
> you
>    can avoid creation of core files by calling tst_no_corefile() function.
>    This takes effect for process (and its children) which invoked it,
> unless
>    they subsequently modify RLIMIT_CORE.
>
>    Note that LTP library will reap any processes that test didn't reap
> itself,
>    and report any non-zero exit code as failure.
>

This looks better, I missed the effect to its children before.

> > +static inline void tst_no_corefile(int verbose)
> > +{
> > +       struct rlimit r;
> > +
> > +       r.rlim_cur = 1;
> > +       r.rlim_max = 1;
> > +       SAFE_SETRLIMIT(RLIMIT_CORE, &r);
>
> SAFE_SETRLIMIT is fine if needs_root = 1. But if test runs as unprivileged
> user
> and RLIMIT_CORE is already 0, unprivileged user won't be able to increase
> it,
> so we get TBROK here.
>
You are right. The SAFE_SETRLIMIT is not good for that achievement. I will
make use of the original type and do error handle with TWARN slightly. And
then I think we probably need to move it out form tst_safe_mcro.h.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190705/75430c48/attachment.htm>
