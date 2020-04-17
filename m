From: Xiao Yang <ice_yangxiao@163.com>
Date: Fri, 17 Apr 2020 21:44:39 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/{quotactl04,
 statx05}.c: Replace extra_opts[] with fs_opts[]
In-Reply-To: <20200417063943.309285-1-yangx.jy@cn.fujitsu.com>
References: <20200417063943.309285-1-yangx.jy@cn.fujitsu.com>
Message-ID: <f5b4139a-11fd-c24a-049a-c6941c87a7e4@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

This is a simple patch set so I pushed it.

Thanks,

Xiao Yang

On 4/17/20 2:39 PM, Xiao Yang wrote:
> extra_opts[] is to store the options which are passed after device name
> (e.g. fs-size: mkfs -t ext4 /dev/sda1 <fs-size>) so perfer to use
> fs_opts[] for quotactl04.c and statx05.c.
>
> Also add a hint to doc/test-writing-guidelines.txt.
>
> References:
> https://github.com/linux-test-project/ltp/blob/master/doc/test-writing-guidelines.txt
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/mmap/mmap16.c
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> Acked-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>   doc/test-writing-guidelines.txt                 | 3 +++
>   testcases/kernel/syscalls/quotactl/quotactl04.c | 4 ++--
>   testcases/kernel/syscalls/statx/statx05.c       | 4 ++--
>   3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index 895f6c99d..3e33fd4c1 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1116,6 +1116,9 @@ The extra options 'extra_opts' should either be 'NULL' if there are none, or a
>   will be passed after device name. e.g: +mkfs -t ext4 -b 1024 /dev/sda1 102400+
>   in this case.
>   
> +Note that perfer to store the options which can be passed before or after device
> +name by 'fs_opts' array.
> +
>   2.2.17 Verifying a filesystem's free space
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
> index 8dab83da0..b0db8fe5d 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl04.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
> @@ -102,10 +102,10 @@ static struct tcase {
>   
>   static void setup(void)
>   {
> -	const char *const extra_opts[] = {"-O quota,project", NULL};
> +	const char *const fs_opts[] = {"-O quota,project", NULL};
>   
>   	test_id = geteuid();
> -	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, extra_opts);
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
>   	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "quota");
>   	mount_flag = 1;
>   }
> diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
> index 42911fc17..77684e1ed 100644
> --- a/testcases/kernel/syscalls/statx/statx05.c
> +++ b/testcases/kernel/syscalls/statx/statx05.c
> @@ -87,12 +87,12 @@ static void run(unsigned int i)
>   static void setup(void)
>   {
>   	char opt_bsize[32];
> -	const char *const extra_opts[] = {"-O encrypt", opt_bsize, NULL};
> +	const char *const fs_opts[] = {"-O encrypt", opt_bsize, NULL};
>   	int ret;
>   
>   	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", getpagesize());
>   
> -	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, extra_opts);
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
>   	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 0);
>   	mount_flag = 1;
>   

