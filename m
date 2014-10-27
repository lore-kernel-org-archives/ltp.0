Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xifo6-00005d-IQ
	for ltp-list@lists.sourceforge.net; Mon, 27 Oct 2014 08:37:42 +0000
Date: Mon, 27 Oct 2014 09:37:15 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141027083715.GB6325@rei.suse.de>
References: <811831435ca9c8a8941033fc8a9cfe00f69b5e6b.1413531372.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <811831435ca9c8a8941033fc8a9cfe00f69b5e6b.1413531372.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2] doc: document tst_checkpoint_create and
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
> +* tst_checkpoint_signal_child() followed by tst_checkpoint_parent_wait()
> +
> +                parent                |                child
> +--------------------------------------+----------------------------------------
> +                                      | tst_checkpoint_child_wait()
> +                                      |   blocking read,
> +                                      |   waits until parent opens write side
> + tst_checkpoint_signal_child()        |
> +   NONBLOCK write                     |
> +                                      |   child is now able to read from FIFO
> + tst_checkpoint_parent_wait()         |
> +   NONBLOCK read                      |
> +   parent able to read from FIFO and  |
> +   can race with read in child        |
> +                                      | tst_checkpoint_signal_parent()
> +--------------------------------------+----------------------------------------

I've reformatted this table to fit better to the thin column on the
GitHub wiki and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
