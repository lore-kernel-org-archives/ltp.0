From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 26 Feb 2021 12:59:30 +0800
Subject: [LTP] [PATCH] syscalls/ioctl: Remove requirement of loop driver
In-Reply-To: <20210226040057.184076-1-zhaogongyi@huawei.com>
References: <20210226040057.184076-1-zhaogongyi@huawei.com>
Message-ID: <60388032.7010600@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2021/2/26 12:00, Zhao Gongyi wrote:
> There is no loop driver when config CONFIG_BLK_DEV_LOOP is set to y, and
> we have check the loop device in tst_find_free_loopdev. So we can remove
> the requirement of loop driver.
Hi Zhongyi,

1) I think .needs_driver can parse either CONFIG_BLK_DEV_LOOP=y or 
CONFIG_BLK_DEV_LOOP=m correctly.
     Do you have any issue that .needs_driver cannot parse 
CONFIG_BLK_DEV_LOOP=y correctly?
2) If CONFIG_BLK_DEV_LOOP is not set, we would like to report TCONF by 
.needs_driver rather than TBROK by tst_find_free_loopdev().

Best Regards,
Xiao Yang
> Signed-off-by: Zhao Gongyi<zhaogongyi@huawei.com>
> ---
>   testcases/kernel/syscalls/ioctl/ioctl_loop01.c | 4 ----
>   testcases/kernel/syscalls/ioctl/ioctl_loop02.c | 4 ----
>   testcases/kernel/syscalls/ioctl/ioctl_loop03.c | 4 ----
>   testcases/kernel/syscalls/ioctl/ioctl_loop04.c | 4 ----
>   testcases/kernel/syscalls/ioctl/ioctl_loop05.c | 4 ----
>   testcases/kernel/syscalls/ioctl/ioctl_loop06.c | 4 ----
>   testcases/kernel/syscalls/ioctl/ioctl_loop07.c | 4 ----
>   7 files changed, 28 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> index cf71184b4..27713847d 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> @@ -142,10 +142,6 @@ static struct tst_test test = {
>   	.cleanup = cleanup,
>   	.test_all = verify_ioctl_loop,
>   	.needs_root = 1,
> -	.needs_drivers = (const char *const []) {
> -		"loop",
> -		NULL
> -	},
>   	.tags = (const struct tst_tag[]) {
>   		{"linux-git", "10c70d95c0f2"},
>   		{"linux-git", "6ac92fb5cdff"},
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
> index ac6184216..538b64e00 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
> @@ -157,8 +157,4 @@ static struct tst_test test = {
>   	.test = verify_ioctl_loop,
>   	.needs_root = 1,
>   	.needs_tmpdir = 1,
> -	.needs_drivers = (const char *const []) {
> -		"loop",
> -		NULL
> -	}
>   };
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop03.c b/testcases/kernel/syscalls/ioctl/ioctl_loop03.c
> index 9cf5a41fa..ee3748178 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop03.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop03.c
> @@ -68,8 +68,4 @@ static struct tst_test test = {
>   	.test_all = verify_ioctl_loop,
>   	.needs_root = 1,
>   	.needs_tmpdir = 1,
> -	.needs_drivers = (const char *const []) {
> -		"loop",
> -		NULL
> -	}
>   };
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop04.c b/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
> index b4ab44a74..615247aec 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop04.c
> @@ -91,8 +91,4 @@ static struct tst_test test = {
>   	.test_all = verify_ioctl_loop,
>   	.needs_root = 1,
>   	.needs_tmpdir = 1,
> -	.needs_drivers = (const char *const []) {
> -		"loop",
> -		NULL
> -	}
>   };
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
> index f8fa413a9..ec88d6039 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
> @@ -151,8 +151,4 @@ static struct tst_test test = {
>   	.test_all = verify_ioctl_loop,
>   	.needs_root = 1,
>   	.needs_tmpdir = 1,
> -	.needs_drivers = (const char *const []) {
> -		"loop",
> -		NULL
> -	}
>   };
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
> index bd0d289ca..969b98c41 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
> @@ -136,8 +136,4 @@ static struct tst_test test = {
>   	.tcnt = ARRAY_SIZE(tcases),
>   	.needs_root = 1,
>   	.needs_tmpdir = 1,
> -	.needs_drivers = (const char *const []) {
> -		"loop",
> -		NULL
> -	}
>   };
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop07.c b/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
> index efe48962e..5e1b38866 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
> @@ -158,8 +158,4 @@ static struct tst_test test = {
>   		{"linux-git", "79e5dc59e297"},
>   		{}
>   	},
> -	.needs_drivers = (const char *const []) {
> -		"loop",
> -		NULL
> -	}
>   };
> --
> 2.17.1
>
>



