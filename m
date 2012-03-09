Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S5smo-0001aS-8g
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 05:54:42 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S5smm-00059N-Hh
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 05:54:42 +0000
Message-ID: <4F599ADE.1050004@cn.fujitsu.com>
Date: Fri, 09 Mar 2012 13:53:34 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1331270886-22153-1-git-send-email-caspar@casparzhang.com>
	<4F59999D.2020909@casparzhang.com>
In-Reply-To: <4F59999D.2020909@casparzhang.com>
Subject: Re: [LTP] [PATCH] sched_getaffinity: fix possible fail in negative
 case
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 03/09/2012 01:48 PM, Caspar Zhang wrote:

> On 03/09/2012 01:28 PM, Caspar Zhang wrote:
>>
>> in negative case:
>>
>>     QUICK_TEST(sched_getaffinity(getpid()+1, len, mask));
>>
>> sometimes getpid()+1 will exist if there're other processes running.
>> This patch uses a different way to make sure the required pid doesn't
>> exist by forking a child and terminating it. The pid of the terminated
>> child will not be used for a short time and it's enough for the test to
>> continue.
>>
>> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
>> ---
>>  .../sched_getaffinity/sched_getaffinity01.c        |   18 ++++++++++++++++--
>>  1 files changed, 16 insertions(+), 2 deletions(-)
>>
> 
> Hmmm, I took a look at commit c8319c8 and found that Garrett added a
> similar non-exist-pid case already. I guess we can simply remove the one
> I tried to fix...


Yes, agree, please remove this one.

Thanks,
Wanlong Gao

> 
> Thanks,
> Caspar
> 
> ------------------------------------------------------------------------------
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing 
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
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
