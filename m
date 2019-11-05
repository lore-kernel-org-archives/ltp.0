From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Nov 2019 13:58:19 +0100
Subject: [LTP] [PATCH 1/2] fanotify: Move __kernel_fsid_t definition to
 correct place
In-Reply-To: <20191105005341.19033-2-petr.vorel@gmail.com>
References: <20191105005341.19033-1-petr.vorel@gmail.com>
 <20191105005341.19033-2-petr.vorel@gmail.com>
Message-ID: <20191105125819.GB8511@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Fixes: b8aebc835 ("fanotify: Fix missing __kernel_fsid_t definition")

Looks good, one minor comment below.

> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h | 20 ++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index 435f100d8..563a4eb5b 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -116,6 +116,15 @@ struct fanotify_mark_type {
>  	const char * name;
>  };
>  
> +#ifdef HAVE_NAME_TO_HANDLE_AT
> +#ifndef __kernel_fsid_t
> +typedef struct {
> +	int	val[2];
> +} lapi_fsid_t;
> +#define __kernel_fsid_t lapi_fsid_t
> +#endif
> +#endif /* HAVE_NAME_TO_HANDLE_AT */

Can we please indent the inner ifdef/endif/define statements?

It's done by spaces after the hash, so it should look like:

#ifndef FOO
# define bar
# ifdef BAR
code comes here
and here
# endif
#endif

-- 
Cyril Hrubis
chrubis@suse.cz
