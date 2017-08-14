From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Aug 2017 15:33:51 +0200
Subject: [LTP] [PATCH V2 1/2] ltp: Add the ability to specify the
 latency constraint
In-Reply-To: <a0a61ae1-15fe-fc0d-9bfb-b2efd94f3c42@linaro.org>
References: <337916262.70548323.1502450718721.JavaMail.zimbra@redhat.com>
 <1502456086-14696-1-git-send-email-daniel.lezcano@linaro.org>
 <20170811140905.GB3341@rei.lan>
 <b11d663b-0afb-58a7-bc3d-14d3e61084c4@linaro.org>
 <20170811152855.GA14152@rei.lan>
 <a0a61ae1-15fe-fc0d-9bfb-b2efd94f3c42@linaro.org>
Message-ID: <20170814133351.GA11524@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > tests that should end up 
> > using the same timer with the same slack formula in kernel and hence 
> > should fail in the very same way. And possibly rest of the timer 
> > testcases should likely fail as well since these are not that 
> > different either.
> 
> The latencies introduced by the kernel energy saving framework can make
> these tests to fail and it is impossible to get rid of that, except by
> setting the latency to zero when running specific test cases.
> 
> 
> > Are you, by any chance, using latest stable release? Since we had 
> > rewritten all the timer precision tests recently in:
> > 
> > https://github.com/linux-test-project/ltp/commit/c459654db64cd29177a382ab178fdd5ad59664e4
> 
> Yes, I am.

That explains it. Previously each of the timer testcases had it's own
PASS/FAIL criteria and each of them was slightly different. We got rid
of that mess recetly and so the latest git has a timer measurement
library and the test only defines a sampling function now. We also did
quite a lot of testing to make sure that the test are stable now.  And
because of that we take more samples and apply discarded mean to get rid
of random outliners. But we did most of the testing on x86 hardware so
it's possible that it still needs some adjustements.

Can you, please, try with the latest git to see if these tests works for
you now? And then, in a case that they stil fail, we will figure out how
to fix them. Most likely we will patch the timer test library, either
to loosen the crieria or to keep the cpu_dma_latecy open while we sample
the timers.

-- 
Cyril Hrubis
chrubis@suse.cz
