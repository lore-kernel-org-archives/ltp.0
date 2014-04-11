Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WYYYF-0007Lp-Ru
	for ltp-list@lists.sourceforge.net; Fri, 11 Apr 2014 10:19:15 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WYYYA-0005sx-GP
	for ltp-list@lists.sourceforge.net; Fri, 11 Apr 2014 10:19:15 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3BAIda3022686
	for <ltp-list@lists.sourceforge.net>; Fri, 11 Apr 2014 18:18:39 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Fri, 11 Apr 2014 18:16:42 +0800
Message-ID: <1397211402-12361-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1397211402-12361-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1397211402-12361-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 2/2] tools/apicmd: add tst_fs_has_free
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

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 tools/apicmds/.gitignore  |  1 +
 tools/apicmds/Makefile    |  2 +-
 tools/apicmds/ltpapicmd.c | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/apicmds/.gitignore b/tools/apicmds/.gitignore
index 0c1a896..0ac3e43 100644
--- a/tools/apicmds/.gitignore
+++ b/tools/apicmds/.gitignore
@@ -9,3 +9,4 @@ tst_ncpus
 tst_ncpus_max
 tst_res
 tst_resm
+tst_fs_has_free
diff --git a/tools/apicmds/Makefile b/tools/apicmds/Makefile
index 9ecf570..aa3eefe 100644
--- a/tools/apicmds/Makefile
+++ b/tools/apicmds/Makefile
@@ -27,7 +27,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 CPPFLAGS		+= -D_GNU_SOURCE
 
 MAKE_TARGETS		:= $(addprefix tst_,brk brkm exit flush kvercmp kvercmp2 \
-				res resm ncpus ncpus_max get_unused_port)
+				res resm ncpus ncpus_max get_unused_port fs_has_free)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index c8099c5..de58c1e 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -73,6 +73,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
+#include <stdint.h>
 #include "test.h"
 #include "usctest.h"
 #include "safe_macros.h"
@@ -324,6 +325,28 @@ err:
 	exit(1);
 }
 
+int apicmd_fs_has_free(int argc, char *argv[])
+{
+	if (argc != 3)
+		goto fs_has_free_err;
+
+	char *endptr;
+	uint64_t required_kib = strtoull(argv[1], &endptr, 0);
+
+	if (*argv[1] == '\0' || *endptr != '\0') {
+		fprintf(stderr, "%s is not a valid numeric string\n", argv[1]);
+		goto fs_has_free_err;
+	}
+
+	return tst_fs_has_free(NULL, argv[0], required_kib);
+
+fs_has_free_err:
+	fprintf(stderr, "Usage: tst_fs_has_free path required_kib\n"
+		"path: the pathname of any file within the mounted filesystem\n"
+		"required_kib: the required free space(count in KB)\n");
+	exit(1);
+}
+
 /*
  * Function:    main - entry point of this program
  *
@@ -359,6 +382,7 @@ int main(int argc, char *argv[])
 	if (TCID == NULL || tst_total == NULL || tst_cntstr == NULL) {
 		if (!strcmp(cmd_name, "tst_kvercmp") &&
 		    !strcmp(cmd_name, "tst_kvercmp2") &&
+		    !strcmp(cmd_name, "tst_fs_has_free") &&
 		    !strcmp(cmd_name, "tst_get_unused_port")) {
 			fprintf(stderr,
 				"\nSet variables TCID, TST_TOTAL, and TST_COUNT before each test:\n"
@@ -409,6 +433,8 @@ int main(int argc, char *argv[])
 		printf("%li\n", tst_ncpus_max());
 	} else if (strcmp(cmd_name, "tst_get_unused_port") == 0) {
 		printf("%u\n", apicmd_get_unused_port(argc, argv));
+	} else if (strcmp(cmd_name, "tst_fs_has_free") == 0) {
+		printf("%d\n", apicmd_fs_has_free(argc, argv));
 	}
 
 	exit(0);
-- 
1.8.2.1


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
