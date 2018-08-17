From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Aug 2018 10:14:51 +0800
Subject: [LTP] [PATCH] pty: fix some issues in pty02
In-Reply-To: <20180816102816.GA4077@rei>
References: <20180816080724.25143-1-liwang@redhat.com>
 <20180816102816.GA4077@rei>
Message-ID: <CAEemH2fUPaQmWid0==_k4o61MNS_5ReJskRCtfSvBfA2FTjjzg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> wrote:

>
> I've tried the test with this patch applied and I still got soft-lockup
> on unpatched kernel, so it seems like the reproducer works fine with
> these changes.
> >
> > -     if (tcsetattr(ptmx, TCSANOW, &io) != 0)
> > -             tst_brk(TBROK | TERRNO, "tcsetattr() failed");
> > +     if (tcgetattr(ptmx, &io) != 0)
> > +             tst_brk(TBROK | TERRNO, "tcgetattr() failed");
> > +
> > +     io.c_lflag = EXTPROC | ICANON;
> > +
> > +     TEST(tcsetattr(ptmx, TCSANOW, &io));
> > +     if (TEST_RETURN == -1) {
> > +             if (TEST_ERRNO == EINVAL)
> > +                     tst_res(TCONF, "tcsetattr(, , EXTPROC | ICANON) is
> not supported");
> > +             else
> > +                     tst_brk(TBROK | TERRNO, "tcsetattr() failed");
> > +     }
>
> We changed the TEST_RETURN to TST_RET and TEST_ERRNO to TST_ERR a few
> weeks ago, can you please update you git tree?
>

Yes, sure.

>
> >       if (unlockpt(ptmx) != 0)
> >               tst_brk(TBROK | TERRNO, "unlockpt() failed");
> >
> >       pts = SAFE_OPEN(ptsname(ptmx), O_RDONLY);
> >       SAFE_WRITE(1, ptmx, &c, 1);
> > +     /* giving newline('\n') to ptmx to avoid reading pts block */
> > +     SAFE_WRITE(1, ptmx, &n, 1);
>
> I wonder if we can just do SAFE_WRITE(1, ptmx, "A\n", 2) here instead?
>

I think yes, and this is more tidy.

>
> Also the comment is a bit misleading, I was thinking for a while about
> what is pts block and why do we need to avoid reading it. So maybe we
> should reword it as:
>
> /* write newline to ptmx to avoid read() on pts to block */
>

Ok, it will be updated in patch v2.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180817/3f7b54e7/attachment.html>
