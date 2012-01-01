Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RhSEv-00005I-Qh
	for ltp-list@lists.sourceforge.net; Sun, 01 Jan 2012 20:42:45 +0000
Date: Sun, 1 Jan 2012 21:53:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120101205321.GA14840@saboteur.suse.cz>
References: <611ED426031E9E48A80D02BED70BC810570E4F83@ALA-MBA.corp.ad.wrs.com>
	<4EF2C511.2000605@cn.fujitsu.com>
	<20111222101221.GC26303@saboteur.suse.cz>
	<201112311514.16549.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201112311514.16549.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] redefine NCPU = sysconf(_SC_NPROCESSORS_CONF)
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
Cc: ltp-list@lists.sourceforge.net, "Shang,  YanFeng" <YanFeng.Shang@windriver.com>

Hi!
> > > > I think using cat /proc/cpuinfo get core number is better.
> > > 
> > > But /proc/cpuinfo may not be supported by other OS.
> > 
> > Yes, procfs is linux specific.
> 
> no, it's not.  but much of the stuff that linux puts under /proc is Linux 
> specific like "cpuinfo".  in fact, the format of "cpuinfo" under Linux tends to 
> change based on the arch you're running on ...

Ah, right, I didn't know that procfs was there before Linux (anyway most
of the systems store process exports only related data there at least
google suggets that), but still it's not good idea not to use cpuinfo in
open posix testsuite...

> since this patch is against the open_posix_testsuite, we need to stick to 
> POSIX APIs (although, the forking of open_posix_testsuite in ltp is pretty 
> awful in general).  if it were against a different tree, then not caring about 
> non-Linux would be fine.

Well, the open posix testsuite project seems to be dead for some time
(at least four years) so having fork is only natural. Do you know some
of the original authors? Maybe we can just ask them to update the
sf.net pages to redirect people to LTP.

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
