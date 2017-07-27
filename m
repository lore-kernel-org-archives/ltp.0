From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 27 Jul 2017 17:20:49 +0200
Subject: [LTP] [PATCH 1/2] syscalls/epoll_*: allow for epoll_wait
 returning a subset of events
In-Reply-To: <20170715013741.102781-1-smuckle.linux@gmail.com>
References: <20170715013741.102781-1-smuckle.linux@gmail.com>
Message-ID: <20170727152049.GC32122@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  static void check_epoll_ctl(int opt, int exp_num)
>  {
>  	int res;
> -
> +	unsigned int events;
>  	char write_buf[] = "test";
>  	char read_buf[sizeof(write_buf)];
>  
> @@ -94,32 +94,59 @@ static void check_epoll_ctl(int opt, int exp_num)
>  		{.events = 0, .data.fd = 0}
>  	};
>  
> +	events = EPOLLIN;
> +	if (exp_num == 2)
> +		events |= EPOLLOUT;
> +
>  	SAFE_WRITE(1, fd[1], write_buf, sizeof(write_buf));
>  
> -	res = epoll_wait(epfd, res_evs, 2, -1);
> -	if (res == -1)
> -		tst_brk(TBROK | TERRNO, "epoll_wait() fails");
> +	while (events) {
> +		int events_returned = 0;
>  
> -	if (res != exp_num) {
> -		tst_res(TFAIL, "epoll_wait() returns %i, expected %i",
> -			res, exp_num);
> -		goto end;
> -	}
> +		bzero(res_evs, sizeof(res_evs));

We should remove the initialization of the res_evs array since we are
clearing it here.

> +		res = epoll_wait(epfd, res_evs, 2, -1);
> +		if (res == -1)
> +			tst_brk(TBROK | TERRNO, "epoll_wait() fails");
>  
> -	if (exp_num == 1) {
> -		if (!has_event(res_evs, 2, fd[0], EPOLLIN) ||
> -		    !has_event(res_evs, 2, 0, 0)) {
> -			tst_res(TFAIL, "epoll_wait() fails to "
> -				"get expected fd and event");
> +		if (res == 0) {
> +			tst_res(TFAIL, "epoll_wait() returns 0, expected %s",
> +				events == (EPOLLIN|EPOLLOUT) ? "1 or 2" : "1");
>  			goto end;
>  		}
> -	}
>  
> -	if (exp_num == 2) {
> -		if (!has_event(res_evs, 2, fd[0], EPOLLIN) ||
> -		    !has_event(res_evs, 2, fd[1], EPOLLOUT)) {
> -			tst_res(TFAIL, "epoll_wait() fails to "
> -				"get expected fd and event");
> +		if (res == 1 && (res_evs[1].data.fd || res_evs[1].events)) {
> +			tst_res(TFAIL,
> +				"epoll_wait() returns 1 with 2 events");
> +			goto end;
> +		}
> +
> +		if (has_event(res_evs, 2, fd[0], EPOLLIN)) {
> +			if (events & EPOLLIN) {
> +				events &= ~EPOLLIN;
> +				events_returned++;
> +			} else {
> +				tst_res(TFAIL, "epoll_wait() returned %d "
> +					"and EPOLLIN %x twice", fd[0],
> +					EPOLLIN);
> +				goto end;
> +			}
> +		}
> +
> +		if (has_event(res_evs, 2, fd[1], EPOLLOUT)) {
> +			if (events & EPOLLOUT) {
> +				events &= ~EPOLLOUT;
> +				events_returned++;
> +			} else {
> +				tst_res(TFAIL, "epoll_wait() returned %d "
> +					"and EPOLLOUT %x twice", fd[1],
> +					EPOLLOUT);
> +				goto end;
> +			}
> +		}
> +
> +		if (res != events_returned) {
> +			tst_res(TFAIL, "epoll_wait() returned %d, expected %d",
> +				res, events_returned);

I find this part a bit confusing. The res is actually number of events
returned from the epoll_wait() while the events_returned is a counter
for events that were matched correctly.

So what abou simplifying the logic a bit and doing:

	while (events) {
		int events_matched = 0;

		res = epoll_wait(...);
		if (res <= 0) {
			tst_res(TFAIL | TERRNO, "epoll_wait() returned %i", res);
			goto end;
		}

		if ((events & EPOLLIN) && has_event(res_evs, 2, fd[0], EPOLLIN)) {
			events_matched++;
			events &= ~EPOLLIN;
		}

		//the same for EPOLLOUT

		if (res != events_matched) {
			tst_res(TFAIL, "Got unexpected events");
			//And possibly dump the res_evs here
			goto end;
		}
	}

>  			goto end;
>  		}
>  	}
> diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
> index c8c55720f..1ea1ca2ec 100644
> --- a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
> +++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
> @@ -200,34 +200,59 @@ static void verify_epollio(void)
>  {
>  	char write_buf[] = "Testing";
>  	char read_buf[sizeof(write_buf)];
> +	uint32_t events = EPOLLIN | EPOLLOUT;
>  
>  	SAFE_WRITE(cleanup, 1, fds[1], write_buf, sizeof(write_buf));
>  
> -	TEST(epoll_wait(epfd, epevs, 3, -1));
> -
> -	if (TEST_RETURN == -1) {
> -		tst_resm(TFAIL | TTERRNO, "epoll_wait() epollio failed");
> -		goto end;
> -	}
> -
> -	if (TEST_RETURN != 2) {
> -		tst_resm(TFAIL, "epoll_wait() returned %li, expected 2",
> -			 TEST_RETURN);
> -		goto end;
> -	}
> -
> -	if (!has_event(epevs, 2, fds[0], EPOLLIN)) {
> -		dump_epevs(epevs, 2);
> -		tst_resm(TFAIL, "epoll_wait() expected %d and EPOLLIN %x",
> -			 fds[0], EPOLLIN);
> -		goto end;
> -	}
> -
> -	if (!has_event(epevs, 2, fds[1], EPOLLOUT)) {
> -		dump_epevs(epevs, 2);
> -		tst_resm(TFAIL, "epoll_wait() expected %d and EPOLLOUT %x",
> -			 fds[1], EPOLLOUT);
> -		goto end;
> +	while (events) {
> +		int events_returned = 0;
> +
> +		TEST(epoll_wait(epfd, epevs, 3, -1));
> +
> +		if (TEST_RETURN == -1) {
> +			tst_resm(TFAIL | TTERRNO, "epoll_wait() epollio failed");
> +			goto end;
> +		}
> +
> +		if (TEST_RETURN == 0) {
> +			tst_resm(TFAIL, "epoll_wait() returned 0, expected %s",
> +				 events == (EPOLLIN|EPOLLOUT) ? "1 or 2" : "1");
> +			goto end;
> +		}
> +
> +		if (has_event(epevs, 2, fds[0], EPOLLIN)) {
> +			if (events & EPOLLIN) {
> +				events &= ~EPOLLIN;
> +				events_returned++;
> +			} else {
> +				dump_epevs(epevs, 2);
> +				tst_resm(TFAIL, "epoll_wait() returned %d "
> +					 "and EPOLLIN %x twice", fds[0],
> +					 EPOLLIN);
> +				goto end;
> +			}
> +		}
> +
> +		if (has_event(epevs, 2, fds[1], EPOLLOUT)) {
> +			if (events & EPOLLOUT) {
> +				events &= ~EPOLLOUT;
> +				events_returned++;
> +			} else {
> +				dump_epevs(epevs, 2);
> +				tst_resm(TFAIL, "epoll_wait() returned %d "
> +					 "and EPOLLOUT %x twice", fds[1],
> +					 EPOLLOUT);
> +				goto end;
> +			}
> +		}
> +
> +		if (TEST_RETURN != events_returned) {
> +			dump_epevs(epevs, 2);
> +			tst_resm(TFAIL,
> +				 "epoll_wait() returned %li, expected %d",
> +				 TEST_RETURN, events_returned);
> +			goto end;
> +		}
>  	}

Here as well.

-- 
Cyril Hrubis
chrubis@suse.cz
