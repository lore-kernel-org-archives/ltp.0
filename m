Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sravan@linux.vnet.ibm.com>) id 1Oz57c-0003kD-5o
	for ltp-list@lists.sourceforge.net; Fri, 24 Sep 2010 10:03:16 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Oz57Y-0005xp-7I
	for ltp-list@lists.sourceforge.net; Fri, 24 Sep 2010 10:03:16 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8OA3Ewb020270
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Sep 2010 06:03:14 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8OA36Si2117884
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Sep 2010 06:03:06 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8OA364w015552
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Sep 2010 06:03:06 -0400
From: Sravan V Dodla <sravan@linux.vnet.ibm.com>
Date: Fri, 24 Sep 2010 15:33:03 +0530
Message-Id: <20100924100303.5709.80714.sendpatchset@sravan-laptop>
Subject: [LTP] [PATCH] Compilation Error Fixed in filecaps.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linux Test Project <ltp-list@lists.sourceforge.net>
Cc: Sravan V Dodla <sravan@linux.vnet.ibm.com>

Hello,

I have been facing an compilation issue with the latest version of LTP. After some debugging I found out that the
flag HAVE_SYS_CAPABILITY_H is not used and sys/capability.h is being included.
So here is the patch to get rid of this error.

Signed-off-by: Sravan V Dodla <sravan@linux.vnet.ibm.com>.

--- c.c	2010-09-23 06:09:27.257635313 +0530
+++ c.c.orig	2010-09-23 06:08:54.643698431 +0530
@@ -20,9 +20,7 @@
 
 
 #include <stdio.h>
-#if HAVE_SYS_CAPABILITY_H
 #include <sys/capability.h>
-#endif
 
 int main()
 {

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
