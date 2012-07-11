Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SolHU-0000pe-Bh
	for ltp-list@lists.sourceforge.net; Wed, 11 Jul 2012 00:59:52 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SolHS-0008OQ-Mb
	for ltp-list@lists.sourceforge.net; Wed, 11 Jul 2012 00:59:52 +0000
Message-ID: <4FFCCFE7.3030204@cn.fujitsu.com>
Date: Wed, 11 Jul 2012 08:59:19 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1341827513-21908-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1341827513-21908-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH 1/2] mm/lib: ksm code style fixes.
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 07/09/2012 05:51 PM, Caspar Zhang wrote:
> 
> This patch gives some minor fixes to the following two commits:
> 
> f9ae09a lib/mem.c: using read_file to replace the redundant code
> 60c41a5 lib/mem.c: add _wait_ksmd_done func to wait ksmd finish his job
> 
> to make the codes cleaner and easier to understand.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>

Pushed this series. Thank you.

Wanlong Gao

> ---
>  testcases/kernel/mem/lib/mem.c |   69 +++++++++++++++------------------------
>  1 files changed, 27 insertions(+), 42 deletions(-)
> 
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond. Discussions 
> will include endpoint security, mobile security and the latest in malware 
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 



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
