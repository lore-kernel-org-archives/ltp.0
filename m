From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 28 Jan 2016 18:24:56 +0100
Subject: [LTP] [PATCH 4/4] epoll_wait/epoll_wait04.c: add new testcase
In-Reply-To: <1452043182-19242-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1451472257-29472-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1452043182-19242-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20160128172456.GD12679@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Verify that:
>  epoll_wait(2) fails if the memory area pointed to by events is not
>  accessible with write permissions.
> 
> Expected result:
>  epoll_wait(2) should return -1 and set errno to EFAULT

Is there any reason why this is not part of the previous (epoll_wait03)
test? All that needs to be done is that the test_case structrue would
have to have epoll_event **ev member that would either pointing to
epoll_event * variable initialized in the setup by mmap() or different
one that will point to the static array (since we cannot get pointer to
variable holding the array).

The code would look like:

epoll_event *ev_efault;
epoll_event *ev = &evps;

{
	{&fd, 1, &ev_efault, EFAULT},
	{&fd, -1, &ev, EINVAL},
	...
}

...
	TEST(epoll_wait(*(tc->epfd), *(tc->ev), tc->maxevents, -1));
...

-- 
Cyril Hrubis
chrubis@suse.cz
