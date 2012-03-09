Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S5shg-0007Zz-3Z
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 05:49:24 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S5shf-00050q-0L
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 05:49:23 +0000
Received: by obqv19 with SMTP id v19so2265635obq.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 08 Mar 2012 21:49:17 -0800 (PST)
Message-ID: <4F59999D.2020909@casparzhang.com>
Date: Fri, 09 Mar 2012 13:48:13 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1331270886-22153-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331270886-22153-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH] sched_getaffinity: fix possible fail in negative
	case
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 03/09/2012 01:28 PM, Caspar Zhang wrote:
> 
> in negative case:
> 
>     QUICK_TEST(sched_getaffinity(getpid()+1, len, mask));
> 
> sometimes getpid()+1 will exist if there're other processes running.
> This patch uses a different way to make sure the required pid doesn't
> exist by forking a child and terminating it. The pid of the terminated
> child will not be used for a short time and it's enough for the test to
> continue.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  .../sched_getaffinity/sched_getaffinity01.c        |   18 ++++++++++++++++--
>  1 files changed, 16 insertions(+), 2 deletions(-)
> 

Hmmm, I took a look at commit c8319c8 and found that Garrett added a
similar non-exist-pid case already. I guess we can simply remove the one
I tried to fix...

Thanks,
Caspar

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
