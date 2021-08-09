From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Aug 2021 13:35:58 +0200
Subject: [LTP] [PATCH v2 09/16] syscalls/sched_rr_get_interval01: use
 sys_sched_*()
In-Reply-To: <20210806164730.51040-10-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
 <20210806164730.51040-10-aleksei.kodanev@bell-sw.com>
Message-ID: <YRETHi+CYYzMF6ez@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
We should explain why we switch from the libc call to a syscall here in
the commit message something as:

"Fix the test on musl where sched_setscheduler is not implmeneted."

Other than that:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
