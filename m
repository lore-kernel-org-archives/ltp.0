Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WO5VU-0003XV-On
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 13:17:08 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-4.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WO5VT-0001JS-CL
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 13:17:08 +0000
From: <liljegren.mats2@gmail.com>
Date: Thu, 13 Mar 2014 14:03:49 +0100
Message-ID: <1394715829-35808-1-git-send-email-liljegren.mats2@gmail.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] .gitignore: Add files created when building
	stress_floppy tests
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
Cc: Mats Liljegren <mats.liljegren@enea.com>

From: Mats Liljegren <mats.liljegren@enea.com>

Signed-off-by: Mats Liljegren <mats.liljegren@enea.com>
---
 .gitignore |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.gitignore b/.gitignore
index 1e9c911..9da07b9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -61,3 +61,8 @@ logfile.*
 /lib/tests/tst_process_state
 /lib/tests/tst_cleanup_once
 /lib/tests/tst_safe_macros
+
+/testcases/kernel/io/stress_floppy/1000K_file
+/testcases/kernel/io/stress_floppy/100K_file
+/testcases/kernel/io/stress_floppy/10K_file
+/testcases/kernel/io/stress_floppy/dumpdir/
-- 
1.7.10.4


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
