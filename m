From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 28 Jan 2016 17:35:17 +0100
Subject: [LTP] [PATCH 2/3] epoll_wait/epoll_wait02.c: add new testcase
In-Reply-To: <1451472257-29472-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1451472257-29472-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1451472257-29472-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20160128163517.GB12679@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +
> +		if (TEST_RETURN != 0) {
> +			tst_resm(TFAIL, "epoll_wait() unexpectedly get %li, "
                                                            ^
						     Should rather be:
					"returned %li, expected 0"

The sentence does not make sense as it is.

> +				 "expected 0", TEST_RETURN);
> +			continue;
> +		}
> +
> +		elapsed_ms = tst_timer_elapsed_ms();
> +
> +		if (elapsed_ms < sleep_ms) {
> +			tst_resm(TFAIL, "epoll_wait() woken up too early %llims, "
> +				 "expected %llims", elapsed_ms, sleep_ms);
> +			continue;
> +		}
> +
> +		if (elapsed_ms - sleep_ms > threshold) {
> +			tst_resm(TFAIL, "epoll_wait() slept too long %llims, "
> +				 "expected %llims, threshold %i",
> +				 elapsed_ms, sleep_ms, threshold);
> +			continue;
> +		}
> +
> +		tst_resm(TPASS, "epoll_wait() slept %llims, expected %llims, "
> +			 "threshold %i", elapsed_ms, sleep_ms, threshold);
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_timer_check(CLOCK_MONOTONIC);
> +
> +	SAFE_PIPE(NULL, fds);
> +
> +	epfd = epoll_create(1);
> +	if (epfd == -1) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "failed to create epoll instance");
> +	}
> +
> +	epevs[0].events = EPOLLIN;
> +	epevs[0].data.fd = fds[0];
> +
> +	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &epevs[0])) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "failed to register epoll target");
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	if (epfd > 0 && close(epfd))
> +		tst_resm(TWARN | TERRNO, "failed to close epfd");
> +
> +	if (close(fds[0]))
> +		tst_resm(TWARN | TERRNO, "close(fds[0]) failed");
> +
> +	if (close(fds[1]))
> +		tst_resm(TWARN | TERRNO, "close(fds[1]) failed");
> +}
> +
> +static void help(void)
> +{
> +	printf("  -s      epoll_wait() timeout length in ms\n");
> +}

The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
