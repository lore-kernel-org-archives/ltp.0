Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z73Rb-0002cT-8Z
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2015 15:15:31 +0000
Date: Mon, 22 Jun 2015 17:14:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150622151416.GA9223@rei.suse.de>
References: <6ad648e0b674845a19073ebd7afcb8ec82f3f891.1434551926.git.jstancek@redhat.com>
	<20150622122056.GA7476@rei.suse.de>
	<676745151.5941810.1434981383477.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <676745151.5941810.1434981383477.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] kmsg01: avoid infinite run in test_read_block()
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
> > Apart from that the logic looks fine. The test could be probably cleaned
> > by using checkpoints instead of pipe and the function used to propagate
> > exit value from child, but that is probably worth of separate patch.
> 
> Checkpoint alone doesn't seem to be enough to tell difference between:
> - child has read one record and will continue reading
> - child read has reached eof and will now exit
> 
> while parent does:
> do {
>   ret = tst_checkpoint_wait()
> } while (ret == 0)
> 
> I could map some shared memory for such flag, but I'm thinking if I can't just
> use tst_futexes to store such flag. In that case, it would likely be
> needed to handle EWOULDBLOCK in tst_checkpoint_wait and restart wait.

Hmm, we can change the tst_checkpoint library to allocate two uint32_t
per id (even would be for futex and odd for the propagated value) and
add parameters to propagate 32bit integer value from
tst_checkpoint_wake() to tst_checkpoint_wait(). That way we would avoid
the need for changing the futex related code at all (the only change
would be id -> 2 * id). Given that we allocate whole page we can waste
half of the checkpoint pairs without any problems.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
