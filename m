Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YDZlY-00084i-IH
	for ltp-list@lists.sourceforge.net; Tue, 20 Jan 2015 14:26:48 +0000
Date: Tue, 20 Jan 2015 15:25:50 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150120142550.GB15452@rei>
References: <8593d893c637eadbac85711428be570e2636ef38.1421761305.git.jstancek@redhat.com>
	<20150120140704.GA15452@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150120140704.GA15452@rei>
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
> > This patch restores behavior from ltp-20140828, where LTP_DEV is exported
> > and tst_acquire_device() will use that instead of trying to acquire/release
> > loopdev on its own.
> 
> That wouldn't do because that breaks the exectuion when device was not
> passed to runltp. What about exporting it but only when it's non-empty?

To explain it better. That breaks execution on systems that has no
support for loop devices (not compiled in kernel), because the function
to prepare loop devices fails and LTP_DEV ends up exported as empty
string.

The library then pickups the empty string and tries to format it with
mkfs.

Looking at the code now, the code seems to be prepared for that option
the LTP_DEV should have been exported only if the create_block() function
was sucessfull but the code does apparently does not work for the case
above.

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
