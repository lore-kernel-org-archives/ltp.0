From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Aug 2021 14:00:04 +0200
Subject: [LTP] [PATCH 6/7] epoll_create: Add test for epoll_create01
In-Reply-To: <20210817064924.127970-7-xieziyao@huawei.com>
References: <20210817064924.127970-1-xieziyao@huawei.com>
 <20210817064924.127970-7-xieziyao@huawei.com>
Message-ID: <YSYwxIo4kx0BhMKp@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	fd = tst_syscall(__NR_epoll_create, tc[n]);
> +	if (fd < 0)
> +		tst_brk(TFAIL | TERRNO, "epoll_create(%d) failed", tc[n]);
> +	tst_res(TPASS, "epoll_create(%d)", tc[n]);

We even have TST_EXP_FD() exactly for this case.

-- 
Cyril Hrubis
chrubis@suse.cz
