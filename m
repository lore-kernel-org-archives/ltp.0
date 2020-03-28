From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 28 Mar 2020 04:42:53 +0100
Subject: [LTP] [PATCH 0/6] C API: .needs_cmds and SAFE_RUN_CMD()
In-Reply-To: <4ff84a77-b858-6cae-a320-cfaed3646864@163.com>
References: <20200327213924.18816-1-pvorel@suse.cz>
 <4ff84a77-b858-6cae-a320-cfaed3646864@163.com>
Message-ID: <20200328034253.GA2720439@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> On 3/28/20 5:39 AM, Petr Vorel wrote:
> > + There is a double check (first in
> > .needs_cmds, then in SAFE_RUN_CMD()), maybe that's not needed.

> Hi Petr,

> Why do you need the duplicate .needs_cmds flag?(it introduces the double
> check as you said)

> Usually, all tests run commands by tst_run_cmd()/SAFE_RUN_CMD() and they can
> report TCONF

> by passing TST_RUN_CMD_CHECK_CMD so it is fair to be a part of
> tst_run_cmd()/SAFE_RUN_CMD().

Thanks for your review.
I guess Cyril will prefer .needs_cmds, as it can be parsed - metadata project:
https://people.kernel.org/metan/towards-parallel-kernel-test-runs
https://github.com/metan-ucw/ltp/tree/master/docparse

I put it there because some command might be run just under some condition (not
always), thus not suitable for .needs_cmds, but still nice to have reliable
check. But maybe I'm wrong.

Kind regards,
Petr
