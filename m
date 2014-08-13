Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <asavkov@redhat.com>) id 1XHajC-00083G-OK
	for ltp-list@lists.sourceforge.net; Wed, 13 Aug 2014 15:44:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XHaj7-0005fp-JX
	for ltp-list@lists.sourceforge.net; Wed, 13 Aug 2014 15:44:42 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7DFiVsn014141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Aug 2014 11:44:31 -0400
From: Artem Savkov <asavkov@redhat.com>
Date: Wed, 13 Aug 2014 17:44:26 +0200
Message-Id: <1407944666-32659-7-git-send-email-asavkov@redhat.com>
In-Reply-To: <1407944666-32659-1-git-send-email-asavkov@redhat.com>
References: <1407944666-32659-1-git-send-email-asavkov@redhat.com>
Subject: [LTP] [PATCH v2 6/6] kernel/containers/netns cleanup
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
Cc: Artem Savkov <asavkov@redhat.com>

Updated netns testcases to use tst_resm/tst_exit interfaces instead of plain
exits and call subexecutables using just their name instead of full path as
it is guaranteed that they are within $PATH.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 testcases/kernel/containers/netns/common.c         | 49 ++++------------------
 testcases/kernel/containers/netns/par_chld_ipv6.c  | 41 +++++++-----------
 .../kernel/containers/netns/two_children_ns.c      | 42 ++++++-------------
 3 files changed, 36 insertions(+), 96 deletions(-)

diff --git a/testcases/kernel/containers/netns/common.c b/testcases/kernel/containers/netns/common.c
index 6862700..2a54be5 100644
--- a/testcases/kernel/containers/netns/common.c
+++ b/testcases/kernel/containers/netns/common.c
@@ -45,6 +45,9 @@
 #include "config.h"
 #include "common.h"
 
+#define PARENTNS_SCRIPT "parentns.sh"
+#define CHILDNS_SCRIPT "childns.sh"
+
 static int child_fn(void *c1);
 
 int crtchild(char *s1, char *s2)
@@ -58,11 +61,11 @@ int crtchild(char *s1, char *s2)
 int create_net_namespace(char *p1, char *c1)
 {
 	int pid, status = 0, ret;
-	char *ltproot, *par;
+	char par[FILENAME_MAX];
 	long int clone_flags = 0;
 
 	if (tst_kvercmp(2, 6, 19) < 0)
-		return 1;
+		tst_brkm(TCONF, NULL, "CLONE_NEWPID not supported");
 
 	clone_flags |= CLONE_NEWNS;
 /* Enable other namespaces too optionally */
@@ -77,32 +80,15 @@ int create_net_namespace(char *p1, char *c1)
 		return -1;
 	}
 
-	/* This code will be executed in parent */
-	ltproot = getenv("LTPROOT");
-
-	if (!ltproot) {
-		printf("LTPROOT env variable is not set\n");
-		printf("Please set LTPROOT and re-run the test.. Thankyou\n");
-		return -1;
-	}
-
-	par = malloc(FILENAME_MAX);
-
-	if (par == NULL) {
-		printf("FAIL: error while allocating memory");
-		exit(1);
-	}
-
 	/* We need to pass the child pid to the parentns.sh script */
-	sprintf(par, "%s/testcases/bin/parentns.sh %s %" PRId32, ltproot, p1,
-		pid);
+	sprintf(par, "%s %s %" PRId32, PARENTNS_SCRIPT, p1, pid);
 
 	ret = system(par);
 	status = WEXITSTATUS(ret);
 	if (ret == -1 || status != 0) {
-		printf("Error while running the script\n");
+		tst_resm(TFAIL, "Error while running the script\n");
 		fflush(stdout);
-		exit(1);
+		tst_exit();
 	}
 	fflush(stdout);
 
@@ -118,7 +104,6 @@ int create_net_namespace(char *p1, char *c1)
 /* The function to be executed in the child namespace */
 int child_fn(void *c1)
 {
-	char *ltproot, *child;
 	unsigned long flags = 0;
 #if HAVE_UNSHARE
 	int ret;
@@ -130,22 +115,6 @@ int child_fn(void *c1)
 	flags |= CLONE_NEWUTS;
 	flags |= CLONE_FS;
 
-	ltproot = getenv("LTPROOT");
-
-	if (!ltproot) {
-		printf("LTPROOT env variable is not set\n");
-		printf("Please set LTPROOT and re-run the test..\n");
-		return -1;
-	}
-
-	child = malloc(FILENAME_MAX);
-	if (child == NULL) {
-		printf("FAIL: error while allocating memory");
-		exit(1);
-	}
-
-	sprintf(child, "%s/testcases/bin/childns.sh", ltproot);
-
 	/* Unshare the network namespace in the child */
 #if HAVE_UNSHARE
 	ret = unshare(flags);
@@ -153,7 +122,7 @@ int child_fn(void *c1)
 		perror("Failed to unshare for netns...");
 		return 1;
 	}
-	return crtchild(child, c1);
+	return crtchild(CHILDNS_SCRIPT, c1);
 #else
 	printf("System doesn't support unshare.\n");
 	return -1;
diff --git a/testcases/kernel/containers/netns/par_chld_ipv6.c b/testcases/kernel/containers/netns/par_chld_ipv6.c
index c9f7ad2..bb1e2fc 100644
--- a/testcases/kernel/containers/netns/par_chld_ipv6.c
+++ b/testcases/kernel/containers/netns/par_chld_ipv6.c
@@ -50,6 +50,9 @@
 char *TCID = "netns_ipv6";
 int TST_TOTAL = 1;
 
+#define PARENT_SCRIPT "paripv6.sh"
+#define CHILD_SCRIPT "childipv6.sh"
+
 static void setup(void)
 {
 	tst_require_root(NULL);
@@ -61,7 +64,6 @@ int main(void)
 {
 	int pid, status = 0, ret;
 	long int flags = 0;
-	char *ltproot, *par, *child;
 
 	setup();
 
@@ -69,26 +71,7 @@ int main(void)
 	flags |= CLONE_NEWNET;
 
 	if (tst_kvercmp(2, 6, 19) < 0)
-		return 1;
-
-	ltproot = getenv("LTPROOT");
-
-	if (!ltproot) {
-		tst_resm(TINFO, "LTPROOT env variable is not set");
-		tst_resm(TINFO,
-			 "Please set LTPROOT and re-run the test.. Thankyou");
-		return -1;
-	}
-
-	par = malloc(FILENAME_MAX);
-	child = malloc(FILENAME_MAX);
-
-	if (par == NULL || child == NULL) {
-		tst_resm(TFAIL, "error while allocating mem");
-		exit(1);
-	}
-	sprintf(par, "%s/testcases/bin/paripv6.sh", ltproot);
-	sprintf(child, "%s/testcases/bin/childipv6.sh", ltproot);
+		tst_brkm(TCONF, NULL, "CLONE_NEWPID not supported");
 
 	if ((pid = fork()) == 0) {
 
@@ -99,23 +82,26 @@ int main(void)
 			perror("unshare");
 			tst_resm(TFAIL,
 				 "Error:Unshare syscall failed for network namespace");
-			return 1;
+			tst_exit();
 		}
 #else
 		tst_resm(TCONF, "System doesn't have unshare support");
 #endif
-		return crtchild(child, NULL);
+		if (crtchild(CHILD_SCRIPT, NULL) != 0) {
+			tst_resm(TFAIL, "Failed running child script");
+			tst_exit();
+		}
 	} else {
 
 		//parent
-		ret = system(par);
+		ret = system(PARENT_SCRIPT);
 		status = WEXITSTATUS(ret);
 		if (ret == -1 || status != 0) {
 			tst_resm(TFAIL,
 				 "Error: While running the IPv6 tests between \
 parent & child NS");
 			fflush(stdout);
-			exit(1);
+			tst_exit();
 		}
 		fflush(stdout);
 
@@ -124,9 +110,10 @@ parent & child NS");
 		if (status != 0 || ret == -1) {
 			tst_resm(TFAIL, "waitpid() returns %d, errno %d", ret,
 				 errno);
-			status = errno;
+			tst_exit();
 		}
 		tst_resm(TPASS, "par child ipv6");
-		return status;
+		tst_exit();
 	}
+	tst_exit();
 }
diff --git a/testcases/kernel/containers/netns/two_children_ns.c b/testcases/kernel/containers/netns/two_children_ns.c
index 8cc0e5d..9bc291c 100644
--- a/testcases/kernel/containers/netns/two_children_ns.c
+++ b/testcases/kernel/containers/netns/two_children_ns.c
@@ -63,8 +63,7 @@ int main(void)
 {
 	int ret, pid[2], status, i;
 	long long flags = 0;
-	char *child[2], *par[2];
-	char *ltproot;
+	char child[2][FILENAME_MAX], par[2][FILENAME_MAX];
 
 	setup();
 
@@ -78,30 +77,12 @@ int main(void)
 
 	/* Checking for Kernel Version */
 	if (tst_kvercmp(2, 6, 19) < 0)
-		return 1;
-
-	ltproot = getenv("LTPROOT");
-	if (!ltproot) {
-		tst_resm(TINFO, "LTPROOT env variable is not set");
-		tst_resm(TINFO,
-			 "Please set LTPROOT and re-run the test.. Thankyou");
-		return -1;
-	}
-
-	child[0] = malloc(FILENAME_MAX);
-	child[1] = malloc(FILENAME_MAX);
-	par[0] = malloc(FILENAME_MAX);
-	par[1] = malloc(FILENAME_MAX);
-	if (child[0] == NULL || child[1] == NULL ||
-	    par[0] == NULL || par[1] == NULL) {
-		tst_resm(TFAIL, "error while allocating mem");
-		exit(1);
-	}
+		tst_brkm(TCONF, NULL, "CLONE_NEWPID not supported");
 
-	sprintf(child[0], "%s/testcases/bin/child_1.sh", ltproot);
-	sprintf(child[1], "%s/testcases/bin/child_2.sh", ltproot);
-	sprintf(par[0], "%s/testcases/bin/parent_1.sh", ltproot);
-	sprintf(par[1], "%s/testcases/bin/parent_2.sh", ltproot);
+	strcpy(child[0], "child_1.sh");
+	strcpy(child[1], "child_2.sh");
+	strcpy(par[0], "parent_1.sh");
+	strcpy(par[1], "parent_2.sh");
 
 	/* Loop for creating two child Network Namespaces */
 	for (i = 0; i < 2; i++) {
@@ -115,10 +96,13 @@ int main(void)
 				perror("Unshare");
 				tst_resm(TFAIL,
 					 "Error:Unshare syscall failed for network namespace");
-				return ret;
+				tst_exit();
 			}
 #endif
-			return crtchild(child[i], NULL);
+			if (crtchild(child[i], NULL) != 0) {
+				tst_resm(TFAIL, "Failed running child script");
+				tst_exit();
+			}
 		} else {
 			//Parent
 
@@ -127,7 +111,7 @@ int main(void)
 			if (ret == -1 || status != 0) {
 				tst_resm(TFAIL,
 					 "Error while running the scripts");
-				exit(status);
+				tst_exit();
 			}
 		}
 	}			//End of FOR Loop
@@ -140,7 +124,7 @@ int main(void)
 			tst_resm(TFAIL, "waitpid() returns %d, errno %d", ret,
 				 status);
 			fflush(stdout);
-			exit(status);
+			tst_exit();
 		}
 	}
 
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
