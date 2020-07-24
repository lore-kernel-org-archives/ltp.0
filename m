From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 24 Jul 2020 13:07:02 +0800
Subject: [LTP] [PATCH V3] syscalls/timer_settime01: Make sure the timer
 fires
In-Reply-To: <20200724033732.gwzu2zdhdziwtbtz@vireshk-mac-ubuntu>
References: <ede8d1c6a1ad1b23d8dca2297c740c301b329e37.1593743927.git.viresh.kumar@linaro.org>
 <47e40724c2a7a9612aca0265e493e62c69d65996.1594204153.git.viresh.kumar@linaro.org>
 <20200714142843.GA14905@yuki.lan>
 <d008820f-22d2-078d-3a62-f1fa20e6750b@cn.fujitsu.com>
 <20200724033732.gwzu2zdhdziwtbtz@vireshk-mac-ubuntu>
Message-ID: <f9289166-5698-e2ec-ecc8-531fbcbd60c5@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Virsh


> Hi,
> 
> On 23-07-20, 10:39, Yang Xu wrote:
>> When tesing timer_settime01 on 3.10.0-1136.el7.x86_64, this case fails
>> whether we use any type clock.
>>
>> timer_settime01.c:174: PASS: timer_settime(CLOCK_BOOTTIME) passed
>> timer_settime01.c:164: FAIL: timer_gettime(CLOCK_BOOTTIME_ALARM) reported
>> bad values (0: 678013000): SUCCESS (0)
>> timer_settime01.c:174: PASS: timer_settime(CLOCK_BOOTTIME_ALARM) passed
>> timer_settime01.c:164: FAIL: timer_gettime(CLOCK_REALTIME_ALARM) reported
>> bad values (0: 358240000): SUCCESS (0)
>> timer_settime01.c:174: PASS: timer_settime(CLOCK_REALTIME_ALARM) passed
>> timer_settime01.c:174: PASS: timer_settime(CLOCK_TAI) passed
> 
> Can you share the complete test log? I am not sure if only the _ALARM
> cocks are failing or all. You are getting values in the order of
> 300-700 ms, while the max value can't be greater than 50 ms. So seems
> like a kernel issue to me. Over that, both _ALARM type clocks weren't
> supported before 3.11 and looks like your kernel version is 3.10.
Yes, only _ALARM fails. I  only find a kernel patch (commit 
11ffa9d6065f344  timerfd: Add alarm timers) introduced alarm clock types 
for timefd in kernel 3.11 and  a kernel patch (commit 9a7adcf5c6dea63d 
timers: Posix interface for alarm-timers)  in kernel 3.1. It seems my 
kernel version has supported this two alarm clock, but not sure why this 
case fails.


  the full log as below:
tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
timer_settime01.c:89: INFO: Testing variant: syscall with old kernel spec
timer_settime01.c:100: INFO: Testing for general initialization:
timer_settime01.c:174: PASS: timer_settime(CLOCK_REALTIME) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_MONOTONIC) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_PROCESS_CPUTIME_ID) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_THREAD_CPUTIME_ID) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_BOOTTIME) passed
timer_settime01.c:164: FAIL: timer_gettime(CLOCK_BOOTTIME_ALARM) 
reported bad values (0: 570013221): SUCCESS (0)
timer_settime01.c:174: PASS: timer_settime(CLOCK_BOOTTIME_ALARM) passed
timer_settime01.c:164: FAIL: timer_gettime(CLOCK_REALTIME_ALARM) 
reported bad values (0: 250240851): SUCCESS (0)
timer_settime01.c:174: PASS: timer_settime(CLOCK_REALTIME_ALARM) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_TAI) passed
timer_settime01.c:100: INFO: Testing for setting old_value:
timer_settime01.c:174: PASS: timer_settime(CLOCK_REALTIME) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_MONOTONIC) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_PROCESS_CPUTIME_ID) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_THREAD_CPUTIME_ID) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_BOOTTIME) passed
timer_settime01.c:164: FAIL: timer_gettime(CLOCK_BOOTTIME_ALARM) 
reported bad values (0: 972013941): SUCCESS (0)
timer_settime01.c:174: PASS: timer_settime(CLOCK_BOOTTIME_ALARM) passed
timer_settime01.c:164: FAIL: timer_gettime(CLOCK_REALTIME_ALARM) 
reported bad values (0: 652241546): SUCCESS (0)
timer_settime01.c:174: PASS: timer_settime(CLOCK_REALTIME_ALARM) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_TAI) passed
timer_settime01.c:100: INFO: Testing for using periodic timer:
timer_settime01.c:174: PASS: timer_settime(CLOCK_REALTIME) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_MONOTONIC) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_PROCESS_CPUTIME_ID) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_THREAD_CPUTIME_ID) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_BOOTTIME) passed
timer_settime01.c:164: FAIL: timer_gettime(CLOCK_BOOTTIME_ALARM) 
reported bad values (50000000: 624015649): SUCCESS (0)
timer_settime01.c:174: PASS: timer_settime(CLOCK_BOOTTIME_ALARM) passed
timer_settime01.c:164: FAIL: timer_gettime(CLOCK_REALTIME_ALARM) 
reported bad values (50000000: 354248401): SUCCESS (0)
timer_settime01.c:174: PASS: timer_settime(CLOCK_REALTIME_ALARM) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_TAI) passed
timer_settime01.c:100: INFO: Testing for using absolute time:
timer_settime01.c:174: PASS: timer_settime(CLOCK_REALTIME) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_MONOTONIC) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_PROCESS_CPUTIME_ID) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_THREAD_CPUTIME_ID) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_BOOTTIME) passed
timer_settime01.c:164: FAIL: timer_gettime(CLOCK_BOOTTIME_ALARM) 
reported bad values (0: 176017000): SUCCESS (0)
timer_settime01.c:174: PASS: timer_settime(CLOCK_BOOTTIME_ALARM) passed
timer_settime01.c:164: FAIL: timer_gettime(CLOCK_REALTIME_ALARM) 
reported bad values (0: 856247000): SUCCESS (0)
timer_settime01.c:174: PASS: timer_settime(CLOCK_REALTIME_ALARM) passed
timer_settime01.c:174: PASS: timer_settime(CLOCK_TAI) passed

> 


