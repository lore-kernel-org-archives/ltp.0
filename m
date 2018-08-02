From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 2 Aug 2018 08:17:00 -0400 (EDT)
Subject: [LTP] [PATCH 4/5] syscalls/flock04: Rewrite to new library
In-Reply-To: <1533182024-18841-4-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1533182024-18841-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1533182024-18841-4-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1739695693.37582576.1533212220162.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> 1) Avoid locking closed fd when running flock04 in loops
> 2) Merge flock05 into flock04
> 
> Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>

+1 for merge, these are very similar

flock04.c:45: PASS: flock() succeeded in acquiring shared lockas expecetd
flock04.c:55: PASS: flock() failed to acquire shared lock as expecetd
flock04.c:55: PASS: flock() failed to acquire exclusive lock as expecetd
flock04.c:55: PASS: flock() failed to acquire exclusive lock as expecetd

This output is bit confusing. 2nd line is test where child is trying to
get exclusive lock". It would help to see what kind of lock parent holds
and what lock is child trying to acquire.

"lockas" is missing space
"expecetd" is typo

> +static void child(int opt1, int opt2, char *lock)
> +	int retval, fd1;
> +
> +	fd1 = SAFE_OPEN("testfile", O_RDWR);
> +	retval = flock(fd1, opt1);
> +	if (LOCK_SH & opt1 && opt2 == LOCK_SH) {
> +		if (retval == -1) {
> +			tst_res(TFAIL, "flock() failed to acquire %s",
> +				lock);

TERRNO would be nice to know here

> +			exit(1);

tst_res will propagate TFAIL to parent via shared memory, so
these exit codes don't matter much, if you use only one exit(0),
after SAFE_CLOSE below, it would work the same.

> +		} else {
> +			tst_res(TPASS, "flock() succeeded in acquiring %s"
> +				"as expecetd", lock);
> +			exit(0);
> +		}
> +	} else {
> +		if (retval == 0) {
> +			tst_res(TFAIL, "flock() succeeded in acquiring %s",
> +				lock);
> +			exit(1);
> +		} else {
> +			tst_res(TPASS, "flock() failed to acquire %s "
> +				"as expecetd", lock);
> +			exit(0);
> +		}
>  	}

If this is unreachable a comment would be nice.

> +	SAFE_CLOSE(fd1);
>  }

For example, I'd suggest following:

static void child(int opt1, int should_pass, char *lock)
{
        int retval, fd1;

        fd1 = SAFE_OPEN("testfile", O_RDWR);
        retval = flock(fd1, opt1);
        if (should_pass)
                tst_res(retval == -1 ? TFAIL : TPASS,
                        " child acquiring %s got %d", lock, retval);
        else
                tst_res(retval == -1 ? TPASS : TFAIL,
                        " child acquiring %s got %d", lock, retval);

        SAFE_CLOSE(fd1);
        exit(0);
}

static void verify_flock(unsigned n)
{
        int fd2;
        pid_t pid;
        struct tcase *tc = &tcases[n];

        fd2 = SAFE_OPEN("testfile", O_RDWR);
        TEST(flock(fd2, tc->operation));
        if (TST_RET != 0) {
                tst_res(TFAIL, "flock() failed to acquire %s", tc->filelock);
                return;
        }
        tst_res(TPASS, "Parent has %s", tc->filelock);

        pid = SAFE_FORK();
        if (pid == 0)
                child(LOCK_SH | LOCK_NB, tc->operation & LOCK_SH, "shared lock");
        else
                tst_reap_children();

        pid = SAFE_FORK();
        if (pid == 0)
                child(LOCK_EX | LOCK_NB, 0, "exclusive lock");
        else
                tst_reap_children();

        SAFE_CLOSE(fd2);
}

which produces:

tst_test.c:1018: INFO: Timeout per run is 0h 05m 00s
flock04.c:61: PASS: Parent has shared lock
flock04.c:40: PASS:  child acquiring shared lock got 0
flock04.c:43: PASS:  child acquiring exclusive lock got -1
flock04.c:61: PASS: Parent has exclusive lock
flock04.c:43: PASS:  child acquiring shared lock got -1
flock04.c:43: PASS:  child acquiring exclusive lock got -1

What do you think?

Regards,
Jan
