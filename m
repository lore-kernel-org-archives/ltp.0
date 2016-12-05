From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 5 Dec 2016 14:09:56 +0100
Subject: [LTP] [PATCH v4 1/1] syscalls/mq_unlink: convert to use new
 test library API
In-Reply-To: <20161202141251.26121-1-pvorel@suse.cz>
References: <20161202141251.26121-1-pvorel@suse.cz>
Message-ID: <20161205130955.GC22344@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  enum test_type {
>  	NORMAL,
>  };

Hmm enum of a single value does not really make any sense and the ttype
looks unused anway. Shouldn't we just remove it?

> +void setup(void)
> +{
> +	euid = geteuid();
> +}
>  
> -static int do_test(struct test_case *tc)
> +static void do_test(unsigned int i)
>  {
> -	int sys_ret;
> -	int sys_errno;
> -	int result = RESULT_OK;
> -	int rc, fd1 = -1, fd2 = -1;
> -	uid_t old_uid = -1;
> +	struct test_case *tc = &tcase[i];
> +	mqd_t fd;
> +	struct passwd *pw;
> +
> +	tst_res(TINFO, "queue name '%s'", tc->qname);
>  
>  	/*
>  	 * When test ended with SIGTERM etc, mq descriptor is left remains.
>  	 * So we delete it first.
>  	 */
> -	TEST(mq_unlink(QUEUE_NAME));
> +	mq_unlink(QUEUE_NAME);
>  
> -	/*
> -	 * Open message queue
> -	 */
> -	rc = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
> -	if (rc == -1) {
> -		tst_resm(TFAIL | TTERRNO, "mq_open failed");
> -		result = 1;
> +	/* prepare */
> +	fd = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
> +	if (fd == -1) {
> +		tst_res(TFAIL | TTERRNO, "mq_open failed");
                        ^
			This should rather be TBROK | TERRNO

>  		goto EXIT;
>  	}
> -	fd1 = rc;
>  
> -	/*
> -	 * Change effective user id
> -	 */
>  	if (tc->user != NULL) {
> -		TEST(rc = setup_euid(tc->user, &old_uid));
> -		if (TEST_RETURN < 0) {
> -			result = 1;
> +		pw = getpwnam(tc->user);
> +		if (!pw) {
> +			tst_res(TFAIL | TTERRNO, "getpwnam failed");
>  			goto EXIT;
>  		}
> -	}
>  
> -	/*
> -	 * Execute system call
> -	 */
> -	errno = 0;
> -	TEST(sys_ret = mq_unlink(tc->qname));
> -	sys_errno = errno;
> -	if (sys_ret >= 0)
> -		fd2 = sys_ret;
> +		if (seteuid(pw->pw_uid)) {
> +			tst_res(TFAIL | TTERRNO, "seteuid failed");
                                  ^
				  Here again TBROK | TERRNO
> +			goto EXIT;
> +		}
> +	}

The getpwnam should be done once in the setup (with SAFE_GETPWNAM()) and
instead of the username we should add a flag as_nobody in the test
structure. We may also run the test for nobody in a child process so
that we don't have to take care restoring the euid at the end of the
function.


Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
