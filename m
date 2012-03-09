Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S5vgd-0001KM-HO
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 09:00:31 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S5vgY-0004PT-79
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 09:00:31 +0000
Received: by obqv19 with SMTP id v19so2457314obq.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 09 Mar 2012 01:00:20 -0800 (PST)
Message-ID: <4F59C663.8060508@casparzhang.com>
Date: Fri, 09 Mar 2012 16:59:15 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1331270886-22153-1-git-send-email-caspar@casparzhang.com>
	<1B7D43CE-92E4-4D04-BBEF-97CEE3AB1D69@gmail.com>
In-Reply-To: <1B7D43CE-92E4-4D04-BBEF-97CEE3AB1D69@gmail.com>
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

On 03/09/2012 03:19 PM, Garrett Cooper wrote:
> On Mar 8, 2012, at 9:28 PM, Caspar Zhang wrote:
> 
>>
>> in negative case:
>>
>>    QUICK_TEST(sched_getaffinity(getpid()+1, len, mask));
>>
>> sometimes getpid()+1 will exist if there're other processes running.
>> This patch uses a different way to make sure the required pid doesn't
>> exist by forking a child and terminating it. The pid of the terminated
>> child will not be used for a short time and it's enough for the test to
>> continue.
> 
> 	pid_t is signed on FreeBSD and Linux, so it's safe to assume that a pid of -1 won't work. It all depends on what you're trying to achieve (the EINVAL or the ESRCH requirement).
> 	Testing to make sure that a pid isn't running via kill(pid, 0) is another semi-viable method, but it's also racy.
> Cheers,
> -Garrett

I'll keep your test case and remove the getpid()+1 one.

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
