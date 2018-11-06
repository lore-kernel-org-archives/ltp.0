From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Nov 2018 13:50:15 +0100
Subject: [LTP] [PATCH 1/1] syscalls/fanotify10: Require kernel v4.19
In-Reply-To: <20181106124802.27170-1-pvorel@suse.cz>
References: <20181106124802.27170-1-pvorel@suse.cz>
Message-ID: <20181106125015.GB4834@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> FAN_MARK_INODE and FAN_MARK_MOUNT were added in v4.19-rc2:
> d54f4fba889b fanotify: add API to attach/detach super block mark
> 
> Fixes: 16f127f4a syscalls/fanotify10: new test for mount ignore mask

I would slightly prefer handling whatever error we get from fanotify so
that the test would also work in a case that the functionality would get
backported to older kernel. But if that's not easily done we may as well
go for the kernel version detection.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify10.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index 2b96de2f1..bfc60cf89 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -298,7 +298,8 @@ static struct tst_test test = {
>  	.mount_device = 1,
>  	.mntpoint = MOUNT_PATH,
>  	.needs_tmpdir = 1,
> -	.needs_root = 1
> +	.needs_root = 1,
> +	.min_kver = "4.19",
>  };
>  
>  #else
> -- 
> 2.19.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
