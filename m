Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SS3Mu-0005ks-7X
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 09:39:36 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SS3Mo-0005qD-EP
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 09:39:36 +0000
Date: Wed, 09 May 2012 05:39:24 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <a0c94f50-c325-42c8-91f4-f97472d3e84c@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4FAA34CF.6050809@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] move_pages08: E2BIG was removed in 2.6.29
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



----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "Jeffrey Burke" <jburke@redhat.com>
> Sent: Wednesday, May 9, 2012 5:11:43 PM
> Subject: [LTP] [PATCH] move_pages08: E2BIG was removed in 2.6.29
> 
> 
> Following commit reworked do_pages_move() to work by page-sized
> chunks and also removed E2BIG:
> 
> commit 3140a2273009c01c27d316f35ab76a37e105fdd8
> Author: Brice Goglin <Brice.Goglin@inria.fr>
> Date:   Tue Jan 6 14:38:57 2009 -0800
>     mm: rework do_pages_move() to work on page_sized chunks
> 
> So, move_pages08 makes sense only for kernels < 2.6.29.

Looks good for me.

Acked-by: Zhouping Liu <zliu@redhat.com> 

-- 
Thanks,
Zhouping

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
