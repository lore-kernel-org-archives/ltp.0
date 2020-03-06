From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 6 Mar 2020 13:45:46 +0100
Subject: [LTP] [PATCH V5 01/10] tst_device: Add tst_is_mounted() helper
In-Reply-To: <2071e47d7d8cb3e7f8bc6558e86999eddd9c3762.1582779464.git.viresh.kumar@linaro.org>
References: <cover.1582779464.git.viresh.kumar@linaro.org>
 <2071e47d7d8cb3e7f8bc6558e86999eddd9c3762.1582779464.git.viresh.kumar@linaro.org>
Message-ID: <20200306124546.GA3375@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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
>  include/tst_device.h                          |  6 +++++
>  lib/tst_device.c                              | 14 +++++++++++
>  testcases/kernel/syscalls/fsmount/fsmount01.c | 25 +------------------
>  3 files changed, 21 insertions(+), 24 deletions(-)
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
> index 8b5459def1cb..8bf6dacf5973 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -386,6 +386,20 @@ int tst_umount(const char *path)
>  	return -1;
>  }
>  
> +int tst_is_mounted(const char *path)
> +{
> +	char cmd[PATH_MAX];
> +	int ret;
> +
> +	snprintf(cmd, sizeof(cmd), "mountpoint -q %s", path);
> +	ret = tst_system(cmd);

I'm not sure that depending on mountpoint command is right choice, there
are all kinds of embedded systems out there that may be missing it.

Also this does not even handle the case that the command is missing.

Looking at the v4 version, all we need is to correctly parse each line
from from /proc/mounts. I would just use strsep() with space as a
delimited and took first token that starts with a slash i.e. '/', then
we can just strcmp() it against the path. Or do I miss something?

> +	if (ret)
> +		tst_resm(TINFO, "No device is mounted at %s", path);
> +
> +	return !ret;
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

-- 
Cyril Hrubis
chrubis@suse.cz
