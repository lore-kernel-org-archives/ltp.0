From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Nov 2019 13:10:39 +0100
Subject: [LTP] [PATCH] memcg_lib/memcg_process: Better synchronization
 of signal USR1
In-Reply-To: <5f914dce-92b7-9070-6230-d76b73d7da34@jv-coder.de>
References: <20191106073621.58738-1-lkml@jv-coder.de>
 <365bdf26-4e52-2159-17cd-52f2fb22e7fd@jv-coder.de>
 <20191125132957.GC8703@rei.lan>
 <2e5756af-d7ef-7919-da6b-46e7fbf3cb66@jv-coder.de>
 <20191125153245.GA15129@rei.lan>
 <5f914dce-92b7-9070-6230-d76b73d7da34@jv-coder.de>
Message-ID: <20191126121038.GC16922@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> We run the test with timeout=1000 now and it works fine. It is simpler
> >> than thinking about any
> >> other synchronization technique. The additonal wait adds less than 30
> >> for all tests, that use memcg_process.
> > 30 what? seconds? That is unfortunatelly not acceptable.
> Yes 30 seconds. Why shouldn't that be not acceptable? It is nothing compared
> to the runtime of other tests.

I have written a blog post that partly applies to this case, see:

https://people.kernel.org/metan/why-sleep-is-almost-never-acceptable-in-tests

> > Actually having a closer look at the code there is a loop that checks
> > every 100ms if:
> >
> > 1) the process is still alive
> > 2) if there was increase in usage_in_bytes in the corresponding cgroup
> >
> > So what is wrong with the original code?
> Please reread the description of my initial post. The problem is the 
> signal race
> not the check. The checkpoint system prevents the race. There is no way 
> around
> a solid synchronization.

So the problem is that sometimes the program has not finished handling
the first signal and we are sending another, right?

I guess that the proper solution would be avoding the signals in the
first place. I guess that we can estabilish two-way communication with
fifos, which would also mean that we would get notified as fast as the
child dies as well.

-- 
Cyril Hrubis
chrubis@suse.cz
