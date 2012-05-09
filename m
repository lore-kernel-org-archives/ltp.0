Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SS5rd-00048T-8r
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 12:19:29 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SS5rX-0001K6-FO
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 12:19:29 +0000
Received: by mail-pb0-f47.google.com with SMTP id rq2so407048pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 09 May 2012 05:19:23 -0700 (PDT)
Message-ID: <4FAA60A0.2070503@casparzhang.com>
Date: Wed, 09 May 2012 20:18:40 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4FAA5A5B.1030704@redhat.com>
In-Reply-To: <4FAA5A5B.1030704@redhat.com>
Subject: Re: [LTP] [PATCH v2] move_pages09: move_pages returns 0 if nothing
 got migrated
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

On 05/09/2012 07:51 PM, Jan Stancek wrote:
> 
> Following commit changed the behavior to return 0 when no pages
> require migration.
> 
> commit e78bbfa8262424417a29349a8064a535053912b9
> Author: Brice Goglin <Brice.Goglin@inria.fr>
> Date:   Sat Oct 18 20:27:15 2008 -0700
>     mm: stop returning -ENOENT from sys_move_pages() if nothing got
> migrated
> 
> So testing for ENOENT in move_pages09, makes sense only for
> kernel < 2.6.28.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---

Acked-by: Caspar Zhang <caspar@casparzhang.com>



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
