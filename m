Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1T6usk-0004ov-Ie
	for ltp-list@lists.sourceforge.net; Thu, 30 Aug 2012 02:53:22 +0000
Received: from acsinet15.oracle.com ([141.146.126.227])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1T6usj-0007Bc-EB
	for ltp-list@lists.sourceforge.net; Thu, 30 Aug 2012 02:53:22 +0000
Message-ID: <503ED594.2000403@oracle.com>
Date: Thu, 30 Aug 2012 10:53:08 +0800
From: Shuang Qiu <shuang.qiu@oracle.com>
MIME-Version: 1.0
References: <1357090412.61662055.1346248995037.JavaMail.root@redhat.com>
In-Reply-To: <1357090412.61662055.1346248995037.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] Set tunable value of min_free_kbytes lower
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Zhouping Liu <zliu@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 08/29/2012 10:03 PM, Zhouping Liu wrote:
>
> ----- Original Message -----
>> From: "Zhouping Liu" <zliu@redhat.com>
>> To: "shuang qiu" <shuang.qiu@oracle.com>
>> Cc: ltp-list@lists.sourceforge.net
>> Sent: Monday, August 27, 2012 1:16:45 PM
>> Subject: Re: [LTP] [PATCH] Set tunable value of min_free_kbytes lower
>>
>>
>>
>> ----- Original Message -----
>>> From: "Zhouping Liu" <zliu@redhat.com>
>>> To: "shuang qiu" <shuang.qiu@oracle.com>
>>> Cc: ltp-list@lists.sourceforge.net
>>> Sent: Friday, August 24, 2012 4:11:41 PM
>>> Subject: Re: [LTP] [PATCH] Set tunable value of min_free_kbytes
>>> lower
>>>
>>>
>>>
>>> ----- Original Message -----
>>>> From: "shuang qiu" <shuang.qiu@oracle.com>
>>>> To: ltp-list@lists.sourceforge.net
>>>> Sent: Thursday, August 23, 2012 2:43:01 PM
>>>> Subject: [LTP] [PATCH] Set tunable value of min_free_kbytes lower
>>>>
>>>> From: Shuang Qiu <shuang.qiu@oracle.com>
>>>>
>>>> The value of min_free_kbytes is set too high(half of mem_free)
>>>> during
>>>> testing min_free_kbytes tunable.It often cause the system to
>>>> become
>>>> out-of-memory.Using 20% of mem_free to avoid oom and system hang.
>>> Hi, shuang
>>>
>>> I met the issue that min_free_kbytes caused system hang before, and
>>> what you said made sense.
>> For the issue that min_free_kbytes caused system hang, I prepared a
>> patch for it,
>> at the same time, in order to enlarge the case's coverage, I add a
>> new case(2x default_tune)
>> I have tested it in my box, it's good.
>>
>> Shuang, can you review and test the patch?
>>
>> diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c
>> b/testcases/kernel/mem/tunable/min_free_kbytes.c
>> index 00ead04..ded0e45 100644
>> --- a/testcases/kernel/mem/tunable/min_free_kbytes.c
>> +++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
>> @@ -10,7 +10,8 @@
>>    * the current free memory with the tunable value repeatedly.
>>    *
>>    * a) default min_free_kbytes with all overcommit memory policy
>> - * b) half of mem_free with all overcommit memory policy
>> + * b) 2x default value with all overcommit memory policy
>> + * c) 10% of MemFree or %5 MemTotal with all overcommit memory
> Hi, Shuang
>
> after setting 10% of MemFree or 5% MemTotal, it still cause a system
> hang, which has 16Gb memory. so I adjusted the value, reduced the value
> to 5% of MemFree or 2% MemTotal, which I think is more reasonable.
OK.
Thanks.
>
> Thanks,
> Zhouping
>
>> policy
>>    *
>>    ********************************************************************
>>    * Copyright (C) 2012 Red Hat, Inc.
>> @@ -115,20 +116,27 @@ int main(int argc, char *argv[])
>>   static void test_tune(unsigned long overcommit_policy)
>>   {
>>          int status;
>> -       int pid[2];
>> +       int pid[3];
>>          int ret, i;
>> -       unsigned long tune, memfree;
>> +       unsigned long tune, memfree, memtotal;
>>   
>>          set_sys_tune("overcommit_memory", overcommit_policy, 1);
>>   
>> -       for (i = 0; i < 2; i++) {
>> +       for (i = 0; i < 3; i++) {
>>                  /* case1 */
>>                  if (i == 0)
>>                          set_sys_tune("min_free_kbytes", default_tune,
>>                          1);
>>                  /* case2 */
>> -               else {
>> +               else if (i == 1) {
>> +                       set_sys_tune("min_free_kbytes", 2 *
>> default_tune, 1);
>> +               /* case3 */
>> +               } else {
>>                          memfree = read_meminfo("MemFree:");
>> -                       tune = memfree / 2;
>> +                       memtotal = read_meminfo("MemTotal:");
>> +                       tune = memfree / 10;
>> +                       if (tune > (memtotal / 20))
>> +                               tune = memtotal / 20;
>> +
>>                          set_sys_tune("min_free_kbytes", tune, 1);
>>                  }
>>   
>>
>>
>>> but after tested the patch, I found it still make the system hang
>>> with the patch, so I don't think
>>> this patch can fix the issue completely, maybe there are other
>>> factors, or need lower tune value.
>>> always suppose it was because of the high tune value, it's more
>>> better to add an optional to control it.
>>> also I will investigate it deeper to look after the real reason.
>>> please comment if you have other ideas.
>>>
>>> Thanks,
>>> Zhouping
>>>
>>>> ---
>>>>   testcases/kernel/mem/tunable/min_free_kbytes.c |    2 +-
>>>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c
>>>> b/testcases/kernel/mem/tunable/min_free_kbytes.c
>>>> index 00ead04..8a03f85 100644
>>>> --- a/testcases/kernel/mem/tunable/min_free_kbytes.c
>>>> +++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
>>>> @@ -128,7 +128,7 @@ static void test_tune(unsigned long
>>>> overcommit_policy)
>>>>   		/* case2 */
>>>>   		else {
>>>>   			memfree = read_meminfo("MemFree:");
>>>> -			tune = memfree / 2;
>>>> +			tune = memfree / 5;
>>>>   			set_sys_tune("min_free_kbytes", tune, 1);
>>>>   		}
>>>>   
>>>> --
>>>> 1.7.7
>>>>
>>>>
>>>> ------------------------------------------------------------------------------
>>>> Live Security Virtual Conference
>>>> Exclusive live event will cover all the ways today's security and
>>>> threat landscape has changed and how IT managers can respond.
>>>> Discussions
>>>> will include endpoint security, mobile security and the latest in
>>>> malware
>>>> threats.
>>>> http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>>>> _______________________________________________
>>>> Ltp-list mailing list
>>>> Ltp-list@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>>>
>> --
>> Thanks,
>> Zhouping
>>



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
