Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MYyDH-00016F-Dw
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 08:20:39 +0000
Received: from mail-qy0-f201.google.com ([209.85.221.201])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MYyDB-0003ey-9v
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 08:20:39 +0000
Message-ID: <4A7A85F9.60502@petalogix.com>
Date: Thu, 06 Aug 2009 09:27:53 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <d51f89b0907230130k158cbfbeo31f290cf207432b6@mail.gmail.com>	<1248978557.5788.61.camel@subratamodak.linux.ibm.com>	<d51f89b0908040422o17ac20f6q36aaff23ea88e839@mail.gmail.com>	<1249385096.15587.17.camel@subratamodak.linux.ibm.com>	<d51f89b0908040431w6208a47fgbe79b5df30c6268c@mail.gmail.com>	<1249387539.15587.24.camel@subratamodak.linux.ibm.com>
	<d51f89b0908040514w188e9c2obceb53fdd266588a@mail.gmail.com>
In-Reply-To: <d51f89b0908040514w188e9c2obceb53fdd266588a@mail.gmail.com>
Subject: Re: [LTP] waitid02 testcase fails on 2.6.29 kernel
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

rohit verma wrote:
> PFA the patch for waitid02
>   
I can confirm that this patch fixed problem with waitid02.
It is just confirmation - I haven't look at style/patch in detail - just
works and pass on Microblaze

Subrate: Do you want to add it to cvs?

Michal

> On Tue, Aug 4, 2009 at 5:35 PM, Subrata Modak<subrata@linux.vnet.ibm.com> wrote:
>   
>> On Tue, 2009-08-04 at 17:01 +0530, rohit verma wrote:
>>     
>>> FYI
>>>       
>> unfortunately, you did not attach the patch itself ;-)
>>
>> Regards--
>> Subrata
>>
>>     
>>> ---------- Forwarded message ----------
>>> From: Subrata Modak <subrata@linux.vnet.ibm.com>
>>> Date: Tue, Aug 4, 2009 at 4:54 PM
>>> Subject: Re: [LTP] waitid02 testcase fails on 2.6.29 kernel
>>> To: rohit verma <rohit.170309@gmail.com>
>>> Cc: maknayak@in.ibm.com, CAI Qian <caiqian@cclom.cn>
>>>
>>>
>>> Rohit,
>>>
>>> Post this to ltp mailing list.
>>>
>>> Regards--
>>> Subrata
>>>
>>> On Tue, 2009-08-04 at 16:52 +0530, rohit verma wrote:
>>>       
>>>> Dear Manas Kumar Nayak,
>>>>
>>>> Pls find attached patch for waitid02 test case.I have modified the
>>>> test case.I have also added 2 test scenarios in the test case using
>>>> WSTOPPED and WNOWAIT.
>>>>
>>>> Note:
>>>> The testcase was failing in LTP July, 2009 release.
>>>> The warning- "implicit declaration of function 'getpgid", has been removed
>>>>
>>>> Pls verify the patch.
>>>>
>>>> Regards--
>>>> Rohit Verma
>>>>
>>>>
>>>>
>>>> On Thu, Jul 30, 2009 at 11:59 PM, Subrata
>>>> Modak<subrata@linux.vnet.ibm.com> wrote:
>>>>         
>>>>> Fixed this now.
>>>>>
>>>>> Regards--
>>>>> Subrata
>>>>>
>>>>> On Thu, 2009-07-23 at 14:00 +0530, rohit verma wrote:
>>>>>           
>>>>>> Hi,
>>>>>>
>>>>>> I am running waitid02.c
>>>>>> (ltp-full-20090630/testcases/kernel/syscalls/waitid/ ) test case on
>>>>>> 2.6.29 kernel.
>>>>>> Test case gives following error:
>>>>>> "Error. is your system >2.6.9 ?";
>>>>>>
>>>>>>  Anybody facing the same issue?
>>>>>>
>>>>>> Code:
>>>>>>
>>>>>> TEST(waitid(P_ALL,0,&infop,WNOHANG));
>>>>>>         if(TEST_RETURN == 0)
>>>>>>                 tst_resm(TPASS,"Success !");
>>>>>>         else{
>>>>>>                 printf("value of return is %d\n",TEST_RETURN);
>>>>>>                 tst_resm(TFAIL,"Error. is your system >2.6.9 ?");
>>>>>>                errnochoose();
>>>>>>         }
>>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Rohit
>>>>>>
>>>>>> ------------------------------------------------------------------------------
>>>>>> _______________________________________________
>>>>>> Ltp-list mailing list
>>>>>> Ltp-list@lists.sourceforge.net
>>>>>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>>>>>             
>>>>>           
>>>>
>>>>         
>>> ------------------------------------------------------------------------------
>>> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day
>>> trial. Simplify your report design, integration and deployment - and focus on
>>> what you do best, core application coding. Discover what's new with
>>> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
>>> _______________________________________________
>>> Ltp-list mailing list
>>> Ltp-list@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>>       
>>     
>
>
>
>   
> ------------------------------------------------------------------------
>
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> ------------------------------------------------------------------------
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


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
