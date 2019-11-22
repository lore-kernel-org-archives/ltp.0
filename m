From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 22 Nov 2019 14:33:43 +0100
Subject: [LTP] [PATCH v2 2/3] perf_event_open02: make do_work() run for
 specified time
In-Reply-To: <219b1b89de51fda28a0af02f6b15e6da8c73ab7c.1574363475.git.jstancek@redhat.com>
References: <5b0f2a837117f3af1351d8b3da357cacecaa1463.1574087532.git.jstancek@redhat.com>
 <219b1b89de51fda28a0af02f6b15e6da8c73ab7c.1574363475.git.jstancek@redhat.com>
Message-ID: <20191122133343.GD19146@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> do_work() runtime varies a lot, because it's based on a fixed
> number of iterations. Use a timer and measure how many iterations
> are needed to run for specified time. We don't need fine accuracy,
> just some coarse runtime across all systems. verify() function is
> using larger value to get more precision for "ratio" calculation.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  .../syscalls/perf_event_open/perf_event_open02.c   | 52 +++++++++++++++++++---
>  1 file changed, 45 insertions(+), 7 deletions(-)
> 
> Notes for v2
> --------------
> 
> Problem with v1 is that it hangs on -rt kernel. With FIFO scheduling
> signal handler never runs and there's nothing to stop do_work().
> Adding sched_yield() to periodically call in do_work() is problem too,
> because test spends more time in kernel and it breaks the expectation
> for 'ratio'.
> 
> So in v2, use timer only to estimate number of (100 thousands) loops
> needed to run for specified time. Actual test will use the estimated
> number (or multiple of it).
> 
> Tested with: 5.3.0-0.rc6.git0.1.fc31.x86_64
> 	     4.18.0-143.el8.x86_64
> 	     4.18.0-147.rt24.93.el8.x86_64

Looks good, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
