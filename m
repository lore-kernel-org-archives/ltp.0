From: Yuriy Kolerov <Yuriy.Kolerov@synopsys.com>
Date: Tue, 19 Jul 2016 10:25:20 +0000
Subject: [LTP] [PATCH 2/2] syscalls/perf_event_open{01,
 02}: Add -n arg for size of idle loop
In-Reply-To: <20160718161445.GA23240@rei.lan>
References: <1468596953-3407-1-git-send-email-yuriy.kolerov@synopsys.com>
 <1468596953-3407-2-git-send-email-yuriy.kolerov@synopsys.com>
 <20160718161445.GA23240@rei.lan>
Message-ID: <3ABF60118B9B784CA5BF7C841D2F00ECFF9B6E@de02wembxa.internal.synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

We have a pretty slow development board with 50-100MHz cores and perf_event_open0x.c can take ~10 minutes on it. I think that dividing LOOPS macro by 10 is fine even for such slow targets. I will prepare a second version of the patch.

-----Original Message-----
From: Cyril Hrubis [mailto:chrubis@suse.cz] 
Sent: Monday, July 18, 2016 7:15 PM
To: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Cc: ltp@lists.linux.it; Vineet.Gupta1@synopsys.com; Alexey.Brodkin@synopsys.com
Subject: Re: [LTP] [PATCH 2/2] syscalls/perf_event_open{01, 02}: Add -n arg for size of idle loop

Hi!
> The value of this option is used in do_word() idle loop. By default
> do_work() iterates 1000000000 times. However such loop may take a long 
> time to finish for all available performance counters on some boards. 
> It would be useful to have an ability to choose the size of idle loop.

Ideally LTP testcases should run just fine without any specific tweaks.

Looking at the code for perf_event_open01.c we can simply change the predefined value of loops. Since this is just a basic test that enables the interface and reads the values but does not try do anything with them. The test would run just fine even if we didn't do anything in between ENABLE and DISABLE ioctls().

The perf_event_open02.c is a bit more complicated, it test grouping and multiplexing. Looking at the test it runs for about 4 second on a cheap notebook so I can imagine that it takes couple of minutes on slow hardware. I guess that we can safely divide the nunber of default loops by 10 and everything should continue just fine.

So would diving by 10 work for you?


If that is still too slow we can always change the test to setup an timer that would send a signal which would set set a variable which would stop the loop in do_work() so that the test runs defined amount of time regardless of the machine speed.

Or we could measure how long reasonably small number of iterations takes in order to callibrate the number of loops the do_work() function should do.

--
Cyril Hrubis
chrubis@suse.cz
