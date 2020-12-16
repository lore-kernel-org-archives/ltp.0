From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 16 Dec 2020 10:10:31 +0800
Subject: [LTP] [PATCH] syscalls/ioctl_loop05.c: skip test on overlay
 filesystem
In-Reply-To: <20201215155650.6496-1-radoslav.kolev@suse.com>
References: <20201215155650.6496-1-radoslav.kolev@suse.com>
Message-ID: <5FD96C97.6020602@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Radoslav
> The undelrying device can't be properly detected and causes failure
> when running in an overlay filesystem.

I guess the best way is to change tst_find_backing_dev api, so it can 
detect the correct underlying device.

>
> Signed-off-by: Radoslav Kolev<radoslav.kolev@suse.com>
> ---
>   testcases/kernel/syscalls/ioctl/ioctl_loop05.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
> index e3c14faab..f8fa413a9 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
> @@ -101,6 +101,9 @@ static void setup(void)
>   	if (tst_fs_type(".") == TST_TMPFS_MAGIC)
>   		tst_brk(TCONF, "tmpfd doesn't support O_DIRECT flag");
>
> +	if (tst_fs_type(".") == TST_OVERLAYFS_MAGIC)
> +		tst_brk(TCONF, "device isn't properly detected in overlay fs");
> +
>   	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
>   	if (dev_num<  0)
>   		tst_brk(TBROK, "Failed to find free loop device");



