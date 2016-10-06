From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 Oct 2016 13:15:49 +0200
Subject: [LTP] [PATCH] syscalls/signal06: fix test for regression with
 earlier version of gcc and kernel
In-Reply-To: <57F627EF.7070605@cn.fujitsu.com>
References: <1470380281-20334-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20161005134303.GA23476@rei.lan> <57F627EF.7070605@cn.fujitsu.com>
Message-ID: <20161006111548.GA9711@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Hmm, what is the exact problem here? Does the old kernel break if we
> > send the signal too fast?
> 
> Yes, running signal06 reports segmentation fault and breaks the test
> if we send the signal too fast on the old kernel.

Hmm, that sounds like a bug itself since we set signal handler for the
SIGSEGV, it shouldn't kill the process while we try to write to the read
only memory. Can you try to run it in a debugger and send a trace?

Since what we do is disable/enable write access to the alternative while
simoutaneously hammer the process with SIGHUP in order to trigger
segfault inside of the sighup signal handler.

I wonder why we have to do that asynchronously in the first place, if
there is a need to hit a particular spot in the kernel while the signal
stack is being written.

Anyway on which systems is this bug reproducible? I can try to make it
both reliable and fast.

> > I do not like much that the test takes ten times more time to finish
> > now.
> 
> Yes, it will take ten times more time than before, but it only takes
> 3~4 seconds to finish...

Let me put that in perspective. We have more than 3000 tests in LTP, if
each of these would take just a few seconds more, the test run would
take a few more hours to finish.

And there is a reason why we need the LTP run to be as fast as possible.
The longer the run takes the less people would use it and it would be
used less frequently which would make all the work put into these
testcases less valuable.

All in all I'm mildly opposed to each change that increses the runtime
if it's not absolutely necessary.

> By current LOOPS(10000), most of the time, the buggy kernel can be
> reproduced, but there is still a chance(about 0.5% in my environment)
> to miss.

Hmm, what about increasing it twice or four times? What is the
probability of missing the bug then?

-- 
Cyril Hrubis
chrubis@suse.cz
