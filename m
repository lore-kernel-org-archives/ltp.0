From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 16 Oct 2019 07:39:52 +0200
Subject: [LTP] [PATCH] open_posix/timer_getoverrun/2-3: Fix test for
 systems with low timer precision
In-Reply-To: <2097000229.6302768.1571152116580.JavaMail.zimbra@redhat.com>
References: <20191011053134.18416-1-lkml@jv-coder.de>
 <2097000229.6302768.1571152116580.JavaMail.zimbra@redhat.com>
Message-ID: <3c5988d6-0e37-6ca8-2567-a98d2ff84dce@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
>> On systems with low timer precision the test always fails, because the
>> allowed
>> maximum number of overruns is calculated from the expected overruns + 10%.
> Did you mean 1% here?
>    fudge = expectedoverruns / 100;
Of course, you are right
>
>> If the expected overruns is less than 200, there is no tollerance.
>> This happens, if the precision of the timer is less than or equal to 4ms.
>> E.g. qemu-arm64 without high resolution timer the accuracy is only 4ms.
> Would tweaking tolerance work too? E.g. use float, round up.
Actually rounding up would not work. I tried it with a timer accuracy of 
4ms and I needed
at least a fudge of two. Rounding up would only result in one. That it 
why I decided to
go for extending the duration
>
> I was assuming -1 in original code is to cope with final timer expiration of tssleep.tv_sec,
> which might not be counted as "overrun". What does the -1 do in your formula?
> Why is it inside brackets?
You may be right. I am not completely sure what it is used for, but I 
guess you are right.
>
> When I try to force different interval values, it fails for me (on x86):
> 3ms
> # ./timer_getoverrun_2-3.run-test
> duration = 7 sec, interval = 6000000 nsec, expected overruns = 1155
> 1166 overruns occurred
> FAIL:  1166 overruns sent; expected 1155
>
> 5ms
> # ./timer_getoverrun_2-3.run-test
> duration = 11 sec, interval = 10000000 nsec, expected overruns = 1089
> 1100 overruns occurred
> FAIL:  1100 overruns sent; expected 1089
How is it possible to force the timer resolution? I tested on qemu
with aarch64 and x86_64 with and without highres=off and ir worked.

If the -1 is outside the brackets, it would fix both of your test cases.
(1155 + 7 - 1)? = 1161; +1% = 1172 -> expected overruns [1161, 1172)
(1089 + 11 - 1) = 1099; +1% = 1109 ->expected overruns [1099, 1109)

J?rg

