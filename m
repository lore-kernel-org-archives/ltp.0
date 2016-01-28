From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 28 Jan 2016 17:19:18 +0100
Subject: [LTP] [PATCH 1/3] epoll_wait/epoll_wait01.c: add new testcase
In-Reply-To: <1451472257-29472-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1451472257-29472-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20160128161917.GA12679@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
> new file mode 100644
> index 0000000..46058a2
> --- /dev/null
> +++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
> @@ -0,0 +1,263 @@
> +/*
> + * Copyright (c) 2015 Fujitsu Ltd.
> + * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> + * the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.
> + */
> +
> +/*
> + * Description:
> + *  Basic test for epoll_wait(2).
> + *  Check that epoll_wait(2) works for EPOLLOUT and EPOLLIN events
> + *  on a epoll instance and that struct epoll_event is set correctly.
> + */
> +
> +#include <sys/epoll.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <poll.h>
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "lapi/fcntl.h"
> +
> +char *TCID = "epoll_wait01";
> +int TST_TOTAL = 3;
> +
> +static int write_size, epfd, fds[2];
> +static struct epoll_event epevs[2];
> +
> +static void setup(void);
> +static int get_writesize(void);
> +static void verify_epollout(void);
> +static void verify_epollin(void);
> +static void verify_epollio(void);
> +static void cleanup(void);
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		verify_epollout();
> +		verify_epollin();
> +		verify_epollio();
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	int pipe_capacity;
> +
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	SAFE_PIPE(NULL, fds);
> +
> +	/* fcntl()'s F_GETPIPE_SZ flag availbility check */
> +	if ((tst_kvercmp(2, 6, 35)) < 0) {
> +		write_size = get_writesize();
> +	} else {
> +		pipe_capacity = fcntl(fds[1], F_GETPIPE_SZ);
> +		if (pipe_capacity == -1) {
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +				 "failed to get the pipe capacity");
> +		}
> +
> +		write_size = pipe_capacity - getpagesize() + 1;
> +	}

I would rather go with runtime detection even for newer kernels. Since
otherwise we have two different codepaths to test.

> +	epfd = epoll_create(2);
> +	if (epfd == -1) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "failed to create epoll instance");
> +	}
> +
> +	epevs[0].events = EPOLLIN;
> +	epevs[0].data.fd = fds[0];
> +	epevs[1].events = EPOLLOUT;
> +	epevs[1].data.fd = fds[1];
> +
> +	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &epevs[0]) ||
> +		epoll_ctl(epfd, EPOLL_CTL_ADD, fds[1], &epevs[1])) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "failed to register epoll target");
> +	}
> +}
> +
> +/*
> + * fcntl(fd, F_GETPIPE_SZ) not supported on kernels which
> + * version lower than 2.6.35, so use this function instead
> + */
> +static int get_writesize(void)
> +{
> +	int nfd, write_size;
> +
> +	struct pollfd pfd[] = {
> +		{.fd = fds[0], .events = POLLIN},
> +		{.fd = fds[1], .events = POLLOUT},
> +	};
> +
> +	write_size = 0;
> +	do {
> +		SAFE_WRITE(cleanup, 1, fds[1], "a", 1);
> +		write_size++;
> +		nfd = poll(pfd, 2, -1);
> +		if (nfd == -1)
> +			tst_brkm(TBROK | TERRNO, cleanup, "poll failed");
> +	} while (nfd == 2);

Why don't we write larger chunks and add the return from SAFE_WRITE to
the write_size? That should work if we pass 0 as len strict, the last
write should just end up truncated.

> +	char buf[write_size];
> +
> +	SAFE_READ(cleanup, 1, fds[0], buf, write_size);
> +
> +	return write_size;
> +}
> +
> +static void verify_epollout(void)
> +{
> +	TEST(epoll_wait(epfd, epevs, 2, -1));
> +
> +	if (TEST_RETURN == -1) {
> +		tst_resm(TFAIL | TTERRNO, "epoll_wait() epollout failed");
> +		return;
> +	}
> +
> +	if (TEST_RETURN != 1) {
> +		tst_resm(TFAIL, "epoll_wait() failed to get one fd ready");
                                       ^
				       We should add the TEST_RETURN
				       value to the output here
I would go for:
		tst_resm(TFAIL, "epoll_wait() returned %i expected 1",
		                TEST_RETURN);


> +		return;
> +	}
> +
> +	if (epevs[0].data.fd != fds[1]) {
> +		tst_resm(TFAIL, "epoll_wait() failed to set write fd");

And maybe write the actuall fds here:

		tst_resm(TFAIL, "epoll.data.fd %i expected %i", ...);

> +		return;
> +	}
> +
> +	if (epevs[0].events != EPOLLOUT) {
> +		tst_resm(TFAIL, "epoll_wait() failed to set EPOLLOUT");

And perhaps print the value of events as hexadecimal here.

> +		return;
> +	}
> +
> +	tst_resm(TPASS, "epoll_wait() epollout");
> +}
> +
> +static void verify_epollin(void)
> +{
> +	char write_buf[write_size];
> +	char read_buf[sizeof(write_buf)];
> +
> +	memset(write_buf, 'a', sizeof(write_buf));
> +
> +	SAFE_WRITE(cleanup, 1, fds[1], write_buf, sizeof(write_buf));
> +
> +	TEST(epoll_wait(epfd, epevs, 2, -1));
> +
> +	if (TEST_RETURN == -1) {
> +		tst_resm(TFAIL | TTERRNO, "epoll_wait() epollin failed");
> +		goto end;
> +	}
> +
> +	if (TEST_RETURN != 1) {
> +		tst_resm(TFAIL, "epoll_wait() failed to get one fd ready");
> +		goto end;
> +	}
> +
> +	if (epevs[0].data.fd != fds[0]) {
> +		tst_resm(TFAIL, "epoll_wait() failed to set read fd");
> +		goto end;
> +	}
> +
> +	if (epevs[0].events != EPOLLIN) {
> +		tst_resm(TFAIL, "epoll_wait() failed to set EPOLLIN");
> +		goto end;
> +	}

And I would be more verbose about the values in these messages as well.

> +	tst_resm(TPASS, "epoll_wait() epollin");
> +
> +end:
> +	SAFE_READ(cleanup, 1, fds[0], read_buf, sizeof(write_buf));
> +}
> +
> +static void verify_epollio(void)
> +{
> +	int i, checked0, checked1;
> +	char write_buf[] = "Testing";
> +	char read_buf[sizeof(write_buf)];
> +
> +	SAFE_WRITE(cleanup, 1, fds[1], write_buf, sizeof(write_buf));
> +
> +	TEST(epoll_wait(epfd, epevs, 2, -1));
                                     ^
			       Shouldn't we pass at least 3 here (and
			       declare epevs to have three elements as
			       well). Since if there were three events
			       queued the epoll_wait() would return just
			       2 and the test will pass.

> +
> +	if (TEST_RETURN == -1) {
> +		tst_resm(TFAIL | TTERRNO, "epoll_wait() epollio failed");
> +		goto end;
> +	}
> +
> +	if (TEST_RETURN != 2) {
> +		tst_resm(TFAIL, "epoll_wait() failed to get two fds ready");
> +		goto end;
> +	}
> +
> +	checked0 = 0;
> +	checked1 = 0;
> +	for (i = 0; i < TEST_RETURN; i++) {
> +		if (checked0 == 0 && epevs[i].data.fd == fds[0]) {
> +			if (epevs[i].events != EPOLLIN) {
> +				tst_resm(TFAIL, "epoll_wait()"
> +					 "failed to set EPOLLIN");
> +				goto end;
> +			}
> +			checked0 = 1;
> +		} else if (checked1 == 0 && epevs[i].data.fd == fds[1]) {
> +			if (epevs[i].events != EPOLLOUT) {
> +				tst_resm(TFAIL, "epoll_wait()"
> +					 "failed to set EPOLLOUT");
> +				goto end;
> +			}
> +			checked1 = 1;
> +		} else {
> +			tst_resm(TFAIL, "epoll_wait()"
> +				 "failed to set write or read fd");
> +			goto end;
> +		}
> +	}


Hmm, this is kind of messy. I would implement this as function that
checks if the array has event with specific values and would have called
it twice once with read fd and once with write fd.

static int has_event(struct epoll_event *events, int events_len,
                     int fd, uint32_t events)
{
	...
}

...
	if (!has_event(epevs, 2, fds[0], EPOLLIN))
		tst_resm(TFAIL, ...);

	if (!has_event(epevs, 2, fds[1], EPOLLOUT))
		tst_resm(TFAIL, ...);
...


And perhaps we can add a function to dump the epevs array with
tst_resm(TINFO, "") and call it on the array whenever we find that
something went wrong before we do tst_resm(TFAIL, ...);

> +	tst_resm(TPASS, "epoll_wait() epollio");
> +
> +end:
> +	SAFE_READ(cleanup, 1, fds[0], read_buf, sizeof(write_buf));
> +}
> +
> +static void cleanup(void)
> +{
> +	if (epfd > 0 && close(epfd))
> +		tst_resm(TWARN | TERRNO, "failed to close epfd");
> +
> +	if (close(fds[0]))
> +		tst_resm(TWARN | TERRNO, "failed to close fds[0]");
> +
> +	if (close(fds[1]))
> +		tst_resm(TWARN | TERRNO, "failed to close fds[1]");
> +}

The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
