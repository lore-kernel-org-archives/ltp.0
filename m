Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UceSQ-0006FK-D4
	for ltp-list@lists.sourceforge.net; Wed, 15 May 2013 16:21:38 +0000
Date: Wed, 15 May 2013 18:22:44 +0200
From: chrubis@suse.cz
Message-ID: <20130515162244.GA25618@rei.suse.cz>
References: <1368627464-10750-1-git-send-email-markos.chandras@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1368627464-10750-1-git-send-email-markos.chandras@gmail.com>
Subject: Re: [LTP] [PATCH] prot_hsymlinks.c: Define _GNU_SOURCE which is
 required for O_DIRECTORY
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
> in uClibc toolchains.
> 
> This is similar to 0d0c695c8c6657710d1a8ecb4f1264dcd405276b
> "open11.c: Define _GNU_SOURCE which is required for O_DIRECTORY"
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
