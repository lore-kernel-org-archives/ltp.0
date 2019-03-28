From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 28 Mar 2019 13:24:35 +0800
Subject: [LTP] [PATCH] syscalls/stime: Use 3 variants via
	test_multiplex()
In-Reply-To: <a09a4b26-60c5-f9c6-d7e7-3d1ae47e091d@google.com>
References: <1553668210-6141-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <5C9B19FE.7030907@cn.fujitsu.com>
 <a09a4b26-60c5-f9c6-d7e7-3d1ae47e091d@google.com>
Message-ID: <5C9C5A93.80308@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/03/28 4:13, Steve Muckle wrote:
> On 03/26/2019 11:36 PM, Xiao Yang wrote:
>> Hi Steve,
>>
>> Could you tell me if Android's libc doesn't implements stime()?
>> If libc stime() isn't implemented on Android, we should avoid testing it
>> as the patch does.
>
> Hi Xiao, that is correct, bionic (Android libc) does not provide stime().
>
> I reviewed and tested your patch on Android, looks good to me.
>
> Reviewed-by: Steve Muckle <smuckle@google.com>
> Tested-by: Steve Muckle <smuckle@google.com>
Hi Steve,

Pushed, thanks for your review and test. :-)

Best Regards,
Xiao Yang
>
>>
>> Best Regards,
>> Xiao Yang
>> On 2019/03/27 14:30, Xiao Yang wrote:
>>> We will test stime() libc wrapper, __NR_stime and __NR_settimeofday 
>>> syscalls.
>>>
>>> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
>>> ---
>>> testcases/kernel/syscalls/stime/stime01.c | 11 ++++--
>>> testcases/kernel/syscalls/stime/stime02.c | 8 +++--
>>> testcases/kernel/syscalls/stime/stime_var.h | 54 
>>> +++++++++++++++++++++++++++++
>>> 3 files changed, 68 insertions(+), 5 deletions(-)
>>> create mode 100644 testcases/kernel/syscalls/stime/stime_var.h
>>>
>>> diff --git a/testcases/kernel/syscalls/stime/stime01.c 
>>> b/testcases/kernel/syscalls/stime/stime01.c
>>> index 279b0b1..82a3402 100644
>>> --- a/testcases/kernel/syscalls/stime/stime01.c
>>> +++ b/testcases/kernel/syscalls/stime/stime01.c
>>> @@ -17,8 +17,8 @@
>>> #include <time.h>
>>> #include <sys/time.h>
>>> -#include "lapi/syscalls.h"
>>> #include "tst_test.h"
>>> +#include "stime_var.h"
>>> static struct timeval real_time_tv;
>>> @@ -32,7 +32,7 @@ static void run(void)
>>> new_time = real_time_tv.tv_sec + 30;
>>> - if (tst_syscall(__NR_stime, &new_time) < 0) {
>>> + if (do_stime(&new_time) < 0) {
>>> tst_res(TFAIL | TERRNO, "stime(%ld) failed", new_time);
>>> return;
>>> }
>>> @@ -52,8 +52,15 @@ static void run(void)
>>> }
>>> }
>>> +static void setup(void)
>>> +{
>>> + stime_info();
>>> +}
>>> +
>>> static struct tst_test test = {
>>> .test_all = run,
>>> .needs_root = 1,
>>> .restore_wallclock = 1,
>>> + .setup = setup,
>>> + .test_variants = TEST_VARIANTS,
>>> };
>>> diff --git a/testcases/kernel/syscalls/stime/stime02.c 
>>> b/testcases/kernel/syscalls/stime/stime02.c
>>> index 1aa1021..126a49a 100644
>>> --- a/testcases/kernel/syscalls/stime/stime02.c
>>> +++ b/testcases/kernel/syscalls/stime/stime02.c
>>> @@ -19,15 +19,14 @@
>>> #include <time.h>
>>> #include <pwd.h>
>>> -#include "lapi/syscalls.h"
>>> #include "tst_test.h"
>>> +#include "stime_var.h"
>>> static time_t new_time;
>>> static void run(void)
>>> {
>>> - TEST(tst_syscall(__NR_stime, &new_time));
>>> -
>>> + TEST(do_stime(&new_time));
>>> if (TST_RET != -1) {
>>> tst_res(TFAIL,
>>> "stime() returned %ld, expected -1 EPERM", TST_RET);
>>> @@ -48,6 +47,8 @@ static void setup(void)
>>> time_t curr_time;
>>> struct passwd *ltpuser;
>>> + stime_info();
>>> +
>>> ltpuser = SAFE_GETPWNAM("nobody");
>>> SAFE_SETUID(ltpuser->pw_uid);
>>> @@ -61,4 +62,5 @@ static struct tst_test test = {
>>> .test_all = run,
>>> .setup = setup,
>>> .needs_root = 1,
>>> + .test_variants = TEST_VARIANTS,
>>> };
>>> diff --git a/testcases/kernel/syscalls/stime/stime_var.h 
>>> b/testcases/kernel/syscalls/stime/stime_var.h
>>> new file mode 100644
>>> index 0000000..1b47441
>>> --- /dev/null
>>> +++ b/testcases/kernel/syscalls/stime/stime_var.h
>>> @@ -0,0 +1,54 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
>>> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
>>> + */
>>> +
>>> +#ifndef STIME_VAR__
>>> +#define STIME_VAR__
>>> +
>>> +#include <sys/time.h>
>>> +#include "lapi/syscalls.h"
>>> +
>>> +#define TEST_VARIANTS 3
>>> +
>>> +static int do_stime(time_t *ntime)
>>> +{
>>> + switch (tst_variant) {
>>> + case 0:
>>> +#ifdef __ANDROID__
>>> + tst_brk(TCONF, "libc stime() is not implemented for Android");
>>> +#else
>>> + return stime(ntime);
>>> +#endif
>>> + case 1:
>>> + return tst_syscall(__NR_stime, ntime);
>>> + case 2: {
>>> + struct timeval tv;
>>> +
>>> + tv.tv_sec = *ntime;
>>> + tv.tv_usec = 0;
>>> +
>>> + return tst_syscall(__NR_settimeofday, &tv, (struct timezone *) 0);
>>> + }
>>> + }
>>> +
>>> + return -1;
>>> +}
>>> +
>>> +static void stime_info(void)
>>> +{
>>> + switch (tst_variant) {
>>> + case 0:
>>> + tst_res(TINFO, "Testing libc stime()");
>>> + break;
>>> + case 1:
>>> + tst_res(TINFO, "Testing SYS_stime syscall");
>>> + break;
>>> + case 2:
>>> + tst_res(TINFO, "Testing SYS_settimeofday syscall");
>>> + break;
>>> + }
>>> +}
>>> +
>>> +#endif /* STIME_VAR__ */
>>
>>
>>
>
>
>
> .
>



