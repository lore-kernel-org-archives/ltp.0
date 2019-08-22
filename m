From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Thu, 22 Aug 2019 11:31:22 +0200
Subject: [LTP] [PATCH v2 1/5] lib/tst_device: Export more functions.
In-Reply-To: <20190820151831.7418-2-chrubis@suse.cz>
References: <20190820151831.7418-1-chrubis@suse.cz>
 <20190820151831.7418-2-chrubis@suse.cz>
Message-ID: <1566466282.3467.10.camel@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Reviewed-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>

On Tue, 2019-08-20 at 17:18 +0200, Cyril Hrubis wrote:
> Export tst_attach_device() and tst_deteach_device() which will be
> later
> on used by a kernel netlink uevent tests.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/tst_device.h | 7 +++++++
>  lib/tst_device.c     | 8 ++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/include/tst_device.h b/include/tst_device.h
> index f0ddc3e93..c6e7b45b1 100644
> --- a/include/tst_device.h
> +++ b/include/tst_device.h
> @@ -50,6 +50,13 @@ int tst_clear_device(const char *dev);
>   *
>   */
>  int tst_find_free_loopdev(const char *path, size_t path_len);
> +
> +
> +int tst_attach_device(const char *dev_path, const char *file_path);
> +
> +
> +int tst_detach_device(const char *dev_path);
> +
>  /*
>   * Reads test block device stat file and returns the bytes written
> since the
>   * last call of this function.
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 22abdef46..10f71901d 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -139,7 +139,7 @@ int tst_find_free_loopdev(char *path, size_t
> path_len)
>  	return -1;
>  }
>  
> -static int attach_device(const char *dev, const char *file)
> +int tst_attach_device(const char *dev, const char *file)
>  {
>  	int dev_fd, file_fd;
>  	struct loop_info loopinfo;
> @@ -185,7 +185,7 @@ static int attach_device(const char *dev, const
> char *file)
>  	return 0;
>  }
>  
> -static int detach_device(const char *dev)
> +int tst_detach_device(const char *dev)
>  {
>  	int dev_fd, ret, i;
>  
> @@ -284,7 +284,7 @@ const char *tst_acquire_device__(unsigned int
> size)
>  	if (tst_find_free_loopdev(dev_path, sizeof(dev_path)) == -1)
>  		return NULL;
>  
> -	if (attach_device(dev_path, DEV_FILE))
> +	if (tst_attach_device(dev_path, DEV_FILE))
>  		return NULL;
>  
>  	device_acquired = 1;
> @@ -329,7 +329,7 @@ int tst_release_device(const char *dev)
>  	 *
>  	 * The file image is deleted in tst_rmdir();
>  	 */
> -	ret = detach_device(dev);
> +	ret = tst_detach_device(dev);
>  
>  	device_acquired = 0;
>  
> -- 
> 2.21.0
> 
> 
