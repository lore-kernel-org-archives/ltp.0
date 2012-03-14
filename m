Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S7nxL-0001Zn-VE
	for ltp-list@lists.sourceforge.net; Wed, 14 Mar 2012 13:09:31 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S7nxG-0003jL-7x
	for ltp-list@lists.sourceforge.net; Wed, 14 Mar 2012 13:09:31 +0000
Received: by dado14 with SMTP id o14so3090525dad.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Mar 2012 06:09:20 -0700 (PDT)
Message-ID: <4F609836.1070109@casparzhang.com>
Date: Wed, 14 Mar 2012 21:08:06 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4F608484.30205@redhat.com>
In-Reply-To: <4F608484.30205@redhat.com>
Subject: Re: [LTP] [PATCH] readlink03: fix expected errno for kernel >=3.2
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

On 03/14/2012 07:44 PM, Jan Stancek wrote:
> 
> This kernel commit restored original behavior:
> commit 1fa1e7f615f4d3ae436fa319af6e4eebdd4026a8
> Author: Andy Whitcroft <apw@canonical.com>
> Date:   Wed Nov 2 09:44:39 2011 +0100
>      readlinkat: ensure we return ENOENT for the empty pathname for
> normal lookups
> 
> For kernel >= 3.2, ENOENT should be expected errno code.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

looks good to me.

Reviewed-by: Caspar Zhang <caspar@casparzhang.com>

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
