From: xuyang <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 24 May 2019 15:36:04 +0800
Subject: [LTP] [PATCH v2] syscalls/prctl05.c: New test for prctl() with
 PR_{SET, GET}_NAME
In-Reply-To: <70578dc6-1a6b-9ab1-1298-0539ae8562f9@163.com>
References: <20190523094003.GC30616@rei.lan>
 <1558611333-10161-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <70578dc6-1a6b-9ab1-1298-0539ae8562f9@163.com>
Message-ID: <5CE79EE4.40403@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2019/05/23 19:51, Xiao Yang wrote:
>
>
> On 05/23/2019 07:35 PM, Yang Xu wrote:
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   include/lapi/prctl.h                       |  5 ++
>>   runtest/syscalls                           |  1 +
>>   testcases/kernel/syscalls/prctl/.gitignore |  1 +
>>   testcases/kernel/syscalls/prctl/prctl05.c  | 71 ++++++++++++++++++++++
>>   4 files changed, 78 insertions(+)
>>   create mode 100644 testcases/kernel/syscalls/prctl/prctl05.c
>>
>> diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
>> index f42bd6459..ad0b12bce 100644
>> --- a/include/lapi/prctl.h
>> +++ b/include/lapi/prctl.h
>> @@ -9,6 +9,11 @@
>>     #include <sys/prctl.h>
>>   +#ifndef PR_SET_NAME
>> +# define PR_SET_NAME 15
>> +# define PR_GET_NAME 16
>> +#endif
>> +
>>   #ifndef PR_SET_SECCOMP
>>   # define PR_GET_SECCOMP  21
>>   # define PR_SET_SECCOMP  22
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 04558a580..d2dcd2152 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -862,6 +862,7 @@ prctl01 prctl01
>>   prctl02 prctl02
>>   prctl03 prctl03
>>   prctl04 prctl04
>> +prctl05 prctl05
>>     pread01 pread01
>>   pread01_64 pread01_64
>> diff --git a/testcases/kernel/syscalls/prctl/.gitignore 
>> b/testcases/kernel/syscalls/prctl/.gitignore
>> index 1c3da3052..9ecaf9854 100644
>> --- a/testcases/kernel/syscalls/prctl/.gitignore
>> +++ b/testcases/kernel/syscalls/prctl/.gitignore
>> @@ -2,3 +2,4 @@
>>   /prctl02
>>   /prctl03
>>   /prctl04
>> +/prctl05
>> diff --git a/testcases/kernel/syscalls/prctl/prctl05.c 
>> b/testcases/kernel/syscalls/prctl/prctl05.c
>> new file mode 100644
>> index 000000000..fad5b23bf
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/prctl/prctl05.c
>> @@ -0,0 +1,71 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> + *
>> + * Test PR_GET_NAME and PR_SET_NAME of prctl(2).
>> + * 1)Set the name of the calling thread, the name can be up to 16 bytes
>> + *   long, including the terminating null byte. If exceeds 16 bytes, 
>> the
>> + *   string is silently truncated.
>> + * 2)Return the name of the calling thread, the buffer should allow 
>> space
>> + *   for up to 16 bytes, the returned string will be null-terminated.
>> + * 3)Check /proc/self/task/[tid]/comm name whether matches the 
>> thread_name.
>> + */
>> +
>> +#include <errno.h>
>> +#include <sys/types.h>
>> +#include <sys/prctl.h>
>> +#include <string.h>
>> +#include <stdio.h>
>> +#include "lapi/syscalls.h"
>> +#include "lapi/prctl.h"
>> +#include "tst_test.h"
>> +
>> +#define thread_name "prctl05_test_xxxxx"
> Hi Xu,
>
> It seems better to use upper case for macro.
>
>> +
>> +static void verify_prctl(void)
>> +{
>> +    char buf[20];
>> +    char comm_buf[20];
>> +    char PROC_NAME_PATH[40];
>> +    pid_t tid;
>> +
>> +    TEST(prctl(PR_SET_NAME, &thread_name));
>
> Why do you want to use the address of macro?
>
>> +    if (TST_RET == -1) {
>> +        tst_res(TFAIL | TTERRNO, "prctl(PR_SET_NAME) failed");
>> +        return;
>> +    }
>> +    tst_res(TPASS,
>> +        "prctl(PR_SET_NAME) succeeded, set thread name as 
>> prctl05_test_xxxxx");
>
> How about using ("...set thread name as %s", thread_name)?
>
>> +
>> +    TEST(prctl(PR_GET_NAME, &buf));
>
> &buf is the same as buf here so we can use buf directly.
>
>> +    if (TST_RET == -1) {
>> +        tst_res(TFAIL | TTERRNO, "prctl(PR_GET_NAME) failed");
>> +        return;
>> +    }
>> +
>> +    buf[19] = '\0';
>> +    if (!strncmp(thread_name, buf, 15) && strlen(buf) == 15)
>> +        tst_res(TPASS, "prctl(PR_GET_NAME) succeeded, "
>> +                "thread name is %s", buf);
>> +    else
>> +        tst_res(TFAIL,
>> +            "prctl(PR_GET_NAME) failed to truncate the name into 16 
>> byte long");
>
> Can we test the shorter name of the calling thread(i.e. shorter than 
> 16 byte) as well?

Hi xiao

   OK. I will add a test for the shorter name and correct my code in v3 patch.
   Thanks for your review.

Best Regards
Yang Xu

>
> Best Regards,
> Xiao Yang
>> +
>> +    tid = tst_syscall(__NR_gettid);
>> +
>> +    sprintf(PROC_NAME_PATH, "/proc/self/task/%d/comm", tid);
>> +    SAFE_FILE_SCANF(PROC_NAME_PATH, "%s", comm_buf);
>> +    if (strcmp(buf, comm_buf))
>> +        tst_res(TFAIL,
>> +            "%s sets name failed, expected prctl105_test_xx, got %s",
>> +            PROC_NAME_PATH, comm_buf);
>> +    else
>> +        tst_res(TPASS, "%s sets thread name succeed as %s",
>> +            PROC_NAME_PATH, comm_buf);
>> +
>> +}
>> +
>> +static struct tst_test test = {
>> +    .test_all = verify_prctl,
>> +};
>
>
>
>
> .
>



