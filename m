From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Jan 2016 21:00:43 +0800
Subject: [LTP] [PATCH] lib/mem.c: exit from test_transparent_hugepage()
 if shortage of memory
In-Reply-To: <20160126111157.GB10910@rei.lan>
References: <1453790132-2360-1-git-send-email-liwang@redhat.com>
 <20160126111157.GB10910@rei.lan>
Message-ID: <CAEemH2d7C9w18y1NTaZRsjKJ_EY+JaQXXRSgeYf-hSprHTGJ_Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

thanks for quick response.

On Tue, Jan 26, 2016 at 7:11 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Sometime thp05.c fails like:
> > ---
> > thp05       0  TINFO  :  Stop all children...
> > thp05       0  TINFO  :  Start to scan all transparent hugepages...
> > thp05       0  TINFO  :  khugepaged daemon takes 10s to scan all thp
> pages
> > thp05       0  TINFO  :  Start to verify transparent hugepage size...
> > thp05       1  TFAIL  :  mem.c:754: child[27099] got 43008KB thps -
> expect 40960KB thps
> > thp05       2  TFAIL  :  mem.c:754: child[27099] got 43008KB thps -
> expect 40960KB thps
> > thp05       3  TFAIL  :  mem.c:754: child[27099] got 43008KB thps -
> expect 40960KB thps
> > thp05       4  TFAIL  :  mem.c:754: child[27099] got 43008KB thps -
> expect 40960KB thps
>
> Hmm shouldn't the TCONF message be included in the output here?
> (otherwise the if wasn't triggered at all)
>

yes, it should be triggered first and then print the msg here.

I have realized the TFAIL problem is not simple like that, and I had
already added some comments in the following maillist. Hope you could take
a consideration when you get a chance.

Of course I'm ok if this issue couldn't be solved in the next LTP released,
since the time is short.


> > ---
> >
> > Since the system has done much testing work so far as it comes here, it
> is very easy to
> > hit the fails if the memory is fragmented, the following tests should
> better be skiped
> > while system dose not have enough memory for THP testing.
> >
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > ---
> >  testcases/kernel/mem/lib/mem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/testcases/kernel/mem/lib/mem.c
> b/testcases/kernel/mem/lib/mem.c
> > index cee4e91..6715c35 100644
> > --- a/testcases/kernel/mem/lib/mem.c
> > +++ b/testcases/kernel/mem/lib/mem.c
> > @@ -773,7 +773,7 @@ void test_transparent_hugepage(int nr_children, int
> nr_thps,
> >       memfree = read_meminfo("MemFree:");
> >       tst_resm(TINFO, "The current MemFree is %luMB", memfree / KB);
> >       if (memfree < MB)
> > -             tst_resm(TCONF, "Not enough memory for testing");
> > +             tst_brkm(TCONF, NULL, "Not enough memory for testing");
>
> This looks like obvious typo, but we should pass the cleanup to the
> tst_brkm() here as the rest of the tst_brkm() in this fuction does.
>
> >       hugepagesize = read_meminfo("Hugepagesize:");
> >       tst_resm(TINFO, "The current Hugepagesize is %luMB", hugepagesize
> / KB);
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>



-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160126/134ab769/attachment.html>
