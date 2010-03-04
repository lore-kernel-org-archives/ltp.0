Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1Nn6Nv-0007nE-5p
	for ltp-list@lists.sourceforge.net; Thu, 04 Mar 2010 08:26:19 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nn6Nt-0004P8-6q
	for ltp-list@lists.sourceforge.net; Thu, 04 Mar 2010 08:26:19 +0000
Message-ID: <4B8F59FB.3060402@cn.fujitsu.com>
Date: Thu, 04 Mar 2010 14:58:03 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
References: <4B7BA433.3030206@linux.vnet.ibm.com>
	<364299f41002170908p302cc665g874c89a109ddfd1f@mail.gmail.com>
	<20100218035756.GA13013@rishikesh.in.ibm.com>
	<4B824029.7070609@cn.fujitsu.com>
	<20100302144613.GA8623@linux.vnet.ibm.com>
	<6260305A-E6D0-4D10-9627-6D83C022588E@gmail.com>
In-Reply-To: <6260305A-E6D0-4D10-9627-6D83C022588E@gmail.com>
Subject: Re: [LTP] [PATCH] mail_tests.sh: fix a version problem of Heirloom
 Mail
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

at 2010-3-3 0:19, Garrett Cooper wrote:
> On Mar 2, 2010, at 6:46 AM, Rishikesh K Rajak
> <risrajak@linux.vnet.ibm.com> wrote:
> 
>> On Mon, Feb 22, 2010 at 04:28:25PM +0800, Shi Weihua wrote:
>>>>> There's a lot of noise in the patch because of if-else behavior in
>>>>> trying to determine the mail app. That's why I didn't commit this (it
>>>>> requires verification of previous mail applications as well).
>>>>
>>>> Thanks Garret, Still i have not committed this to CVS repo.
>>>>
>>>> Shi, can you please verify if this patch does not break with any other
>>>> mail application.
>>>
>>>  In fact, i don't know any other mail application.
>>>  When i tested RHEL's alpha version, this ltp bug catched. so tried
>>> to fix it.
>>>
>>>  Maybe, you should knock FOSS community(?).
>> Hi Shi,
>>
>> With Feb release still i am seeing some failure with mail file.
>>
>> cmdline="export TCdat=$LTPROOT/testcases/bin; mail_tests.sh"
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> mail_tests::setup    0  TINFO  :  INIT: Removing all mails for mail_test
>> and root
>> mail_tests::mail01    0  TINFO  :  Test #1: mail root@localhost will
>> send mail to root
>> mail_tests::mail01    0  TINFO  :  Test #1: user on local machine.
>> mail_tests::mail01    1  TPASS  :  Test #1: Mail was sent to root & was
>> received
>> mail_tests::mail02    0  TINFO  :  Test #2: mail user@bad-domain will
>> result in failure
>> mail_tests::mail02    0  TINFO  :  Test #2: to deliver the mail. Mailer
>> daemon should
>> mail_tests::mail02    0  TINFO  :  Test #2: report this failure.
>> mail_tests::mail02    2  TFAIL  :  Test #2: No new mail for root.
>> Reason:
>> No mail for root
>> mail_tests::mail03    0  TINFO  :  Test #3: mail
>> non_existent_user@localhost will fail
>> mail_tests::mail03    0  TINFO  :  Test #3: to deliver the mail. Mailer
>> daemon should
>> mail_tests::mail03    0  TINFO  :  Test #3: report this failure.
>> mail_tests::mail03    3  TFAIL  :  Test #3: No new mail for root.
>> Reason:
>> No mail for root
>> mail_tests::mail04    0  TINFO  :  Test #4: Test that mail -c
>> user@domain will
>> mail_tests::mail04    0  TINFO  :  Test #4: carbon copy user@domain
>> mail_tests::mail04    4  TPASS  :  Test #4: Mail was carbon copied to
>> user mail_test
>> mail_tests::mail05    0  TINFO  :  Test #5: Test that mail -b
>> user@domain will
>> mail_tests::mail05    0  TINFO  :  Test #5: blind carbon copy
>> user@domain
>> mail_tests::mail05    5  TPASS  :  Test #5: Mail was carbon copied to
>> user mail_test
>> mail_tests::cleanup    0  TINFO  :  Test CLEAN: Removing temporary files
>> from /tmp
>> mail_tests::cleanup    0  TINFO  :  Test CLEAN: Removing temporary user
>> mail_test
>> <<<execution_status>>>
>>
>> Can you please look into it if possible? I have run this testcase on
>> SLES10.SP3GA & RHEL5.4 GA on x86_64 , ppc64 & s390x and everywhere same
>> result.
> 
> Same here on Gentoo Linux before and after my cleanup to the test.

This fail message is same as my message which outputed on RHEL6alpha3 at 2009.12.
   >> mail_tests::mail03    3  TFAIL  :  Test #3: No new mail for root.
   >> Reason:
   >> No mail for root
The mailx version on your system is "Heirloom Mail" ? you can get the version by a
command of echo "d" | mail -u root.

If it's "Heirloom Mail", you should accept my patch.
	http://marc.info/?l=ltp-list&m=126440546415559&w=2

If it's other mailx, please give me the output of echo "d" | mail -u root, let's
try to fix it.

-Shi Weihua

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
