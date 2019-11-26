From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 26 Nov 2019 13:39:11 +0100
Subject: [LTP] [PATCH] memcg_lib/memcg_process: Better synchronization
 of signal USR1
In-Reply-To: <20191126121038.GC16922@rei.lan>
References: <20191106073621.58738-1-lkml@jv-coder.de>
 <365bdf26-4e52-2159-17cd-52f2fb22e7fd@jv-coder.de>
 <20191125132957.GC8703@rei.lan>
 <2e5756af-d7ef-7919-da6b-46e7fbf3cb66@jv-coder.de>
 <20191125153245.GA15129@rei.lan>
 <5f914dce-92b7-9070-6230-d76b73d7da34@jv-coder.de>
 <20191126121038.GC16922@rei.lan>
Message-ID: <42d40727-f631-39ff-fdc0-576e13336a4d@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


>> Yes 30 seconds. Why shouldn't that be not acceptable? It is nothing compared
>> to the runtime of other tests.
> I have written a blog post that partly applies to this case, see:
>
> https://people.kernel.org/metan/why-sleep-is-almost-never-acceptable-in-tests
I know where you are coming from and it is basically the same as my own 
opinion.
The difference is: When I look at ltp I see a runtime of more than 6 
hours, looking at the
controller test alone it is more than 4 hours. This puts 30 seconds into 
a very differenet
perspective than looking at only syscall tests. (In the testrun I looked 
at it is around 13 minutes).
That is why I don't care about 30 seconds in this case.

>
> So the problem is that sometimes the program has not finished handling
> the first signal and we are sending another, right?
>
> I guess that the proper solution would be avoding the signals in the
> first place. I guess that we can estabilish two-way communication with
> fifos, which would also mean that we would get notified as fast as the
> child dies as well.
Correct. Using fifos is probably a viable solution, but it would require 
library work,
because otherwise the overhead is way too big.
Another thing I can think of is extending tst_checkpoint wait to also 
watch a process
and stop waiting, if that process dies. This would be the simplest way 
to get good
synchronization and get rid of the sleep.
