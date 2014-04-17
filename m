Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WamMn-0007xG-3R
	for ltp-list@lists.sourceforge.net; Thu, 17 Apr 2014 13:28:37 +0000
Date: Thu, 17 Apr 2014 15:27:50 +0200
From: chrubis@suse.cz
Message-ID: <20140417132750.GA6420@rei>
References: <20140416190028.GA2093@ls3530.fritz.box>
	<20140417093329.GA6558@rei.suse.cz>
	<trinity-7fc052ce-4544-4fa4-afc0-9b68430ef693-1397729289569@3capp-gmx-bs62>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <trinity-7fc052ce-4544-4fa4-afc0-9b68430ef693-1397729289569@3capp-gmx-bs62>
Subject: Re: [LTP] [PATCH] fix fanotify syscall check on compat kernel
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
To: Helge Deller <deller@gmx.de>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

Hi!
> > Also I've been unable to make the testcases work with -m32 on x86_64
> > both with and without the patch and even when using glibc wrappers from
> > sys/fallocate.h, in all cases the error is EINVAL which suggets that the
> > parameters are passed wrongly somewhere on the way.
> 
> Does it work on the same kernel with -m64 ?
> In any case, for the tests to work the kernel needs to have been compiled with the
> kernel option CONFIG_FANOTIFY_ACCESS_PERMISSIONS set. In my initial tests this
> option wasn't set and I got EINVAL too.

And it seems to work (-m32 with your patch) on two testing machines with
slightly older kernel. So I guess that the patch is fine and I had just
bad luck with one particular machine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
