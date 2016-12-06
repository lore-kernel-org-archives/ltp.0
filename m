From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Dec 2016 13:31:56 +0100
Subject: [LTP] [PATCH v2 1/1] syscalls/mq_open: fix old tests + convert
 to use new API
In-Reply-To: <20161206081933.6466-1-pvorel@suse.cz>
References: <20161206081933.6466-1-pvorel@suse.cz>
Message-ID: <20161206123155.GE17241@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#define FILE_SCANF(path, fmt, ...) \
> +	file_scanf(__FILE__, __LINE__, \
> +	           (path), (fmt), ## __VA_ARGS__)
>  
> -	tst_rmdir();
> -}
> +#define FILE_PRINTF(path, fmt, ...) \
> +	file_printf(__FILE__, __LINE__, \
> +	            (path), (fmt), ## __VA_ARGS__)

If needed these should rather be added into the
include/tst_safe_file_ops.h

However these versions without the SAFE_ in name (these are the ones
that will not call tst_brk()) are supposed to be used in the test
cleanup only. You are supposed to use use SAFE_MACROS() as much as
possible as that simplifies the code quite a lot...

> -static int do_test(struct test_case *tc)
> +static void do_test(unsigned int i)
>  {
> -	int sys_ret;
> -	int sys_errno;
> -	int result = RESULT_OK;
> -	int rc, fd1 = -1, fd2 = -1, cmp_ok = 1;
> -	uid_t old_uid = -1;
> -	rlim_t oldlim = -1;
> -	int oldval = -1;
> +	struct test_case *tc = &tcase[i];
> +	struct rlimit rlim;
> +	int oldlim = -1;
> +
> +	int max_queues;
> +
> +	int fd1 = -1, fd2 = -1;
>  	struct mq_attr new, old, *p_attr;
>  
> +	tst_res(TINFO, "queue name \"%s\"", tc->qname);
> +
>  	/*
>  	 * When test ended with SIGTERM etc, mq descriptor is left remains.
>  	 * So we delete it first.
>  	 */
> -	TEST(mq_unlink(QUEUE_NAME));
> +	mq_unlink(QUEUE_NAME);
>  
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
> +	if (tc->ttype != NO_SPACE &&
> +		(!(tc->oflag & O_CREAT) || tc->oflag & O_EXCL)) {
> +		TEST(fd1 = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR,
> +			S_IRWXU, NULL));
> +		if (fd1 < 0)
>  			goto TEST_END;
> -		fd1 = sys_ret;
>  	}
> +
>  	if (tc->ttype == NO_FILE) {
> -		TEST(rc = setup_ulimit_fnum(ULIMIT_FNUM, &oldlim));
> -		if (rc < 0) {
> -			result = 1;
> -			goto EXIT;
> +		if (getrlimit(RLIMIT_NOFILE, &rlim) == -1) {
> +			tst_res(TBROK | TERRNO, "getrlimit failed");
> +			goto CLEANUP;
> +		}
> +		if (rlim.rlim_cur > NOFILE_LIMIT) {
> +			oldlim = rlim.rlim_cur;
> +			rlim.rlim_cur = NOFILE_LIMIT;
> +			if (setrlimit(RLIMIT_NOFILE, &rlim) == -1) {
> +				tst_res(TBROK | TERRNO, "setrlimit %d to %ld failed",
> +						RLIMIT_NOFILE, rlim.rlim_cur);
> +				goto CLEANUP;
> +			}
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
> +		if (FILE_SCANF(PROC_MAX_QUEUES, "%d", &max_queues)) {
> +			tst_res(TBROK | TERRNO, "Read %s failed",
> +				PROC_MAX_QUEUES);
> +			goto CLEANUP;
> +		}
> +		if (FILE_PRINTF(PROC_MAX_QUEUES, "%d", 0)) {
> +			tst_res(TBROK | TERRNO, "Write %s failed",
> +				PROC_MAX_QUEUES);
> +			goto CLEANUP;
>  		}
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
> +	if (tc->as_nobody && seteuid(pw->pw_uid)) {
> +		tst_res(TBROK | TERRNO, "seteuid failed");
> +		goto CLEANUP;
>  	}
>  
> -	/*
> -	 * Execute system call
> -	 */
> -	//tst_resm(TINFO,"PATH_MAX: %d\n", PATH_MAX);
> -	//tst_resm(TINFO,"NAME_MAX: %d", NAME_MAX);
>  	p_attr = NULL;
>  	if (tc->mq_maxmsg || tc->mq_msgsize) {
>  		new.mq_maxmsg = tc->mq_maxmsg;
>  		new.mq_msgsize = tc->mq_msgsize;
>  		p_attr = &new;
>  	}
> -	errno = 0;
> +
>  	if (tc->oflag & O_CREAT)
> -		TEST(sys_ret = mq_open(tc->qname, tc->oflag, S_IRWXU, p_attr));
> +		TEST(fd2 = mq_open(tc->qname, tc->oflag, S_IRWXU, p_attr));
>  	else
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
> +		TEST(fd2 = mq_open(tc->qname, tc->oflag));
> +
> +	if (fd2 > 0 && p_attr) {
> +		if (tst_syscall(__NR_mq_getsetattr, fd2, NULL, &old) < 0) {
> +			tst_res(TFAIL | TERRNO, "mq_getsetattr failed");
> +			goto CLEANUP;
> +		}

Hmm, we should rather call mq_getattr() here, or is there a reason to
call the raw syscall instead of the library function?

> +		if (old.mq_maxmsg != new.mq_maxmsg
> +			|| old.mq_msgsize != new.mq_msgsize) {
> +			tst_res(TFAIL | TERRNO, "wrong mq_attr: "
> +				"mq_maxmsg expected %ld return %ld, "
> +				"mq_msgsize expected %ld return %ld",
> +				new.mq_maxmsg, old.mq_maxmsg, new.mq_msgsize,
> +				old.mq_msgsize);
> +			goto CLEANUP;
>  		}
> -		tst_resm(TINFO, "mq_maxmsg E:%ld,\tR:%ld", new.mq_maxmsg,
> -			 old.mq_maxmsg);
> -		tst_resm(TINFO, "mq_msgsize E:%ld,\tR:%ld", new.mq_msgsize,
> -			 old.mq_msgsize);
> -		cmp_ok = old.mq_maxmsg == new.mq_maxmsg
> -		    && old.mq_msgsize == new.mq_msgsize;
>  	}
>  
>  TEST_END:
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
> -}
> -
> -/*
> - * main()
> - */
> +	if (TEST_ERRNO != tc->err || (tc->ret < 0 && TEST_RETURN != tc->ret) ||
> +		(tc->ret >= 0 && TEST_RETURN < 0)) {
> +		tst_res(TFAIL | TTERRNO, "%s returned: %ld, "
> +			"expected: %d, expected errno: %s (%d)", tc->desc,
> +			TEST_RETURN, tc->ret, tst_strerrno(tc->err), tc->err);
> +	} else {
> +		tst_res(TPASS | TTERRNO, "%s returned: %ld", tc->desc,
> +			TEST_RETURN);
> +	}
>  
> -int main(int ac, char **av)
> -{
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
> +CLEANUP:
> +	if (tc->as_nobody && seteuid(euid) == -1)
> +		tst_res(TWARN | TERRNO, "seteuid back to %d failed", euid);
>  
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
> +	if (tc->ttype == NO_SPACE && max_queues != -1 &&
> +		FILE_PRINTF(PROC_MAX_QUEUES, "%d", max_queues))
> +		tst_res(TWARN | TERRNO, "restoring max_queues back to %d failed",
> +			max_queues);
>  
> -		}
> +	if (tc->ttype == NO_FILE && oldlim != -1) {
> +		rlim.rlim_cur = oldlim;
> +		if (setrlimit(RLIMIT_NOFILE, &rlim) == -1)
> +			tst_res(TWARN | TERRNO, "Restore limit %d back to %lu failed",
> +				RLIMIT_NOFILE, rlim.rlim_cur);
>  	}
> -	cleanup();
> -	tst_exit();
> +
> +	if (fd1 > 0 && close(fd1))
> +		tst_res(TWARN | TTERRNO, "close(fd1) failed");
> +
> +	if (fd2 > 0 && close(fd2))
> +		tst_res(TWARN | TTERRNO, "close(fd2) failed");
> +
> +	if (fd1 > 0)
> +		mq_unlink(QUEUE_NAME);
> +
> +	if (fd2 > 0 && strcmp(tc->qname, QUEUE_NAME) != 0)
> +		mq_unlink(tc->qname);
>  }

This is quite a maze of ifs and gotos. Maybe it would be a bit easier if
we used SAFE_MACROS() here much more and move the cleanup into the test
cleanup function. FYI the SAFE_CLOSE() also resets the fd to invalid
value, so we easily can do SAFE_CLOSE() at the end of the do_test()
function and if (fd > 0) close(fd); in the test cleanup function as
well.

Or alternatively we can split the test function into separate functions
per testcases.  Given that half of them needs non-trivial setup and
cleanup it may be much easier to write it that way.

> +static struct tst_test test = {
> +	.tid = "mq_open01",
> +	.tcnt = ARRAY_SIZE(tcase),
> +	.test = do_test,
> +	.needs_root = 1,
> +	.setup = setup,
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
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
