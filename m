Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rikpl-0003i8-Gi
	for ltp-list@lists.sourceforge.net; Thu, 05 Jan 2012 10:46:09 +0000
Date: Thu, 5 Jan 2012 11:45:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120105104537.GA14623@saboteur.suse.cz>
References: <4F02E0C6.3090308@imgtec.com>
	<201201031538.47749.vapier@gentoo.org>
	<20120104143426.GD15845@saboteur.suse.cz>
	<201201041358.21225.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201201041358.21225.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 08/21] syscalls/remap_file_pages: unsigned int is
 always greater to zero
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net, Markos Chandras <Markos.Chandras@imgtec.com>

Hi!
> > And moreover isn't sizeof(char) == 1 by definition?
> 
> i don't know the ISO C spec well enough to say.  but it's probably safe to say 
> that sizeof(char) will always be 1 on any system we ever care about.  
> personally i wouldn't discourage the use of sizeof(char) when it makes sense.

Looked that up:

"It's fundamental to correct usage of functions such as malloc and fread
 that sizeof(char) be exactly one. In practise, this means that byte in
 C terms is the smallest unit of storage, even if this unit is 36 bits
 wide; and all objects are composed of an integer number of these
 smallest units."

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
