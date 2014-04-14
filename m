Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WZkaQ-0004l4-L7
	for ltp-list@lists.sourceforge.net; Mon, 14 Apr 2014 17:22:26 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-4.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WZkaO-0002mI-Oc
	for ltp-list@lists.sourceforge.net; Mon, 14 Apr 2014 17:22:26 +0000
Date: Mon, 14 Apr 2014 19:22:12 +0200
From: Mats Liljegren <mats.liljegren@enea.com>
Message-ID: <20140414192212.3c97cc76@mats-desktop>
MIME-Version: 1.0
Subject: [LTP] Problems with cross-compiling
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

I've been using Yocto, which does cross-compiling. It has support for
compiling LTP, but I've noticed it has a couple of patches. I found
that one patch was needed for actually compile LTP, which applies to
the file utils/Makefile.

The patch is for an older version of LTP, but I re-implemented it for
the new version. Looking at the following rule:

$(FFSB): $(abs_srcdir)/$(FFSBDIR)
        mkdir -p $(FFSBDIR)
        cd $(FFSBDIR) && "$^/configure" && $(MAKE) top_srcdir="$^" all

This calls configure without parameters, which is most likely wrong for
a cross-compile environment. It is this configure that fails. By simple
removing it, everything works within Yocto.

Is there any reason for keeping this configure here? Or should I make
a patch for removing it?

Regards
Mats Liljegren

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
