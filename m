From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 26 Sep 2019 11:50:40 +0200
Subject: [LTP] [PATCH v3] move_pages12: handle errno EBUSY for
 madvise(..., MADV_SOFT_OFFLINE)
In-Reply-To: <CAEemH2d=KXmeGs+LVjUph2sgxVhkhVC3sAReyDuLkFNpqd64UQ@mail.gmail.com>
References: <20190808054513.31041-1-liwang@redhat.com>
 <87a7arxznf.fsf@rpws.prws.suse.cz>
 <CAEemH2d=KXmeGs+LVjUph2sgxVhkhVC3sAReyDuLkFNpqd64UQ@mail.gmail.com>
Message-ID: <877e5vxu6n.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

>
> Can you help to check if these commits have been backported to SLEL
> kernel-5.12?
>     commit e66f17ff71772b209eed39de35aaa99ba819c93d
>     commit c9d398fa237882ea07167e23bcfc5e6847066518
>     commit 4643d67e8cb0b3536ef0ab5cddd1cedc73fa14ad

The final one has not been backported yet, but I don't think we are
hitting that bug (there is a high chance I am wrong ofcourse). Thanks.

>
> The move_pages12 test actually found three regression BUG which has all
> been fixed in the mainline kernel so far.

It is a good test!

>
>
>> TBH I'm not sure what we are testing when checking the return value of
>> MADV_SOFT_OFFLINE? The bug is not reproduced if madvise always fails, so
>> the test should pass right?
>>
>
> The return value checking of MADV_SOFT_OFFLINE are two:
>     EINVAL - To make sure system support MADV_SOFT_OFFLINE
>     EBUSY -  To make ignore the defect(EBUSY when soft-offlining hugepage)
> designed by the kernel
>
> The madvise(MADV_SOFT_OFFLINE) should not always fail, it might get failure
> occasionally on EBUSY(ignored already), but exit with TCONF if hit EINVAL.
>
> @MIke & @Naoyo, If I was wrong please correct me.



-- 
Thank you,
Richard.
