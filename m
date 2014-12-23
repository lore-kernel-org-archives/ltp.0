Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Y3Ls3-0004Rp-1a
	for ltp-list@lists.sourceforge.net; Tue, 23 Dec 2014 09:35:15 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y3Lrg-00018H-5W
	for ltp-list@lists.sourceforge.net; Tue, 23 Dec 2014 09:35:15 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sBN9XWxR027051
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Dec 2014 17:33:32 +0800
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 23 Dec 2014 17:33:40 +0800
Message-ID: <1419327221-28508-11-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1419327221-28508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <1419327221-28508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 11/12] smack: Rename 'notroot.c' to
	'smack_notroot.c'
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

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/security/smack/.gitignore         |  2 +-
 testcases/kernel/security/smack/notroot.c          | 29 ----------------------
 .../kernel/security/smack/smack_file_access.sh     |  2 +-
 testcases/kernel/security/smack/smack_notroot.c    | 29 ++++++++++++++++++++++
 4 files changed, 31 insertions(+), 31 deletions(-)
 delete mode 100644 testcases/kernel/security/smack/notroot.c
 create mode 100644 testcases/kernel/security/smack/smack_notroot.c

diff --git a/testcases/kernel/security/smack/.gitignore b/testcases/kernel/security/smack/.gitignore
index 5e9e819..16d5663 100644
--- a/testcases/kernel/security/smack/.gitignore
+++ b/testcases/kernel/security/smack/.gitignore
@@ -1,2 +1,2 @@
-/notroot
+/smack_notroot
 /smack_set_socket_labels
diff --git a/testcases/kernel/security/smack/notroot.c b/testcases/kernel/security/smack/notroot.c
deleted file mode 100644
index 05858d3..0000000
--- a/testcases/kernel/security/smack/notroot.c
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * Copyright (C) 2007 Casey Schaufler <casey@schaufler-ca.com>
- *
- *	This program is free software; you can redistribute it and/or modify
- *	it under the terms of the GNU General Public License as published by
- *	the Free Software Foundation, version 2.
- *
- * Author:
- *	Casey Schaufler <casey@schaufler-ca.com>
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-
-int main(int argc, char *argv[])
-{
-	setuid(1);
-
-	execv(argv[1], &argv[1]);
-
-	perror(argv[0]);
-	exit(1);
-}
diff --git a/testcases/kernel/security/smack/smack_file_access.sh b/testcases/kernel/security/smack/smack_file_access.sh
index a2d09c0..8642715 100755
--- a/testcases/kernel/security/smack/smack_file_access.sh
+++ b/testcases/kernel/security/smack/smack_file_access.sh
@@ -37,7 +37,7 @@ TST_CLEANUP=cleanup
 
 chmod 777 $(pwd)
 
-notroot /bin/sh -c "echo InitialData 2>/tmp/smack_fail.log > $testfile"
+smack_notroot /bin/sh -c "echo InitialData 2>/tmp/smack_fail.log > $testfile"
 if [ ! -f "$testfile" ]; then
 	tst_brkm TFAIL "Test file \"$testfile\" can not be created."
 fi
diff --git a/testcases/kernel/security/smack/smack_notroot.c b/testcases/kernel/security/smack/smack_notroot.c
new file mode 100644
index 0000000..05858d3
--- /dev/null
+++ b/testcases/kernel/security/smack/smack_notroot.c
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2007 Casey Schaufler <casey@schaufler-ca.com>
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ *
+ * Author:
+ *	Casey Schaufler <casey@schaufler-ca.com>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+int main(int argc, char *argv[])
+{
+	setuid(1);
+
+	execv(argv[1], &argv[1]);
+
+	perror(argv[0]);
+	exit(1);
+}
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
