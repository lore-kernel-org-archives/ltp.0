From: Li Wang <liwang@redhat.com>
Date: Thu, 26 Sep 2019 16:35:19 +0800
Subject: [LTP] [PATCH v3] move_pages12: handle errno EBUSY for
 madvise(..., MADV_SOFT_OFFLINE)
In-Reply-To: <87a7arxznf.fsf@rpws.prws.suse.cz>
References: <20190808054513.31041-1-liwang@redhat.com>
 <87a7arxznf.fsf@rpws.prws.suse.cz>
Message-ID: <CAEemH2d=KXmeGs+LVjUph2sgxVhkhVC3sAReyDuLkFNpqd64UQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Sep 26, 2019 at 3:52 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello,
>
> Li Wang <liwang@redhat.com> writes:
>
> > The test#2 is going to simulate the race condition, where move_pages()
> > and soft offline are called on a single hugetlb page concurrently. But,
> > it return EBUSY and report FAIL in soft-offline a moving hugepage as a
> > result sometimes.
> >
> > The root cause seems a call to page_huge_active return false, then the
> > soft offline action will failed to isolate hugepage with EBUSY return as
> > below call trace:
> >
> > In Parent:
> >   madvise(..., MADV_SOFT_OFFLINE)
> >   ...
> >     soft_offline_page
> >       soft_offline_in_use_page
> >         soft_offline_huge_page
> >           isolate_huge_page
> >             page_huge_active
> >              # return false at here
> >
> > In Child:
> >   move_pages()
> >   ...
> >     do_move_pages
> >       do_move_pages_to_node
> >         add_page_for_migration
> >           isolate_huge_page
> >             # it has already isolated the hugepage
> >
> > In this patch, I simply regard the returned EBUSY as a normal situation
> and
> > mask it in error handler. Because move_pages is calling
> add_page_for_migration
> > to isolate hugepage before do migration, so that's very possible to hit
> the
> > collision and return EBUSY on the same page.
>
> We also get EIO (on aarch64) and ENOMEM (on x86). From looking at
> migrate_pages, this seems normal, although the behaviour on older kernels
> is different to newer ones.
>
> On OpenSUSE with kernel 5.2 the test completes without any problem, but
> on SLES kernel 5.12 we get the other error codes.
>

Can you help to check if these commits have been backported to SLEL
kernel-5.12?
    commit e66f17ff71772b209eed39de35aaa99ba819c93d
    commit c9d398fa237882ea07167e23bcfc5e6847066518
    commit 4643d67e8cb0b3536ef0ab5cddd1cedc73fa14ad

The move_pages12 test actually found three regression BUG which has all
been fixed in the mainline kernel so far.


> TBH I'm not sure what we are testing when checking the return value of
> MADV_SOFT_OFFLINE? The bug is not reproduced if madvise always fails, so
> the test should pass right?
>

The return value checking of MADV_SOFT_OFFLINE are two:
    EINVAL - To make sure system support MADV_SOFT_OFFLINE
    EBUSY -  To make ignore the defect(EBUSY when soft-offlining hugepage)
designed by the kernel

The madvise(MADV_SOFT_OFFLINE) should not always fail, it might get failure
occasionally on EBUSY(ignored already), but exit with TCONF if hit EINVAL.

@MIke & @Naoyo, If I was wrong please correct me.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190926/e4226aa8/attachment.htm>
