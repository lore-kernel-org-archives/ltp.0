Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MYzV3-0001Ie-N5
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 09:43:05 +0000
Received: from mail-bw0-f206.google.com ([209.85.218.206])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MYzUz-00066L-Na
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 09:43:05 +0000
Message-ID: <4A7A9DFB.7050305@petalogix.com>
Date: Thu, 06 Aug 2009 11:10:19 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <d51f89b0908032310k20c3843am7ea069d03436a7a@mail.gmail.com>	<1249387637.15587.29.camel@subratamodak.linux.ibm.com>
	<d51f89b0908040516i7c65740bi3e30e0972c8374fa@mail.gmail.com>
In-Reply-To: <d51f89b0908040516i7c65740bi3e30e0972c8374fa@mail.gmail.com>
Subject: Re: [LTP] Issue with rt_sigqueueinfo testcase in LTP.
Reply-To: michal.simek@petalogix.com
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
To: rohit verma <rohit.170309@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

I can confirm that fault too - on Microblaze and x86 too.
The funny thing is that this test failed but it is reported as passed in
log.

Michal
> FYI...
>
>
> ---------- Forwarded message ----------
> From: Subrata Modak <subrata@linux.vnet.ibm.com>
> Date: Tue, Aug 4, 2009 at 5:37 PM
> Subject: Re: Issue with rt_sigqueueinfo testcase in LTP.
> To: rohit verma <rohit.170309@gmail.com>
> Cc: maknayak@in.ibm.com
>
>
> Hi Rohit,
>
> On Tue, 2009-08-04 at 11:40 +0530, rohit verma wrote:
>   
>> Dear Manas Kumar Nayak,
>>
>> I have found an issue with rt_sigqueueinfo test-case.
>>
>> Following is the test output:
>>
>> rt_sigqueueinfo01    1  PASS  :  Test Succeeded
>> rt_sigqueueinfo01    1  FAIL  :  Test Failed, errno=1 : Operation not permitted
>> rt_sigqueueinfo01    1  PASS  :  Test Succeeded
>> rt_sigqueueinfo01    1  FAIL  :  Test Failed, errno=1 : Operation not permitted
>> rt_sigqueueinfo01    0  WARN  :  tst_rmdir(): rmobj(/tmp/rt_3FaSpK)
>> failed: lstat(/tmp/rt_3FaSpK) failed; errno=2: No such file or
>> directory
>>
>> I think the following lines are causing the failures:
>>
>> (Line - 164)
>>
>> uinfo.si_errno = 0;
>> uinfo.si_code = 0;//SI_USER
>> TEST(retval = syscall(__NR_rt_sigqueueinfo, getpid(), 17, &uinfo));
>>
>> Reason -
>>
>> You can observe the following comment & source when you look at the
>> Linux source (v 2.6.29)
>> (linux-2.6.29/kernel/signal.c)
>>
>>           /* Not even root can pretend to send signals from the kernel.
>>            Nor can they impersonate a kill(), which adds source info.  */
>>         if (info.si_code >= 0)
>>                 return -EPERM;
>>
>> which implies that si_code cannot be set to ' 0 ' (SI_USER) when
>> invoking the rt_sigqueueinfo syscall.
>>
>>
>> I am not sure how to fix this issue. But, a possible fix would be to
>> remove the second set of fork &
>> rt_sigqueueinfo invocations and use the first set (with SI_QUEUE). If
>> needed, the loop count can be
>> increased.
>>     
>
> Please propose this over to the mailing list. Manas has just ported the
> test case from Crackerjack to LTP. He may not be exactly aware of the
> issues, as it was a blind port, which in one way was good, as the
> porting generated issues, people interested discussed and solved
> them ;-)
>
> Regards--
> Subrata
>
>   
>>     
>
>
>
>
>   


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
