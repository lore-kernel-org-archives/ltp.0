Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S5vUt-0005FP-3x
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 08:48:23 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S5vUs-00022M-4f
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 08:48:23 +0000
Received: by obqv19 with SMTP id v19so2443827obq.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 09 Mar 2012 00:48:16 -0800 (PST)
Message-ID: <4F59C390.9010402@casparzhang.com>
Date: Fri, 09 Mar 2012 16:47:12 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1331282781-31469-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331282781-31469-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH] get_mempolicy: enable libnuma API == 2
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
To: LTP List <ltp-list@lists.sourceforge.net>

On 03/09/2012 04:46 PM, Caspar Zhang wrote:
> 
> This patch enables get_mempolicy01 test when libnuma API version is 2.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  .../syscalls/get_mempolicy/get_mempolicy01.c       |   73 +++++++++++++-------
>  1 files changed, 47 insertions(+), 26 deletions(-)
> 

sorry, wrong title, should be PATCH 1/1 ...

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
