Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SFf94-0004Zh-C3
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 05:22:06 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SFf93-00059T-F8
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 05:22:06 +0000
Message-ID: <4F7D2BF7.6070201@redhat.com>
Date: Thu, 05 Apr 2012 13:21:59 +0800
From: ZhoupingLiu <zliu@redhat.com>
MIME-Version: 1.0
References: <4F794D8B.6050505@cn.fujitsu.com> <4F7D26DC.5090605@redhat.com>
	<4F7D27D5.9080006@cn.fujitsu.com>
In-Reply-To: <4F7D27D5.9080006@cn.fujitsu.com>
Subject: Re: [LTP] ksm03
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
To: gaowanlong@cn.fujitsu.com
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 04/05/2012 01:04 PM, Wanlong Gao wrote:
> On 04/05/2012 01:00 PM, ZhoupingLiu wrote:
>
>> On 04/02/2012 02:56 PM, Wanlong Gao wrote:
>>> Hi Caspar,
>>>
>>> Have you ever seen like below? It happens on ksm03,
>>> the page_sharing numbers is always incorrect, it
>>> occurs on RHEL7-Alpha, any ides?
>> hi, Wanlong
>>
>> I caught this error, but it just only occurred in s390x,
>> and not 100% occurred, I will check the reason.
>> could you tell me which arches do you met the issue?
>
> Not fortunately, I met on x86_64 :(
> and the case can't finish then.

Okay, I'll dig it deeper, thanks for your info.

--
Thanks,
Zhouping

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
