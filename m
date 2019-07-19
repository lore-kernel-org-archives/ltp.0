From: Hongzhi, Song <hongzhi.song@windriver.com>
Date: Fri, 19 Jul 2019 16:13:08 +0800
Subject: [LTP] Question about kernel/syscall/signal/signal06.c
In-Reply-To: <20190717094614.GA9539@rei>
References: <56f854e2-9cc6-4725-3182-ff83e106ee23@windriver.com>
 <20190717094614.GA9539@rei>
Message-ID: <7d2c4936-2e89-6285-c856-a156d3a76284@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This case fails when boot qemux86-64 with 1/2 cores.

I find [kernel 5.2-rc1: 0d714dba162] causes the failure by git bisect.

If git checkout a commit before 0d714dba162, the case will pass on the 
same qemu configuration.


--Hongzhi


On 7/17/19 5:46 PM, Cyril Hrubis wrote:
> Hi!
>> I find signal06 fails on qemux86-64 when qemu has a small number cores,
>> e.g. "qemu -smp 1/2/4/6".
>>
>> ERROR INFO:
>>
>> signal06?????? 0?? TINFO?? :?? loop = 23
>> signal06?????? 1?? TFAIL?? :?? signal06.c:87: Bug Reproduced!
>>
>> But if boot qemu with "-smp 16", the case has great chance to pass.
>>
>>
>> I have two questions about this case:
>>
>> 1. I don't know why multi-core will affect the case.
> Have you looked into the code? The test is trying to reproduce a race
> condition between two threads of course the number of cores does affect
> the reproducibility.
>
>> 2. On failure situation, what does break the "while loop" shown in below
>> code.
> Bug in a kernel that fails to restore fpu state.
>
