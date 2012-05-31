Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Sa6V3-0006ce-Hj
	for ltp-list@lists.sourceforge.net; Thu, 31 May 2012 14:37:17 +0000
Date: Thu, 31 May 2012 16:35:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120531143531.GB3926@saboteur.suse.cz>
References: <4FBBA012.2010005@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4FBBA012.2010005@redhat.com>
Subject: Re: [LTP] [PATCH v2 3/3] syscalls/cma: add errno tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +process_vm_readv01 process_vm_readv01
> +process_vm_writev01 process_vm_writev01
> +
>  pselect01 pselect01
>  pselect01_64 pselect01_64
>
> +static char TCID_readv[] = "process_vm_readv";
> +static char TCID_writev[] = "process_vm_writev";
> +char *TCID = "cma01";
> +int  TST_TOTAL = 1;
> +static void (*cma_test_params)(struct process_vm_params *params) = NULL;
> +
> +static void setup(char *argv[]);
> +static void cleanup(void);
> +
> +static void cma_test_params_read(struct process_vm_params *params);
> +static void cma_test_params_write(struct process_vm_params *params);
> +static void cma_test_errnos();

Forgotten void in the cma_test_errnos() parameters.

> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	char *msg;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
> +	setup(argv);

Ah, branching on program name is not really clean solution. I would add
switch that would do basically the same, but that would be explicit
behavior. That is the reason why we do have a testcase name followed by
the testcase command line in runtest files. You can then have following
lines in the runtest file:

process_vm_read01 process_vm -r
process_vm_write01 process_vm -w

Or something similar.

> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		Tst_count = 0;
> +		cma_test_errnos();
> +	}
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(char *argv[])
> +{
> +	tst_require_root(NULL);
> +
> +	if (strstr(argv[0], "read") != NULL) {
> +		TCID = TCID_readv;
> +#if defined(__NR_process_vm_readv)
> +		cma_test_params = cma_test_params_read;
> +#else
> +		tst_brkm(TCONF, NULL, "process_vm_readv does not"
> +		    "exist on your system");
> +#endif
> +	} else if (strstr(argv[0], "write") != NULL) {
> +		TCID = TCID_writev;
> +#if defined(__NR_process_vm_writev)
> +		cma_test_params = cma_test_params_write;
> +#else
> +		tst_brkm(TCONF, NULL, "process_vm_writev does not"
> +		    "exist on your system");
> +#endif
> +	} else
> +		tst_brkm(TBROK, NULL, "executable name expected"
> +				" to contain either 'read' or 'write'");
> +	TEST_PAUSE;
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +}
> +
> +static void cma_test_params_read(struct process_vm_params *params)
> +{
> +	TEST(test_process_vm_readv(params->pid,
> +	    params->lvec, params->liovcnt,
> +	    params->rvec, params->riovcnt,
> +	    params->flags));
> +}
> +
> +static void cma_test_params_write(struct process_vm_params *params)
> +{
> +	TEST(test_process_vm_writev(params->pid,
> +	    params->lvec, params->liovcnt,
> +	    params->rvec, params->riovcnt,
> +	    params->flags));
> +}
> +
> +static int cma_check_ret(long expected_ret, long act_ret)
> +{
> +	int ret = 0;
> +	if (expected_ret == act_ret) {
> +		tst_resm(TPASS, "expected ret success - "
> +		    "returned value = %ld", act_ret);
> +	} else {
> +		tst_resm(TFAIL, "unexpected failure - "
> +		    "returned value = %ld, expected: %ld",
> +		    act_ret, expected_ret);
> +		ret = 1;
> +	}
> +	return ret;
> +}
> +
> +static int cma_check_errno(long expected_errno, long act_errno)
> +{
> +	int ret = 0;
> +	if (act_errno == expected_errno)
> +		tst_resm(TPASS, "expected failure - "
> +		    "returned value = %ld : %s",
> +		    act_errno, strerror(act_errno));
> +	else if (act_errno == 0) {
> +		tst_resm(TFAIL, "call succeeded unexpectedly");
> +		ret = 1;
> +	} else {
> +		tst_resm(TFAIL, "unexpected failure - "
> +		    "returned value = %ld : %s, "
> +		    "expected value = %ld : %s",
> +		    act_errno, strerror(act_errno),
> +		    expected_errno, strerror(expected_errno));
> +		ret = 2;
> +	}
> +	return ret;
> +}

This part is a little confusing. Doing return right in place instead of
setting ret variable and returning at the end of the function would make
it a little better.

Also you don't need to pass TEST_ERRNO as a parameter and it's better
printed by adding TTERRNO flag to tst_*().

> +static struct process_vm_params *cma_alloc_sane_params()
> +{
> +	struct process_vm_params *sane_params = NULL;
> +	int len;
> +
> +	len = getpagesize();
> +	sane_params = SAFE_MALLOC(tst_exit, sizeof(struct process_vm_params));
> +	sane_params->len = len;
> +	sane_params->ldummy = SAFE_MALLOC(tst_exit, len);
> +	sane_params->rdummy = SAFE_MALLOC(tst_exit, len);
> +
> +	sane_params->lvec = SAFE_MALLOC(tst_exit, sizeof(struct iovec));
> +	sane_params->lvec->iov_base = sane_params->ldummy;
> +	sane_params->lvec->iov_len = len;
> +	sane_params->liovcnt = 1;
> +
> +	sane_params->rvec = SAFE_MALLOC(tst_exit, sizeof(struct iovec));
> +	sane_params->rvec->iov_base = sane_params->rdummy;
> +	sane_params->rvec->iov_len = len;
> +	sane_params->riovcnt = 1;
> +
> +	sane_params->flags = 0;
> +	sane_params->pid = getpid();
> +
> +	return sane_params;
> +}

There is no need to pass tst_exit as cleanup fn to SAFE_*() macros.

> +static void cma_free_params(struct process_vm_params *params)
> +{
> +	if (params) {
> +		free(params->ldummy);
> +		free(params->rdummy);
> +		free(params->lvec);
> +		free(params->rvec);
> +		free(params);
> +	}
> +}
> +
> +static void cma_test_sane_params(void)
> +{
> +	struct process_vm_params *sane_params = NULL;
> +
> +	sane_params = cma_alloc_sane_params();
> +	tst_resm(TINFO, "test_sane_params");
> +	cma_test_params(sane_params);
> +	cma_check_ret(sane_params->len, TEST_RETURN);
> +	cma_free_params(sane_params);
> +}
> +
> +static void cma_test_flags(void)
> +{
> +	struct process_vm_params *params = NULL;
> +	long flags[] = { -INT_MAX, -1, 1, INT_MAX, 0 };
> +	int flags_size = sizeof(flags)/sizeof(flags[0]);
> +	int i;
> +
> +	params = cma_alloc_sane_params();
> +	for (i = 0; i < flags_size; i++) {
> +		params->flags = flags[i];
> +		tst_resm(TINFO, "test_flags, flags=%ld", flags[i]);
> +		cma_test_params(params);
> +		/* atm. only flags == 0 is allowed, everything else
> +		 * should fail with EINVAL */
> +		if (flags[i] != 0) {
> +			cma_check_ret(-1, TEST_RETURN);
> +			cma_check_errno(EINVAL, TEST_ERRNO);
> +		} else {
> +			cma_check_ret(params->len, TEST_RETURN);
> +		}
> +	}
> +	cma_free_params(params);
> +}

If I understand this correctly, this test may break in the future, once
somebody makes use of the flags?

> +static void cma_test_iov_len_overflow(void)
> +{
> +	struct process_vm_params *params = NULL;

Why are you initalizing something that gets assigned two lines of code
later? (which gets repeated in most of the tests).

> +	ssize_t maxlen = -1;
> +	params = cma_alloc_sane_params();
> +
> +	params->lvec->iov_len = maxlen;
> +	params->rvec->iov_len = maxlen;
> +	tst_resm(TINFO, "test_iov_len_overflow");
> +	cma_test_params(params);
> +	cma_check_ret(-1, TEST_RETURN);
> +	cma_check_errno(EINVAL, TEST_ERRNO);
> +	cma_free_params(params);
> +}
> +
> +static void cma_test_iov_invalid(void)
> +{
> +	struct process_vm_params *sane_params = NULL;
> +	struct process_vm_params *params;
> +	struct process_vm_params params_copy;
> +
> +	sane_params = cma_alloc_sane_params();
> +	/* make a shallow copy we can 'damage' */
> +	params = &params_copy;
> +
> +	*params = *sane_params;

Ufff, this indirection shouldn't be needed. You could do:

params_copy = *sane_params;

And then pass &params_copy to the fuctions.

> +	tst_resm(TINFO, "test_iov_invalid - lvec->iov_base");
> +	params->lvec->iov_base = (void *)-1;
> +	cma_test_params(params);
> +	cma_check_ret(-1, TEST_RETURN);
> +	cma_check_errno(EFAULT, TEST_ERRNO);
> +
> +	*params = *sane_params;
> +	tst_resm(TINFO, "test_iov_invalid - rvec->iov_base");
> +	params->rvec->iov_base = (void *)-1;
> +	cma_test_params(params);
> +	cma_check_ret(-1, TEST_RETURN);
> +	cma_check_errno(EFAULT, TEST_ERRNO);
> +
> +	*params = *sane_params;
> +	tst_resm(TINFO, "test_iov_invalid - lvec");
> +	params->lvec = (void *)-1;
> +	cma_test_params(params);
> +	cma_check_ret(-1, TEST_RETURN);
> +	cma_check_errno(EFAULT, TEST_ERRNO);
> +
> +	*params = *sane_params;
> +	tst_resm(TINFO, "test_iov_invalid - rvec");
> +	params->rvec = (void *)-1;
> +	cma_test_params(params);
> +	cma_check_ret(-1, TEST_RETURN);
> +	cma_check_errno(EFAULT, TEST_ERRNO);
> +
> +	cma_free_params(sane_params);
> +}
> +
> +static void cma_test_invalid_pid(void)
> +{
> +	int status;
> +	struct process_vm_params *params = NULL;
> +	pid_t child_pid;
> +
> +	params = cma_alloc_sane_params();
> +	tst_resm(TINFO, "test_invalid_pid");
> +	params->pid = -1;
> +	cma_test_params(params);
> +	cma_check_ret(-1, TEST_RETURN);
> +	cma_check_errno(ESRCH, TEST_ERRNO);
> +	cma_free_params(params);
> +
> +	child_pid = fork();
> +	switch (child_pid) {
> +		case -1:
> +			tst_brkm(TBROK|TERRNO, cleanup, "fork");
> +			break;
> +		case 0:
> +			exit(0);
> +		default:
> +			if (waitpid(child_pid, &status, 0) == -1)
> +				tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
> +			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> +				tst_resm(TFAIL, "child returns %d", status);
> +
> +			params = cma_alloc_sane_params();
> +			params->pid = child_pid;
> +			cma_test_params(params);
> +			cma_check_ret(-1, TEST_RETURN);
> +			cma_check_errno(ESRCH, TEST_ERRNO);
> +			cma_free_params(params);

So you expect that pid is not reused right after child has exited?

While not guaranteed, this would probably work.

Maybe even better would be to read /proc/sys/kernel/pid_max and try
value greater that that.

> +	}
> +}
> +
> +static void cma_test_invalid_perm(void)
> +{
> +	char nobody_uid[] = "nobody";
> +	struct passwd *ltpuser;
> +	int status;
> +	struct process_vm_params *params = NULL;
> +	pid_t child_pid;
> +	pid_t parent_pid;
> +	int ret = 0;
> +
> +	tst_resm(TINFO, "test_invalid_perm");
> +	parent_pid = getpid();
> +	child_pid = fork();
> +	switch (child_pid) {
> +		case -1:
> +			tst_brkm(TBROK|TERRNO, cleanup, "fork");
> +			break;
> +		case 0:
> +			ltpuser = getpwnam(nobody_uid);
> +			if (ltpuser == NULL)
> +				tst_brkm(TBROK|TERRNO, NULL,
> +				    "getpwnam failed");
> +			if (setuid(ltpuser->pw_uid) == -1)
> +				tst_brkm(TBROK|TERRNO, NULL,
> +				    "setuid(%u) failed", ltpuser->pw_uid);
> +
> +			params = cma_alloc_sane_params();
> +			params->pid = parent_pid;
> +			cma_test_params(params);
> +			ret |= cma_check_ret(-1, TEST_RETURN);
> +			ret |= cma_check_errno(EPERM, TEST_ERRNO);
> +			cma_free_params(params);
> +			exit(ret);
> +		default:
> +			if (waitpid(child_pid, &status, 0) == -1)
> +				tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
> +			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> +				tst_resm(TFAIL, "child returns %d", status);
> +	}
> +}
> +
> +static void cma_test_invalid_protection(void)
> +{
> +	struct process_vm_params *sane_params = NULL;
> +	struct process_vm_params *params;
> +	struct process_vm_params params_copy;
> +	void *p;
> +
> +	sane_params = cma_alloc_sane_params();
> +	/* make a shallow copy we can 'damage' */
> +	params = &params_copy;
> +
> +	p = mmap(NULL, getpagesize(), PROT_NONE,
> +			MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
> +	if (p == MAP_FAILED)
> +		tst_brkm(TBROK|TERRNO, cleanup, "mmap");
> +
> +	*params = *sane_params;
> +	params->lvec->iov_base = p;
> +	tst_resm(TINFO, "test_invalid_protection lvec");
> +	cma_test_params(params);
> +	cma_check_ret(-1, TEST_RETURN);
> +	cma_check_errno(EFAULT, TEST_ERRNO);
> +
> +	*params = *sane_params;
> +	params->rvec->iov_base = p;
> +	tst_resm(TINFO, "test_invalid_protection rvec");
> +	cma_test_params(params);
> +	cma_check_ret(-1, TEST_RETURN);
> +	cma_check_errno(EFAULT, TEST_ERRNO);
> +
> +	cma_free_params(sane_params);
> +}

Once again the indirection, and you aren't unmapping the memory, which
is a minor issue...

> +static void cma_test_errnos()
> +{
> +	cma_test_sane_params();
> +	cma_test_flags();
> +	cma_test_iov_len_overflow();
> +	cma_test_iov_invalid();
> +	cma_test_invalid_pid();
> +	cma_test_invalid_perm();
> +	cma_test_invalid_protection();
> +}
> diff --git a/testcases/kernel/syscalls/cma/process_vm_readv/Makefile b/testcases/kernel/syscalls/cma/process_vm_readv/Makefile
> index f10cac2..4e4633c 100644
> --- a/testcases/kernel/syscalls/cma/process_vm_readv/Makefile
> +++ b/testcases/kernel/syscalls/cma/process_vm_readv/Makefile
> @@ -19,4 +19,11 @@
>  top_srcdir              ?= ../../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
> +
> +MAKE_DEPS               := ../cma01
> +MAKE_TARGETS            += process_vm_readv01
> +
> +process_vm_readv01: ../cma01.c
> +	cp -f ../cma01 ./process_vm_readv01
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/cma/process_vm_writev/Makefile b/testcases/kernel/syscalls/cma/process_vm_writev/Makefile
> index f10cac2..6f255ec 100644
> --- a/testcases/kernel/syscalls/cma/process_vm_writev/Makefile
> +++ b/testcases/kernel/syscalls/cma/process_vm_writev/Makefile
> @@ -19,4 +19,11 @@
>  top_srcdir              ?= ../../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
> +
> +MAKE_DEPS               := ../cma01
> +MAKE_TARGETS            += process_vm_writev01
> +
> +process_vm_writev01: ../cma01.c
> +	cp -f ../cma01 ./process_vm_writev01
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk

And that is exactly thing I don't like to see, directories only with
Makefiles and binaries magically created somewhere else.

Either create one test that does different thigs when given different
parameters or split the tests in several files (and put most of the
common code in file included in both tests).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
