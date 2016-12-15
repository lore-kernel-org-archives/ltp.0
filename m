From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Dec 2016 14:52:34 +0100
Subject: [LTP] [PATCH v3 2/2] syscalls/mq_open: fix old tests + convert
 to use new API
In-Reply-To: <20161210202909.22260-2-pvorel@suse.cz>
References: <20161210202909.22260-1-pvorel@suse.cz>
 <20161210202909.22260-2-pvorel@suse.cz>
Message-ID: <20161215135234.GA16771@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Hope it's not too complicated. cleanup(void) doesn't use any SAFE_* function, that's why they're two functions.

This version is better, but still more complicated than it could be.

> -	/*
> -	 * Execute system call
> -	 */
> +static void setup_n(unsigned int i)
> +{
> +	struct test_case *tc = &tcase[i];
>  
> -	if (tc->ttype != NO_SPACE && !(tc->oflag & O_CREAT)) {
> -		errno = 0;
> -		TEST(sys_ret =
> -		     mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU,
> -			     NULL));
> -		sys_errno = errno;
> -		if (sys_ret < 0)
> -			goto TEST_END;
> -		fd1 = sys_ret;
> -	}
>  	if (tc->ttype == NO_FILE) {
> -		TEST(rc = setup_ulimit_fnum(ULIMIT_FNUM, &oldlim));
> -		if (rc < 0) {
> -			result = 1;
> -			goto EXIT;
> +		SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlim);

We can get the rlimit once in the test setup.

> +		if (rlim.rlim_cur > NOFILE_LIMIT) {
> +			oldlim = rlim.rlim_cur;
> +			rlim.rlim_cur = NOFILE_LIMIT;
> +			SAFE_SETRLIMIT(RLIMIT_NOFILE, &rlim);
>  		}
>  	}
>  
> -	/*
> -	 * Change /proc/sys/fs/mqueue/queues_max
> -	 */
>  	if (tc->ttype == NO_SPACE) {
> -		TEST(rc = setup_proc_fs(PROC_MAX_QUEUES, 0, &oldval));
> -		if (rc < 0) {
> -			result = 1;
> -			goto EXIT;
> -		}
> +		SAFE_FILE_SCANF(PROC_MAX_QUEUES, "%d", &max_queues);

Here as well, we can read the max_queues fil,e once in the test setup.

> +		SAFE_FILE_PRINTF(PROC_MAX_QUEUES, "%d", 0);
>  	}
>  
> -	/*
> -	 * Change effective user id
> -	 */
> -	if (tc->user != NULL) {
> -		TEST(rc = setup_euid(tc->user, &old_uid));
> -		if (rc < 0) {
> -			result = 1;
> -			goto EXIT;
> -		}
> +	if (tc->as_nobody)
> +		SAFE_SETEUID(pw->pw_uid);
> +}

Looking at the code now, it may be clearer to add a setup() and
cleanup() function pointers to the test structure and split the
setup/cleanup per testcase so that we don't have to switch on tc->ttype.

> +static void cleanup(void)
> +{
> +	if (max_queues != -1 && FILE_PRINTF(PROC_MAX_QUEUES, "%d", max_queues))
> +		tst_res(TWARN | TERRNO, "restoring max_queues back to %d failed",
> +			max_queues);
> +
> +	if (fd1 > 0)
> +		close(fd1);
> +	if (fd2 > 0)
> +		close(fd2);
> +
> +	mq_unlink(QUEUE_NAME);
> +	if (strcmp(qname, QUEUE_NAME) != 0)
> +		mq_unlink(qname);
> +}
> +
> +static void cleanup_n(unsigned int i)
> +{
> +	struct test_case *tc = &tcase[i];
> +
> +	if (tc->as_nobody)
> +		SAFE_SETEUID(euid);
> +
> +	if (oldlim != -1) {
> +		rlim.rlim_cur = oldlim;
> +		SAFE_SETRLIMIT(RLIMIT_NOFILE, &rlim);
>  	}
>  
> +	if (fd1 > 0)
> +		SAFE_CLOSE(fd1);
> +	if (fd2 > 0)
> +		SAFE_CLOSE(fd2);
> +
> +	cleanup();
> +}
> +
> +static void do_test(unsigned int i)
> +{
> +	struct test_case *tc = &tcase[i];
> +	struct mq_attr oldattr;
> +
> +	qname = tc->qname;
> +	max_queues = oldlim = fd1 = fd2 = -1;
> +
> +	tst_res(TINFO, "queue name \"%s\"", qname);
> +
>  	/*
> -	 * Execute system call
> +	 * When test ended with SIGTERM etc, mq descriptor is left remains.
> +	 * So we delete it first.
>  	 */
> -	//tst_resm(TINFO,"PATH_MAX: %d\n", PATH_MAX);
> -	//tst_resm(TINFO,"NAME_MAX: %d", NAME_MAX);
> -	p_attr = NULL;
> -	if (tc->mq_maxmsg || tc->mq_msgsize) {
> -		new.mq_maxmsg = tc->mq_maxmsg;
> -		new.mq_msgsize = tc->mq_msgsize;
> -		p_attr = &new;
> +	mq_unlink(QUEUE_NAME);
> +
> +	if (tc->ttype != NO_SPACE &&
> +		(!(tc->oflag & O_CREAT) || tc->oflag & O_EXCL)) {
> +		TEST(fd1 = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR,
> +			S_IRWXU, NULL));
> +		if (fd1 < 0)
> +			goto TEST_END;
>  	}

> +
> +	setup_n(i);
> +
>  	if (tc->oflag & O_CREAT)
> -		TEST(sys_ret = mq_open(tc->qname, tc->oflag, S_IRWXU, p_attr));
> +		TEST(fd2 = mq_open(qname, tc->oflag, S_IRWXU,
> +			tc->rq.mq_maxmsg || tc->rq.mq_msgsize ? &tc->rq : NULL));

I'm still puzzled by this part.

Why can't we just do setup() and cleanup() for each of the
testcases, instead of this trickery?

The first three testcases in struct testcase just need to unlink the
queue in the test specific cleanup.

The fourth and fift (ENAMETOOLONG and EINVAL) does not need any setup
nor cleanup.

The sixth (EACCESS) needs setup and cleanup with SAFE_SETEUID().

The seventh (EEXISTS) needs setup that creates the queue and cleanup
that unlinks it.

The eighth (EMFILE) needs setup and cleanup with setrlimit().

The tenth (ENOENT) does not need any setup nor cleanup.

The eleventh (ENOSPC) needs cleanup and setup that writes the file in /proc/sys/.


And the test function could just then be simple TEST(fd = mq_open(...))
and comparsion of the TEST_RETURN and TEST_ERRNO with the expected
return and errno.

Something as:

static void unlink_queue(void)
{
	if (mq_unlink(QUEUE_NAME))
		tst_brk(TBROK | TERRNO, "mq_unlink(" QUEUE_NAME ") failed");
}

static void create_queue(void)
{
	if (mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL))
		tst_brk(TBROK | TERRNO, "mq_open(" QUEUE_NAME ") failed");
}

static struct tcase {
	char *qname,
	int oflags,
	struct mq_attr *attr,
	int exp_ret,
	int exp_errno,
	void (*setup)(void),
	void (*cleanup)(void),
} tcases[] = {
	{
		.qname = QUEUE_NAME,
		.oflag = O_CREAT,
		.exp_ret = 0,
		.exp_errno = 0,
		.cleanup = unlink_queue,
	},
	...
	{
		.qname = QUEUE_NAME
		.oflag = O_CREAT | O_EXCL,
		.exp_ret = -1,
		.exp_errno = EEXIST,
		.setup = create_queue,
		.cleanup = unlink_queue,
	}
};

static void do_test(unsigned int i)
{
	struct tcase *tc = tcases[i];

	if (tc->setup)
		tc->setup();


	TEST(mq_open(tc->qname, ...));

	...


	if (tc->cleanup)
		tc->cleanup();
}

Or do I miss something and there is a reason why we can't write the test
this way?

-- 
Cyril Hrubis
chrubis@suse.cz
