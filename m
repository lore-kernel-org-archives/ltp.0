Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S7oJi-0002Eh-O5
	for ltp-list@lists.sourceforge.net; Wed, 14 Mar 2012 13:32:38 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S7oJe-0007XD-VJ
	for ltp-list@lists.sourceforge.net; Wed, 14 Mar 2012 13:32:38 +0000
Message-ID: <4F609430.20506@cn.fujitsu.com>
Date: Wed, 14 Mar 2012 20:50:56 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4F608484.30205@redhat.com>
In-Reply-To: <4F608484.30205@redhat.com>
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

Hi Jan,

> 
> This kernel commit restored original behavior:
> commit 1fa1e7f615f4d3ae436fa319af6e4eebdd4026a8
> Author: Andy Whitcroft <apw@canonical.com>
> Date:   Wed Nov 2 09:44:39 2011 +0100
>     readlinkat: ensure we return ENOENT for the empty pathname for
> normal lookups
> 
> For kernel >= 3.2, ENOENT should be expected errno code.


I had posted a patch long time ago, you can see here
http://marc.info/?l=ltp-list&m=132063831228321&w=2

This is a kernel bug, and already fixed in 3.0 and 3.1
stable tree, so, just test the kernel version like this
is not the best method.

What do you think?

Thanks,
Wanlong Gao

> 

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/readlink/readlink03.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing 
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list



------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
