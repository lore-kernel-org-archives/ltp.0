Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YDac3-0004Rd-2U
	for ltp-list@lists.sourceforge.net; Tue, 20 Jan 2015 15:21:03 +0000
Date: Tue, 20 Jan 2015 16:20:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150120152005.GA15976@rei>
References: <8593d893c637eadbac85711428be570e2636ef38.1421761305.git.jstancek@redhat.com>
	<20150120144403.GC15452@rei>
	<1705158126.11277852.1421766771922.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1705158126.11277852.1421766771922.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] runltp: export initialized LTP_DEV
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
Cc: ltp-list@lists.sourceforge.net, liwan@redhat.com

Hi!
> ---
> commit 5c7c3fb219957484db92111d423e4e2553fb580b removed initialization
> of empty LTP_DEV from setup(), but it also caused that LTP_DEV
> is no longer exported when it's initialized in set_block_device().
> 
> This causes every test to attempt to get loop device on its own,
> which is not necessary and may presumably sporadically cause issues
> on older buggy kernels during cleanup of loop device.
> 
> This patch makes LTP_DEV exported (when it's not empty) and
> tst_acquire_device() will use that instead of trying to acquire/release
> loop device on its own for each test.
> ---

Looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
