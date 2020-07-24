From: Yang Xu <xuyang_jy_0410@163.com>
Date: Fri, 24 Jul 2020 23:01:47 +0800
Subject: [LTP] [PATCH V3] syscalls/timer_settime01: Make sure the timer
 fires
In-Reply-To: <20200724132913.GH9768@yuki.lan>
References: <ede8d1c6a1ad1b23d8dca2297c740c301b329e37.1593743927.git.viresh.kumar@linaro.org>
 <47e40724c2a7a9612aca0265e493e62c69d65996.1594204153.git.viresh.kumar@linaro.org>
 <20200714142843.GA14905@yuki.lan>
 <d008820f-22d2-078d-3a62-f1fa20e6750b@cn.fujitsu.com>
 <20200724033732.gwzu2zdhdziwtbtz@vireshk-mac-ubuntu>
 <f9289166-5698-e2ec-ecc8-531fbcbd60c5@cn.fujitsu.com>
 <20200724132913.GH9768@yuki.lan>
Message-ID: <6376bcd5-0a82-c625-eaee-8684ff707f10@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

HI Cyril


> Hi!
>>>> When tesing timer_settime01 on 3.10.0-1136.el7.x86_64, this case fails
>>>> whether we use any type clock.
>>>>
>>>> timer_settime01.c:174: PASS: timer_settime(CLOCK_BOOTTIME) passed
>>>> timer_settime01.c:164: FAIL: timer_gettime(CLOCK_BOOTTIME_ALARM) reported
>>>> bad values (0: 678013000): SUCCESS (0)
>>>> timer_settime01.c:174: PASS: timer_settime(CLOCK_BOOTTIME_ALARM) passed
>>>> timer_settime01.c:164: FAIL: timer_gettime(CLOCK_REALTIME_ALARM) reported
>>>> bad values (0: 358240000): SUCCESS (0)
>>>> timer_settime01.c:174: PASS: timer_settime(CLOCK_REALTIME_ALARM) passed
>>>> timer_settime01.c:174: PASS: timer_settime(CLOCK_TAI) passed
>>>
>>> Can you share the complete test log? I am not sure if only the _ALARM
>>> cocks are failing or all. You are getting values in the order of
>>> 300-700 ms, while the max value can't be greater than 50 ms. So seems
>>> like a kernel issue to me. Over that, both _ALARM type clocks weren't
>>> supported before 3.11 and looks like your kernel version is 3.10.
>> Yes, only _ALARM fails. I  only find a kernel patch (commit
>> 11ffa9d6065f344  timerfd: Add alarm timers) introduced alarm clock types
>> for timefd in kernel 3.11 and  a kernel patch (commit 9a7adcf5c6dea63d
>> timers: Posix interface for alarm-timers)  in kernel 3.1. It seems my
>> kernel version has supported this two alarm clock, but not sure why this
>> case fails.
> 
> This is on RHEL kernel that has backported the _ALARM support right? So
> this may as well be case of badly bacported patch...
Just double check. My previous word may  make you feel confused.
On RHEL7 kernel, timer_* includes ALARM supports because kernel has 
upported it since 3.1 and timers_fd doesn't introduced ALARM 
support(REHL7 doesn't backport this patch). IMO, this case doesn't 
call/use timerfd_* function. We only need timer_*  ALARM suuport to run 
this case. so it doesn't need to backport ALARM support. Or, I miss some 
thing?
> 

