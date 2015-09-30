From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Sep 2015 18:38:10 +0200
Subject: [LTP] [PATCH v2] fcntl/fcntl33.c: add F_SETLEASE test
In-Reply-To: <1442308070-17325-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1440145583-9317-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1442308070-17325-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20150930163810.GB8256@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "tst_fs_type.h"
> +
> +/*
> + * MIN_TIME_LIMIT is defined to 5 senconds as a minimal acceptable
> + * amount of time for the lease breaker waitting for unblock via
                                            ^
					   waiting

> + * lease holder voluntarily downgrade or remove the lease, if the
> + * lease breaker is unblocked within MIN_TIME_LIMIT we may consider
> + * that the feature of the lease mechanism works well.
> + */

We set the lease-break-time to 45 in the setup(), what units are that?
ms? It would be better to note what value for timeout have we set in
kernel here as well. 

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
> +static void cleanup(void);
> +
> +static int fd;
> +static int ls_brk_t;
> +
> +static sigset_t newset, oldset;
> +static struct timespec timeout;
> +static struct test_case_t {
> +	int lease_type;
> +	int op_type;
> +	char *desc;
> +} test_cases[] = {
> +	{F_WRLCK, OP_OPEN_RDONLY,
> +		"open(O_RDONLY) conflicts with fcntl(F_SETLEASE, F_WRLCK)"},
> +	{F_WRLCK, OP_OPEN_WRONLY,
> +		"open(O_WRONLY) conflicts with fcntl(F_SETLEASE, F_WRLCK)"},
> +	{F_WRLCK, OP_OPEN_RDWR,
> +		"open(O_RDWR) conflicts with fcntl(F_SETLEASE, F_WRLCK)"},
> +	{F_WRLCK, OP_TRUNCATE,
> +		"truncate() conflicts with fcntl(F_SETLEASE, F_WRLCK)"},
> +	{F_RDLCK, OP_OPEN_WRONLY,
> +		"open(O_WRONLY) conflicts with fcntl(F_SETLEASE, F_RDLCK)"},
> +	{F_RDLCK, OP_OPEN_RDWR,
> +		"open(O_RDWR) conflicts with fcntl(F_SETLEASE, F_RDLCK)"},
> +	{F_RDLCK, OP_TRUNCATE,
> +		"truncate() conflicts with fcntl(F_SETLEASE, F_RDLCK)"},
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
> +		tst_brkm(TCONF, cleanup, "%s filesystem does not support "
> +			 "fcntl()'s F_SETLEASE operation",
> +			 tst_fs_type_name(type));
> +	default:
> +		break;
> +	}

What does happen when we try the fcntl() on unsupported FS?

Do we get reasonable errno? I would expect ENOSYS but as far as I can
see the manual page is silent about this.

If we get reasonable errno we should rather do test in the test setup,
we should call the fcntl on a fd in the setup and continue only if it
hasn't failed with that errno.

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
> +	tst_timer_check(CLOCK_MONOTONIC);
> +
> +	/* Backup the lease-break-time. */
> +	SAFE_FILE_SCANF(NULL, PATH_LS_BRK_T, "%d", &ls_brk_t);
> +	SAFE_FILE_PRINTF(NULL, PATH_LS_BRK_T, "%d", 45);
> +
> +	tst_tmpdir();
> +
> +	SAFE_TOUCH(cleanup, "file", FILE_MODE, NULL);
> +
> +	sigemptyset(&newset);
> +	sigaddset(&newset, SIGIO);
> +
> +	if (sigprocmask(SIG_SETMASK, &newset, &oldset) < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "sigprocmask() failed");
> +
> +	/* Time limit for lease holder to receive SIGIO. */
> +	timeout.tv_sec = 5;
> +	timeout.tv_nsec = 0;

You can initialize this statically as:

static struct timespec timeout = {.tv_sec = 5};

> +	TEST_PAUSE;
> +}
> +
> +static void do_test(int i)
> +{
> +	pid_t cpid;
> +
> +	cpid = tst_fork();
> +	if (cpid < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
> +
> +	if (cpid == 0)
> +		do_child(i);
> +
> +	fd = SAFE_OPEN(cleanup, "file", O_RDONLY);
> +
> +	TEST(fcntl(fd, F_SETLEASE, test_cases[i].lease_type));
> +	if (TEST_RETURN == -1) {
> +		tst_resm(TFAIL | TTERRNO, "fcntl() failed to set lease");
> +		SAFE_WAITPID(cleanup, cpid, NULL, 0);
> +		SAFE_CLOSE(cleanup, fd);
> +		fd = 0;
> +		return;
> +	}
> +
> +	/* Wait for SIGIO caused by lease breaker. */
> +	TEST(sigtimedwait(&newset, NULL, &timeout));
> +	if (TEST_RETURN == -1) {
> +		if (TEST_ERRNO == EAGAIN) {
> +			tst_resm(TFAIL | TTERRNO, "failed to receive SIGIO "
> +				 "within %lis", timeout.tv_sec);
> +			SAFE_WAITPID(cleanup, cpid, NULL, 0);
> +			SAFE_CLOSE(cleanup, fd);
> +			fd = 0;
> +			return;
> +		}
> +		tst_brkm(TBROK | TTERRNO, cleanup, "sigtimedwait() failed");
> +	} else if (TEST_RETURN != SIGIO) {
> +		tst_brkm(TBROK, cleanup, "received wrong signal");
> +	}

No need for the else here, the previous if () exits the function
execution anyway.

> +	/* Try to downgrade or remove the lease. */
> +	switch (test_cases[i].lease_type) {
> +	case F_WRLCK:
> +		TEST(fcntl(fd, F_SETLEASE, F_RDLCK));
> +		if (TEST_RETURN == 0)
> +			break;
> +	case F_RDLCK:
> +		TEST(fcntl(fd, F_SETLEASE, F_UNLCK));
> +		if (TEST_RETURN == -1) {
> +			tst_resm(TFAIL | TTERRNO,
> +				 "fcnt() failed to remove the lease");
                                    ^
				    fcntl()
> +		}
> +		break;
> +	default:
> +		break;
> +	}

Do we need to remove the lease here? Isn't it removed once anyway once
we close the file descriptor at the end of the function?

Or do we do that so that child gets ublocked in case that the lease
hasn't timeouted?

> +	tst_record_childstatus(cleanup, cpid);
> +
> +	SAFE_CLOSE(cleanup, fd);
> +	fd = 0;
> +}
> +
> +static int do_child(int i)
> +{
> +	long long elapsed_ms;
> +
> +	if (tst_process_state_wait2(getppid(), 'S') != 0) {
> +		tst_brkm(TBROK | TERRNO, NULL,
> +			 "failed to wait for parent process's state");
> +	}
> +
> +	tst_timer_start(CLOCK_MONOTONIC);
> +
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
> +	tst_timer_stop();
> +
> +	elapsed_ms = tst_timer_elapsed_ms();
> +
> +	if (elapsed_ms < MIN_TIME_LIMIT * 1000) {
> +		tst_resm(TPASS, "%s, unblocked within %ds",
> +			 test_cases[i].desc, MIN_TIME_LIMIT);
> +	} else {
> +		tst_resm(TFAIL, "%s, unblocked too long %llims, "
                                       ^
				       blocked?

> +			 "expected within %ds",
> +			 test_cases[i].desc, elapsed_ms, MIN_TIME_LIMIT);
> +	}
> +
> +	tst_exit();
> +}
> +
> +static void cleanup(void)
> +{
> +	if (sigprocmask(SIG_SETMASK, &oldset, NULL) < 0)
> +		tst_resm(TWARN | TERRNO, "sigprocmask restore oldset failed");
> +
> +	if (fd > 0 && close(fd))
> +		tst_resm(TWARN | TERRNO, "failed to close file");
> +
> +	tst_rmdir();
> +
> +	/* Restore the lease-break-time. */
> +	FILE_PRINTF(PATH_LS_BRK_T, "%d", ls_brk_t);
> +}

-- 
Cyril Hrubis
chrubis@suse.cz
