Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UjUMW-0006AJ-2Y
	for ltp-list@lists.sourceforge.net; Mon, 03 Jun 2013 12:59:48 +0000
Date: Mon, 3 Jun 2013 15:01:05 +0200
From: chrubis@suse.cz
Message-ID: <20130603130105.GA4074@rei>
References: <006901ce5601$42cc89e0$c8659da0$@lge.com>
	<20130521103319.GA28186@rei> <20130530130325.GA5552@rei.suse.cz>
	<006901ce5dda$30547c60$90fd7520$@lge.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <006901ce5dda$30547c60$90fd7520$@lge.com>
Subject: Re: [LTP] [PATCH] Makefile: Disable parallel build for
 $(CRITICAL_MAKEFILES)
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
To: Jungsoo Son <jungsoo.son@lge.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > I got a an idea how to fix this in portable fashion. The key is the order
> > of filenames the make looks for.
> > 
> > The gnu make tries GNUmakefile first, then makefile or Makefile.
> > 
> > So if we create GNUmakefile, which would include the Makefile and adds
> > the .NOTPARALLEL: target it should work both with both GNU make and any
> > other POSIX conforming make out there.
> 
> I think your idea is good. 
> But I think that the code to distinguish GNU make and other POSIX will makes
> the Makefile to be more complex.
> I do not wish to complicate the Makefile more than is necessary.
> How about using '-j1' without '.NOTPARALLEL:' option as follows.

Again the same problem as previously. The POSIX specification does not
require the -j option to exist as the standard does not take parallel
build into the account at all. And for the Open Posix part of LTP we
need to stick to the POSIX.

And looking at the POSIX spec again, the POSIX make does not even
support including files. So the only way how to fix this is to copy the
top level Makefile to GNUmakefile and add the line. :(

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
