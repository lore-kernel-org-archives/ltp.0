From: Heiko Carstens <hca@linux.ibm.com>
Date: Thu, 25 Mar 2021 13:33:05 +0100
Subject: [LTP] [PATCH 0/3] s390 vdso fixes
In-Reply-To: <CAEemH2cSk=doHL51uD5Qu6uCRRTCgYd0EN0iij=X+538J53XsQ@mail.gmail.com>
References: <YFmUrVOyX4q+8Dy9@osiris>
 <20210323215819.4161164-1-hca@linux.ibm.com>
 <CAEemH2cSk=doHL51uD5Qu6uCRRTCgYd0EN0iij=X+538J53XsQ@mail.gmail.com>
Message-ID: <YFyDARFZZUCG5LGc@osiris>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Mar 25, 2021 at 04:56:18PM +0800, Li Wang wrote:
> Hi Heiko,
> 
> On Wed, Mar 24, 2021 at 5:58 AM Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> > Li Wang reported that clock_gettime(CLOCK_MONOTONIC_RAW, ...) does not
> > work correctly on s390 via vdso. Debugging this also revealed an
> > unrelated bug (first patch).
> >
> > The second patch fixes the problem: the tod clock steering parameters
> > required by __arch_get_hw_counter() are only present within the first
> > element of the _vdso_data array and not at all within the _timens_data
> > array.
> >
> > Instead of working around this simply provide an s390 specific vdso
> > data page which contains the tod clock steering parameters.
> >
> > This allows also to remove ARCH_HAS_VDSO_DATA again.
> >
> > Heiko Carstens (3):
> >   s390/vdso: fix tod clock steering
> >   s390/vdso: fix arch_data access for __arch_get_hw_counter()
> >   lib/vdso: remove struct arch_vdso_data from vdso data struct
> >
> 
> Thanks for the quick fix! I confirmed these patches work for me.
> (tested with latest mainline kernel v5.12-rc4)
> 
> Tested-by: Li Wang <liwang@redhat.com>

Thanks a lot for confirming! However I decided to go with the simple variant:
https://lore.kernel.org/linux-s390/YFnxr1ZlMIOIqjfq@osiris/T/#m26f94fd8ac048421a4a8870e7259a09f97840a3e

May I add your Tested-by there as well?
