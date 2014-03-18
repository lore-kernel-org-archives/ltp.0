Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WPuH8-0000a6-4Y
	for ltp-list@lists.sourceforge.net; Tue, 18 Mar 2014 13:41:50 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WPuH7-0005Lf-B8
	for ltp-list@lists.sourceforge.net; Tue, 18 Mar 2014 13:41:50 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2IDfgFx022751
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Mar 2014 13:41:43 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2IDfgq6011804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Mar 2014 13:41:42 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2IDffCV019148
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Mar 2014 13:41:41 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 18 Mar 2014 17:41:56 +0400
Message-Id: <1395150116-16817-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v2] tools/apicmd: add tst_get_unused_port
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

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 tools/apicmds/.gitignore  |    1 +
 tools/apicmds/Makefile    |    2 +-
 tools/apicmds/ltpapicmd.c |   37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/tools/apicmds/.gitignore b/tools/apicmds/.gitignore
index a6d73d3..0c1a896 100644
--- a/tools/apicmds/.gitignore
+++ b/tools/apicmds/.gitignore
@@ -2,6 +2,7 @@ tst_brk
 tst_brkm
 tst_exit
 tst_flush
+tst_get_unused_port
 tst_kvercmp
 tst_kvercmp2
 tst_ncpus
diff --git a/tools/apicmds/Makefile b/tools/apicmds/Makefile
index 3cadc3f..9ecf570 100644
--- a/tools/apicmds/Makefile
+++ b/tools/apicmds/Makefile
@@ -27,7 +27,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 CPPFLAGS		+= -D_GNU_SOURCE
 
 MAKE_TARGETS		:= $(addprefix tst_,brk brkm exit flush kvercmp kvercmp2 \
-				res resm ncpus ncpus_max)
+				res resm ncpus ncpus_max get_unused_port)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index 8fae62a..140fbe2 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -69,6 +69,7 @@
  *
  */
 
+#include <sys/socket.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
@@ -289,6 +290,40 @@ void apicmd_kvercmp2(int argc, char *argv[])
 	exit(exit_value);
 }
 
+struct param_pair {
+	char *cmd;
+	int value;
+};
+
+unsigned short apicmd_get_unused_port(int argc, char *argv[])
+{
+	if (argc != 3)
+		goto err;
+
+	const struct param_pair params[][3] = {
+		{{"ipv4", AF_INET}, {"ipv6", AF_INET6}, {NULL, 0}},
+		{{"stream", SOCK_STREAM}, {"dgram", SOCK_DGRAM}, {NULL, 0}}
+	};
+
+	int i;
+	const struct param_pair *p[2];
+	for (i = 0; i < 2; ++i) {
+		for (p[i] = params[i]; p[i]->cmd; ++p[i]) {
+			if (!strcmp(p[i]->cmd, argv[i]))
+				break;
+		}
+		if (!p[i]->cmd)
+			goto err;
+	}
+	return  tst_get_unused_port(NULL, p[0]->value, p[1]->value);
+
+err:
+	fprintf(stderr, "Usage: tst_get_unused_port FAMILY TYPE\n"
+		"where FAMILY := { ipv4 | ipv6 }\n"
+		"      TYPE := { stream | dgram }\n");
+	exit(1);
+}
+
 /*
  * Function:    main - entry point of this program
  *
@@ -371,6 +406,8 @@ int main(int argc, char *argv[])
 		printf("%li\n", tst_ncpus());
 	} else if (strcmp(cmd_name, "tst_ncpus_max") == 0) {
 		printf("%li\n", tst_ncpus_max());
+	} else if (strcmp(cmd_name, "tst_get_unused_port") == 0) {
+		printf("%u\n", apicmd_get_unused_port(argc, argv));
 	}
 
 	exit(0);
-- 
1.7.1


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
