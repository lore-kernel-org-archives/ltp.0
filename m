From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 May 2019 15:54:50 +0200
Subject: [LTP] [PATCH] lib: Migrate tst_get_unused_port to new API
Message-ID: <20190520135450.22014-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ sort .gitignore in testcases/lib

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/.gitignore            | 11 +++---
 testcases/lib/Makefile              |  2 +-
 testcases/lib/tst_get_unused_port.c | 58 +++++++++++++++++++++++++++++
 tools/apicmds/.gitignore            |  1 -
 tools/apicmds/ltpapicmd.c           | 31 ---------------
 5 files changed, 65 insertions(+), 38 deletions(-)
 create mode 100644 testcases/lib/tst_get_unused_port.c

diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index d83a48e2a..52f99dc45 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -1,12 +1,13 @@
-/tst_sleep
-/tst_random
 /tst_check_drivers
 /tst_checkpoint
-/tst_rod
-/tst_kvcmp
 /tst_device
+/tst_getconf
+/tst_get_unused_port
+/tst_kvcmp
 /tst_net_iface_prefix
 /tst_net_ip_prefix
 /tst_net_vars
-/tst_getconf
+/tst_random
+/tst_rod
+/tst_sleep
 /tst_supported_fs
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index e1dea3b05..4616e24c0 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -28,6 +28,6 @@ INSTALL_TARGETS		:= *.sh
 
 MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
-			   tst_getconf tst_supported_fs tst_check_drivers
+			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_get_unused_port.c b/testcases/lib/tst_get_unused_port.c
new file mode 100644
index 000000000..4d315ba17
--- /dev/null
+++ b/testcases/lib/tst_get_unused_port.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+ * Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+ * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+ */
+
+#define TST_NO_DEFAULT_MAIN
+#include <stdio.h>
+
+#include "tst_safe_net.h"
+#include "tst_test.h"
+
+static void help(const char *fname)
+{
+	printf("usage: %s FAMILY TYPE\n", fname);
+	printf("FAMILY := { ipv4 | ipv6 }\n");
+	printf("TYPE := { stream | dgram }\n");
+}
+
+int main(int argc, char *argv[])
+{
+	int family = 0, type = 0;
+	int opt;
+
+	while ((opt = getopt(argc, argv, ":h")) != -1) {
+		switch (opt) {
+		case 'h':
+			help(argv[0]);
+			return 0;
+		default:
+			help(argv[0]);
+			return 1;
+		}
+	}
+
+	if (argc != 3) {
+		help(argv[0]);
+		return 1;
+	}
+
+	if (!strcmp(argv[1], "ipv4"))
+		family = AF_INET;
+	else if (!strcmp(argv[1], "ipv6"))
+		family = AF_INET6;
+
+	if (!strcmp(argv[2], "stream"))
+		type = SOCK_STREAM;
+	else if (!strcmp(argv[2], "dgram"))
+		type = SOCK_DGRAM;
+
+	if (!family || !type) {
+		help(argv[0]);
+		return 1;
+	}
+
+	return TST_GET_UNUSED_PORT(family, type);
+}
diff --git a/tools/apicmds/.gitignore b/tools/apicmds/.gitignore
index a9ca9ec6d..54a1d664d 100644
--- a/tools/apicmds/.gitignore
+++ b/tools/apicmds/.gitignore
@@ -1,7 +1,6 @@
 tst_brk
 tst_brkm
 tst_exit
-tst_get_unused_port
 tst_ncpus
 tst_ncpus_conf
 tst_ncpus_max
diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index d94061242..f7e2a5eab 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -193,35 +193,6 @@ struct param_pair {
 	int value;
 };
 
-unsigned short apicmd_get_unused_port(int argc, char *argv[])
-{
-	if (argc != 3)
-		goto err;
-
-	const struct param_pair params[][3] = {
-		{{"ipv4", AF_INET}, {"ipv6", AF_INET6}, {NULL, 0}},
-		{{"stream", SOCK_STREAM}, {"dgram", SOCK_DGRAM}, {NULL, 0}}
-	};
-
-	int i;
-	const struct param_pair *p[2];
-	for (i = 0; i < 2; ++i) {
-		for (p[i] = params[i]; p[i]->cmd; ++p[i]) {
-			if (!strcmp(p[i]->cmd, argv[i]))
-				break;
-		}
-		if (!p[i]->cmd)
-			goto err;
-	}
-	return  TST_GET_UNUSED_PORT(NULL, p[0]->value, p[1]->value);
-
-err:
-	fprintf(stderr, "Usage: tst_get_unused_port FAMILY TYPE\n"
-		"where FAMILY := { ipv4 | ipv6 }\n"
-		"      TYPE := { stream | dgram }\n");
-	exit(1);
-}
-
 int apicmd_fs_has_free(int argc, char *argv[])
 {
 	if (argc != 3) {
@@ -336,8 +307,6 @@ int main(int argc, char *argv[])
 		printf("%li\n", tst_ncpus_conf());
 	} else if (strcmp(cmd_name, "tst_ncpus_max") == 0) {
 		printf("%li\n", tst_ncpus_max());
-	} else if (strcmp(cmd_name, "tst_get_unused_port") == 0) {
-		printf("%u\n", apicmd_get_unused_port(argc, argv));
 	} else if (strcmp(cmd_name, "tst_fs_has_free") == 0) {
 		apicmd_fs_has_free(argc, argv);
 	}
-- 
2.21.0

