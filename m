From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 26 Nov 2019 06:08:01 +0100
Subject: [LTP] [PATCH] memcg_lib/memcg_process: Better synchronization
 of signal USR1
In-Reply-To: <20191125153245.GA15129@rei.lan>
References: <20191106073621.58738-1-lkml@jv-coder.de>
 <365bdf26-4e52-2159-17cd-52f2fb22e7fd@jv-coder.de>
 <20191125132957.GC8703@rei.lan>
 <2e5756af-d7ef-7919-da6b-46e7fbf3cb66@jv-coder.de>
 <20191125153245.GA15129@rei.lan>
Message-ID: <5f914dce-92b7-9070-6230-d76b73d7da34@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


>> We run the test with timeout=1000 now and it works fine. It is simpler
>> than thinking about any
>> other synchronization technique. The additonal wait adds less than 30
>> for all tests, that use memcg_process.
> 30 what? seconds? That is unfortunatelly not acceptable.
Yes 30 seconds. Why shouldn't that be not acceptable? It is nothing compared
to the runtime of other tests.
>
> Actually having a closer look at the code there is a loop that checks
> every 100ms if:
>
> 1) the process is still alive
> 2) if there was increase in usage_in_bytes in the corresponding cgroup
>
> So what is wrong with the original code?
Please reread the description of my initial post. The problem is the 
signal race
not the check. The checkpoint system prevents the race. There is no way 
around
a solid synchronization.
