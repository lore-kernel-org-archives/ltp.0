From: Li Wang <liwang@redhat.com>
Date: Thu, 25 Mar 2021 22:11:09 +0800
Subject: [LTP] [PATCH 0/3] s390 vdso fixes
In-Reply-To: <YFyDARFZZUCG5LGc@osiris>
References: <YFmUrVOyX4q+8Dy9@osiris>
 <20210323215819.4161164-1-hca@linux.ibm.com>
 <CAEemH2cSk=doHL51uD5Qu6uCRRTCgYd0EN0iij=X+538J53XsQ@mail.gmail.com>
 <YFyDARFZZUCG5LGc@osiris>
Message-ID: <CAEemH2cQxfjxm8jOCmESsX8aAvhHw=BqyEq24sgNiVc0iCPNDQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Heiko Carstens <hca@linux.ibm.com> wrote:


> ...
> > > Heiko Carstens (3):
> > >   s390/vdso: fix tod clock steering
> > >   s390/vdso: fix arch_data access for __arch_get_hw_counter()
> > >   lib/vdso: remove struct arch_vdso_data from vdso data struct
> > >
> >
> > Thanks for the quick fix! I confirmed these patches work for me.
> > (tested with latest mainline kernel v5.12-rc4)
> >
> > Tested-by: Li Wang <liwang@redhat.com>
>
> Thanks a lot for confirming! However I decided to go with the simple
> variant:
>
> https://lore.kernel.org/linux-s390/YFnxr1ZlMIOIqjfq@osiris/T/#m26f94fd8ac048421a4a8870e7259a09f97840a3e
>
> May I add your Tested-by there as well?
>

Sure, I just reverted the 2/3 and 3/3, then apply the simple variant
scratch-patch. It also works well.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210325/bf84e964/attachment.htm>
