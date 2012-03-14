Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S7pFq-0005d1-2H
	for ltp-list@lists.sourceforge.net; Wed, 14 Mar 2012 14:32:42 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S7pFk-0001Fq-D5
	for ltp-list@lists.sourceforge.net; Wed, 14 Mar 2012 14:32:41 +0000
Message-ID: <4F60A555.1030100@cn.fujitsu.com>
Date: Wed, 14 Mar 2012 22:04:05 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <389bdf61-8e14-45b2-adbf-66c1d0ac3a96@zmail17.collab.prod.int.phx2.redhat.com>
In-Reply-To: <389bdf61-8e14-45b2-adbf-66c1d0ac3a96@zmail17.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] readlink03: fix expected errno for kernel >=3.2
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

On 03/14/2012 09:57 PM, Jan Stancek wrote:

> 
> 
> ----- Original Message -----
>> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
>> To: "Jan Stancek" <jstancek@redhat.com>
>> Cc: ltp-list@lists.sourceforge.net, "Jeffrey Burke" <jburke@redhat.com>
>> Sent: Wednesday, March 14, 2012 1:50:56 PM
>> Subject: Re: [LTP] [PATCH] readlink03: fix expected errno for kernel >=3.2
>>
>> Hi Jan,
>>
>>>
>>> This kernel commit restored original behavior:
>>> commit 1fa1e7f615f4d3ae436fa319af6e4eebdd4026a8
>>> Author: Andy Whitcroft <apw@canonical.com>
>>> Date:   Wed Nov 2 09:44:39 2011 +0100
>>>     readlinkat: ensure we return ENOENT for the empty pathname for
>>> normal lookups
>>>
>>> For kernel >= 3.2, ENOENT should be expected errno code.
>>
>>
>> I had posted a patch long time ago, you can see here
>> http://marc.info/?l=ltp-list&m=132063831228321&w=2
>>
>> This is a kernel bug, and already fixed in 3.0 and 3.1
>> stable tree, so, just test the kernel version like this
>> is not the best method.
>>
>> What do you think?
> 
> Agreed, version check doesn't make much sense.
> 
> I think if this patch was important enough to be backported to stable
> trees, we can be sure it's a bug and we can drop that version
> check entirely - which is what your patch does.


Yeah, so let me resend it with your Ack.

Thanks,
Wanlong Gao

> 
> Regards,
> Jan
> 
> 



------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
