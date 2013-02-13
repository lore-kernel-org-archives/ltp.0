Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1U5d0L-0001gZ-Oa
	for ltp-list@lists.sourceforge.net; Wed, 13 Feb 2013 14:08:09 +0000
Date: Wed, 13 Feb 2013 15:08:37 +0100
From: chrubis@suse.cz
Message-ID: <20130213140836.GB2164@rei>
References: <1360761545-2443-1-git-send-email-markos.chandras@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1360761545-2443-1-git-send-email-markos.chandras@gmail.com>
Subject: Re: [LTP] [PATCH] open11.c: Define _GNU_SOURCE which is required
 for O_DIRECTORY
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
To: Markos Chandras <markos.chandras@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> O_DIRECTORY is only available if _GNU_SOURCE is defined
> in uClibc toolchains:

Looks like I've been too hasty with ifdefing it out. 

Commited thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
