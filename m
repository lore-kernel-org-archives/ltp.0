From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 17:15:33 +0100
Subject: [LTP] [PATCH V2 18/32] guard mallocopt() with __GLIBC__
In-Reply-To: <1452302060-103643-18-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-18-git-send-email-raj.khem@gmail.com>
Message-ID: <20160202161533.GI19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> ---
>  utils/benchmark/ebizzy-0.3/ebizzy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c b/utils/benchmark/ebizzy-0.3/ebizzy.c
> index 5bb8eff..934d951 100644
> --- a/utils/benchmark/ebizzy-0.3/ebizzy.c
> +++ b/utils/benchmark/ebizzy-0.3/ebizzy.c
> @@ -215,10 +215,10 @@ static void read_options(int argc, char *argv[])
>  			"\"never mmap\" option specified\n");
>  		usage();
>  	}
> -
> +#ifdef __GLIBC__
>  	if (never_mmap)
>  		mallopt(M_MMAP_MAX, 0);
> -
> +#endif

Silently ignoring user switches is not a good practice. You should at
least print warning that the functionality is not supported.

-- 
Cyril Hrubis
chrubis@suse.cz
