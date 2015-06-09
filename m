Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Z2GAY-0003mQ-CE
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 09:50:06 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z2GAW-0001qo-EU
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 09:50:06 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t599nwqm022899
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2015 09:49:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t599nwe7027976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2015 09:49:58 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t599nvJ0018777
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2015 09:49:57 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue,  9 Jun 2015 12:49:45 +0300
Message-Id: <1433843386-31431-4-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1433843386-31431-3-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1433843386-31431-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-2-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-3-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 4/5] tools/apicmd: Add tst_fs_type
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

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 doc/test-writing-guidelines.txt |   17 +++++++++++++++++
 tools/apicmds/.gitignore        |    1 +
 tools/apicmds/Makefile          |    2 +-
 tools/apicmds/ltpapicmd.c       |   17 +++++++++++++++++
 4 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 2c40e3d..e35ec34 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1195,6 +1195,7 @@ Following functions similar to the LTP C interface are available.
 * tst_tmpdir()
 * tst_rmdir()
 * tst_fs_has_free()
+* tst_fs_type()
 
 There is one more function called 'tst_check_cmds()' that gets unspecified
 number of parameters and asserts that each parameter is a name of an
@@ -1249,6 +1250,22 @@ satisfied, 1 if not, and 2 on error.
 
 The second argument supports suffixes kB, MB and GB, the default unit is Byte.
 
+.tst_fs_type
+[source,sh]
+-------------------------------------------------------------------------------
+#!/bin/sh
+
+...
+
+# whether the current directory is on NFS
+if [ $(tst_fs_type .) = "NFS" ]; then
+	tst_brkm TCONF "Not supported on NFS"
+fi
+
+...
+-------------------------------------------------------------------------------
+
+
 2.3.3 Cleanup
 ^^^^^^^^^^^^^
 
diff --git a/tools/apicmds/.gitignore b/tools/apicmds/.gitignore
index b4f7922..c77ba02 100644
--- a/tools/apicmds/.gitignore
+++ b/tools/apicmds/.gitignore
@@ -11,3 +11,4 @@ tst_ncpus_max
 tst_res
 tst_resm
 tst_fs_has_free
+tst_fs_type
diff --git a/tools/apicmds/Makefile b/tools/apicmds/Makefile
index 9c9472d..e8ee78c 100644
--- a/tools/apicmds/Makefile
+++ b/tools/apicmds/Makefile
@@ -28,7 +28,7 @@ CPPFLAGS		+= -D_GNU_SOURCE
 
 MAKE_TARGETS		:= $(addprefix tst_,brk brkm exit flush kvercmp \
 			     kvercmp2 res resm ncpus ncpus_conf ncpus_max \
-			     get_unused_port fs_has_free)
+			     get_unused_port fs_has_free fs_type)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index 5238328..ed59f6a 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -77,6 +77,7 @@
 #include "test.h"
 #include "usctest.h"
 #include "safe_macros.h"
+#include "tst_fs_type.h"
 
 char *TCID;			/* Name of the testcase */
 int TST_TOTAL;			/* Total number of testcases */
@@ -359,6 +360,20 @@ fs_has_free_err:
 	exit(2);
 }
 
+const char *apicmd_fs_type(int argc, char *argv[])
+{
+	long fs_type;
+
+	if (argc != 2) {
+		fprintf(stderr, "Usage: tst_fs_type path\n");
+		exit(2);
+	}
+
+	fs_type = tst_fs_type(NULL, argv[0]);
+
+	return tst_fs_type_name(fs_type);
+}
+
 /*
  * Function:    main - entry point of this program
  *
@@ -449,6 +464,8 @@ int main(int argc, char *argv[])
 		printf("%u\n", apicmd_get_unused_port(argc, argv));
 	} else if (strcmp(cmd_name, "tst_fs_has_free") == 0) {
 		apicmd_fs_has_free(argc, argv);
+	} else if (strcmp(cmd_name, "tst_fs_type") == 0) {
+		printf("%s\n", apicmd_fs_type(argc, argv));
 	}
 
 	exit(0);
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
