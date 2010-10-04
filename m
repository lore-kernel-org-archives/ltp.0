Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge.hallyn@canonical.com>) id 1P2ki5-0000KN-Pa
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 13:04:05 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P2ki5-0006K4-1H
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 13:04:05 +0000
Date: Mon, 4 Oct 2010 08:04:05 -0500
From: "Serge E. Hallyn" <serge.hallyn@canonical.com>
Message-ID: <20101004130404.GC19814@hallyn.com>
References: <20100929135647.GA4587@hallyn.com>
	<1285772543.17329.2.camel@subratamodak.linux.ibm.com>
	<1286176414.4882.2.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1286176414.4882.2.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] securebits: add secure_keepcaps testcases
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list@lists.sf.net

Quoting Subrata Modak (subrata@linux.vnet.ibm.com):
> > Looks fine to be,i just need a little documentation file which would
> > say:
> > 	What securebits is all about (some pointers/links)? Any specific
> > configuration required to run these tests, etc ?
> 
> Serge,
> 
> Can you also provide me this ?

I don't know where you'd want that documentation file, but for contents
I think it should just read:

====
For more information on securebits, see the capabilities.7 manpage,
specifically the section entitled

	The "securebits" flags: establishing a capabilities-only environment

To run these tests there are no kernel configuration requirements, but
your kernel must be at least Linux 2.6.32-rc7, and you must have a
/usr/include/linux/securebits.h which defines SECBIT_NOROOT.  You also
need the libcap v2 development libraries installed.
====

thanks,
-serge

------------------------------------------------------------------------------
Virtualization is moving to the mainstream and overtaking non-virtualized
environment for deploying applications. Does it make network security 
easier or more difficult to achieve? Read this whitepaper to separate the 
two and get a better understanding.
http://p.sf.net/sfu/hp-phase2-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
