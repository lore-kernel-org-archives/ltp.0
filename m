From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 28 Jan 2021 14:41:34 +0800
Subject: [LTP] [PATCH v2] syscalls/time{01,
 02}: Convert to new API and merge them
In-Reply-To: <05e9d284-407a-9c42-afcc-6200363d419a@cn.fujitsu.com>
References: <20210127102234.1282037-1-ruansy.fnst@cn.fujitsu.com>
 <601227EF.4080105@cn.fujitsu.com>
 <05e9d284-407a-9c42-afcc-6200363d419a@cn.fujitsu.com>
Message-ID: <60125C9E.9020101@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2021/1/28 13:30, Ruan Shiyang wrote:
>
>
> On 2021/1/28 ??10:56, Xiao Yang wrote:
>> On 2021/1/27 18:22, Shiyang Ruan wrote:
>>> Merge the two cases because each of them is very simple.
>>>
>>> Signed-off-by: Shiyang Ruan<ruansy.fnst@cn.fujitsu.com>
>>> ---
>>>   testcases/kernel/syscalls/time/time01.c | 204 
>>> ++++++------------------
>>>   testcases/kernel/syscalls/time/time02.c | 147 -----------------
>>>   2 files changed, 47 insertions(+), 304 deletions(-)
>>>   delete mode 100644 testcases/kernel/syscalls/time/time02.c
>> Hi Ruan,
>>
>> You also need to remove all entries releated to time02, for example:
>> runtest/syscalls:time02 time02
>> testcases/kernel/syscalls/time/.gitignore:/time02 >
>
> Yes, I forgot that.
>
> ...
>
>>> +/*\
>>> + * [DESCRIPTION]
>>> + * 1) Basic test for the time(2) system call. It is intended to 
>>> provide a
>>> + * limited exposure of the system call.
>>> + * 2) Verify that time(2) returns the value of time in seconds 
>>> since the Epoch
>>> + * and stores this value in the memory pointed to by the parameter.
>>> +\*/
>>
>> It is better to replace the number with '-' so that it follows the 
>> markdown list.
>>
>
> OK.
>
>>>
>>> -void setup();
>>> -void cleanup();
>>> +#include<time.h>
>>> +#include<errno.h>
>>>
>>> -char *TCID = "time01";
>>> -int TST_TOTAL = 1;
>>> +#include "tst_test.h"
>>>
>>> -int main(int ac, char **av)
>>> +static void verify_time(void)
>>>   {
>>> -    int lc;
>>> -
>>> -    tst_parse_opts(ac, av, NULL, NULL);
>>> -
>>> -    setup();
>>> -
>>> -    for (lc = 0; TEST_LOOPING(lc); lc++) {
>>> +    TEST(time(0));
>>>
>>> -        tst_count = 0;
>>> -
>>> -        /*
>>> -         * Call time(2)
>>> -         */
>>> -        TEST(time(0));
>>> -
>>> -        /* check return code */
>>> -        if (TEST_RETURN == -1) {
>>> -            tst_resm(TFAIL, "time(0) Failed, errno=%d : %s",
>>> -                 TEST_ERRNO, strerror(TEST_ERRNO));
>>> -        } else {
>>> -            tst_resm(TPASS, "time(0) returned %ld",
>>> -                 TEST_RETURN);
>>> -        }
>>> -    }
>>> -
>>> -    cleanup();
>>> -    tst_exit();
>>> +    if (TST_RET == -1)
>>> +        tst_res(TFAIL | TTERRNO, "time(0)");
>>> +    else
>>> +        tst_res(TPASS, "time(0) returned %ld", TST_RET);
>>>   }
>>>
>>> -/***************************************************************
>>> - * setup() - performs all ONE TIME setup for this test.
>>> - ***************************************************************/
>>> -void setup(void)
>>> +static void verify_time_store(void)
>>>   {
>>> -    void trapper();
>>> -
>>> -    tst_sig(NOFORK, DEF_HANDLER, cleanup);
>>> -
>>> -    TEST_PAUSE;
>>> +    time_t tloc;
>>> +
>>> +    TEST(time(&tloc));
>>> +
>>> +    if (TST_RET == -1)
>>> +        tst_res(TFAIL | TTERRNO, "time(&tloc)");
>>> +    else
>>> +        if (tloc == TST_RET)
>>> +            tst_res(TPASS, "time(&tloc) returned value %ld, "
>>> +                       "stored value %jd are same",
>>> +                       TST_RET, (intmax_t) tloc);
>>> +        else
>>> +            tst_res(TFAIL, "time(&tloc) returned value %ld, "
>>> +                       "stored value %jd are different",
>>> +                       TST_RET, (intmax_t) tloc);
>>>   }
>>>
>>> -/***************************************************************
>>> - * cleanup() - performs all ONE TIME cleanup for this test at
>>> - *        completion or premature exit.
>>> - ***************************************************************/
>>> -void cleanup(void)
>>> +struct tcase {
>>> +    void (*verify)(void);
>>> +} tcases[] = {
>>> +    {&verify_time },
>>> +    {&verify_time_store },
>>> +};
>>> +
>>> +static void run(unsigned int i)
>>>   {
>>> +    tcases[i].verify();
>>>   }
>> I think we don't need to define two different functions.
>> How about defining different arguments and then pass them to time()? 
>> for example:
>> struct time_t *args[2]= {NULL, &tloc};
>>
>> static void verify_time_store(unsigned int i)
>> {
>>      TEST(time(args[i]));
>>       ......
>> }
>
> I think these two are different.
>
> In `verify_time_store()`, we check the return value of `time(&tloc)` 
> and judge whether it is equal to the argument `tloc`.  But in 
> `verify_time()`, the judgment of whether they are equal or not is not 
> necessary.  So, I think the two functions are needed because of the 
> different logic.
Hi Ruan,

How about the following logic?
---------------------------------------------
static void verify_time(unsigned int i)
{
     TEST(time(args[i]));
     if (TST_RET == -1) {
         tst_res(TFAIL | TTERRNO, "time(&tloc)");
         return;
     }

     if (arg[i] && *args[i] != TST_RET) {
         tst_res(TFAIL, "...");
         return;
     }

     tst_res(TPASS, "...");
}
---------------------------------------------
Some same steps can be removed in original verify_time_store() and 
verify_time().  Is it simpler?
By the way, I have no objection to use different functions.

Best Regards,
Xiao Yang
>
>
> -- 
> Thanks,
> Ruan Shiyang.
>
>>
>> Best Regards,
>> Xiao Yang
>>> +
>>> +static struct tst_test test = {
>>> +    .test = run,
>>> +    .tcnt = ARRAY_SIZE(tcases),
>>> +};
> .
>



