Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XeoxN-0004Mk-Dp
	for ltp-list@lists.sourceforge.net; Thu, 16 Oct 2014 17:35:21 +0000
Date: Thu, 16 Oct 2014 19:34:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141016173458.GA5149@rei.suse.de>
References: <b8054b8185431bf461ab892b87fd647c03b323b8.1413463764.git.jstancek@redhat.com>
	<20141016130128.GF20676@rei.suse.de>
	<270995651.10143129.1413467048364.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <270995651.10143129.1413467048364.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] doc: document tst_checkpoint_create and
 tst_checkpoint_init
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> I thought we had this issue only in parent:
> 
> ---------------------------------------------------------------------------------------------------
>                 parent                        |          child
>                                               | tst_checkpoint_child_wait
>                                               |    - has to wait until parent opens pipe for write
> tst_checkpoint_signal_child (NONBLOCK write)  | 
> tst_checkpoint_parent_wait (NONBLOCK read)    |
>   - parent now races on read with child       |
> ---------------------------------------------------------------------------------------------------
> 
> because child is opening always in blocking mode, it will always wait until other
> side is opened as well:
> ---------------------------------------------------------------------------------------------------
>                 parent                        |          child
>                                               | tst_checkpoint_signal_parent
>                                               |    - has to wait until parent opens pipe for read
> tst_checkpoint_parent_wait (NONBLOCK read)    |
>   - reads from FIFO                           |
>                                               | tst_checkpoint_child_wait
>                                               |    - has to wait until parent opens pipe for write
> tst_checkpoint_signal_child (NONBLOCK write)  |   
>   - at this point first byte was already read |
>     from FIFO, parent writes second byte      |
>                                               |    - and only now will child succeed opening pipe
> ---------------------------------------------------------------------------------------------------
> 
> Am I missing something?

You are right. The problem here is that the fifo can be opened for
NONBLOCK reading even if there are no writers and therefore there are
two readers that fight for the data in the fifo.

The second ordering should be fine as far as I can tell.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
