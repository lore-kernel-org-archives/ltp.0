From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 Jan 2017 11:55:29 +0100
Subject: [LTP] [PATCH v4 1/1] syscalls/mq_open: fix old tests + convert
 to use new API
In-Reply-To: <20170116133235.912-1-pvorel@suse.cz>
References: <20170116133235.912-1-pvorel@suse.cz>
Message-ID: <20170117105529.GA10880@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> ---
> Still a bit complicated, differences from suggestions on v3:
> * mq_getattr testing forced me to use goto.
> * Some tests are testing openning two file descriptors on with the same name, I
>   suppose that's a good idea.
> * I kept as_nobody as some tests are already using setup.
> * Maybe too much duplicity with cleanup.

This one looks much better nearly done.

>  enum test_type {
>  	NORMAL,
> @@ -131,307 +44,251 @@ enum test_type {
>  	NO_SPACE,
>  };
>  
> -/*
> - * Data Structure
> - */
> +#define TYPE_NAME(x) .ttype = x, .desc = #x

We now use only the tc->desc, we should get rid of the enum and
TYPE_NAME() macro and write the description directly as a string
into the test structure members.

>  struct test_case {
>  	int ttype;
> -	char *user;
> +	const char *desc;
> +	int as_nobody;
>  	char *qname;
>  	int oflag;
> -	long mq_maxmsg;		// Maximum numebr of messages.
> -	long mq_msgsize;	// Maximum message size.
> +	struct mq_attr rq;
>  	int ret;
>  	int err;
> +	void (*setup)(void);
> +	void (*cleanup)(void);
>  };
>  
> -#define ULIMIT_FNUM     0
> +#define NOFILE_LIMIT     0

I would get rid of this macro and have used 0 in the code directly. This
obfuscates the value for no good reason.

>  #define PROC_MAX_QUEUES "/proc/sys/fs/mqueue/queues_max"
>  
> -/* Test cases
> - *
> - *   test status of errors on man page
> - *
> - *   EACCES	     v (permission is denied)
> - *   EEXIST	     v (named message queue already exists)
> - *   EINTR	      --- (interrupted by a signal)
> - *   EINVAL	     v (not supported for the given name, or invalid
> - *			 arguments)
> - *   EMFILE	     v (process file table overflow)
> - *   ENAMETOOLONG       v (too long name length)
> - *   ENFILE	     can't check because it's difficult to create no-fd
> - *   ENOENT	     v (O_CREAT is not set and the named message queue
> - *			 does not exist)
> - *   ENOSPC	     v (no space for the new message queue)
> - */
> +static void create_queue(void);
> +static void unlink_queue(void);
> +static void set_rlimit(void);
> +static void restore_rlimit(void);
> +static void set_max_queues(void);
> +static void restore_max_queues(void);
>  
>  static struct test_case tcase[] = {
> -#if 1
> -	{			// case00
> -	 .ttype = NORMAL,
> -	 .qname = QUEUE_NAME,
> -	 .oflag = O_CREAT,
> -	 .mq_maxmsg = 20,
> -	 .mq_msgsize = 16384,
> -	 .ret = 0,
> -	 .err = 0,
> -	 },
> -#else
> -	{			// case00
> -	 .ttype = NORMAL,
> -	 .qname = QUEUE_NAME,
> -	 .oflag = O_CREAT,
> -	 .ret = 0,
> -	 .err = 0,
> -	 },
> -	{			// case01
> -	 .ttype = NORMAL,
> -	 //  0    1       2       3
> -	 //  0123456789012345678901234567890123456789
> -	 "aaaaaaaaaaaaaaa",
> -	 .oflag = O_CREAT,
> -	 .ret = 0,
> -	 .err = 0,
> -	 },
> -	{			// case02
> -	 .ttype = NORMAL,
> -	 //  0    1       2       3
> -	 //  0123456789012345678901234567890123456789
> -	 "aaaaaaaaaaaaaaaa",
> -	 .oflag = O_CREAT,
> -	 .ret = -1,
> -	 .err = ENAMETOOLONG,
> -	 },
> -
> -	{			// case03
> -	 .ttype = NORMAL,
> -	 .qname = "",
> -	 .oflag = O_CREAT,
> -	 .ret = -1,
> -	 .err = EINVAL,
> -	 },
> -	{			// case04
> -	 .ttype = NORMAL,
> -	 .user = "nobody",
> -	 .qname = QUEUE_NAME,
> -	 .ret = -1,
> -	 .err = EACCES,
> -	 },
> -	{			// case05
> -	 .ttype = NORMAL,
> -	 .qname = QUEUE_NAME,
> -	 .oflag = O_CREAT | O_EXCL,
> -	 .ret = -1,
> -	 .err = EEXIST,
> -	 },
> -	{			// case06
> -	 .ttype = NO_FILE,
> -	 .qname = QUEUE_NAME,
> -	 .oflag = O_CREAT,
> -	 .ret = -1,
> -	 .err = EMFILE,
> -	 },
> -	{			// case07
> -	 .ttype = NORMAL,
> -	 .qname = "/notexist",
> -	 .oflag = 0,
> -	 .ret = -1,
> -	 .err = ENOENT,
> -	 },
> -
> -	{			// case08
> -	 .ttype = NO_SPACE,
> -	 .user = "nobody",
> -	 .qname = QUEUE_NAME,
> -	 .oflag = O_CREAT,
> -	 .ret = -1,
> -	 .err = ENOSPC,
> -	 },
> -#endif
> +	{
> +		TYPE_NAME(NORMAL),
> +		.qname = QUEUE_NAME,
> +		.oflag = O_CREAT,
> +		.rq = (struct mq_attr) {.mq_maxmsg = 20, .mq_msgsize = 16384},
> +		.ret = 0,
> +		.err = 0,
> +	},
> +	{
> +		TYPE_NAME(NORMAL),
> +		.qname = QUEUE_NAME,
> +		.oflag = O_CREAT,
> +		.ret = 0,
> +		.err = 0,
> +	},
> +	{
> +		TYPE_NAME(NORMAL),
> +		.qname = "/caaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaa",
> +		.oflag = O_CREAT,
> +		.ret = 0,
> +		.err = 0,
> +	},
> +	{
> +		TYPE_NAME(NORMAL),
> +		.qname = "/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
> +			"aaaaaaaaaaaaaaaa",
> +		.oflag = O_CREAT,
> +		.ret = -1,
> +		.err = ENAMETOOLONG,
> +	},
> +
> +	{
> +		TYPE_NAME(NORMAL),
> +		.qname = "",
> +		.oflag = O_CREAT,
> +		.ret = -1,
> +		.err = EINVAL,
> +	},
> +	{
> +		TYPE_NAME(NORMAL),
> +		.as_nobody = 1,
> +		.qname = QUEUE_NAME,
> +		.ret = -1,
> +		.err = EACCES,
> +		.setup = create_queue,
> +		.cleanup = unlink_queue,
> +	},
> +	{
> +		TYPE_NAME(NORMAL),
> +		.qname = QUEUE_NAME,
> +		.oflag = O_CREAT | O_EXCL,
> +		.ret = -1,
> +		.err = EEXIST,
> +		.setup = create_queue,
> +		.cleanup = unlink_queue,
> +	},
> +	{
> +		TYPE_NAME(NO_FILE),
> +		.qname = QUEUE_NAME,
> +		.oflag = O_CREAT,
> +		.ret = -1,
> +		.err = EMFILE,
> +		.setup = set_rlimit,
> +		.cleanup = restore_rlimit,
> +	},
> +	{
> +		TYPE_NAME(NORMAL),
> +		.qname = "/notexist",
> +		.oflag = 0,
> +		.ret = -1,
> +		.err = ENOENT,
> +	},
> +	{
> +		TYPE_NAME(NO_SPACE),
> +		.as_nobody = 1,
> +		.qname = QUEUE_NAME,
> +		.oflag = O_CREAT,
> +		.ret = -1,
> +		.err = ENOSPC,
> +		.setup = set_max_queues,
> +		.cleanup = restore_max_queues,
> +	}
>  };
>  
> -/*
> - * do_test()
> - *
> - *   Input  : TestCase Data
> - *   Return : RESULT_OK(0), RESULT_NG(1)
> - *
> - */
> +static void create_queue(void)
> +{
> +	fd2 = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
> +	if (fd2 == -1)
> +		tst_brk(TBROK | TERRNO, "mq_open(" QUEUE_NAME ") failed");
> +}
>  
> -static int do_test(struct test_case *tc)
> +static void unlink_queue(void)
>  {
> -	int sys_ret;
> -	int sys_errno;
> -	int result = RESULT_OK;
> -	int rc, fd1 = -1, fd2 = -1, cmp_ok = 1;
> -	uid_t old_uid = -1;
> -	rlim_t oldlim = -1;
> -	int oldval = -1;
> -	struct mq_attr new, old, *p_attr;
> -
> -	/*
> -	 * When test ended with SIGTERM etc, mq descriptor is left remains.
> -	 * So we delete it first.
> -	 */
> -	TEST(mq_unlink(QUEUE_NAME));
> -
> -	/*
> -	 * Execute system call
> -	 */
> -
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
> -	if (tc->ttype == NO_FILE) {
> -		TEST(rc = setup_ulimit_fnum(ULIMIT_FNUM, &oldlim));
> -		if (rc < 0) {
> -			result = 1;
> -			goto EXIT;
> -		}
> -	}
> +	if (fd2 > 0)
> +		SAFE_CLOSE(fd2);
>  
> -	/*
> -	 * Change /proc/sys/fs/mqueue/queues_max
> -	 */
> -	if (tc->ttype == NO_SPACE) {
> -		TEST(rc = setup_proc_fs(PROC_MAX_QUEUES, 0, &oldval));
> -		if (rc < 0) {
> -			result = 1;
> -			goto EXIT;
> -		}
> -	}
> +	if (mq_unlink(QUEUE_NAME))
> +		tst_brk(TBROK | TERRNO, "mq_close(" QUEUE_NAME ") failed");
> +}
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
> -	}
>  
> -	/*
> -	 * Execute system call
> -	 */
> -	//tst_resm(TINFO,"PATH_MAX: %d\n", PATH_MAX);
> -	//tst_resm(TINFO,"NAME_MAX: %d", NAME_MAX);
> -	p_attr = NULL;
> -	if (tc->mq_maxmsg || tc->mq_msgsize) {
> -		new.mq_maxmsg = tc->mq_maxmsg;
> -		new.mq_msgsize = tc->mq_msgsize;
> -		p_attr = &new;
> -	}
> -	errno = 0;
> -	if (tc->oflag & O_CREAT)
> -		TEST(sys_ret = mq_open(tc->qname, tc->oflag, S_IRWXU, p_attr));
> -	else
> -		TEST(sys_ret = mq_open(tc->qname, tc->oflag));
> -	sys_errno = errno;
> -	if (sys_ret < 0)
> -		goto TEST_END;
> -	fd2 = sys_ret;
> -
> -	if (p_attr) {
> -		TEST(rc = ltp_syscall(__NR_mq_getsetattr, fd2, NULL, &old));
> -		if (TEST_RETURN < 0) {
> -			tst_resm(TFAIL,
> -				 "mq_getsetattr failed - errno = %d : %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -			result = 1;
> -			goto EXIT;
> -		}
> -		tst_resm(TINFO, "mq_maxmsg E:%ld,\tR:%ld", new.mq_maxmsg,
> -			 old.mq_maxmsg);
> -		tst_resm(TINFO, "mq_msgsize E:%ld,\tR:%ld", new.mq_msgsize,
> -			 old.mq_msgsize);
> -		cmp_ok = old.mq_maxmsg == new.mq_maxmsg
> -		    && old.mq_msgsize == new.mq_msgsize;
> +static void set_max_queues(void)
> +{
> +	SAFE_FILE_SCANF(PROC_MAX_QUEUES, "%d", &max_queues);
> +	SAFE_FILE_PRINTF(PROC_MAX_QUEUES, "%d", 0);
> +}
> +
> +static void restore_max_queues(void)
> +{
> +	SAFE_FILE_PRINTF(PROC_MAX_QUEUES, "%d", max_queues);
> +}
> +
> +static void set_rlimit(void)
> +{
> +	if (rlim.rlim_cur > NOFILE_LIMIT) {
> +		oldlim = rlim.rlim_cur;
> +		rlim.rlim_cur = NOFILE_LIMIT;
> +		SAFE_SETRLIMIT(RLIMIT_NOFILE, &rlim);

I guess that declaring new rlimit structure here, initializing it and
passing it to setrlimit() would be a bit cleaner than messing up with
the saved value.

>  	}
> +}
>  
> -TEST_END:
> -	/*
> -	 * Check results
> -	 */
> -	result |= (sys_errno != tc->err) || !cmp_ok;
> -	PRINT_RESULT_CMP(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno,
> -			 cmp_ok);
> -
> -EXIT:
> -	if (tc->user != NULL && old_uid != -1)
> -		TEST(cleanup_euid(old_uid));
> -
> -	if (tc->ttype == NO_SPACE && oldval != -1)
> -		TEST(cleanup_proc_fs(PROC_MAX_QUEUES, oldval));
> -
> -	if (tc->ttype == NO_FILE && oldlim != -1)
> -		TEST(cleanup_ulimit_fnum(oldlim));
> -	if (fd1 >= 0)
> -		TEST(close(fd1));
> -	if (fd2 >= 0)
> -		TEST(close(fd2));
> -	if (fd1 >= 0)
> -		TEST(mq_unlink(QUEUE_NAME));
> -	if (fd2 >= 0 && strcmp(tc->qname, QUEUE_NAME) != 0)
> -		TEST(mq_unlink(tc->qname));
> -
> -	return result;
> +static void restore_rlimit(void)
> +{
> +	rlim.rlim_cur = oldlim;
> +	SAFE_SETRLIMIT(RLIMIT_NOFILE, &rlim);
>  }
>  
> -/*
> - * main()
> - */
> +static void setup(void)
> +{
> +	euid = geteuid();
> +	pw = SAFE_GETPWNAM("nobody");
> +	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlim);
> +}
>  
> -int main(int ac, char **av)
> +static void cleanup(void)
>  {
> -	int result = RESULT_OK;
> -	int i;
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> -		tst_count = 0;
> -		for (testno = 0; testno < TST_TOTAL; ++testno) {
> -
> -			/*
> -			 * Execute test
> -			 */
> -			for (i = 0; i < (int)ARRAY_SIZE(tcase); i++) {
> -				int ret;
> -				tst_resm(TINFO, "(case%02d) START", i);
> -				ret = do_test(&tcase[i]);
> -				tst_resm(TINFO, "(case%02d) END => %s", i,
> -					 (ret == 0) ? "OK" : "NG");
> -				result |= ret;
> -			}
> -
> -			/*
> -			 * Check results
> -			 */
> -			switch (result) {
> -			case RESULT_OK:
> -				tst_resm(TPASS, "mq_open call succeeded ");
> -				break;
> -
> -			default:
> -				tst_brkm(TFAIL | TTERRNO, cleanup,
> -					 "mq_open failed");
> -				break;
> -			}
> +	if (fd > 0)
> +		mq_close(fd);
>  
> +	if (fd2 > 0)
> +		mq_close(fd2);
> +
> +	mq_unlink(qname);
> +}
> +
> +static void do_test(unsigned int i)
> +{
> +	struct test_case *tc = &tcase[i];
> +	struct mq_attr oldattr;
> +
> +	qname = tc->qname;
> +	oldlim = fd = fd2 = -1;
> +
> +	tst_res(TINFO, "queue name \"%s\"", qname);
> +
> +	if (tc->setup)
> +		tc->setup();
> +
> +	if (tc->as_nobody)
> +		SAFE_SETEUID(pw->pw_uid);

I would have moved the SETEUID() into the tc->setup() and tc->cleanup()
as well.

> +	TEST(fd = mq_open(qname, tc->oflag, S_IRWXU,
> +			tc->rq.mq_maxmsg || tc->rq.mq_msgsize ? &tc->rq : NULL));

This is still much more complicated than it could be. If the tc->rq was
a pointer we could have either initialized it with an anonymous
structure or keeping uninitialized which would eqnd up as NULL. Then we
could simply do:

struct tcase {
	...
        struct mq_attr *mq;
	...
} tcases[] = {
        {
	 ...
	 .mq = &(struct mq_attr){.mq_maxmsg = 20, .mq_msgsize = 16384}
	 ...
	}
};

fd = mq_open(qname, tc->oflag, S_IRWXU, tc->rq);

> +	if (fd > 0 && (tc->rq.mq_maxmsg || tc->rq.mq_msgsize)) {

This could be then:

	if (fd > 0 && tc->rq) {
		...

> +		if (mq_getattr(fd, &oldattr) < 0) {
> +			tst_res(TFAIL | TERRNO, "mq_getattr failed");
> +			goto CLEANUP;
> +		}
> +
> +		if (oldattr.mq_maxmsg != tc->rq.mq_maxmsg
> +			|| oldattr.mq_msgsize != tc->rq.mq_msgsize) {
> +			tst_res(TFAIL | TERRNO, "wrong mq_attr: "
> +				"mq_maxmsg expected %ld return %ld, "
> +				"mq_msgsize expected %ld return %ld",
> +				tc->rq.mq_maxmsg, oldattr.mq_maxmsg, tc->rq.mq_msgsize,
> +				oldattr.mq_msgsize);
> +			goto CLEANUP;
>  		}
>  	}
> -	cleanup();
> -	tst_exit();
> +
> +	if (TEST_ERRNO != tc->err || (tc->ret < 0 && TEST_RETURN != tc->ret) ||
> +		(tc->ret >= 0 && TEST_RETURN < 0)) {
> +		tst_res(TFAIL | TTERRNO, "%s returned: %ld, "
> +			"expected: %d, expected errno: %s (%d)", tc->desc,
> +			TEST_RETURN, tc->ret, tst_strerrno(tc->err), tc->err);
> +	} else {
> +		tst_res(TPASS | TTERRNO, "%s returned: %ld", tc->desc, TEST_RETURN);
> +	}

I would have broken this checks into possitive cases and negative cases, i.e.

	if (tc->ret == 0) {
		if (TEST_RETURN)
			... FAILED
		else
			... PASSED

		goto cleanup;
	}

	if (tc->ret != TEST_RETURN)
		... FAILED wrong return code

	if (TEST_ERRNO != tc->err)
		... FAILED unexpectedly expected errno XYZ

cleanup:

	...
> +CLEANUP:
> +	if (tc->as_nobody)
> +		SAFE_SETEUID(euid);
> +
> +	if (tc->cleanup)
> +		tc->cleanup();
> +
> +	if (TEST_RETURN != -1) {
> +		if (fd > 0)
> +			SAFE_CLOSE(fd);
> +		mq_unlink(qname);
> +	}
>  }
> +
> +static struct tst_test test = {
> +	.tid = "mq_open01",
> +	.tcnt = ARRAY_SIZE(tcase),
> +	.test = do_test,
> +	.needs_root = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};
> diff --git a/testcases/kernel/syscalls/utils/common_j_h.c b/testcases/kernel/syscalls/utils/common_j_h.c
> index 43165ca20..dbdbc117a 100644
> --- a/testcases/kernel/syscalls/utils/common_j_h.c
> +++ b/testcases/kernel/syscalls/utils/common_j_h.c
> @@ -227,113 +227,6 @@ int cleanup_swapfile(char *path)
>  	return 0;
>  }
>  
> -/*
> - * Change user limit that the calling process can open
> - */
> -int setup_ulimit_fnum(rlim_t newlim, rlim_t * oldlim)
> -{
> -	int rc;
> -	struct rlimit rlim;
> -
> -	rc = getrlimit(RLIMIT_NOFILE, &rlim);
> -	if (rc < 0) {
> -		EPRINTF("getrlimit failed.\n");
> -		return -1;
> -	}
> -	*oldlim = rlim.rlim_cur;
> -	if (newlim > rlim.rlim_max) {
> -		EPRINTF("can't set ulimit value: %ld.\n", newlim);
> -		return -1;
> -	}
> -	rlim.rlim_cur = newlim;
> -	rc = setrlimit(RLIMIT_NOFILE, &rlim);
> -	if (rc < 0) {
> -		EPRINTF("setrlimit failed.\n");
> -		return -1;
> -	}
> -	return 0;
> -}
> -
> -int cleanup_ulimit_fnum(rlim_t oldlim)
> -{
> -	int rc;
> -	struct rlimit rlim;
> -
> -	rc = getrlimit(RLIMIT_NOFILE, &rlim);
> -	if (rc < 0) {
> -		EPRINTF("getrlimit failed.\n");
> -		return -1;
> -	}
> -	if (oldlim > rlim.rlim_max) {
> -		EPRINTF("can't set ulimit value: %ld.\n", oldlim);
> -		return -1;
> -	}
> -	rlim.rlim_cur = oldlim;
> -	rc = setrlimit(RLIMIT_NOFILE, &rlim);
> -	if (rc < 0) {
> -		EPRINTF("setrlimit failed.\n");
> -		return -1;
> -	}
> -	return 0;
> -}
> -
> -/*
> - * Change /proc or /sys setting
> - */
> -int setup_proc_fs(char *path, int newval, int *oldval)
> -{
> -	int fd = -1, rc, len;
> -	char buf[32];
> -
> -	fd = open(path, O_RDWR);
> -	if (fd < 0) {
> -		EPRINTF("open %s failed.\n", path);
> -		return -1;
> -	}
> -
> -	do {
> -		rc = read(fd, buf, 32);
> -	} while (rc < 0 && errno == EAGAIN);
> -	if (rc < 0) {
> -		EPRINTF("read failed.\n");
> -		close(fd);
> -		return -1;
> -	}
> -
> -	*oldval = atoi(buf);
> -	sprintf(buf, "%d\n", newval);
> -	len = strlen(buf);
> -	rc = write(fd, buf, len);
> -	close(fd);
> -	if (rc != len) {
> -		EPRINTF("write failed.\n");
> -		return -1;
> -	}
> -	return 0;
> -}
> -
> -int cleanup_proc_fs(char *path, int oldval)
> -{
> -	int fd = -1, rc, len;
> -	char buf[32];
> -
> -	fd = open(path, O_RDWR);
> -	if (fd < 0) {
> -		EPRINTF("open %s failed.\n", path);
> -		return -1;
> -	}
> -
> -	sprintf(buf, "%d\n", oldval);
> -	len = strlen(buf);
> -	rc = write(fd, buf, len);
> -	close(fd);
> -	if (rc != len) {
> -		EPRINTF("write failed.\n");
> -		return -1;
> -	}
> -	return 0;
> -}
> -
>  #if 0
>  /*
>   * Check max nodes from /sys/devices/system/node/node* files (for NUMA)
> diff --git a/testcases/kernel/syscalls/utils/include_j_h.h b/testcases/kernel/syscalls/utils/include_j_h.h
> index ff6aaf42d..742d96401 100644
> --- a/testcases/kernel/syscalls/utils/include_j_h.h
> +++ b/testcases/kernel/syscalls/utils/include_j_h.h
> @@ -135,12 +135,6 @@ int cleanup_file(char *path);
>  int setup_swapfile(char *testdir, char *fname, char *path, size_t size);
>  int cleanup_swapfile(char *path);
>  
> -int setup_ulimit_fnum(rlim_t newlim, rlim_t *oldlim);
> -int cleanup_ulimit_fnum(rlim_t oldlim);
> -
> -int setup_proc_fs(char *path, int newval, int *oldval);
> -int cleanup_proc_fs(char *path, int oldval);
> -
>  #define QUEUE_NAME	"/test_mqueue"
>  pid_t create_echo_msg_proc(void);
>  
> -- 
> 2.11.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz
