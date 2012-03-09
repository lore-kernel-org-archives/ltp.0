Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S63pS-0003uG-LG
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 17:42:10 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S63pO-00085W-Rb
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 17:42:10 +0000
Received: by pbcum15 with SMTP id um15so2886844pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 09 Mar 2012 09:42:00 -0800 (PST)
Message-ID: <4F5A40A7.1080700@casparzhang.com>
Date: Sat, 10 Mar 2012 01:40:55 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1331282781-31469-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331282781-31469-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH 2/2] get_mempolicy: enable libnuma API == 2
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

FYI, updated the patch and tested in RHEL5 and RHEL6, both libnuma v1
and v2 work well. Also fixed mbind01, both patches committed.

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
