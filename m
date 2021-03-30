From: yangx.jy@fujitsu.com <yangx.jy@fujitsu.com>
Date: Tue, 30 Mar 2021 08:05:39 +0000
Subject: [LTP] [PATCH] min_kver: Add kernel version requestions
In-Reply-To: <20210330074437.3208-1-zhaogongyi@huawei.com>
References: <20210330074437.3208-1-zhaogongyi@huawei.com>
Message-ID: <6062DBD2.30501@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zhongyi,

Do you get any issue here?

It is unncessary to add version check because LTP has check the support 
of  preadv2/pwritev2:
1) Call preadv2/pwritev2 directly if glibc provides it.
2) Call syscall(__NR_preadv2/__NR_pwritev2) if glibc doesn't provides 
preadv2/pwritev.
3) Report TCONF if kernel doesn't support __NR_preadv2/__NR_pwritev2.

Please reference "include/lapi/preadv2.h"

Best Regards,
Xiao Yang
On 2021/3/30 15:44, Zhao Gongyi wrote:
> We need add kernel version requestions sinc preadv2() and pwritev2()
> first appeared in Linux 4.6.
>
> For those:
> 	testcases/kernel/syscalls/preadv2/preadv201.c
> 	testcases/kernel/syscalls/pwritev2/pwritev201.c
>
> Signed-off-by: Zhao Gongyi<zhaogongyi@huawei.com>
> ---
>   testcases/kernel/syscalls/preadv2/preadv201.c   | 1 +
>   testcases/kernel/syscalls/pwritev2/pwritev201.c | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/preadv2/preadv201.c b/testcases/kernel/syscalls/preadv2/preadv201.c
> index 91e2b9889..e8220f94c 100644
> --- a/testcases/kernel/syscalls/preadv2/preadv201.c
> +++ b/testcases/kernel/syscalls/preadv2/preadv201.c
> @@ -111,6 +111,7 @@ static void cleanup(void)
>   }
>
>   static struct tst_test test = {
> +	.min_kver = "4.6",
>   	.tcnt = ARRAY_SIZE(tcases),
>   	.setup = setup,
>   	.cleanup = cleanup,
> diff --git a/testcases/kernel/syscalls/pwritev2/pwritev201.c b/testcases/kernel/syscalls/pwritev2/pwritev201.c
> index eba45b7d3..a8273e59d 100644
> --- a/testcases/kernel/syscalls/pwritev2/pwritev201.c
> +++ b/testcases/kernel/syscalls/pwritev2/pwritev201.c
> @@ -111,6 +111,7 @@ static void cleanup(void)
>   }
>
>   static struct tst_test test = {
> +	.min_kver = "4.6",
>   	.tcnt = ARRAY_SIZE(tcases),
>   	.setup = setup,
>   	.cleanup = cleanup,
> --
> 2.17.1
>
>
