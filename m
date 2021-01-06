From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Jan 2021 11:44:16 +0100
Subject: [LTP] [PATCH v3] sched/sched_stress:Bugfix for setting real
 time priority
In-Reply-To: <1602841876-91490-3-git-send-email-luofenglin1@huawei.com>
References: <1602841876-91490-1-git-send-email-luofenglin1@huawei.com>
 <1602841876-91490-3-git-send-email-luofenglin1@huawei.com>
Message-ID: <X/WUgOgHiWj1+9Nb@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When real time flag is set, setpriority function is used for user-time
> policy setting, here use sched_setscheduler to set real time policy RR
> instead

This explains what has been changed, which is not useful, everyone can
see read the code diff.

What is missing here is why this has been changed, as when you change
the testcases to run with realtime priority the test behavior changes
and we do end up testing something different that the test originally
did.

The main problem with the testsuite is that it's missing high level
description what exactly is being tested and why. The README just says
run sched_stress.sh, that's not useful at all.

-- 
Cyril Hrubis
chrubis@suse.cz
