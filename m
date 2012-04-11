Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SHubl-0008VL-TB
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 10:17:01 +0000
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SHubl-0007qA-51
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 10:17:01 +0000
Received: by dadz9 with SMTP id z9so1151769dad.33
	for <ltp-list@lists.sourceforge.net>;
	Wed, 11 Apr 2012 03:16:55 -0700 (PDT)
Message-ID: <4F855A0D.9010308@casparzhang.com>
Date: Wed, 11 Apr 2012 18:16:45 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1334133622-24512-1-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1334133622-24512-1-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH] aio_cancel/3-1: increase BUF_SIZE
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
To: ltp-list@lists.sourceforge.net

On 04/11/2012 04:40 PM, Kang Kai wrote:
> When do aio_cancel, all the aio_write operations have finished on some
> platforms. That cause the case return UNRESOLVED. So increase the BUF_SIZE
> to delay aio_write finish that make one aio_write operation can be
> cancelled at least.
> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
Reviewed-by: Caspar Zhang <caspar@casparzhang.com>

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
