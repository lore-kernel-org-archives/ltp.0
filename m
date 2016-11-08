From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 8 Nov 2016 10:59:06 +0100
Subject: [LTP] [PATCH 3/3] syscalls/umount03: Cleanup && Convert to new
 API
In-Reply-To: <1478170518-5952-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1478170518-5952-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1478170518-5952-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20161108095905.GE30943@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> ---
>  testcases/kernel/syscalls/umount/umount03.c | 105 +++++++++-------------------
>  1 file changed, 32 insertions(+), 73 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/umount/umount03.c b/testcases/kernel/syscalls/umount/umount03.c
> index 322005e..1ade141 100644
> --- a/testcases/kernel/syscalls/umount/umount03.c
> +++ b/testcases/kernel/syscalls/umount/umount03.c
> @@ -20,107 +20,66 @@
>   *	is not the super-user.
>   *
>   * RESTRICTIONS
> - *	test must be run with the -D option
>   *	test doesn't support -c option to run it in parallel, as mount
>   *	syscall is not supposed to run in parallel.
>   */

I've removed the whole RESTRICTIONS part of the comment since the -c
option has been removed long time ago anyway.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
