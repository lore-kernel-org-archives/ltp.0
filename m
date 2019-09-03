From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Sep 2019 16:35:13 +0200
Subject: [LTP] [PATCH 2/2] uevents/uevent03.c: Check if "UI_GET_SYSNAME"
 is supported
In-Reply-To: <1567514890-1216-2-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1567514890-1216-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1567514890-1216-2-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20190903143513.GA14511@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/uevents/uevent03.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/uevents/uevent03.c b/testcases/kernel/uevents/uevent03.c
> index 9b901dc..f676984 100644
> --- a/testcases/kernel/uevents/uevent03.c
> +++ b/testcases/kernel/uevents/uevent03.c
> @@ -52,7 +52,7 @@ static void get_minor_major(char *device, char *minor, char *major, size_t buf_s
>  
>  static void verify_uevent(void)
>  {
> -	int pid, fd;
> +	int pid, fd, ret;
>  	char sysname[64];
>  	char add_msg[1024];
>  	char rem_msg[1024];
> @@ -167,7 +167,18 @@ static void verify_uevent(void)
>  
>  	create_uinput_mouse();
>  
> -	SAFE_IOCTL(mouse_fd, UI_GET_SYSNAME(sizeof(sysname)), sysname);
> +	ret = ioctl(mouse_fd, UI_GET_SYSNAME(sizeof(sysname)), sysname);
> +	if (ret < 0) {
> +		if (errno == EINVAL) {
> +			tst_brk(TCONF,
> +				"kernel does not support UI_GET_SYSNAME");
> +		} else {
> +			tst_brk(TBROK,
> +				"ioctl(%d, %s,...) failed",
> +				mouse_fd, "UI_GET_SYSNAME");
> +		}
> +	}

I do wonder if it makes sense to add a fallback that reads the sysname
from /proc/bus/input/devices.

We do have the sysname as the last component of the SysFs= path.

I guess that it's probably not worth of the effort.

>  	handlers = get_input_handlers();
>  
>  	tst_res(TINFO, "Sysname: %s", sysname);
> -- 
> 1.8.3.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
