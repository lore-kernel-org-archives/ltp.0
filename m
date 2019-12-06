From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 6 Dec 2019 07:24:23 +0100
Subject: [LTP] [PATCH] memcg_lib/memcg_process: Better synchronization
 of signal USR1
In-Reply-To: <20191203151238.GI2844@rei>
References: <20191106073621.58738-1-lkml@jv-coder.de>
 <365bdf26-4e52-2159-17cd-52f2fb22e7fd@jv-coder.de>
 <20191125132957.GC8703@rei.lan>
 <2e5756af-d7ef-7919-da6b-46e7fbf3cb66@jv-coder.de>
 <20191125153245.GA15129@rei.lan>
 <5f914dce-92b7-9070-6230-d76b73d7da34@jv-coder.de>
 <20191126121038.GC16922@rei.lan>
 <42d40727-f631-39ff-fdc0-576e13336a4d@jv-coder.de>
 <20191203151238.GI2844@rei>
Message-ID: <6d81a8f8-df00-62de-d0aa-aa7bcd3e622b@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
>>> I have written a blog post that partly applies to this case, see:
>>>
>>> https://people.kernel.org/metan/why-sleep-is-almost-never-acceptable-in-tests
>> I know where you are coming from and it is basically the same as my own
>> opinion.
>> The difference is: When I look at ltp I see a runtime of more than 6
>> hours, looking at the
>> controller test alone it is more than 4 hours. This puts 30 seconds into
>> a very differenet
>> perspective than looking at only syscall tests. (In the testrun I looked
>> at it is around 13 minutes).
>> That is why I don't care about 30 seconds in this case.
> controllers testrun runs for 25 minutes on our servers, it will probably
> be reduced to 15 minutes in two or three years with next upgrade. The
> main point is that hardware tends to be faster and faster but any sleep
> in the tests will not scale and ends up being a problem sooner or later.
> It also greatly depends on which HW are you running the tests on.
Ok in that case it makes sense.
>> Correct. Using fifos is probably a viable solution, but it would require
>> library work,
>> because otherwise the overhead is way too big.
>> Another thing I can think of is extending tst_checkpoint wait to also
>> watch a process
>> and stop waiting, if that process dies. This would be the simplest way
>> to get good
>> synchronization and get rid of the sleep.
> I'm not sure if we can implement this without introducing another race
> condition. The only way how to wake up futex from sleep before it
> timeouts in a race-free way is sending a signal. In this case we should
> see EINTR. But that would mean that the process that is waking up the
> futex has to be a child of the process, unless we reparent that process,
> but all that would be too tricky I guess.
>
> If we decide to wake the futex regulary to check if the process is alive
> we can miss the wake. Well the library tries hard and loops over the
> wake syscall for a while, but this could still fail on very slow
> devices under load. But if the timing is unfortunate we may miss more
> than one wake signal, which would lead to timeout. Timing problems like
> that can easily arise on VMs with a single CPU on overbookend host.
Ok, so we are back to fifos. I guess this should be part of the library.
I will send a proposal for discussion to the mailing list later or next 
week.

J?rg
