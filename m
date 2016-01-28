From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 28 Jan 2016 18:16:17 +0100
Subject: [LTP] [PATCH 3/3] epoll_wait/epoll_wait03.c: add new testcase
In-Reply-To: <1451472257-29472-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1451472257-29472-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1451472257-29472-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20160128171617.GC12679@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include <sys/epoll.h>
> +#include <string.h>
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +
> +static int epfd, fds[2];
> +static struct epoll_event epevs[1];
> +
> +static struct test_case_t {
> +	int epfd;
> +	int maxevents;
> +	int exp_errno;
> +} test_cases[] = {
> +	/* test1 */
> +	{-1, 1, EBADF},
> +	/* test2 */
> +	{0, 1, EINVAL},
> +	/*
> +	 * test3
> +	 * temporarily set epfd to 0
> +	 * will be set to an epoll instance later
> +	 */

Instead of this comment the epfd should rather be pointer to an integer
that is initialized in setup(). Changing this structure in setup() by
explicit position is a bad habbit and will lead to unexpected side
effect when this structure gets changed.

> +	{0, -1, EINVAL},
> +	/*
> +	 * test4
> +	 * temporarily set epfd to 0
> +	 * will be set to an epoll instance later
> +	 */
> +	{0, 0, EINVAL},
> +};
> +
> +char *TCID = "epoll_wait03";
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
> +
> +static void setup(void);
> +static void verify_epoll_wait(struct test_case_t *test_cases);
> +static void cleanup(void);
> +
> +int main(int ac, char **av)
> +{
> +	int lc, tc;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		for (tc = 0; tc < TST_TOTAL; tc++)
> +			verify_epoll_wait(&test_cases[tc]);
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	SAFE_PIPE(NULL, fds);
> +
> +	epfd = epoll_create(1);
> +	if (epfd == -1) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "failed to create epoll instance");
> +	}
> +
> +	test_cases[2].epfd = epfd;
> +	test_cases[3].epfd = epfd;
> +
> +	epevs[0].events = EPOLLOUT;
> +	epevs[0].data.fd = fds[1];

This should be initialized statically as:

static struct epoll_event epevs[1] = {
	{.events = EPOLLOUT, .data = {.fd = fds[1]}}
};

> +	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[1], &epevs[0])) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "failed to register epoll target");
> +	}
> +}
> +
> +static void verify_epoll_wait(struct test_case_t *test_cases)
> +{
> +	TEST(epoll_wait(test_cases->epfd, epevs, test_cases->maxevents, -1));
> +	if (TEST_RETURN != -1) {
> +		tst_resm(TFAIL, "epoll_wait() succeed unexpectedly");
> +	} else {
> +		if (TEST_ERRNO == test_cases->exp_errno) {
> +			tst_resm(TPASS | TTERRNO,
> +				 "epoll_wait() fails as expected");
> +		} else {
> +			tst_resm(TFAIL | TTERRNO,
> +				 "epoll_wait() fails unexpectedly, "
> +				 "expected %d: %s", test_cases->exp_errno,
> +				 strerror(test_cases->exp_errno));
                                 ^
                                 you shoud use tst_strerrno() instead
> +		}
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

The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
