From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Nov 2017 15:31:56 +0100
Subject: [LTP] [PROBLEM_WITH_CPUACCT.SH_100_100_LTP_TESTSUITE]
In-Reply-To: <CAPiF6ThOKV6egQ8nhxKoiUba1S8UzLP3h0LOB+HO8T9vc0vemg@mail.gmail.com>
References: <CAPiF6ThOKV6egQ8nhxKoiUba1S8UzLP3h0LOB+HO8T9vc0vemg@mail.gmail.com>
Message-ID: <20171122143156.GE2389@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I had run the test case ???./cpuacct.sh 100 100??? on my ARM board.
> 
> Afterward,  I have gotten a problem as bellow:
> 
> 
> 
> *1 TINFO: Creating 100 subgroups each with 100 processes*
> 
> *[69402.212655] imx2_wdt_interrupt: pretimer*
> 
> *[69402.212777] The following is the list of last 50 interrupts for each
> CPU*
> 
> *[69402.212868] [69402.145532]: irqnumber 1023 cpuid 0*
> 
> *[69402.212960] [69402.145727]: irqnumber 99 cpuid 0*
> 
> 
> 
> And my ARM board restarted immediately.

If that happens the odds are that you hardware/kernel is buggy.

> I think the test case had made my board run out of CPU power(CPU
> overloading ), so the watchdog timer has identified this problem and
> restarted the board.

There is no such thing CPU overload as far as I can tell. For small
system it may be the case that you are running out of memory but if
adding sleep to the loop fixes the problem that shouldn't be the case.

So all in all this looks like buggy kernel to me.

-- 
Cyril Hrubis
chrubis@suse.cz
