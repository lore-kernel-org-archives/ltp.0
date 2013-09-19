Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VMfTM-00006y-IF
	for ltp-list@lists.sourceforge.net; Thu, 19 Sep 2013 14:44:48 +0000
Date: Thu, 19 Sep 2013 16:45:08 +0200
From: chrubis@suse.cz
Message-ID: <20130919144508.GB14290@rei>
References: <1379492909-19596-1-git-send-email-alexey.kodanev@oracle.com>
	<20130919115958.GB13055@rei> <523AED4C.3080601@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <523AED4C.3080601@oracle.com>
Subject: Re: [LTP] [PATCH v2] mk/module.mk: add Makefile to build kernel
 modules
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
To: alexey.kodanev@oracle.com
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> >> Makefile example:
> >>
> >> top_srcdir      ?= ../../../..
> >>
> > Why aren't you including env_pre.mk here?
> >
> > It contains mostly compatibility hack for older Make.
> >
> > Does it break something?
> >
> Yes, I would include it only inside ifeq($(KERNELRELEASE),) otherwise 
> make stops in the kernel tree with error "Fix it to use EXTRA_CFLAGS", 
> it finds that CFLAGS is not empty... may be we can add 
> ifneq($(KERNELRELEASE),) to the "env_pre.mk and "testcases.mk"?

And what about this then:

Makefile:

top_srcdir      ?= ../../../..

include $(top_srcdir)/include/mk/env_pre.mk

REQ_VERSION_MAJOR       := 2
REQ_VERSION_PATCH       := 6

MODULE_NAMES    := ltp_foo

include $(top_srcdir)/include/mk/module.mk
include $(top_srcdir)/include/mk/generic_leaf_target.mk



And make module.mk either to set MAKE_TARGETS to the ltp_foo.ko or to be
empty in case we don't want to build anything (which should be NOOP).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
LIMITED TIME SALE - Full Year of Microsoft Training For Just $49.99!
1,500+ hours of tutorials including VisualStudio 2012, Windows 8, SharePoint
2013, SQL 2012, MVC 4, more. BEST VALUE: New Multi-Library Power Pack includes
Mobile, Cloud, Java, and UX Design. Lowest price ever! Ends 9/20/13. 
http://pubads.g.doubleclick.net/gampad/clk?id=58041151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
