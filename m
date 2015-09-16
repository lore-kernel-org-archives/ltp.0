From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 16 Sep 2015 08:12:48 -0400 (EDT)
Subject: [LTP] [PATCH v2] lib/mem.c: handle the case oom0{3,
 5} exit with 'EAGAIN' situation
In-Reply-To: <1442397332-25347-1-git-send-email-liwang@redhat.com>
References: <1442397332-25347-1-git-send-email-liwang@redhat.com>
Message-ID: <317477236.12581685.1442405568730.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Li Wang" <liwang@redhat.com>
> To: ltp@lists.linux.it
> Sent: Wednesday, 16 September, 2015 11:55:32 AM
> Subject: [LTP] [PATCH v2] lib/mem.c: handle the case oom0{3,	5} exit with 'EAGAIN' situation
> 
> v1 --> v2
> 	1. limited the number of loops
> 	2. added the usleep(300) to wait resource freed
> 
> Sometimes oom0{3,5} failed as the following results:
> 
> oom05       0  TINFO  :  start OOM testing for mlocked pages.
> oom05       0  TINFO  :  expected victim is 3371.
> oom05       0  TINFO  :  thread (3fff788ff1c0), allocating 3221225472 bytes.
> ...
> oom05       5  TFAIL  :  mem.c:153: victim unexpectedly ended with retcode:
> 11, expected: 12
> 
> In the OOM test, that tries to consume all memory. But the test doesn't retry
> to mlock, it simply
> exits with errno returned by mlock. At the moment testcase is expecting
> either ENOMEM or getting
> killed by kernel.
> 
> Here do retry the function if mlock() fail with 'EAGAIN' errno.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/mem/lib/mem.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index 8fe4bf0..b8a55e2 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -30,6 +30,7 @@ static int alloc_mem(long int length, int testcase)
>  {
>  	char *s;
>  	long i, pagesz = getpagesize();
> +	int loop = 10;
>  
>  	tst_resm(TINFO, "thread (%lx), allocating %ld bytes.",
>  		(unsigned long) pthread_self(), length);
> @@ -39,8 +40,15 @@ static int alloc_mem(long int length, int testcase)
>  	if (s == MAP_FAILED)
>  		return errno;
>  
> -	if (testcase == MLOCK && mlock(s, length) == -1)
> -		return errno;
> +	if (testcase == MLOCK) {
> +		while (mlock(s, length) == -1 && loop > 0) {
> +			if (EAGAIN != errno)
> +				return errno;
> +			usleep(300);

usleep is in microseconds, so this wouldn't give system much time.

Other than that it looks good to me.

Regards,
Jan

> +			loop--;
> +		}
> +	}
> +
>  #ifdef HAVE_MADV_MERGEABLE
>  	if (testcase == KSM && madvise(s, length, MADV_MERGEABLE) == -1)
>  		return errno;
> --
> 1.8.3.1
> 
> 
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
> 
