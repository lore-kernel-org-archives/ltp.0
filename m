Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZNMOf-0001J1-U5
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2015 14:43:53 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZNMOd-0005OP-DQ
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2015 14:43:53 +0000
Date: Thu, 6 Aug 2015 16:43:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150806144327.GB19339@rei.suse.de>
References: <1437986018-8279-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1437986018-8279-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2] fcntl/fcntl33.c: add new test
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
To: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +/*
> + * MIN_TIME_LIMIT is defined to 5 senconds as a minimal acceptable
> + * amount of time for the lease breaker waitting for unblock, if the
> + * lease breaker is unblocked within MIN_TIME_LIMIT we may consider
> + * that the feature of the lease mechanism works well.
> + */
> +#define MIN_TIME_LIMIT	5
> +
> +#define OP_OPEN_RDONLY	0
> +#define OP_OPEN_WRONLY	1
> +#define OP_OPEN_RDWR	2
> +#define OP_TRUNCATE	3
> +
> +#define FILE_MODE	(S_IRWXU | S_IRWXG | S_IRWXO | S_ISUID | S_ISGID)
> +#define PATH_LS_BRK_T	"/proc/sys/fs/lease-break-time"
> +
> +static void setup(void);
> +static void do_test(int);
> +static int do_child(int);
> +static void sighandler(int);
> +static void cleanup(void);
> +
> +static int fd;
> +static int ls_brk_t;
> +static volatile int lease;
> +
> +static struct test_case_t {
> +	int lease_type;
> +	int op_type;
> +	char *string;
              ^
	      This is nice example how we shouldn't name variables.

	What about 'desc' or something that actually says more about
	what is the string used for?

> +} test_cases[] = {
> +	{F_WRLCK, OP_OPEN_RDONLY, "open() O_RDONLY conflicts with F_WRLCK"},
> +	{F_WRLCK, OP_OPEN_WRONLY, "open() O_WRONLY conflicts with F_WRLCK"},
> +	{F_WRLCK, OP_OPEN_RDWR, "open() O_RDWR conflicts with F_WRLCK"},
> +	{F_WRLCK, OP_TRUNCATE, "truncate() conflicts with F_WRLCK"},
> +	{F_RDLCK, OP_OPEN_WRONLY, "open() O_WRONLY conflicts with O_RDLCK"},
> +	{F_RDLCK, OP_OPEN_RDWR, "open() O_RDWR conflicts with O_RDLCK"},
> +	{F_RDLCK, OP_TRUNCATE, "truncate() conflicts with F_RDLCK"},
> +};
> +
> +char *TCID = "fcntl33";
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	int tc;
> +	long type;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	setup();
> +
> +	switch ((type = tst_fs_type(cleanup, "."))) {
> +	case TST_NFS_MAGIC:
> +	case TST_RAMFS_MAGIC:
> +	case TST_TMPFS_MAGIC:
> +		tst_brkm(TCONF, cleanup,
> +			"Cannot do fcntl on a file on %s filesystem",

Here as well, please include what kind of fcntl these do not support.

> +			tst_fs_type_name(type));
> +		break;

No need for the break here as tst_brkm() does not return (calls exit()).

> +	default:
> +		break;
> +	}
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		for (tc = 0; tc < TST_TOTAL; tc++)
> +			do_test(tc);
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	/* Backup the lease-break-time. */
> +	SAFE_FILE_SCANF(NULL, PATH_LS_BRK_T, "%d", &ls_brk_t);
> +	SAFE_FILE_PRINTF(NULL, PATH_LS_BRK_T, "%d", 45);
> +
> +	tst_tmpdir();
> +
> +	TST_CHECKPOINT_INIT(tst_rmdir);
> +
> +	SAFE_TOUCH(cleanup, "file", FILE_MODE, NULL);
> +
> +	TEST_PAUSE;
> +}
> +
> +static void do_test(int i)
> +{
> +	pid_t cpid;
> +
> +	cpid = FORK_OR_VFORK();

Never use FORK_OR_VFORK() in testcases that are not ported to uclinux.
You should use tst_fork() instead.

> +	if (cpid < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "fork(2) failed");
> +
> +	if (cpid == 0)
> +		do_child(i);
> +
> +	fd = SAFE_OPEN(cleanup, "file", O_RDONLY);
> +
> +	lease = test_cases[i].lease_type;
> +
> +	TEST(fcntl(fd, F_SETLEASE, lease));
> +	if (TEST_RETURN == -1) {
> +		tst_resm(TFAIL | TTERRNO, "fcntl(2) failed to set lease");
> +		SAFE_WAITPID(cleanup, cpid, NULL, 0);
> +		SAFE_CLOSE(cleanup, fd);
> +		fd = 0;
> +		return;
> +	}
> +
> +	if (signal(SIGIO, sighandler) == SIG_ERR)
> +		tst_brkm(TBROK | TERRNO, cleanup, "signal(2) failed");

Why don't we set up the signal handler once in the setup?

> +	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
> +
> +	tst_record_childstatus(cleanup, cpid);
> +
> +	SAFE_CLOSE(cleanup, fd);
> +	fd = 0;
> +}
> +
> +static int do_child(int i)
> +{
> +	time_t time_start, time_end;
> +
> +	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
> +
> +	if (time(&time_start) == -1) {
> +		tst_brkm(TBROK | TERRNO, NULL,
> +			"getting start time failed");
> +	}

Using time() for measuring elapsed time is wrong for several reasons.

We have timer functions in LTP library (which are documented in
test-writing-guidelines.txt). Use them.

> +	switch (test_cases[i].op_type) {
> +	case OP_OPEN_RDONLY:
> +		SAFE_OPEN(NULL, "file", O_RDONLY);
> +		break;
> +	case OP_OPEN_WRONLY:
> +		SAFE_OPEN(NULL, "file", O_WRONLY);
> +		break;
> +	case OP_OPEN_RDWR:
> +		SAFE_OPEN(NULL, "file", O_RDWR);
> +		break;
> +	case OP_TRUNCATE:
> +		SAFE_TRUNCATE(NULL, "file", 0);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (time(&time_end) == -1) {
> +		tst_brkm(TBROK | TERRNO, NULL,
> +			"getting end time failed");
> +	}
> +
> +	if (difftime(time_end, time_start) < MIN_TIME_LIMIT) {
> +		tst_resm(TPASS, "fcntl(2) lease passed, "
> +			"test type: %s", test_cases[i].string);
> +	} else {
> +		tst_resm(TFAIL, "unblocking took too long time, "
> +			"test type: %s", test_cases[i].string);
> +	}
> +
> +	tst_exit();
> +}
> +
> +static void sighandler(int sig)
> +{
> +	int ret;
> +
> +	if (sig != SIGIO) {
> +		ret = write(STDOUT_FILENO, "get wrong signal\n",
> +			sizeof("get wrong signal\n"));
> +	} else {
> +		switch (lease) {
> +		case F_WRLCK:
> +			TEST(fcntl(fd, F_SETLEASE, F_RDLCK));
> +			if (TEST_RETURN == 0)
> +				break;
> +		case F_RDLCK:
> +			TEST(fcntl(fd, F_SETLEASE, F_UNLCK));
> +			if (TEST_RETURN == -1) {
> +				ret = write(STDOUT_FILENO,
> +					"fcntl(2) failed\n",
> +					sizeof("fcntl(2) failed\n"));
> +			}
> +			break;
> +		default:
> +			break;
> +		}

I do not like that we do the unlocking here in signal handler. It should
be done in parent process and we should fail the test properly if this
fails.

What about doing sigtimedwait() in parent with suitable timeout instead?

> +	}
> +
> +	(void)ret;

Why do we set the variable if it's not used at all?

> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd > 0 && close(fd))
> +		tst_resm(TWARN | TTERRNO, "failed to close file");
> +
> +	tst_rmdir();
> +
> +	/* Restore the lease-break-time. */
> +	FILE_PRINTF(PATH_LS_BRK_T, "%d", ls_brk_t);
> +}
> -- 
> 1.8.4.2
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
