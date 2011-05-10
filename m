Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1QJpSZ-0003Z4-Dk
	for ltp-list@lists.sourceforge.net; Tue, 10 May 2011 16:06:55 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QJpSY-0004wB-0w
	for ltp-list@lists.sourceforge.net; Tue, 10 May 2011 16:06:55 +0000
Message-ID: <4DC9627C.1050402@redhat.com>
Date: Wed, 11 May 2011 00:06:20 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <2025116569.785721.1302133158267.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>	<4D9D5128.3060709@cn.fujitsu.com>	<20110408032844.GA2945@hpt.nay.redhat.com>	<4D9E9DCF.8020504@cn.fujitsu.com>
	<20110408060725.GB2945@hpt.nay.redhat.com>
In-Reply-To: <20110408060725.GB2945@hpt.nay.redhat.com>
Subject: Re: [LTP] [PATCH]KSM: full_scans will stop increasing after
 stopping ksm
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
To: Bian Naimeng <biannm@cn.fujitsu.com>, ltp-list@lists.sourceforge.net

Hi Bian, to make a conclusion for this thread:

I have tested ksm cases and Pingtian's patch for many times, it worked
well. If it doesn't work on your system, please check:

1) Have you disabled ksm and ksmtuned before test? it will very easy to
get "stopped before echo 2 > ksm/run" due to ksmtuned behavior if you
keep them running.

2) Have you tried with a kernel containing this upstream commit:
2919bfd0758257c469abef8c26c3e516bbebb851 ? Without the patch in this
commit, your test might fail as well.

Thanks,
Caspar

On 04/08/2011 02:07 PM, Han Pingtian wrote:
> On Fri, Apr 08, 2011 at 01:31:59PM +0800, Bian Naimeng wrote:
>>
>>
>> Han Pingtian wrote:
>>> On Thu, Apr 07, 2011 at 01:52:40PM +0800, Bian Naimeng wrote:
>>>>
>>>> CAI Qian wrote:
>>>>> ----- Original Message -----
>>>>>> Qian Cai wrote:
>>>>>>> On 2011-4-4, at 0:47, Bian Naimeng <biannm@cn.fujitsu.com> wrote:
>>>>>>>
>>>>>>>> There are some problem in ksm tests.
>>>>>>>>
>>>>>>>> 1. We should break the test when checking is failure.
>>>>>>> No, this is not the intention. The design here is to run all tests
>>>>>>> to check for all stats to give a full picture even if the a single
>>>>>>> failure has been observed. This type of the failures do not prevent
>>>>>>> the rest of the tests from running, so there is no need to stop the
>>>>>>> tests now which also give more insight to track down root causes.
>>>>>> Various reason can make checking failure, someone can make the test
>>>>>> hangup.
>>>>>> I did this test on RHEL5, i found ksmd stopped before doing "echo 2 >
>>>>>> /sys/kernel/mm/ksm/run",
>>>>>> so group_check will be hanged on "new_num < old_num * 3".
>>>>>>
>>>>>> So, i think we should break the test if "run" is not expecting.
>>>>> What happened if you run the tests for a recent upstream kernel? There
>>>>> are some patches for ksm recently merged upstream. If the problem still
>>>>> persistent, please paste the EXACT OUTPUT from the ksm01 test. If it is
>>>>> hung, please upload sysrq-t output somewhere.
>>>>>
>>>> Maybe there are some bugs in the RHEL6's kernel, but the purpose of this patch
>>>> is not to workround these bugs, i want to fix the test's bug.
>>>>
>>>> Would you explain to me why we do this loop "while (new_num < old_num * 3)" in
>>>> group_check, i think "while (new_num < old_num + 3)" is better.
>>>>
>>>> Some time ago, the following patch insert this loop.
>>>> http://sourceforge.net/mailarchive/forum.php?thread_name=AANLkTi%3Dg%3DojJu0m%2B556rnekYenRTXtX%2BVBOj%3DrPmnjSw%40mail.gmail.com&forum_name=ltp-list
>>>>
>>>> The changelog of this patch said "we should wait 3~5 increments of the
>>>> /sys/kernel/mm/ksm/full_scans before checking ksm* testcases's results", but
>>>> it do "while (new_num < old_num * 3)" actually.
>>> I made a mistake. The code is what I wanted to do, but the changelog was
>>> wrong. When testing the new ksm patch, the developer told us we must
>>> wait 3~5 times increments of the number before checking testing
>>> results. So I coded to wait til new_num >= old_num * 3 before checking
>>> the results. 
>>>
>>
>> The bigger old_new is, the longer time test takes, it's strange.
> I agree that it's strange. But it seems that we have to do this way.
>>
>>> About 'echo 2 > /sys/kernel/mm/ksm/run' problem, I have tested it with
>>> ksm01.
>>> If I run the 'echo 2 > /sys/kernel/mm/ksm/run' before issue ksm test,
>>> the content of /sys/kernel/mm/ksm/run will be changed to 1 and the test
>>> can finished successfully. 
>>
>> I think we shoud not care this.
> Yep, I think so.
>>
>>> Only if I echo the 2 between the testing process,
>>> ksm01 will hang up. On that time, new_num will be zero, so your plus 3
>>> method won't work either. So what should we do in this circumstance?
>>>
>>
>> Please look at my patch, after stopping ksmd in the testing(echo 2 > /sys/kernel/mm/ksm/run or
>> echo 0 > /sys/kernel/mm/ksm/run), group_check will skip waiting at the loop "new_num >= old_num * 3".
>>
> Run 'echo 2 > /sys/kernel/mm/ksm/run' before calling group_check() won't
> cause the while loops infinitely, because old_num and new_num would be all
> zero before the while, so new_num == old_num * 3, the while won't be
> ran.
>> Regards
>>  Bian
>>
>>> Thanks.
>>>
>>> Han Pingtian
>>>> Regards
>>>>  Bian
>>>>
>>>>> CAI Qian
>>>>>  
>>>>>>>> 2. The condition "new_num < old_num * 3" seems uncomfortable, i
>>>>>>>> think
>>>>>>>>   it should be "new_num < old_num + 3"
>>>>>>> I don't understand. What error did you see from the testing output?
>>>>>> Sometimes, the old_num is a big number, so it takes long time in this
>>>>>> loop,
>>>>>> i don't understand the purpose.
>>>>>> Would you explain to me why we expect this condition "new_num <
>>>>>> old_num * 3".
>>>>>>
>>>>>>>> 3. After stopping ksm(echo 2 > /sys/kernel/mm/ksm/run), the ksmd
>>>>>>>>   will stop scaning pages, so looping in "new_num < old_num * 3"
>>>>>>>>   is wrong.
>>>>>>> Ditto.
>>>>>>>
>>>>>> After stopping ksm, looping in "new_num < old_num * 3" will make the
>>>>>> process hang up,
>>>>>> because new_num does not be increased.
>>>>>>
>>>>>> Regards
>>>>>> Bian

------------------------------------------------------------------------------
Achieve unprecedented app performance and reliability
What every C/C++ and Fortran developer should know.
Learn how Intel has extended the reach of its next-generation tools
to help boost performance applications - inlcuding clusters.
http://p.sf.net/sfu/intel-dev2devmay
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
