From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Apr 2018 15:39:31 +0200
Subject: [LTP] LTP Release preparations
In-Reply-To: <20180419141749.GA13045@rei>
References: <20180412113532.GA5963@rei>
 <20180419141749.GA13045@rei>
Message-ID: <20180424133931.GA18016@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I suppose that we should get in the fix for the read_all testcase along
> with the exponential back off.
> 
> Also I would like to get in the needs_rofs patchset.
> 
> There is also patch for converting our python code to be python3
> compatible that is worth looking into.

That has been done.

I've also send a patch for long-standing problem with perf_event_open02
testcase that would be a good candidate for the release.

Peter how is it with the IMA testsuite, should we merge the patchset and
call it incremental improvement over the previous code?

Anything else to be merged?

I would like to go for freezing the git at the end of the week and
start with a pre-release testing next week. Is that OK with everyone?

-- 
Cyril Hrubis
chrubis@suse.cz
