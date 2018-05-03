From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 May 2018 10:49:31 +0200
Subject: [LTP] [PATCH] [RFC] syscalls/perf_event_open02: Fix failures
In-Reply-To: <20180424124957.15634-1-chrubis@suse.cz>
References: <20180424124957.15634-1-chrubis@suse.cz>
Message-ID: <20180503084931.GE29568@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The testcase was failing randomly, it could be reproduced easily when
> the machine is under load. To reproduce the issue just run a few
> dd if=/dev/zero of=/dev/null to saturate your CPUs.
> 
> It has been sugessted that the reason for the failure are rounding
> errors caused by a frequent preemption. I haven't got a definitive
> answer from kernel devs for this but it's true that changing the process
> pritority to realtime SCHED_FIFO for the measurement does fix the issue.
> 
> So we either delete the test or apply this patch.

Any comments for this patch?

I would like to have this sorted out before the release...

-- 
Cyril Hrubis
chrubis@suse.cz
