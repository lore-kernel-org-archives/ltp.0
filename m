Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WO5yd-0005U6-Lg
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 13:47:15 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-1.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WO5yc-0001y5-8w
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 13:47:15 +0000
From: <liljegren.mats2@gmail.com>
Date: Thu, 13 Mar 2014 14:46:55 +0100
Message-ID: <1394718415-16640-1-git-send-email-liljegren.mats2@gmail.com>
In-Reply-To: <20140313132002.GD31515@rei.suse.cz>
References: <20140313132002.GD31515@rei.suse.cz>
MIME-Version: 1.0
Subject: [LTP] [PATCH] testcases/kernel/io/stress_floppy/.gitignore: File
	added
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
 testcases/kernel/io/stress_floppy/.gitignore |    4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 testcases/kernel/io/stress_floppy/.gitignore

diff --git a/testcases/kernel/io/stress_floppy/.gitignore b/testcases/kernel/io/stress_floppy/.gitignore
new file mode 100644
index 0000000..41ea989
--- /dev/null
+++ b/testcases/kernel/io/stress_floppy/.gitignore
@@ -0,0 +1,4 @@
+/1000K_file
+/100K_file
+/10K_file
+/dumpdir/
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
