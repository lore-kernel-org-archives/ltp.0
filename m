From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Feb 2017 10:35:48 +0100
Subject: [LTP] [PATCH v2] ltp-aiodio/dio_sparse: Fix usleep in
	read_sparse()
In-Reply-To: <1486625035-31034-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <5888236A.1010702@cn.fujitsu.com>
 <1486625035-31034-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170209093451.GB12673@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> usleep(100000) sometimes leads to child process being too late
> to do the read before being killed by parent process, tune it
> to usleep(100) to make sure we do the real test in time.
> 
> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/io/ltp-aiodio/common_sparse.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/io/ltp-aiodio/common_sparse.h b/testcases/kernel/io/ltp-aiodio/common_sparse.h
> index f7f4ef4..7297319 100644
> --- a/testcases/kernel/io/ltp-aiodio/common_sparse.h
> +++ b/testcases/kernel/io/ltp-aiodio/common_sparse.h
> @@ -113,7 +113,7 @@ static void read_sparse(char *filename, int filesize)
>  	/*
>  	 * Wait for the file to appear.
>  	 */
> -	for (i = 0; i < 10000; i++) {
> +	for (i = 0; i < 10000000; i++) {
>  		fd = open(filename, O_RDONLY);
>  
>  		if (fd != -1)
> @@ -123,7 +123,7 @@ static void read_sparse(char *filename, int filesize)
>  			fprintf(stderr, "Child %i waits for '%s' to appear\n",
>  			        getpid(), filename);
>  
> -		usleep(100000);
> +		usleep(100);
>  	}

Looking at the code again, I see no reason why we can't open and
truncate the file before we start the read_sparse() children, then we
could drop this loop and just pass file descriptor to this function and
to the dio_sparse() and aiodio_sparse() as well. Or did I miss
something?

-- 
Cyril Hrubis
chrubis@suse.cz
