From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Jul 2021 14:23:54 +0200
Subject: [LTP] [PATCH 2/3] epoll_pwait2: Add test for epoll_pwait201
In-Reply-To: <20210628080424.245911-3-xieziyao@huawei.com>
References: <20210628080424.245911-1-xieziyao@huawei.com>
 <20210628080424.245911-3-xieziyao@huawei.com>
Message-ID: <YOw0WvldeLvW+gA5@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void run(void)
> +{
> +	TEST(tst_syscall(__NR_epoll_pwait2, efd, &e, 1, NULL, NULL, 0));

It would be better to put the prototype for epoll_pwait2 into
include/lapi/epoll.h.

Also given that the difference between epoll_pwait() and epoll_pwait2()
is only in the timeout parameter type it would make much more sense to
write these tests with two test variants so that we would cover both
epoll_pwait() and epoll_wait2().

I would have put these tests into epoll_wait/ directory and added
epoll_var.h that would make a common wrapper for both of these
functions. We do this for example for select in select/select_var.h but
in this case this would be much easier, I guess that the wrapper would
get timespec structure and convert that to miliseconds for
epoll_pwait().

-- 
Cyril Hrubis
chrubis@suse.cz
