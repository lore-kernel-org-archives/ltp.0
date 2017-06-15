From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Jun 2017 16:31:13 +0200
Subject: [LTP] [PATCH 2/2] sched/autogroup01: Add new regression test
In-Reply-To: <1497520655-12426-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1497520655-12426-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1497520655-12426-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170615143113.GD2832@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void do_test(void)
> +{
> +	int i;
> +
> +	if (!SAFE_FORK()) {
> +		SAFE_FILE_PRINTF(PATH_AUTOGROUP, "%d", 1);
> +		SAFE_SETSID();
> +
> +		if (SAFE_FORK()) {
> +			pause();
> +			exit(0);

                     Do we really reach this exit(0)?

		     We are sending SIGKILL to this process after all...

> +		}
> +
> +		SAFE_KILL(getppid(), SIGKILL);
> +		usleep(1000);
> +
> +		SAFE_FILE_PRINTF(PATH_AUTOGROUP, "%d", 0);
> +		SAFE_SETSID();
> +
> +		for (i = 0; i < LOOPS; i++)
> +			usleep(10);
> +
> +		TST_CHECKPOINT_WAKE(0);
> +
> +		exit(0);
> +	}
> +
> +	SAFE_WAIT(NULL);
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	tst_res(TPASS, "Bug not reproduced");
> +}

Otherwise it looks fine. We may as well include the comments that were
present in the original reproducer as that makes the code a bit easier
to understand.

-- 
Cyril Hrubis
chrubis@suse.cz
