From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:20:10 +0200
Subject: [LTP] [COMMITTED] [PATCH 37/40] Make use of SAFE_GETSOCKNAME()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-37-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/connect/connect01.c   | 3 +--
 testcases/kernel/syscalls/recv/recv01.c         | 4 ++--
 testcases/kernel/syscalls/recvfrom/recvfrom01.c | 4 ++--
 testcases/kernel/syscalls/recvmsg/recvmsg01.c   | 3 +--
 testcases/kernel/syscalls/send/send01.c         | 3 +--
 testcases/kernel/syscalls/sendfile/sendfile02.c | 3 +--
 testcases/kernel/syscalls/sendfile/sendfile04.c | 3 +--
 testcases/kernel/syscalls/sendfile/sendfile05.c | 3 +--
 testcases/kernel/syscalls/sendfile/sendfile06.c | 3 +--
 testcases/kernel/syscalls/sendmsg/sendmsg01.c   | 3 +--
 testcases/kernel/syscalls/sendto/sendto01.c     | 3 +--
 11 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index c0f711b09..d65af4ae0 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -242,8 +242,7 @@ pid_t start_server(struct sockaddr_in *sin0)
 		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
 		return -1;
 	}
-	if (getsockname(sfd, (struct sockaddr *)sin0, &slen) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+	SAFE_GETSOCKNAME(cleanup, sfd, (struct sockaddr *)sin0, &slen);
 
 	switch ((pid = FORK_OR_VFORK())) {
 	case 0:		/* child */
diff --git a/testcases/kernel/syscalls/recv/recv01.c b/testcases/kernel/syscalls/recv/recv01.c
index 9c21dc206..3345e51e6 100644
--- a/testcases/kernel/syscalls/recv/recv01.c
+++ b/testcases/kernel/syscalls/recv/recv01.c
@@ -53,6 +53,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "recv01";
 int testno;
@@ -238,8 +239,7 @@ pid_t start_server(struct sockaddr_in *sin0)
 		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
 		return -1;
 	}
-	if (getsockname(sfd, (struct sockaddr *)sin0, &slen) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+	SAFE_GETSOCKNAME(cleanup, sfd, (struct sockaddr *)sin0, &slen);
 
 	switch ((pid = FORK_OR_VFORK())) {
 	case 0:		/* child */
diff --git a/testcases/kernel/syscalls/recvfrom/recvfrom01.c b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
index 3bcf2a1fc..e07879b06 100644
--- a/testcases/kernel/syscalls/recvfrom/recvfrom01.c
+++ b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
@@ -53,6 +53,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "recvfrom01";
 int testno;
@@ -267,8 +268,7 @@ pid_t start_server(struct sockaddr_in *sin0)
 		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
 		return -1;
 	}
-	if (getsockname(sfd, (struct sockaddr *)sin0, &slen) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+	SAFE_GETSOCKNAME(cleanup, sfd, (struct sockaddr *)sin0, &slen);
 
 	switch ((pid = FORK_OR_VFORK())) {
 	case 0:		/* child */
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
index 4e19157e7..5bdc60cd9 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
@@ -384,8 +384,7 @@ pid_t start_server(struct sockaddr_in *ssin, struct sockaddr_un *ssun)
 		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
 		return -1;
 	}
-	if (getsockname(sfd, (struct sockaddr *)ssin, &slen) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+	SAFE_GETSOCKNAME(cleanup, sfd, (struct sockaddr *)ssin, &slen);
 
 	/* set up UNIX-domain socket */
 	ufd = socket(PF_UNIX, SOCK_STREAM, 0);
diff --git a/testcases/kernel/syscalls/send/send01.c b/testcases/kernel/syscalls/send/send01.c
index 80a20098a..31e8c1758 100644
--- a/testcases/kernel/syscalls/send/send01.c
+++ b/testcases/kernel/syscalls/send/send01.c
@@ -183,8 +183,7 @@ static pid_t start_server(struct sockaddr_in *sin0)
 		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
 		return -1;
 	}
-	if (getsockname(sfd, (struct sockaddr *)sin0, &slen) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+	SAFE_GETSOCKNAME(cleanup, sfd, (struct sockaddr *)sin0, &slen);
 
 	switch ((pid = FORK_OR_VFORK())) {
 	case 0:
diff --git a/testcases/kernel/syscalls/sendfile/sendfile02.c b/testcases/kernel/syscalls/sendfile/sendfile02.c
index c2a7e7d0f..e5f115146 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile02.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile02.c
@@ -228,8 +228,7 @@ int create_server(void)
 			 strerror(errno));
 		return -1;
 	}
-	if (getsockname(sockfd, (struct sockaddr *)&sin1, &slen) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+	SAFE_GETSOCKNAME(cleanup, sockfd, (struct sockaddr *)&sin1, &slen);
 
 	child_pid = FORK_OR_VFORK();
 	if (child_pid < 0) {
diff --git a/testcases/kernel/syscalls/sendfile/sendfile04.c b/testcases/kernel/syscalls/sendfile/sendfile04.c
index 09869c2c6..0f315abb0 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile04.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile04.c
@@ -225,8 +225,7 @@ int create_server(void)
 			 strerror(errno));
 		return -1;
 	}
-	if (getsockname(sockfd, (struct sockaddr *)&sin1, &slen) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+	SAFE_GETSOCKNAME(cleanup, sockfd, (struct sockaddr *)&sin1, &slen);
 
 	child_pid = FORK_OR_VFORK();
 	if (child_pid < 0) {
diff --git a/testcases/kernel/syscalls/sendfile/sendfile05.c b/testcases/kernel/syscalls/sendfile/sendfile05.c
index 85e296744..0f268ceb3 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile05.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile05.c
@@ -190,8 +190,7 @@ int create_server(void)
 			 strerror(errno));
 		return -1;
 	}
-	if (getsockname(sockfd, (struct sockaddr *)&sin1, &slen) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+	SAFE_GETSOCKNAME(cleanup, sockfd, (struct sockaddr *)&sin1, &slen);
 
 	child_pid = FORK_OR_VFORK();
 	if (child_pid < 0) {
diff --git a/testcases/kernel/syscalls/sendfile/sendfile06.c b/testcases/kernel/syscalls/sendfile/sendfile06.c
index 2d8d6d769..abb67604f 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile06.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile06.c
@@ -169,8 +169,7 @@ static int create_server(void)
 			 strerror(errno));
 		return -1;
 	}
-	if (getsockname(sockfd, (struct sockaddr *)&sin1, &slen) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+	SAFE_GETSOCKNAME(cleanup, sockfd, (struct sockaddr *)&sin1, &slen);
 
 	child_pid = FORK_OR_VFORK();
 	if (child_pid < 0) {
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
index b79c6f4ac..d7f7b757c 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
@@ -442,8 +442,7 @@ static pid_t start_server(struct sockaddr_in *sin0, struct sockaddr_un *sun0)
 			 strerror(errno));
 		return -1;
 	}
-	if (getsockname(sfd, (struct sockaddr *)sin0, &slen) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+	SAFE_GETSOCKNAME(cleanup, sfd, (struct sockaddr *)sin0, &slen);
 
 	/* set up UNIX-domain socket */
 	ufd = socket(PF_UNIX, SOCK_DGRAM, 0);
diff --git a/testcases/kernel/syscalls/sendto/sendto01.c b/testcases/kernel/syscalls/sendto/sendto01.c
index 813c3d7f8..5304da691 100644
--- a/testcases/kernel/syscalls/sendto/sendto01.c
+++ b/testcases/kernel/syscalls/sendto/sendto01.c
@@ -253,8 +253,7 @@ static pid_t start_server(struct sockaddr_in *sin0)
 		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
 		return -1;
 	}
-	if (getsockname(sfd, (struct sockaddr *)sin0, &slen) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+	SAFE_GETSOCKNAME(cleanup, sfd, (struct sockaddr *)sin0, &slen);
 
 	switch ((pid = FORK_OR_VFORK())) {
 	case 0:
-- 
2.13.5

