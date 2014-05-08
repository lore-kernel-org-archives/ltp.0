Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WiH8W-0001pQ-Bk
	for ltp-list@lists.sourceforge.net; Thu, 08 May 2014 05:44:52 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WiH8U-0006tj-SK
	for ltp-list@lists.sourceforge.net; Thu, 08 May 2014 05:44:52 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s485ic3N032464
	for <ltp-list@lists.sourceforge.net>; Thu, 8 May 2014 13:44:39 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Thu, 8 May 2014 13:42:23 +0800
Message-ID: <1399527743-20552-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
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

Add 'verifying filesystem free space' paragraph.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 doc/test-writing-guidelines.txt | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 91edbf0..0239b19 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -723,6 +723,56 @@ options passed to mkfs.
 The extra options 'fs_opts' should either be 'NULL' if there are none or a
 'NULL' terminated array of strings such as '{"-b", "1024", NULL}'.
 
+2.2.14 Verifying a filesystem's free space
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Some tests have size requirements for the filesystem's free space. If these
+requirements are not satisfied, some tests are not appropriate to run.
+Especially you run runltp with "-z" option to specify a big block device,
+different tests have different requirements for the free space of this
+block device, e.g. you specify a 500MB block device, testA needs 400MB free
+space and testB needs 600MB, then testA will surely fail. The tst_fs_has_free()
+below can be used to verify whether filesystem has enough free space, return 1
+if satisfied and 0 if not.
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "test.h"
+
+int tst_fs_has_free(void (*cleanup)(void), const char *path,
+		    unsigned int size, unsigned int mult);
+-------------------------------------------------------------------------------
+
+This function takes 4 arguments:
+    @path is the pathname of any file within filesystem you want to verify
+its free space.
+    @mult should be TST_BYTES, TST_KB, TST_MB or TST_GB.
+    the required free space is calculated by @size * @mult, e.g.
+tst_fs_has_free(cleanup, "/tmp/testfile", 64, TST_MB) will return 1 if the
+filesystem, which "/tmp/testfile" is in, has 64MB free space at least, and
+return 1 if not.
+
+There is also a similar shell interface:
+[source,sh]
+-------------------------------------------------------------------------------
+#!/bin/bash
+
+...
+
+# whether current directory has 32KB free space at least.
+if ! tst_fs_has_free . 32; then
+	tst_brkm TCONF "Not enough free space"
+fi
+
+...
+-------------------------------------------------------------------------------
+
+The tst_fs_has_free shell interface return 0 if the specified free space
+is satisfied, 1 if not, and 2 for error. And the second argument support
+suffixes KB, MB and GB, so 32KB or 64MB is also valid. If not specifying
+a suffix, the default unit is 1 KB.
+
+
 2.3 Writing a testcase in shell
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
1.8.2.1


------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
