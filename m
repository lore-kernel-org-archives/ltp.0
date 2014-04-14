Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WZbWb-0007Zc-Ry
	for ltp-list@lists.sourceforge.net; Mon, 14 Apr 2014 07:41:53 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WZbWa-0006vK-Uj
	for ltp-list@lists.sourceforge.net; Mon, 14 Apr 2014 07:41:53 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3E7fkV6015521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Apr 2014 07:41:47 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3E7fjI3001267
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Apr 2014 07:41:46 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3E7fj4S009060
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Apr 2014 07:41:45 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 14 Apr 2014 11:41:40 +0400
Message-Id: <1397461300-2172-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] utils: fix the installation of ffsb binary
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
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Commit a8846217ff4aa2b6063725504bccaad5602fe43a made
ffsb binary non-installable.

Therefore ext4-* test cases fail with:
ext4-uninit-groups    1  TFAIL  :  Test broken: ffsb: command not found

Fixed this by introducing a new Makefile target for ffsb in utils directory.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 utils/Makefile |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/utils/Makefile b/utils/Makefile
index aa052e6..923bb2d 100644
--- a/utils/Makefile
+++ b/utils/Makefile
@@ -22,7 +22,7 @@ top_srcdir		?= ..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS         += ffsb
+MAKE_TARGETS         += ffsb
 
 FFSBDIR			:= ffsb-6.0-rc2
 FILTER_OUT_DIRS		:= $(FFSBDIR)
@@ -32,6 +32,9 @@ $(FFSB): $(abs_srcdir)/$(FFSBDIR)
 	mkdir -p $(FFSBDIR)
 	cd $(FFSBDIR) && "$^/configure" && $(MAKE) top_srcdir="$^" all
 
+ffsb: $(FFSB)
+	cp $(FFSB) ffsb
+
 trunk-all: $(FFSB)
 
 trunk-clean:: | ffsb-clean
@@ -39,5 +42,4 @@ trunk-clean:: | ffsb-clean
 ffsb-clean:: $(abs_srcdir)/$(FFSBDIR)
 	cd $(FFSBDIR); $(MAKE) top_srcdir="$^" clean
 
-
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
-- 
1.7.1


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
