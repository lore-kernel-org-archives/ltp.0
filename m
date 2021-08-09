From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Aug 2021 12:03:52 +0200
Subject: [LTP] [PATCH v2 03/16] syscalls/sched_getparam03: use
 libc/sys_sched_*()
In-Reply-To: <20210806164730.51040-4-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
 <20210806164730.51040-4-aleksei.kodanev@bell-sw.com>
Message-ID: <YRD9iIMbpmliSrz2@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static struct sched_variants variants[] = {
> +	{ .sched_getparam = libc_sched_getparam, .desc = "libc"},
> +	{ .sched_getparam = sys_sched_getparam, .desc = "syscall"},
> +};

Here as well.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
