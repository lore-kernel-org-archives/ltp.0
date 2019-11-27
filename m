From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 27 Nov 2019 08:41:32 +0100
Subject: [LTP] [PATCH] memcg_lib/memcg_process: Better synchronization
 of signal USR1
In-Reply-To: <42d40727-f631-39ff-fdc0-576e13336a4d@jv-coder.de>
References: <20191106073621.58738-1-lkml@jv-coder.de>
 <365bdf26-4e52-2159-17cd-52f2fb22e7fd@jv-coder.de>
 <20191125132957.GC8703@rei.lan>
 <2e5756af-d7ef-7919-da6b-46e7fbf3cb66@jv-coder.de>
 <20191125153245.GA15129@rei.lan>
 <5f914dce-92b7-9070-6230-d76b73d7da34@jv-coder.de>
 <20191126121038.GC16922@rei.lan>
 <42d40727-f631-39ff-fdc0-576e13336a4d@jv-coder.de>
Message-ID: <fb1559d9-6d1b-a870-f7b6-471f7599c1fd@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
>>
>> So the problem is that sometimes the program has not finished handling
>> the first signal and we are sending another, right?
>>
>> I guess that the proper solution would be avoding the signals in the
>> first place. I guess that we can estabilish two-way communication with
>> fifos, which would also mean that we would get notified as fast as the
>> child dies as well.
> Correct. Using fifos is probably a viable solution, but it would 
> require library work,
> because otherwise the overhead is way too big.
> Another thing I can think of is extending tst_checkpoint wait to also 
> watch a process
> and stop waiting, if that process dies. This would be the simplest way 
> to get good
> synchronization and get rid of the sleep.
>
When thinking about this yesterday, I had another idea to fix it without 
much work:
For the test, that expects the process to terminate, just don't call 
tst_checkpoint at
all. We know it will fail there. Would this be acceptable for you?

J?rg
