From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Jan 2017 14:43:52 +0100
Subject: [LTP] [PATCH 2/2] ltp-aiodio/dio_sparse: Fix usleep in
 read_sparse()
In-Reply-To: <1484818349-30539-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1484818349-30539-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1484818349-30539-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170124134351.GD29054@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/io/ltp-aiodio/common_sparse.h b/testcases/kernel/io/ltp-aiodio/common_sparse.h
> index f7f4ef4..a7f5035 100644
> --- a/testcases/kernel/io/ltp-aiodio/common_sparse.h
> +++ b/testcases/kernel/io/ltp-aiodio/common_sparse.h
> @@ -123,7 +123,7 @@ static void read_sparse(char *filename, int filesize)
>  			fprintf(stderr, "Child %i waits for '%s' to appear\n",
>  			        getpid(), filename);
>  
> -		usleep(100000);
> +		usleep(10);

Isn't 10us too small? Also we really should increase the number of the
loop iterations if we reduce the sleep as much.

>  	}
>  
>  	if (fd == -1) {
> -- 
> 1.8.4.2
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
