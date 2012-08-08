Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Sz2Wy-0001C5-Aa
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 09:26:20 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Sz2Wx-00083u-Ej
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 09:26:20 +0000
Received: by pbcwy7 with SMTP id wy7so1084308pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Aug 2012 02:26:13 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Wed,  8 Aug 2012 17:25:57 +0800
Message-Id: <daaedb1bfd5c8c23d0346cd001250ab3881e5e12.1344417933.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.6"
Subject: [LTP] [PATCH] kernel/Makefile: add kernel/lib
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This patch makes kernel/lib get cleared when doing `make clean` in top
of LTP directory.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)


--------------1.7.8.6
Content-Type: text/x-patch; name="0001-kernel-Makefile-add-kernel-lib.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-kernel-Makefile-add-kernel-lib.patch"

diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 3922ce1..4b4800d 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -29,6 +29,10 @@ include $(top_srcdir)/include/mk/env_pre.mk
 
 # Build syscalls in all scenarios.
 SUBDIRS			:= syscalls
+
+# Build lib
+SUBDIRS			+= lib
+
 ifneq ($(UCLINUX),1)
 # KEEP THIS LIST ALPHABETIZED PLEASE!
 SUBDIRS			+= connectors \

--------------1.7.8.6
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
--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.6--



