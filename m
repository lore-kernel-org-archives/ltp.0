From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 29 Aug 2017 16:27:48 +0200
Subject: [LTP] [PATCH v6] syscalls/fcntl36: add tests for OFD locks
In-Reply-To: <1503560908-21618-1-git-send-email-xzhou@redhat.com>
References: <20170823133512.GA20766@rei.lan>
 <1503560908-21618-1-git-send-email-xzhou@redhat.com>
Message-ID: <20170829142748.GA18897@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +} tcases[] = {
> +
> +	{fn_ofd_r,   fn_ofd_w,
> +		NULL, NULL, "OFD read  locks vs OFD   write locks"},
> +	{fn_ofd_w,   fn_posix_w,
> +		NULL, NULL, "OFD write locks vs POSIX write locks"},
> +	{fn_ofd_r,   fn_posix_w,
> +		NULL, NULL, "OFD read  locks vs POSIX write locks"},
> +	{fn_posix_r, fn_ofd_w,
> +		NULL, NULL, "OFD write locks vs POSIX read  locks"},
> +	{fn_ofd_w,   fn_ofd_w,
> +		NULL, NULL, "OFD write locks vs OFD   write locks"},
> +
> +	{fn_ofd_r,   fn_ofd_w,   fn_posix_w,
> +		      NULL, "OFD   r/w locks vs POSIX write locks"},
> +	{fn_posix_r, fn_ofd_w,   fn_posix_w,
> +		      NULL, "POSIX r/w locks vs OFD   write locks"},
> +	{fn_ofd_r,   fn_posix_r, fn_ofd_w,
> +		      NULL, "OFD   r/w locks vs POSIX read locks"},
> +	{fn_ofd_r,   fn_posix_r, fn_posix_w,
> +		      NULL, "POSIX r/w locks vs OFD   read locks"},
> +
> +	{fn_ofd_r,   fn_posix_r, fn_posix_w, fn_ofd_w,
> +			    "OFD   r/w locks vs POSIX r/w locks"},

The cases that concurently run posix read vs. posix write locks
unfortunately does not work, since posix locks are process based we
cannot have more than one lock on a file region per process (threads are
counted as single process as well) and conflicting locks are converted
i.e. the last two will fail with wrongly read data in the fn_posix_r
funciton in a case that posix read and posix write locks were held
concurently (which happens for me and the test fails on my testing
machine).

We can run as many threads with ofd locks as we want, since these are
based on open file descriptors and we can add exactly one posix lock
thread to the mix as well but no more than that.

Moreover I think that we may need a pthread_barrier before we close the
file descriptors in the test functions since the posix locks are dropped
when any file descriptor asociated with the file is closed, since if we
run more than two threads and ofd thread closes the fd, the posix thread
looses it's lock and the remaining ofd thread(s) run concurently, it's
unlikely that something like this would happen, but it's possible.

> +};
> +
> +static void tests(unsigned int i)
> +{
> +	test_fn(tcases[i].fn0, tcases[i].fn1,
> +		tcases[i].fn2, tcases[i].fn3, tcases[i].desc);
> +}
> +
> +static struct tst_test test = {
> +	.min_kver = "3.15",
> +	.needs_tmpdir = 1,
> +	.test = tests,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup
> +};
> -- 
> 1.8.3.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
