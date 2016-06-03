From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 3 Jun 2016 05:24:34 -0400 (EDT)
Subject: [LTP] [PATCH] dma_thread_diotest: Correct the number of running
 workers
In-Reply-To: <20160602135831.GA31858@localhost.localdomain>
References: <20160602135831.GA31858@localhost.localdomain>
Message-ID: <2014219793.2541042.1464945874769.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Dong Zhu" <bluezhudong@gmail.com>
> To: ltp@lists.linux.it
> Sent: Thursday, 2 June, 2016 3:58:31 PM
> Subject: [LTP] [PATCH] dma_thread_diotest: Correct the number of running workers
> 
> This test will cause Segmentation fault (core dumped) in a
> system with 20 CPUs and memory PAGESIZE is 64KB.
> Because for a 1MB buffer which could admit 1MB/PAGESIZE
> workers at most.
> 
> So the purpose of this patch is correcting the number
> of running workers in terms of actual PAGESIZE.
> 
> Signed-off-by: Dong Zhu <bluezhudong@gmail.com>

I have slightly modified commit log and pushed.

Thanks,
Jan

> ---
>  testcases/kernel/io/direct_io/dma_thread_diotest.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/io/direct_io/dma_thread_diotest.c
> b/testcases/kernel/io/direct_io/dma_thread_diotest.c
> index 39cf658..5f52dcc 100644
> --- a/testcases/kernel/io/direct_io/dma_thread_diotest.c
> +++ b/testcases/kernel/io/direct_io/dma_thread_diotest.c
> @@ -113,10 +113,10 @@
>  #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
>  			 S_IXGRP|S_IROTH|S_IXOTH)
>  #define FILECOUNT	100
> -#define MIN_WORKERS	2
> -#define MAX_WORKERS	256
>  #define PATTERN		(0xfa)
>  #define PAGE_SIZE	getpagesize()
> +#define MIN_WORKERS	2
> +#define MAX_WORKERS	(READSIZE/PAGE_SIZE)
>  
>  char *TCID = "dma_thread_diotest";
>  int TST_TOTAL = 1;
> @@ -229,6 +229,8 @@ int main(int argc, char *argv[])
>  	int i, lc;
>  
>  	workers = sysconf(_SC_NPROCESSORS_ONLN);
> +	if (workers > MAX_WORKERS)
> +		workers = MAX_WORKERS;
>  	tst_parse_opts(argc, argv, options, help);
>  
>  	setup();
> @@ -439,6 +441,6 @@ static void cleanup(void)
>  static void help(void)
>  {
>  	printf("-a align read buffer to offset <alignment>.\n");
> -	printf("-w number of worker threads, 2 (default) to 256,"
> -	       " defaults to number of cores.\n");
> +	printf("-w number of worker threads, 2 (default) to %d,"
> +	       " defaults to number of cores.\n", MAX_WORKERS);
>  }
> --
> 2.1.0
> 
> 
> --
> Best Regards,
> Dong Zhu
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
