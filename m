From: Li Wang <liwang@redhat.com>
Date: Thu, 25 Mar 2021 16:56:18 +0800
Subject: [LTP] [PATCH 0/3] s390 vdso fixes
In-Reply-To: <20210323215819.4161164-1-hca@linux.ibm.com>
References: <YFmUrVOyX4q+8Dy9@osiris>
 <20210323215819.4161164-1-hca@linux.ibm.com>
Message-ID: <CAEemH2cSk=doHL51uD5Qu6uCRRTCgYd0EN0iij=X+538J53XsQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Heiko,

On Wed, Mar 24, 2021 at 5:58 AM Heiko Carstens <hca@linux.ibm.com> wrote:

> Li Wang reported that clock_gettime(CLOCK_MONOTONIC_RAW, ...) does not
> work correctly on s390 via vdso. Debugging this also revealed an
> unrelated bug (first patch).
>
> The second patch fixes the problem: the tod clock steering parameters
> required by __arch_get_hw_counter() are only present within the first
> element of the _vdso_data array and not at all within the _timens_data
> array.
>
> Instead of working around this simply provide an s390 specific vdso
> data page which contains the tod clock steering parameters.
>
> This allows also to remove ARCH_HAS_VDSO_DATA again.
>
> Heiko Carstens (3):
>   s390/vdso: fix tod clock steering
>   s390/vdso: fix arch_data access for __arch_get_hw_counter()
>   lib/vdso: remove struct arch_vdso_data from vdso data struct
>

Thanks for the quick fix! I confirmed these patches work for me.
(tested with latest mainline kernel v5.12-rc4)

Tested-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210325/ef168269/attachment-0001.htm>
