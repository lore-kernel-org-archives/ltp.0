From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 22 Jun 2021 14:40:45 +0100
Subject: [LTP] [PATCH v2 3/3] tst_cgroup: make use of alias in
 safe_cgroup_has
In-Reply-To: <20210622122538.402907-3-liwang@redhat.com>
References: <20210622122538.402907-1-liwang@redhat.com>
 <20210622122538.402907-3-liwang@redhat.com>
Message-ID: <87a6ni586a.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

> This is to fix the check issue of 'memory.swap.max' on CGroup v1.
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  lib/tst_cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 18e3b6169..61cc02fa7 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -1010,7 +1010,7 @@ int safe_cgroup_has(const char *const file, const int lineno,
>  		if (!(alias = cgroup_file_alias(cfile, *dir)))
>  		    continue;
>  
> -		if (!faccessat((*dir)->dir_fd, file_name, F_OK, 0))

Ah, dumb mistake by me!

> +		if (!faccessat((*dir)->dir_fd, alias, F_OK, 0))
>  			return 1;
>  
>  		if (errno == ENOENT)

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.
