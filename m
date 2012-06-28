Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SkH17-00007h-Rw
	for ltp-list@lists.sourceforge.net; Thu, 28 Jun 2012 15:52:25 +0000
Date: Thu, 28 Jun 2012 17:09:40 +0200
From: chrubis@suse.cz
Message-ID: <20120628150940.GA10274@saboteur.suse.cz>
References: <4F02E1B9.2090603@imgtec.com>
	<CAGH67wRnBFxdBgQos0Px8GscXQ+Sn30JNmM-z2KU7-v6Vc7d3A@mail.gmail.com>
	<4F043605.9050703@imgtec.com>
	<CAGH67wR_qD3pc_k7qdeyRWq60V6qr6A7yeT9Q4zcYTLrJ-WBkA@mail.gmail.com>
	<20120104144305.GE15845@saboteur.suse.cz>
	<20120125182606.GA11236@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20120125182606.GA11236@saboteur.suse.cz>
Subject: Re: [LTP] [PATCH 09/21] realtime/lib/Makefile: Fix path for
 config.mk
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Markos Chandras <Markos.Chandras@imgtec.com>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
What about attached patch?

-- 
Cyril Hrubis
chrubis@suse.cz

--PEIAKu/WMn1b1Hv9
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-Fix-realtime-build.patch"

From 36ae7233c9606b78edcb2ca0eaf1a0a926cbd470 Mon Sep 17 00:00:00 2001
From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Jun 2012 17:14:57 +0200
Subject: [PATCH 1/3] Fix realtime build.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/realtime/lib/Makefile |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/realtime/lib/Makefile b/testcases/realtime/lib/Makefile
index 8860549..fc4784b 100644
--- a/testcases/realtime/lib/Makefile
+++ b/testcases/realtime/lib/Makefile
@@ -2,6 +2,7 @@
 #    realtime/lib Makefile.
 #
 #    Copyright (C) 2009, Cisco Systems Inc.
+#    Copyright (C) 2012  Cyril Hrubis <chrubis@suse.cz>
 #
 #    This program is free software; you can redistribute it and/or modify
 #    it under the terms of the GNU General Public License as published by
@@ -22,9 +23,9 @@
 
 top_srcdir		?= ../../..
 
-include $(top_srcdir)/../config.mk
+include $(top_srcdir)/include/mk/env_pre.mk
 
-CFLAGS			+= -D_GNU_SOURCE
+CFLAGS			+= -D_GNU_SOURCE -I../include/
 
 LDLIBS			+= -lpthread -lrt -lm
 
-- 
1.7.3.4


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--PEIAKu/WMn1b1Hv9--

