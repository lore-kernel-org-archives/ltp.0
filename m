Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W88SM-00080A-Uk
	for ltp-list@lists.sourceforge.net; Tue, 28 Jan 2014 13:11:58 +0000
Date: Tue, 28 Jan 2014 14:11:29 +0100
From: chrubis@suse.cz
Message-ID: <20140128131129.GA7102@rei>
References: <87vbx532pm.fsf@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87vbx532pm.fsf@redhat.com>
Subject: Re: [LTP] [PATCH v2] syscalls/fork: add new case fork14
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
To: Madper Xie <cxie@redhat.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi!
> +int main(int ac, char **av)
> +{
> +	int lc, ret;
> +	char *msg;
> +
> +	msg = parse_opts(ac, av, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +/*
> + * Tested on ppc64/x86_64/i386/s390x. And only 64bit has this issue.
> + * Since a 32bit program can't mmap so many memory.
> + */
> +#if __WORDSIZE == 32
> +	tst_brkm(TCONF, NULL, "This test is only for 64bit.");
> +#endif
> +	setup();
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		ret = fork_test();
> +		if (ret == 0)
> +			tst_resm(TPASS, "fork failed as expected.");
> +	}
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	TEST_PAUSE;
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +}
> +
> +static int fork_test(void)
> +{
> +	int i, ret = 0;
> +	void *addr;
> +
> +	for (i = 0; i < EXTENT; i++) {
> +		addr = mmap(NULL, (size_t) 1 * GB, PROT_READ | PROT_WRITE,
                                   ^
				   Why do you multiply the size by 1
				   casted to (size_t) that does not make
				   much sense.

> +			MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> +		if (addr == MAP_FAILED)
> +			tst_brkm(TBROK|TERRNO, cleanup, "mmap");

                      I wonder if this should be really TBROK. This
		      could easily fail with ENOMEM if you turn off
		      memory overcommit and you machine does not have
		      enough RAM.

> +		switch (fork()) {
> +		case -1:
> +			break;
> +		case 0:
> +			exit(0);
> +		default:
> +			if (waitpid(-1, NULL, 0) == -1)
> +				tst_brkm(TBROK|TERRNO,
> +					cleanup, "waitpid");
> +
> +			if (i >= LARGE) {
> +				tst_brkm(TFAIL, NULL,
> +					"Fork succeeds incorrectly");
> +				ret++;
> +			}
> +		}
> +	}
> +	return ret;
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
