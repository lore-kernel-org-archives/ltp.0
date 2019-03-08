From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 8 Mar 2019 06:21:31 -0500 (EST)
Subject: [LTP] [PATCH v3] mm: rewrite mtest01 with new API
In-Reply-To: <20190308101049.21201-1-liwang@redhat.com>
References: <20190308101049.21201-1-liwang@redhat.com>
Message-ID: <2064253320.6099818.1552044091281.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Test issue:
>    mtest01 start many children to alloc chunck of memory and do write
>    page(with -w option), but occasionally some children were killed by
>    oom-killer and exit with SIGCHLD signal sending. After the parent
>    reciving this SIGCHLD signal it will report FAIL as a test result.
> 
>    It seems not a real kernel bug if something just like that, it's
>    trying to use 80% of memory and swap. Once it uses most of memory,
>    system starts swapping, but the test is likely consuming memory at
>    greater rate than kswapd can provide, which eventually triggers OOM.
> 
>    ---- FAIL LOG ----
>    mtest01     0  TINFO  :  Total memory already used on system = 1027392
>    kbytes
>    mtest01     0  TINFO  :  Total memory used needed to reach maximum =
>    12715520 kbytes
>    mtest01     0  TINFO  :  Filling up 80% of ram which is 11688128 kbytes
>    mtest01     1  TFAIL  :  mtest01.c:314: child process exited unexpectedly
>    -------------------
> 
>  Rewrite changes:
>    To make mtest01 more easier to understand, I just rewrite it into
>    LTP new API and make a little changes in children behavior.
> 
>    * decrease the pressure to 80% of free memory for testing
>    * drop the signal SIGCHLD action becasue new API help to
>    check_child_status
>    * make child pause itself after finishing their memory allocating/writing
>    * parent sends SIGCONT to make children continue and exit
>    * use TST_PROCESS_STATE_WAIT to wait child changes to 'T' state
>    * involve ALLOC_THRESHOLD to rework same code in defines
>    * to make mtest01 support running with -i N > 1
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
> 
> Notes:
>     v2 --> v3
>        * modify test description for new version
>        * move some global variables to local
>        * remove SIGCONT sending from cleanup
>        * involve ALLOC_THRESHOLD to avoid same code in defines

Hi,

looks lot more readable than original version.

Some nit-picks below / no need to re-post for that typo,
I can fix it before commit.

<snip>

> +#if defined (_s390_)
> +#define ALLOC_THRESHOLD		FIVE_HUNDRED_MB
> +#elif __WORDSIZE == 32
> +#define ALLOC_THRESHOL		(unsigned long long)(2*FIVE_HUNDRED_MB)

typo here, missing 'D'

> +#elif __WORDSIZE == 64
> +#define ALLOC_THRESHOLD		(unsigned long long)(6*FIVE_HUNDRED_MB)
> +#endif
>  
> -static void handler(int signo)
> +#define STOP_THRESHOLD 15	/* seconds remaining before reaching timeout */
> +
> +static pid_t *pid_list;
> +static sig_atomic_t pid_count;
> +static int max_pids;
> +static unsigned long long alloc_maxbytes;
> +static unsigned long long original_maxbytes;

We could use "original_maxbytes" in setup() and options(),
then alloc_maxbytes could be local variable of mem_test().

<snip> 
> +static void do_write_page(char *mem, int chunksize)
> +{
> +	int i;
>  
> -	free(pid_list);
> +	for (i = 0; i < chunksize; i++)
> +		*(mem + i) = 'a';

We could do i+=pagesize to make it slightly faster.

<snip>

> +static void child_loop_alloc(unsigned long long alloc_bytes)
> +{
> +	unsigned long bytecount = (unsigned long)chunksize;

Shouldn't this variable start at 0?

> +	char *mem;
> +
> +	while (1) {
> +		mem = SAFE_MALLOC(chunksize);
> +		if (dowrite)
> +			do_write_page(mem, chunksize);
> +
> +		if (verbose)
> +			tst_res(TINFO,
> +				"child %d allocated %lu bytes chunksize is %d",
> +				getpid(), bytecount, chunksize);
> +		bytecount += chunksize;
> +		if (bytecount >= alloc_bytes)
> +			break;
>  	}

Overall, the rewrite looks good to me.

Thanks,
Jan
