From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Jan 2020 12:42:08 +0100
Subject: [LTP] [PATCH] syscalls/capget[set]: Make use of guarded buffers
In-Reply-To: <1578633511-15403-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1578633511-15403-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200110114208.GA25704@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> Also, using pid=0 instead of getpid() in capget02.c because
> it also returns the capabilities for the calling thread.

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks these improvements.

...
> diff --git a/testcases/kernel/syscalls/capget/capget02.c b/testcases/kernel/syscalls/capget/capget02.c
...
> -	tst_res(TINFO, "%s", tc->message);
> -	TEST(tst_syscall(__NR_capget, tc->headerp, tc->datap));
> +	header->version = tc->version;
> +	if (tc->pid == 1)
> +		header->pid = unused_pid;
> +	else
> +		header->pid = tc->pid;
> +
> +	tst_res(TINFO, "%s ", tc->message);
Why this extra space? I suggest to merge with the original:
	tst_res(TINFO, "%s", tc->message);

Kind regards,
Petr
