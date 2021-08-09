From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Aug 2021 14:44:31 +0200
Subject: [LTP] [PATCH v2 16/16] syscalls/sched_getscheduler02: convert
 to new API
In-Reply-To: <20210806164730.51040-17-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
 <20210806164730.51040-17-aleksei.kodanev@bell-sw.com>
Message-ID: <YREjL0ttZGLbjJFw@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> + * Pass an invalid pid to sched_getscheduler() and test for ESRCH.
                ^
		unused is more precise I guess.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
