Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1NZhoy-0005lS-Dx
	for ltp-list@lists.sourceforge.net; Tue, 26 Jan 2010 09:34:52 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NZhow-0000kY-LP
	for ltp-list@lists.sourceforge.net; Tue, 26 Jan 2010 09:34:52 +0000
Message-ID: <4B5EB72B.7010909@cn.fujitsu.com>
Date: Tue, 26 Jan 2010 17:34:35 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
References: <4B5E8192.80909@cn.fujitsu.com>	
	<364299f41001252354m16d21845h6c1bd0b53cd5c98@mail.gmail.com>
	<364299f41001260025v527adde4u44ff82c647d18b4e@mail.gmail.com>
In-Reply-To: <364299f41001260025v527adde4u44ff82c647d18b4e@mail.gmail.com>
Subject: Re: [LTP] [PROBLEM?] rt_sigaction01 still failed on x86_64
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

at 2010-1-26 16:25, Garrett Cooper wrote:
> On Mon, Jan 25, 2010 at 11:54 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
>> On Mon, Jan 25, 2010 at 9:45 PM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
>>> Hi, Cooper
>>>
>>> I noticed that you added a check of platform which not defined
>>> sa_sigaction in struct sigaction.
>>> http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c?r1=1.6&r2=1.7
>>>
>>> As your expectted, the following message will output on x86_64.
>>> ------------
>>> Your architecture doesn't support this test (no sa_sigaction field in struct sigaction).
>>> ------------
>>> But unfortunately, it still failed on my x86_64.
>>>
>>> On my x86_64, signal.h like this:
>>> ------------
>>> #ifndef __ASSEMBLY__
>>>
>>> #ifdef __i386__
>>>        (sa_sigaction defined here)  <--
>>> #else /* __i386__ */
>>>        (no sa_sigaction defined)    <--
>>> #endif /* !__i386__ */
>>>
>>> #endif /* __ASSEMBLY__ */
>>> ------------
>>> your check still work ? Sorry, I don't know the check process in
>>> LTP configure clearly. Could you give me some explanation.
>>
>> Shi,
>>    I'm just going to test out the other proposed rt_sigaction, and
>> revert this change if it doesn't work back to a semi-functioning state
>> (which means that x86_64 will once again be broken).
> 
>     Files reverted because liubo's patch didn't stick.

Do you will pick out some useful code from liubo's patch ?
Previously, you said you would do that. (2009-12-22) ;-)

> Thanks,
> -Garrett
> 
> 


------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
