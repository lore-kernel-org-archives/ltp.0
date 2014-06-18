Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1Wx9Rb-0006zh-5u
	for ltp-list@lists.sourceforge.net; Wed, 18 Jun 2014 06:34:03 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wx9RZ-0006CP-Pd
	for ltp-list@lists.sourceforge.net; Wed, 18 Jun 2014 06:34:03 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5I6Xn3o031734
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Jun 2014 14:33:49 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 18 Jun 2014 14:31:03 +0800
Message-ID: <1403073063-26575-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] doc: test-writing-guidelines
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

Add paragraph to describe two new tst_ interfaces: tst_fs_fill_hardlinks() and
tst_fs_fill_subdirs().

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 doc/test-writing-guidelines.txt | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 0a2ac8f..8513f46 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -773,6 +773,45 @@ The required free space is calculated by 'size * mult', e.g.
 filesystem, which '"/tmp/testfile"' is in, has 64MB free space at least, and 0
 if not.
 
+2.2.15 Getting maximal count of links to a regular file or directory
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Some tests need to know the maximal count of links to a regular file or
+directory, such as rename(2) or linkat(2)'s EMLINK error value test.
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "test.h"
+
+int tst_fs_fill_hardlinks(void (*cleanup) (void), const char *dir);
+------------------------------------------------------------------------------
+
+Try to get maximal count of hard links to a regular file inside the @dir.
+Note: This number depends on the filesystem @dir is on. This function uses
+link(2) to create hard links to a single file until it gets EMLINK or creates
+65535 links. If limit is hit maximal number of hardlinks is returned and the
+@dir is filled with hardlinks in format "testfile%i" where i belongs to
+[0, limit) interval. If no limit is hit (succed to create 65535 without error)
+or if link() failed with ENOSPC or EDQUOT, zero is returned and previously
+created files are removed.
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "test.h"
+
+int tst_fs_fill_subdirs(void (*cleanup) (void), const char *dir);
+------------------------------------------------------------------------------
+
+Try to get maximum number of subdirectories in directory. Note: This number
+depends on the filesystem @dir is on. This function uses mkdir(2) to create
+directories in @dir until it gets EMLINK or creates 65535 directories.
+If limit is hit the maximal number of subdirectories is returned and the
+@dir is filled with subdirectories in format "testdir%i" where i belongs to
+[0, limit - 2) interval (because each newly created dir has two links
+allready the '.' and link from parent dir). If no limit is hit or mkdir()
+failed with ENOSPC or EDQUOT, zero is returned previously created directories
+are removed.
+
 2.3 Writing a testcase in shell
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
1.8.2.1


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
