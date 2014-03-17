Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WPbqJ-0004yN-ON
	for ltp-list@lists.sourceforge.net; Mon, 17 Mar 2014 18:00:55 +0000
Date: Mon, 17 Mar 2014 19:00:32 +0100
From: chrubis@suse.cz
Message-ID: <20140317180032.GB1807@rei>
References: <1392885919-27160-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1392885919-27160-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3] fcntl/fcntl31.c: add I/O availability signals
 test for fcntl(2)
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Hi???please review this v2 patch and ignore the previous:)
> 
> create a new case to test F_GETOWN, F_SETOWN, F_GETOWN_EX,
> F_SETOWN_EX, F_GETSIG, F_SETSIG for fcntl(2)
> 

...

> +static void setownex_pid_test(void)
> +{
> +	static struct f_owner_ex tst_own_ex;
> +
> +	if (ownex_enabled == 0) {
> +		tst_resm(TCONF, ownex_tconf_msg);

We should change this to tst_resm(TCONF, "%s", ownex_tconf_msg);
otherwise this produces warnings because compiler cannot inspect the
format string...

> +		return;
> +	}
> +
> +	tst_own_ex.type = F_OWNER_PID;
> +	tst_own_ex.pid = pid;
> +
> +	TEST(fcntl(test_fd, F_SETOWN_EX, &tst_own_ex));
> +	if (TEST_RETURN < 0) {
> +		tst_brkm(TFAIL | TTERRNO, cleanup,
> +			 "fcntl F_SETOWN_EX failed");
> +	}
> +	test_set_and_get_sig(SIGUSR1,
> +			     "F_GETOWN_EX, F_SETOWN_EX for process ID");
> +
> +	setownex_cleanup();
> +}

...

> +static void signal_parent(void)
> +{
> +	int ret, fd;
> +
> +	fd = pipe_fds[1];
> +	close(pipe_fds[0]);
> +
> +	ret = setpgrp();
> +	if (ret < 0) {
> +		fprintf(stderr, "child process(%d) setpgrp() failed \n",
> +			getpid());
> +	}
> +
> +	ret = write(fd, "c", 1);
> +
> +	switch (ret) {
> +	case 0:
> +		fprintf(stderr, "No data written, something is wrong\n");
> +	break;
> +	case -1:
> +		fprintf(stderr, "Failed to write to pipe: %s\n",
> +			strerror(errno));
> +	break;
> +	}
> +
> +	close(fd);
> +	return;
> +}
> +
> +static void check_io_signal(char *des)
> +{
> +	int ret;
> +	pid_t child;
> +
> +	child = tst_fork();
> +	if (child < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
> +
> +	if (child == 0) {
> +		signal_parent();
> +		exit(0);
> +	} else {
> +		ret = sigtimedwait(&newset, NULL, &timeout);
> +		if (ret == -1) {
> +			tst_brkm(TBROK | TERRNO, NULL,
> +				 "sigtimedwait() failed.");
> +		}
> +
> +		switch (ret) {
> +		case SIGUSR1:
> +			tst_resm(TPASS, "fcntl test %s success", des);
> +		break;
> +		case SIGIO:
> +			tst_resm(TFAIL, "received default SIGIO, fcntl test "
> +				 "%s failed", des);
> +		break;
> +		default:
> +			tst_brkm(TBROK, cleanup, "fcntl io events "
> +				 "signal mechanism work abnormally");
> +		}
> +		wait(NULL);
> +	}
> +}

There is a problem with a pipe capacity, if you run the test with enough
iterations you will get failure beceause the child cannot write to the full
pipe.

fcntl31     1  TPASS  :  fcntl test F_GETOWN, F_SETOWN for process ID success
fcntl31     0  TINFO  :  default io events signal is SIGIO
fcntl31     2  TBROK  :  sigtimedwait() failed.: errno=EAGAIN(11): Resource temporarily unavailable
fcntl31     3  TBROK  :  Remaining cases broken
fcntl31     2  TBROK  :  unexpected signal 13 received (pid = 4293).
fcntl31     3  TBROK  :  Remaining cases broken
fcntl31     0  TWARN  :  close(3) failed: errno=EBADF(9): Bad file descriptor

I can reproduce the problem with:

$ ./fcntl31 -i 100000 &> log.txt
$ tail log.txt

You can easily fix this problem if you read the byte from pipe in the parent
process (before or after the wait()).


And there is a small synchronization problem too. If the write() in the
signal_parent() is entered before the parent sleeps in sigtimedwait() the
signal is lost and the test fails.

What we need to do is to ensure parents sleeps in sigtimedwait() before we
execute the write(). I guess that TST_PROCESS_STATE_WAIT() in child should work
here.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
