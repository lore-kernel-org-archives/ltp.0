Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1M8iTI-0000NN-PR
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 22:16:40 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M8iSt-0004VQ-89
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 22:16:40 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4PMDLrl031220
	for <ltp-list@lists.sourceforge.net>; Mon, 25 May 2009 16:13:21 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4PMG9qS174416
	for <ltp-list@lists.sourceforge.net>; Mon, 25 May 2009 16:16:09 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4PMG8Rm023829
	for <ltp-list@lists.sourceforge.net>; Mon, 25 May 2009 16:16:09 -0600
Date: Mon, 25 May 2009 17:16:09 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090525221609.GA30283@us.ibm.com>
References: <4A0D13F2.8030804@cn.fujitsu.com>
	<20090515134519.GA21654@us.ibm.com>
	<1242647979.5161.12.camel@subratamodak.linux.ibm.com>
	<20090518150725.GA9790@us.ibm.com>
	<4A163E59.7030002@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4A163E59.7030002@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] Synchronization between two processes
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
To: Wei Yongjun <yjwei@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Quoting Wei Yongjun (yjwei@cn.fujitsu.com):
> Serge E. Hallyn wrote:
>> Quoting Subrata Modak (subrata@linux.vnet.ibm.com):
>>   
>>> On Fri, 2009-05-15 at 08:45 -0500, Serge E. Hallyn wrote:     
>>>> Quoting Gui Xiaohua (guixh@cn.fujitsu.com):
>>>>       
>>>>> The child-process wait SIGUSR1 which would be sended by parent-process,
>>>>> if the child-process execute sigtimedwait() after parent-process 
>>>>> send the signal, it would never receive the SIGUSR1 from 
>>>>> parent-process.
>>>>> I cann't make sure the SIGUSR1 be sended after child-process 
>>>>> execute sigtimedwait() with 100 percent, and i try my best.
>>>>>         
>>>> Well, in theory I suppose this could happen, but you'd have to have
>>>> a pretty bad scheduler if the parent can do a strcmp(buf, "c:go")
>>>> between the pipe read and signal send, while the child goes straight
>>>> from pipe write to sigtimedwait.
>>>>
>>>> Have you seen this signal be missed?  If not, then I'd rather assume
>>>> things are reasonable.  If you have seen this happen, then why not
>>>> instead set up a SIGUSR1 handler in the child before doing the pipe
>>>> write, then just sleep for 3 seconds instead of doing sigtimedwait?
>>>>       
>>> Thanks Serge.
>>>     
>>
>> Or, if I'm being unreasonable, then at least have the parent only wait
>> for at most 1 second, and leave the child alone.  Every every ltp test
>> is going to hang for 5 seconds...
>>
>> But I prefer setting the signal handler ahead of time.
>>
>>   
> Sorry to relpy late.
>
> As your last advice, i change the test case, and it work will.
>
> [PATCH] fix sync problem between two processes of pidns12 test
>
> The child-process wait SIGUSR1 which would be sended by parent-process,
> if the child-process execute sigtimedwait() after parent-process send
> the signal, it would never receive the SIGUSR1 from parent-process.
>
> This patch rewrite child_signal_handler() to handle to SIGUSR1 and
> instead sigtimedwait() with sleep for 3 seconds.

Thank you, this looks right.

I assume the reason it wasn't originally done this way, was out of
a concern that the TPASS/TFAIL out of signal handler wouldn't
count...

-serge

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
