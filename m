Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X2koU-0006LA-KA
	for ltp-list@lists.sourceforge.net; Thu, 03 Jul 2014 17:28:50 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 322DDADA6
	for <ltp-list@lists.sourceforge.net>;
	Thu,  3 Jul 2014 17:28:43 +0000 (UTC)
Date: Thu, 3 Jul 2014 19:28:29 +0200
From: chrubis@suse.cz
Message-ID: <20140703172829.GA12545@rei.scz.novell.com>
References: <20140703163617.GB5081@tarantula.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140703163617.GB5081@tarantula.localdomain>
Subject: Re: [LTP] sched_setparam{02,03} failures on 3.14 and newer kernels
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
To: ltp-list@lists.sourceforge.net

Hi!
> I'm getting failures with the sched_setparam02 and sched_setparam03 tests on
> the 3.14 and 3.15 kernels in Fedora that did not happen on 3.13.  Did something
> change in the upstream kernel?  Do the tests need to be updated?

The testcases are bit messy but there doesn't seem to be anything wrong
with them.

And it seems to work fine for me with 3.14.0 vanilla kernel, but does
not work with older 3.11 based distribution kernel (possibly some patch
got backported there).

> 3.14 getparam != setparam:
> ===============================================================================
> [root@localhost bin]# uname -r
> 3.14.9-200.fc20.x86_64
> [root@localhost bin]# strace \
>     -e trace=sched_setscheduler,sched_setparam,sched_getparam \
>     ./sched_setparam02 >/dev/null
> sched_setscheduler(0, SCHED_FIFO, { 1 }) = 0
> sched_setparam(0, { 5 })                = 0
> sched_getparam(0, { 0 })                = 0
> sched_setscheduler(0, SCHED_RR, { 1 })  = 0
> sched_setparam(0, { 5 })                = 0
> sched_getparam(0, { 0 })                = 0
> sched_setscheduler(0, SCHED_OTHER, { 0 }) = 0
> sched_setparam(0, { 0 })                = 0
> sched_getparam(0, { 0 })                = 0
> +++ exited with 5 +++
> ===============================================================================

The man 7 sched suggests that SCHED_FIFO and SCHED_RR priority must be >
0 at all times. So I guess that this is a bug and we need to find the
patch that changed the kernel behavior.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
