From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Jan 2021 11:25:20 +0100
Subject: [LTP] [PATCH v1] sched/sched_stress:Modify sched driver param
 to run long term testcases
In-Reply-To: <1602841876-91490-1-git-send-email-luofenglin1@huawei.com>
References: <1602841876-91490-1-git-send-email-luofenglin1@huawei.com>
Message-ID: <X/WQEEj8Kx+tvz78@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Add sched_driver process slots param to 10, then long term testcases can run.
> Additionally, add sched_driver run time 0.05 hour, long term testcases
> run 1/5 of total time.

This does not say why should we run the long term testcases for 1/5 of
total time. As far as I can tell the code looks like the long term tests
are supposed to run on background while we execute the short term tests
in a loop while changing their priority.

Also each logical change should be in a separate patch.

The change to to increase the slots looks good, but should really go in
as a separate patch that explains the change.

-- 
Cyril Hrubis
chrubis@suse.cz
