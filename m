Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SkQNy-0006Fx-3D
	for ltp-list@lists.sourceforge.net; Fri, 29 Jun 2012 01:52:38 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SkQNw-0004dC-Hd
	for ltp-list@lists.sourceforge.net; Fri, 29 Jun 2012 01:52:38 +0000
Message-ID: <4FED0A5A.5040501@cn.fujitsu.com>
Date: Fri, 29 Jun 2012 09:52:26 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1340785620-4444-1-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1340785620-4444-1-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH 0/3] some fix for aio related cases
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
To: Kang Kai <kai.kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

On 06/27/2012 04:26 PM, Kang Kai wrote:
> Hi,
> 
> These patches are for aio cases.

pushed, thank you.

Wanlong Gao

> 
> Regards,
> Kai
> 
> Kang Kai (3):
>   aio_cancel/4-1: fails on routerstation randomly
>   aio_read/9-1: check aio resource limitation
>   aio_write/7-1: check aio resource limitation
> 
>  .../conformance/interfaces/aio_cancel/4-1.c        |    5 +++--
>  .../conformance/interfaces/aio_read/9-1.c          |    2 +-
>  .../conformance/interfaces/aio_write/7-1.c         |    4 ++--
>  3 files changed, 6 insertions(+), 5 deletions(-)
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
