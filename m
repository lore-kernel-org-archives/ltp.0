From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Nov 2020 11:16:55 +0100
Subject: [LTP] [PATCH v3 2/5] fanotify: Handle supported features checks
 in setup()
In-Reply-To: <20201113164944.26101-3-pvorel@suse.cz>
References: <20201113164944.26101-1-pvorel@suse.cz>
 <20201113164944.26101-3-pvorel@suse.cz>
Message-ID: <20201119101655.GC2785@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
> index c2e185710..f4e8ac9e6 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify07.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
> @@ -195,6 +195,8 @@ static void test_fanotify(void)
>  
>  static void setup(void)
>  {
> +	fanotify_access_permissions_supported_by_kernel();
> +
>  	sprintf(fname, "fname_%d", getpid());
>  	SAFE_FILE_PRINTF(fname, "%s", fname);
>  }

Shouldn't we drop the check for EINVAL in setup_instance() as well?

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index 90cf5cb5f..b95efb998 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -64,6 +64,7 @@ static unsigned int fanotify_class[] = {
>  static int fd_notify[NUM_CLASSES][GROUPS_PER_PRIO];
>  
>  static char event_buf[EVENT_BUF_LEN];
> +static int support_exec_events;
>  
>  #define MOUNT_PATH "fs_mnt"
>  #define MNT2_PATH "mntpoint"
> @@ -451,6 +452,11 @@ static void test_fanotify(unsigned int n)
>  
>  	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
>  
> +	if (support_exec_events != 0 && tc->expected_mask_with_ignore & FAN_OPEN_EXEC) {
> +		tst_res(TCONF | TERRNO, "FAN_OPEN_EXEC not supported in kernel?");
> +		return;
> +	}
> +

Maybe we should rename the variable to "exec_events_unsupported" then
we could write:

	if (exec_events_unsupported && tc->mask & FAM_OPEN_EXEC)

Which is a bit easier to understand.

-- 
Cyril Hrubis
chrubis@suse.cz
