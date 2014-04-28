Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WejgX-0005Yr-Ti
	for ltp-list@lists.sourceforge.net; Mon, 28 Apr 2014 11:25:21 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WejgW-0005mq-45
	for ltp-list@lists.sourceforge.net; Mon, 28 Apr 2014 11:25:21 +0000
Message-ID: <535E3A1B.6020502@cn.fujitsu.com>
Date: Mon, 28 Apr 2014 19:23:07 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1398674834-1643-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1398674834-1643-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<535E33C8.3070401@oracle.com>
In-Reply-To: <535E33C8.3070401@oracle.com>
Subject: Re: [LTP] [PATCH 2/2] kernel/mem/lib/mem.c: do the necessary
 cleanup work
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

On 04/28/2014 06:56 PM, Stanislav Kholmanskikh wrote:
> Hi!
>
> On 04/28/2014 12:47 PM, Xiaoguang Wang wrote:
>> Oom01 case will modify "/proc/sys/vm/overcommit_memory" to have tests. In most systems,
>> the overcommit_memory's default value is 0. When running oom01, if KSM configuration
>> is not enabled, "tst_brkm(TCONF, NULL, ...)" will be called, in this case, we will forget
>> to execute the restore operation defined in cleanup, and this will impact other test cases
>> in LTP, for example, fork14 in RHEL5 will succeed unexpectedly.
>>
>> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
>> ---
>>   testcases/kernel/mem/lib/mem.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
>> index f145a2a..69a9014 100644
>> --- a/testcases/kernel/mem/lib/mem.c
>> +++ b/testcases/kernel/mem/lib/mem.c
>> @@ -146,7 +146,7 @@ void testoom(int mempolicy, int lite)
>>   	oom(MLOCK, lite);
>>
>>   	if (access(PATH_KSM, F_OK) == -1)
>> -		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
>> +		tst_brkm(TCONF, cleanup, "KSM configuration is not enabled");
> In the current situation the OOM test cases will exit with TCONF if no 
> KSM is setup on the system.
>
> But is KSM the absolute requirement for the test cases?
According to my understanding about oom01, this is not a mandatory requirement :-)
>
> And could we execute the KSM part of testoom() only if KSM is enabled?
Yeah, sound reasonable, thanks. I will make a new version soon.

Regards,
Xiaoguang Wang
>
> Thanks.
>
>>   	tst_resm(TINFO, "start OOM testing for KSM pages.");
>>   	oom(KSM, lite);
>>
> ------------------------------------------------------------------------------
> "Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
> Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
> unparalleled scalability from the best Selenium testing platform available.
> Simple to use. Nothing to install. Get started now for free."
> http://p.sf.net/sfu/SauceLabs
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
