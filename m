From: Zorro Lang <zlang@redhat.com>
Date: Wed, 26 Feb 2020 13:14:07 +0800
Subject: [LTP] [PATCH V4 1/10] tst_device: Add tst_is_mounted() helper
In-Reply-To: <305330ad290ce4802d832e02765b8723a976d4a7.1582627066.git.viresh.kumar@linaro.org>
References: <7c0899c42b8d8434c1cf9ca6b261993a1c09031f.1582612624.git.viresh.kumar@linaro.org>
 <305330ad290ce4802d832e02765b8723a976d4a7.1582627066.git.viresh.kumar@linaro.org>
Message-ID: <20200226051407.GP14282@dhcp-12-102.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Feb 25, 2020 at 04:09:31PM +0530, Viresh Kumar wrote:
> This patch moves the ismount() helper added to the fsmount syscall tests
> to the standard library and renames it to tst_is_mounted(). The helper
> can be used across different files now.
> 
> Minor modifications are also done to the helper.
> 
> Acked-by: Li Wang <liwang@redhat.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V3->V4:
> - s/TWARN/TINFO
> - Fix commit log.
> 
>  include/tst_device.h                          |  6 +++++
>  lib/tst_device.c                              | 23 +++++++++++++++++
>  testcases/kernel/syscalls/fsmount/fsmount01.c | 25 +------------------
>  3 files changed, 30 insertions(+), 24 deletions(-)
> 
> diff --git a/include/tst_device.h b/include/tst_device.h
> index f5609f5986bb..bd6910672d2f 100644
> --- a/include/tst_device.h
> +++ b/include/tst_device.h
> @@ -36,6 +36,12 @@ extern struct tst_device *tst_device;
>   */
>  int tst_umount(const char *path);
>  
> +/*
> + * Verifies if an earlier mount is successful or not.
> + * @path: Mount path to verify
> + */
> +int tst_is_mounted(const char *path);
> +
>  /*
>   * Clears a first few blocks of the device. This is needed when device has
>   * already been formatted with a filesystems, subset of mkfs.foo utils aborts
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 8b5459def1cb..d99fb8bc554a 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -386,6 +386,29 @@ int tst_umount(const char *path)
>  	return -1;
>  }
>  
> +int tst_is_mounted(const char *path)
> +{
> +	char line[256];
> +	FILE *file;
> +	int ret = 0;
> +
> +	file = SAFE_FOPEN(NULL, "/proc/mounts", "r");
> +
> +	while (fgets(line, sizeof(line), file)) {
> +		if (strstr(line, path) != NULL) {

This code moving is fine. But if we'd like to make this function to be common
function, we'd better think more about that. I think the current code logic
isn't so well.

For example, if path is "/mnt/test", and we get a line as "/mnt/test/mnt1 ..."
or "/mnt/mnt/test", Then this function thinks "/mnt/test" is a mountpoint.

We can refer to util-linux/sys-utils/mountpoint.c a little, but it's complicated,
or we can call mountpoint command directly?

> +			ret = 1;
> +			break;
> +		}
> +	}
> +
> +	SAFE_FCLOSE(NULL, file);
> +
> +	if (!ret)
> +		tst_resm(TINFO, "No device is mounted at %s", path);
> +
> +	return ret;
> +}
> +
>  int find_stat_file(const char *dev, char *path, size_t path_len)
>  {
>  	const char *devname = strrchr(dev, '/') + 1;
> diff --git a/testcases/kernel/syscalls/fsmount/fsmount01.c b/testcases/kernel/syscalls/fsmount/fsmount01.c
> index 83185b48aedd..8e29a1537334 100644
> --- a/testcases/kernel/syscalls/fsmount/fsmount01.c
> +++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
> @@ -12,30 +12,10 @@
>  #include "tst_test.h"
>  #include "lapi/fcntl.h"
>  #include "lapi/fsmount.h"
> -#include "tst_safe_stdio.h"
>  
> -#define LINELENGTH 256
>  #define MNTPOINT "newmount_point"
>  static int sfd, mfd, is_mounted;
>  
> -static int ismount(char *mntpoint)
> -{
> -	int ret = 0;
> -	FILE *file;
> -	char line[LINELENGTH];
> -
> -	file = SAFE_FOPEN("/proc/mounts", "r");
> -
> -	while (fgets(line, sizeof(line), file)) {
> -		if (strstr(line, mntpoint) != NULL) {
> -			ret = 1;
> -			break;
> -		}
> -	}
> -	SAFE_FCLOSE(file);
> -	return ret;
> -}
> -
>  static void cleanup(void)
>  {
>  	if (is_mounted)
> @@ -76,12 +56,9 @@ static void test_fsmount(void)
>  	tst_res(TPASS, "move_mount() attached to the mount point");
>  	SAFE_CLOSE(mfd);
>  
> -	if (ismount(MNTPOINT)) {
> -		tst_res(TPASS, "device mounted");
> +	if (tst_is_mounted(MNTPOINT)) {
>  		SAFE_UMOUNT(MNTPOINT);
>  		is_mounted = 0;
> -	} else {
> -		tst_res(TFAIL, "device not mounted");
>  	}
>  }
>  
> -- 
> 2.21.0.rc0.269.g1a574e7a288b
> 

