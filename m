From: Lachlan Sneff <t-josne@linux.microsoft.com>
Date: Wed, 15 Jul 2020 15:46:37 -0400
Subject: [LTP] [PATCH 1/2] IMA: Verify that the kernel cmdline is passed
 and measured correctly through the kexec barrier.
In-Reply-To: <20200715081857.GB10916@dell5510>
References: <20200702153545.3126-1-t-josne@linux.microsoft.com>
 <20200702153545.3126-2-t-josne@linux.microsoft.com>
 <20200715081857.GB10916@dell5510>
Message-ID: <3ec443ab-f9ed-a435-2a61-e1b7c8f513dd@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On 7/15/20 4:18 AM, Petr Vorel wrote:
>> +++ b/testcases/kexec/utils.sh
>> @@ -0,0 +1,47 @@
>> +#!/bin/sh
>> +
>> +install() {
>> +    local arg="$1"
>> +
>> +    if [ ! -d "/etc/init.d" ]; then
>> +        mkdir /etc/init.d
>> +    fi
> I'm not sure if tests like this are suitable for LTP.
> Ideal LTP test is a normal test, which is able to run with runltp, cleanup after
> itself and use LTP C or/and shell API. LTP is full of tests which needs special
> handling and thus not being run, not sure if it's a good idea to introduce yet
> another one.
>
> Also test shouldn't not significantly modify SUT to make it unbootable, which
> I'm not sure in this case. This is a big difference to kselftests which are
> meant to help during kernel development which somehow expects some system
> modifications (as you install your custom build kernel).
>
> I wonder if using QEMU would help to implement this test while not touching SUT
> (thus be able to run this test with runltp). If you miss something in LTP API
> just let us know.
Using qemu is an interesting idea, but would be difficult to generalize.

I actually do agree with you that a test like this may not be 
appropriate for
LTP since it's so separate and alien to the rest of the LTP suite.

I need to confirm internally before I make a decision here, but is there
a better place to put a test like this?


Thanks for your review,

Lachlan :)

