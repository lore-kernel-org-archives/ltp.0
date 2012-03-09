Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1S5u6j-000193-Tz
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 07:19:22 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S5u6j-0004jG-B4
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 07:19:21 +0000
Received: by iaag37 with SMTP id g37so2185024iaa.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 08 Mar 2012 23:19:16 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1257)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <1331270886-22153-1-git-send-email-caspar@casparzhang.com>
Date: Thu, 8 Mar 2012 23:19:12 -0800
Message-Id: <1B7D43CE-92E4-4D04-BBEF-97CEE3AB1D69@gmail.com>
References: <1331270886-22153-1-git-send-email-caspar@casparzhang.com>
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Mar 8, 2012, at 9:28 PM, Caspar Zhang wrote:

> 
> in negative case:
> 
>    QUICK_TEST(sched_getaffinity(getpid()+1, len, mask));
> 
> sometimes getpid()+1 will exist if there're other processes running.
> This patch uses a different way to make sure the required pid doesn't
> exist by forking a child and terminating it. The pid of the terminated
> child will not be used for a short time and it's enough for the test to
> continue.

	pid_t is signed on FreeBSD and Linux, so it's safe to assume that a pid of -1 won't work. It all depends on what you're trying to achieve (the EINVAL or the ESRCH requirement).
	Testing to make sure that a pid isn't running via kill(pid, 0) is another semi-viable method, but it's also racy.
Cheers,
-Garrett
------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
