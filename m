From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 22 Oct 2020 15:09:24 +0800
Subject: [LTP] [PATCH] Remove ftime and sys/timeb.h
In-Reply-To: <5F912C97.9030204@cn.fujitsu.com>
References: <1603339033-8451-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <5F912C97.9030204@cn.fujitsu.com>
Message-ID: <5F913024.7050303@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao
> On 2020/10/22 11:57, Yang Xu wrote:
>> The two case use ftime to get the current milliseconds and it was
>> used to generate random value. Use gettimeofday() to get the microseconds
>> can reach the same aim.
>>
>> This also fixes the travis build error[1] on Fedora:Rawhide because
>> the<sys/timeb.h>
>> has been deprecated[2].
>>
>> [1] https://travis-ci.org/github/linux-test-project/ltp/jobs/737698948
>> [2] https://www.spinics.net/lists/fedora-devel/msg279545.html
>>
>> Reported-by: Petr Vorel<petr.vorel@gmail.com>
>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> ---
>> testcases/kernel/mem/hugetlb/lib/hugetlb.c | 12 ++++++------
>> testcases/kernel/sched/tool/trace_sched.c | 8 ++++----
>> 2 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
>> b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
>> index 4bb2d500e..1204f21d2 100644
>> --- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
>> +++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
>> @@ -35,7 +35,7 @@
>> #include<sys/types.h>
>> #include<sys/ipc.h>
>> #include<sys/shm.h>
>> -#include<sys/timeb.h>
>> +#include<sys/time.h>
>> #include<pwd.h>
>> #include "hugetlb.h"
>>
>> @@ -52,7 +52,7 @@ int getipckey(void)
>> char *curdir = NULL;
>> size_t size = 0;
>> key_t ipc_key;
>> - struct timeb time_info;
>> + struct timeval time_info;
>>
>> curdir = getcwd(curdir, size);
>> if (curdir == NULL)
>> @@ -67,11 +67,11 @@ int getipckey(void)
>> * project identifier is a "random character" produced by
>> * generating a random number between 0 and 25 and then adding
>> * that to the ascii value of 'a'. The "seed" for the random
>> - * number is the millisecond value that is set in the timeb
>> - * structure after calling ftime().
>> + * number is the microseconds value that is set in the timeval
>> + * structure after calling gettimeofday().
>> */
>> - ftime(&time_info);
>> - srandom((unsigned int)time_info.millitm);
>> + gettimeofday(&time_info, NULL);
>> + srandom((unsigned int)time_info.tv_usec);
>>
>> ipc_key = ftok(curdir, ascii_a + random() % 26);
>> if (ipc_key == -1)
>> diff --git a/testcases/kernel/sched/tool/trace_sched.c
>> b/testcases/kernel/sched/tool/trace_sched.c
>> index 71caf239a..e23fc7399 100644
>> --- a/testcases/kernel/sched/tool/trace_sched.c
>> +++ b/testcases/kernel/sched/tool/trace_sched.c
>> @@ -52,7 +52,7 @@
>> #include<sys/types.h>
>> #include<sys/stat.h>
>> #include<sys/wait.h>
>> -#include<sys/timeb.h>
>> +#include<sys/time.h>
>> #include<unistd.h>
>> #include<string.h>
>>
>> @@ -199,7 +199,7 @@ void *thread_func(void *args)
>> static int sched_policy; /* scheduling policy as set by user/default */
>> struct sched_param ssp; /* set schedule priority. */
>> struct sched_param gsp; /* gsp schedule priority. */
>> - struct timeb tptr; /* tptr.millitm will be used to seed srand. */
>> + struct timeval tptr; /* tv_usec will be used to seed srand. */
>> thread_sched_t *locargptr = /* local ptr to the arguments. */
>> (thread_sched_t *) args;
>>
>> @@ -215,8 +215,8 @@ void *thread_func(void *args)
>> ssp.sched_priority = 0;
>> else {
>> /* Set a random value between max_priority and min_priority */
>> - ftime(&tptr);
>> - srand((tptr.millitm) % 1000);
>> + gettimeofday(&tptr, NULL);
>> + srand((tptr.tv_usec) % 1000000);
> Hi Yang,
>
> One minor issue:
> '% 1000000' seems useless because the range of tv_usec is 0~999999.
Agree. Will fix it in v2 patch.

Best Regards
Yang Xu
>
> Other than that, it's good to me.
>
> Best Regards,
> Xiao Yang
>> set_priority = (min_priority + (int)((float)max_priority
>> * rand() / (RAND_MAX +
>> 1.0)));
>
> .
>



