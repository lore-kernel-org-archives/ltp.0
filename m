Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1P5vcd-00042Y-SQ
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 07:19:35 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P5vcd-00061R-2Q
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 07:19:35 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20101004130404.GC19814@hallyn.com>
References: <20100929135647.GA4587@hallyn.com>
	<1285772543.17329.2.camel@subratamodak.linux.ibm.com>
	<1286176414.4882.2.camel@subratamodak.linux.ibm.com>
	<20101004130404.GC19814@hallyn.com>
Date: Wed, 13 Oct 2010 12:49:03 +0530
Message-Id: <1286954346.4893.13.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] securebits: add secure_keepcaps testcases
Reply-To: subrata@linux.vnet.ibm.com
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
To: "Serge E. Hallyn" <serge.hallyn@canonical.com>
Cc: ltp-list@lists.sf.net

On Mon, 2010-10-04 at 08:04 -0500, Serge E. Hallyn wrote:
> Quoting Subrata Modak (subrata@linux.vnet.ibm.com):
> > > Looks fine to be,i just need a little documentation file which would
> > > say:
> > > 	What securebits is all about (some pointers/links)? Any specific
> > > configuration required to run these tests, etc ?
> > 
> > Serge,
> > 
> > Can you also provide me this ?
> 
> I don't know where you'd want that documentation file, but for contents
> I think it should just read:
> 
> ====
> For more information on securebits, see the capabilities.7 manpage,
> specifically the section entitled
> 
> 	The "securebits" flags: establishing a capabilities-only environment
> 
> To run these tests there are no kernel configuration requirements, but
> your kernel must be at least Linux 2.6.32-rc7, and you must have a
> /usr/include/linux/securebits.h which defines SECBIT_NOROOT.  You also
> need the libcap v2 development libraries installed.
> ====

Thanks. I added this documentation and the tests to LTP. Sorry for being
late.

Regards--
Subrata

> 
> thanks,
> -serge


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
