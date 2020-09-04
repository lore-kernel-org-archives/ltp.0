From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 4 Sep 2020 17:53:51 +0200
Subject: [LTP] [PATCH v2] syscall/ptrace08: Simplify the test.
In-Reply-To: <20200904140931.10153-1-chrubis@suse.cz>
References: <20200904140931.10153-1-chrubis@suse.cz>
Message-ID: <20200904155351.GA13149@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	/*
> +	 * The original fix for the kernel haven't rejected the kernel address
> +	 * right away when breakpoint was modified from userspace it was
> +	 * disabled and the EINVAL was returned when dr7 was written to enable
> +	 * it again.
> +	 */
> +	if (tst_kvercmp(4, 17, 0) < 0)
> +		deffered_check = 1;

And this should be 4.19 as the modify_user_hw_breakpoint_check() was made
uncoditional (by accident) in:

commit bd14406b78e6daa1ea3c1673bda1ffc9efdeead0
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Mon Aug 27 11:12:25 2018 +0200

    perf/hw_breakpoint: Modify breakpoint even if the new attr has disabled set


-- 
Cyril Hrubis
chrubis@suse.cz
