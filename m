Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SS6Dg-0005Bv-Gr
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 12:42:16 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SS6Dc-00038e-76
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 12:42:16 +0000
Message-ID: <4FAA65D5.3080208@cn.fujitsu.com>
Date: Wed, 09 May 2012 20:40:53 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4FAA5A59.8070707@redhat.com>
In-Reply-To: <4FAA5A59.8070707@redhat.com>
Subject: Re: [LTP] [PATCH v2] move_pages08: E2BIG was removed in 2.6.29
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

On 05/09/2012 07:51 PM, Jan Stancek wrote:

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


pushed, thanks all,

Wanlong Gao

> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  .../kernel/syscalls/move_pages/move_pages08.c      |   15 +++++++++++++--
>  1 files changed, 13 insertions(+), 2 deletions(-)
> 
> 
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
