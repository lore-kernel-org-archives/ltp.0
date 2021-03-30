From: zhaogongyi <zhaogongyi@huawei.com>
Date: Tue, 30 Mar 2021 08:18:45 +0000
Subject: [LTP] [PATCH] min_kver: Add kernel version requestions
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB40389E765@dggeml531-mbx.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

I have seen the function definition in lapi/preadv2.h or lapi/pwritev2.h, but it seems not enough.

I run the testcases preadv201 and pwritev201 on my qemu, kernel version 4.4, arch is armeb, and report as follows: 

# ./preadv201
tst_test.c:1294: TINFO: Timeout per run is 0h 05m 00s
preadv201.c:91: TPASS: preadv2() read 64 bytes with content 'a' expectedly
preadv201.c:91: TPASS: preadv2() read 64 bytes with content 'a' expectedly
preadv201.c:91: TPASS: preadv2() read 32 bytes with content 'b' expectedly
preadv201.c:64: TFAIL: preadv2() failed: EINVAL (22)
preadv201.c:64: TFAIL: preadv2() failed: EINVAL (22)
preadv201.c:64: TFAIL: preadv2() failed: EINVAL (22)

Summary:
passed   3
failed   3
broken   0
skipped  0
warnings 0


# ./pwritev201
tst_test.c:1294: TINFO: Timeout per run is 0h 05m 00s
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content 'a' expectedly
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content 'a' expectedly
pwritev201.c:96: TPASS: pwritev2() wrote 64 bytes successfully with content 'a' expectedly
pwritev201.c:62: TFAIL: pwritev2() failed: EINVAL (22)
pwritev201.c:62: TFAIL: pwritev2() failed: EINVAL (22)
pwritev201.c:62: TFAIL: pwritev2() failed: EINVAL (22)

Summary:
passed   3
failed   3
broken   0
skipped  0
warnings 0


See man 2, we known preadv2() and pwritev2() first appeared in Linux 4.6, so I think we need to check kernel version in testcases.

Thanks!

Best Regards,
Gongyi


> Hi Zhongyi,
> 
> Do you get any issue here?
> 
> It is unncessary to add version check because LTP has check the support of
> preadv2/pwritev2:
> 1) Call preadv2/pwritev2 directly if glibc provides it.
> 2) Call syscall(__NR_preadv2/__NR_pwritev2) if glibc doesn't provides
> preadv2/pwritev.
> 3) Report TCONF if kernel doesn't support __NR_preadv2/__NR_pwritev2.
> 
> Please reference "include/lapi/preadv2.h"
> 
> Best Regards,
> Xiao Yang
> On 2021/3/30 15:44, Zhao Gongyi wrote:
> > We need add kernel version requestions sinc preadv2() and pwritev2()
> > first appeared in Linux 4.6.
> >
> > For those:
> > 	testcases/kernel/syscalls/preadv2/preadv201.c
> > 	testcases/kernel/syscalls/pwritev2/pwritev201.c
> >
> > Signed-off-by: Zhao Gongyi<zhaogongyi@huawei.com>
> > ---
> >   testcases/kernel/syscalls/preadv2/preadv201.c   | 1 +
> >   testcases/kernel/syscalls/pwritev2/pwritev201.c | 1 +
> >   2 files changed, 2 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/preadv2/preadv201.c
> > b/testcases/kernel/syscalls/preadv2/preadv201.c
> > index 91e2b9889..e8220f94c 100644
> > --- a/testcases/kernel/syscalls/preadv2/preadv201.c
> > +++ b/testcases/kernel/syscalls/preadv2/preadv201.c
> > @@ -111,6 +111,7 @@ static void cleanup(void)
> >   }
> >
> >   static struct tst_test test = {
> > +	.min_kver = "4.6",
> >   	.tcnt = ARRAY_SIZE(tcases),
> >   	.setup = setup,
> >   	.cleanup = cleanup,
> > diff --git a/testcases/kernel/syscalls/pwritev2/pwritev201.c
> > b/testcases/kernel/syscalls/pwritev2/pwritev201.c
> > index eba45b7d3..a8273e59d 100644
> > --- a/testcases/kernel/syscalls/pwritev2/pwritev201.c
> > +++ b/testcases/kernel/syscalls/pwritev2/pwritev201.c
> > @@ -111,6 +111,7 @@ static void cleanup(void)
> >   }
> >
> >   static struct tst_test test = {
> > +	.min_kver = "4.6",
> >   	.tcnt = ARRAY_SIZE(tcases),
> >   	.setup = setup,
> >   	.cleanup = cleanup,
> > --
> > 2.17.1
> >
> >
