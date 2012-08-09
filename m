Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SzM6U-0000ZI-Q7
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 06:20:18 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SzM6T-0000SA-Ms
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 06:20:18 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q796KADe026178
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Aug 2012 14:20:11 +0800
Message-ID: <5023564B.7050309@cn.fujitsu.com>
Date: Thu, 09 Aug 2012 14:18:51 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1344490274-19671-1-git-send-email-penght@cn.fujitsu.com>
In-Reply-To: <1344490274-19671-1-git-send-email-penght@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] syslog07: fix a bug of -o
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 08/09/2012 01:31 PM, Peng Haitao wrote:
> Add missing -o.
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/syslog/syslog07 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Pushed, thank you.

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
