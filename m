From: Na Nha <minhnhan0801@gmail.com>
Date: Sat, 2 Dec 2017 17:45:45 +0700
Subject: [LTP] [PROBLEM_WITH_CPUACCT.SH_100_100_LTP_TESTSUITE]
In-Reply-To: <20171122143156.GE2389@rei.lan>
References: <CAPiF6ThOKV6egQ8nhxKoiUba1S8UzLP3h0LOB+HO8T9vc0vemg@mail.gmail.com>
 <20171122143156.GE2389@rei.lan>
Message-ID: <CAPiF6TiT_Sob2A=JXYNUUbOmqk3aGVqKj0MQF-kJE+z0MfsHoA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi!


Many thanks for your reply.

Could you explain further to me that why it’s not kind of CPU overload?

Actually, I had given it 2 tries for 2 cases: fresh cpuacct.sh
(non-modified) and cpuacct.sh with delay function.

Besides I had calculated the percentage of CPU usage from /proc/stat
from this project https://github.com/pcolby/scripts along with.

So what I have observed that the first case (without delay) always
consumes 100% CPU usage and my ARM board was restarted immediately
then.

On the other hand, after adding delay function into cpuacct.sh, it was
only 50% and nothing wrong happened.


So I think it’s truly kind of CPU overload.


Trân trọng / Best regards,

Nhan Le Minh

2017-11-22 21:31 GMT+07:00 Cyril Hrubis <chrubis@suse.cz>:
> Hi!
>> I had run the test case ???./cpuacct.sh 100 100??? on my ARM board.
>>
>> Afterward,  I have gotten a problem as bellow:
>>
>>
>>
>> *1 TINFO: Creating 100 subgroups each with 100 processes*
>>
>> *[69402.212655] imx2_wdt_interrupt: pretimer*
>>
>> *[69402.212777] The following is the list of last 50 interrupts for each
>> CPU*
>>
>> *[69402.212868] [69402.145532]: irqnumber 1023 cpuid 0*
>>
>> *[69402.212960] [69402.145727]: irqnumber 99 cpuid 0*
>>
>>
>>
>> And my ARM board restarted immediately.
>
> If that happens the odds are that you hardware/kernel is buggy.
>
>> I think the test case had made my board run out of CPU power(CPU
>> overloading ), so the watchdog timer has identified this problem and
>> restarted the board.
>
> There is no such thing CPU overload as far as I can tell. For small
> system it may be the case that you are running out of memory but if
> adding sleep to the loop fixes the problem that shouldn't be the case.
>
> So all in all this looks like buggy kernel to me.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
