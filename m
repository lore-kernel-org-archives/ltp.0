Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1T4MjC-0007N7-3Y
	for ltp-list@lists.sourceforge.net; Thu, 23 Aug 2012 02:00:58 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T4MjA-0001GW-4N
	for ltp-list@lists.sourceforge.net; Thu, 23 Aug 2012 02:00:58 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q7N1bIlZ032739
	for <ltp-list@lists.sourceforge.net>; Thu, 23 Aug 2012 09:37:20 +0800
Message-ID: <503588E2.6030407@cn.fujitsu.com>
Date: Thu, 23 Aug 2012 09:35:30 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <502496C6.3090906@cn.fujitsu.com>
In-Reply-To: <502496C6.3090906@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v4] pthread_cond_brodcast/1-2.c hung when mem left
 is not enough
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 08/10/2012 01:06 PM, DAN LI wrote:
> pthread_cond_brodcast/1-2.c try to create as many childrens(thread or process) 
> as possible,however,if current free memory is exhausted before all childrens are
> started,the case will timeout and hung since it's stated with program "t0".
>  
> The patch adjust count of childrens according to judgement of size of current free
> memory.
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> ---
>  .../interfaces/pthread_cond_broadcast/1-2.c        |   47 ++++++++++++++++++--
>  1 file changed, 43 insertions(+), 4 deletions(-)

Pushed with removing the tailing spaces. thank you.

Wanlong Gao


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
