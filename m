Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WNizE-0005Mi-Ey
	for ltp-list@lists.sourceforge.net; Wed, 12 Mar 2014 13:14:20 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WNizC-0005le-JM
	for ltp-list@lists.sourceforge.net; Wed, 12 Mar 2014 13:14:20 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2CDCvbE005122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 12 Mar 2014 09:14:00 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s2CCtvdn018857
	for <ltp-list@lists.sourceforge.net>; Wed, 12 Mar 2014 08:55:59 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 12 Mar 2014 13:55:48 +0100
Message-Id: <a2f617c2d58b7b36ca6103451f1beda78fe55ffd.1394628698.git.jstancek@redhat.com>
In-Reply-To: <b0a5209e870097e04ba474c1ca6d64de91523462.1394628698.git.jstancek@redhat.com>
References: <b0a5209e870097e04ba474c1ca6d64de91523462.1394628698.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v3 2/2] do not pick free/unused port by chance
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

Let the kernel pick free random port and do not rely on previously used
formula: (getpid() % 32768) + 11000 to provide unused port numbers.

If test only needs unused port number (without binding anything to it)
get it with tst_get_unused_port().

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/bind/bind01.c         |    2 +-
 testcases/kernel/syscalls/connect/connect01.c   |   17 ++++++++++-------
 testcases/kernel/syscalls/recv/recv01.c         |   15 +++++++++------
 testcases/kernel/syscalls/recvfrom/recvfrom01.c |   15 +++++++++------
 testcases/kernel/syscalls/recvmsg/recvmsg01.c   |   12 ++++++++----
 testcases/kernel/syscalls/send/send01.c         |   15 +++++++++------
 testcases/kernel/syscalls/sendfile/sendfile02.c |    6 +++++-
 testcases/kernel/syscalls/sendfile/sendfile04.c |    6 +++++-
 testcases/kernel/syscalls/sendfile/sendfile05.c |    6 +++++-
 testcases/kernel/syscalls/sendfile/sendfile06.c |    6 +++++-
 testcases/kernel/syscalls/sendmsg/sendmsg01.c   |   17 ++++++++++-------
 testcases/kernel/syscalls/sendto/sendto01.c     |   15 +++++++++------
 12 files changed, 85 insertions(+), 47 deletions(-)

diff --git a/testcases/kernel/syscalls/bind/bind01.c b/testcases/kernel/syscalls/bind/bind01.c
index ed02299..d61b807 100644
--- a/testcases/kernel/syscalls/bind/bind01.c
+++ b/testcases/kernel/syscalls/bind/bind01.c
@@ -162,7 +162,7 @@ void setup(void)
 	/* initialize sockaddr's */
 	sin1.sin_family = AF_INET;
 	/* this port must be unused! */
-	sin1.sin_port = htons((getpid() % 32768) + 10000);
+	sin1.sin_port = tst_get_unused_port(NULL, AF_INET, SOCK_STREAM);
 	sin1.sin_addr.s_addr = INADDR_ANY;
 
 	sin2.sin_family = AF_INET;
diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index 9fab087..4699fea 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -175,15 +175,11 @@ void setup(void)
 {
 	TEST_PAUSE;		/* if -p option specified */
 
-	/* initialize sockaddr's */
-	sin1.sin_family = AF_INET;
-	sin1.sin_port = htons((getpid() % 32768) + 11000);
-	sin1.sin_addr.s_addr = INADDR_ANY;
 	pid = start_server(&sin1);
 
 	sin2.sin_family = AF_INET;
 	/* this port must be unused! */
-	sin2.sin_port = htons((getpid() % 32768) + 10000);
+	sin2.sin_port = tst_get_unused_port(NULL, AF_INET, SOCK_STREAM);
 	sin2.sin_addr.s_addr = INADDR_ANY;
 
 	sin3.sin_family = AF_INET;
@@ -243,15 +239,19 @@ void setup2(void)
 
 pid_t start_server(struct sockaddr_in *sin0)
 {
-	struct sockaddr_in sin1 = *sin0;
 	pid_t pid;
+	socklen_t slen = sizeof(*sin0);
+
+	sin0->sin_family = AF_INET;
+	sin0->sin_port = 0; /* pick random free port */
+	sin0->sin_addr.s_addr = INADDR_ANY;
 
 	sfd = socket(PF_INET, SOCK_STREAM, 0);
 	if (sfd < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup, "server socket failed");
 		return -1;
 	}
-	if (bind(sfd, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
+	if (bind(sfd, (struct sockaddr *)sin0, sizeof(*sin0)) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup, "server bind failed");
 		return -1;
 	}
@@ -259,6 +259,9 @@ pid_t start_server(struct sockaddr_in *sin0)
 		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
 		return -1;
 	}
+	if (getsockname(sfd, (struct sockaddr *)sin0, &slen) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+
 	switch ((pid = FORK_OR_VFORK())) {
 	case 0:		/* child */
 #ifdef UCLINUX
diff --git a/testcases/kernel/syscalls/recv/recv01.c b/testcases/kernel/syscalls/recv/recv01.c
index 4966587..0615acf 100644
--- a/testcases/kernel/syscalls/recv/recv01.c
+++ b/testcases/kernel/syscalls/recv/recv01.c
@@ -159,10 +159,6 @@ void setup(void)
 {
 	TEST_PAUSE;
 
-	/* initialize sockaddr's */
-	sin1.sin_family = AF_INET;
-	sin1.sin_port = htons((getpid() % 32768) + 11000);
-	sin1.sin_addr.s_addr = INADDR_ANY;
 	pid = start_server(&sin1);
 
 	(void)signal(SIGPIPE, SIG_IGN);
@@ -221,15 +217,19 @@ void cleanup1(void)
 
 pid_t start_server(struct sockaddr_in *sin0)
 {
-	struct sockaddr_in sin1 = *sin0;
 	pid_t pid;
+	socklen_t slen = sizeof(*sin0);
+
+	sin0->sin_family = AF_INET;
+	sin0->sin_port = 0; /* pick random free port */
+	sin0->sin_addr.s_addr = INADDR_ANY;
 
 	sfd = socket(PF_INET, SOCK_STREAM, 0);
 	if (sfd < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup, "server socket failed");
 		return -1;
 	}
-	if (bind(sfd, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
+	if (bind(sfd, (struct sockaddr *)sin0, sizeof(*sin0)) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup, "server bind failed");
 		return -1;
 	}
@@ -237,6 +237,9 @@ pid_t start_server(struct sockaddr_in *sin0)
 		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
 		return -1;
 	}
+	if (getsockname(sfd, (struct sockaddr *)sin0, &slen) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+
 	switch ((pid = FORK_OR_VFORK())) {
 	case 0:		/* child */
 #ifdef UCLINUX
diff --git a/testcases/kernel/syscalls/recvfrom/recvfrom01.c b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
index 171b3ab..b5ab4a0 100644
--- a/testcases/kernel/syscalls/recvfrom/recvfrom01.c
+++ b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
@@ -181,10 +181,6 @@ void setup(void)
 {
 	TEST_PAUSE;
 
-	/* initialize sockaddr's */
-	sin1.sin_family = AF_INET;
-	sin1.sin_port = htons((getpid() % 32768) + 11000);
-	sin1.sin_addr.s_addr = INADDR_ANY;
 	pid = start_server(&sin1);
 }
 
@@ -248,15 +244,19 @@ void cleanup1(void)
 
 pid_t start_server(struct sockaddr_in *sin0)
 {
-	struct sockaddr_in sin1 = *sin0;
 	pid_t pid;
+	socklen_t slen = sizeof(*sin0);
+
+	sin0->sin_family = AF_INET;
+	sin0->sin_port = 0; /* pick random free port */
+	sin0->sin_addr.s_addr = INADDR_ANY;
 
 	sfd = socket(PF_INET, SOCK_STREAM, 0);
 	if (sfd < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup, "server socket failed");
 		return -1;
 	}
-	if (bind(sfd, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
+	if (bind(sfd, (struct sockaddr *)sin0, sizeof(*sin0)) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup, "server bind failed");
 		return -1;
 	}
@@ -264,6 +264,9 @@ pid_t start_server(struct sockaddr_in *sin0)
 		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
 		return -1;
 	}
+	if (getsockname(sfd, (struct sockaddr *)sin0, &slen) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+
 	switch ((pid = FORK_OR_VFORK())) {
 	case 0:		/* child */
 #ifdef UCLINUX
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
index 847c0d1..dd6b3d5 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
@@ -260,10 +260,6 @@ void setup(void)
 	int tfd;
 	TEST_PAUSE;
 
-	/* initialize sockaddr's */
-	sin1.sin_family = AF_INET;
-	sin1.sin_port = htons((getpid() % 32768) + 11000);
-	sin1.sin_addr.s_addr = INADDR_ANY;
 	tst_tmpdir();
 	(void)strcpy(tmpsunpath, "udsockXXXXXX");
 	tfd = mkstemp(tmpsunpath);
@@ -380,6 +376,11 @@ void cleanup2(void)
 pid_t start_server(struct sockaddr_in *ssin, struct sockaddr_un *ssun)
 {
 	pid_t pid;
+	socklen_t slen = sizeof(*ssin);
+
+	ssin->sin_family = AF_INET;
+	ssin->sin_port = 0; /* pick random free port */
+	ssin->sin_addr.s_addr = INADDR_ANY;
 
 	/* set up inet socket */
 	sfd = socket(PF_INET, SOCK_STREAM, 0);
@@ -395,6 +396,9 @@ pid_t start_server(struct sockaddr_in *ssin, struct sockaddr_un *ssun)
 		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
 		return -1;
 	}
+	if (getsockname(sfd, (struct sockaddr *)ssin, &slen) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+
 	/* set up UNIX-domain socket */
 	ufd = socket(PF_UNIX, SOCK_STREAM, 0);
 	if (ufd < 0) {
diff --git a/testcases/kernel/syscalls/send/send01.c b/testcases/kernel/syscalls/send/send01.c
index 6ebe131..5df4a55 100644
--- a/testcases/kernel/syscalls/send/send01.c
+++ b/testcases/kernel/syscalls/send/send01.c
@@ -165,15 +165,19 @@ static char *argv0;
 
 static pid_t start_server(struct sockaddr_in *sin0)
 {
-	struct sockaddr_in sin1 = *sin0;
 	pid_t pid;
+	socklen_t slen = sizeof(*sin0);
+
+	sin0->sin_family = AF_INET;
+	sin0->sin_port = 0; /* pick random free port */
+	sin0->sin_addr.s_addr = INADDR_ANY;
 
 	sfd = socket(PF_INET, SOCK_STREAM, 0);
 	if (sfd < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup, "server socket failed");
 		return -1;
 	}
-	if (bind(sfd, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
+	if (bind(sfd, (struct sockaddr *)sin0, sizeof(*sin0)) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup, "server bind failed");
 		return -1;
 	}
@@ -181,6 +185,9 @@ static pid_t start_server(struct sockaddr_in *sin0)
 		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
 		return -1;
 	}
+	if (getsockname(sfd, (struct sockaddr *)sin0, &slen) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+
 	switch ((pid = FORK_OR_VFORK())) {
 	case 0:
 #ifdef UCLINUX
@@ -299,10 +306,6 @@ static void setup(void)
 {
 	TEST_PAUSE;
 
-	/* initialize sockaddr's */
-	sin1.sin_family = AF_INET;
-	sin1.sin_port = htons((getpid() % 32768) + 11000);
-	sin1.sin_addr.s_addr = INADDR_ANY;
 	server_pid = start_server(&sin1);
 
 	signal(SIGPIPE, SIG_IGN);
diff --git a/testcases/kernel/syscalls/sendfile/sendfile02.c b/testcases/kernel/syscalls/sendfile/sendfile02.c
index 8d60c44..d96e12e 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile02.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile02.c
@@ -232,6 +232,7 @@ void cleanup()
 int create_server(void)
 {
 	static int count = 0;
+	socklen_t slen = sizeof(sin1);
 
 	sockfd = socket(PF_INET, SOCK_DGRAM, 0);
 	if (sockfd < 0) {
@@ -240,7 +241,7 @@ int create_server(void)
 		return -1;
 	}
 	sin1.sin_family = AF_INET;
-	sin1.sin_port = htons(((getpid() * TST_TOTAL) % 32768) + 11000 + count);
+	sin1.sin_port = 0; /* pick random free port */
 	sin1.sin_addr.s_addr = INADDR_ANY;
 	count++;
 	if (bind(sockfd, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
@@ -248,6 +249,9 @@ int create_server(void)
 			 strerror(errno));
 		return -1;
 	}
+	if (getsockname(sockfd, (struct sockaddr *)&sin1, &slen) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+
 	child_pid = FORK_OR_VFORK();
 	if (child_pid < 0) {
 		tst_brkm(TBROK, cleanup, "client/server fork failed: %s",
diff --git a/testcases/kernel/syscalls/sendfile/sendfile04.c b/testcases/kernel/syscalls/sendfile/sendfile04.c
index b366231..0444b12 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile04.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile04.c
@@ -218,6 +218,7 @@ void cleanup()
 int create_server(void)
 {
 	static int count = 0;
+	socklen_t slen = sizeof(sin1);
 
 	sockfd = socket(PF_INET, SOCK_DGRAM, 0);
 	if (sockfd < 0) {
@@ -226,7 +227,7 @@ int create_server(void)
 		return -1;
 	}
 	sin1.sin_family = AF_INET;
-	sin1.sin_port = htons(((getpid() * TST_TOTAL) % 32768) + 11000 + count);
+	sin1.sin_port = 0; /* pick random free port */
 	sin1.sin_addr.s_addr = INADDR_ANY;
 	count++;
 	if (bind(sockfd, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
@@ -234,6 +235,9 @@ int create_server(void)
 			 strerror(errno));
 		return -1;
 	}
+	if (getsockname(sockfd, (struct sockaddr *)&sin1, &slen) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+
 	child_pid = FORK_OR_VFORK();
 	if (child_pid < 0) {
 		tst_brkm(TBROK, cleanup, "client/server fork failed: %s",
diff --git a/testcases/kernel/syscalls/sendfile/sendfile05.c b/testcases/kernel/syscalls/sendfile/sendfile05.c
index 09148f2..d4b302a 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile05.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile05.c
@@ -182,6 +182,7 @@ void cleanup()
 int create_server(void)
 {
 	static int count = 0;
+	socklen_t slen = sizeof(sin1);
 
 	sockfd = socket(PF_INET, SOCK_DGRAM, 0);
 	if (sockfd < 0) {
@@ -190,7 +191,7 @@ int create_server(void)
 		return -1;
 	}
 	sin1.sin_family = AF_INET;
-	sin1.sin_port = htons((getpid() % 32768) + 11000 + count);
+	sin1.sin_port = 0; /* pick random free port */
 	sin1.sin_addr.s_addr = INADDR_ANY;
 	count++;
 	if (bind(sockfd, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
@@ -198,6 +199,9 @@ int create_server(void)
 			 strerror(errno));
 		return -1;
 	}
+	if (getsockname(sockfd, (struct sockaddr *)&sin1, &slen) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+
 	child_pid = FORK_OR_VFORK();
 	if (child_pid < 0) {
 		tst_brkm(TBROK, cleanup, "client/server fork failed: %s",
diff --git a/testcases/kernel/syscalls/sendfile/sendfile06.c b/testcases/kernel/syscalls/sendfile/sendfile06.c
index 2f253be..de512a9 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile06.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile06.c
@@ -204,6 +204,7 @@ void cleanup()
 int create_server(void)
 {
 	static int count = 0;
+	socklen_t slen = sizeof(sin1);
 
 	sockfd = socket(PF_INET, SOCK_DGRAM, 0);
 	if (sockfd < 0) {
@@ -212,7 +213,7 @@ int create_server(void)
 		return -1;
 	}
 	sin1.sin_family = AF_INET;
-	sin1.sin_port = htons((getpid() % 32768) + 11000 + count);
+	sin1.sin_port = 0; /* pick random free port */
 	sin1.sin_addr.s_addr = INADDR_ANY;
 	count++;
 	if (bind(sockfd, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
@@ -220,6 +221,9 @@ int create_server(void)
 			 strerror(errno));
 		return -1;
 	}
+	if (getsockname(sockfd, (struct sockaddr *)&sin1, &slen) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+
 	child_pid = FORK_OR_VFORK();
 	if (child_pid < 0) {
 		tst_brkm(TBROK, cleanup, "client/server fork failed: %s",
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
index 81d5770..58d3364 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
@@ -461,8 +461,12 @@ int main(int argc, char *argv[])
 
 static pid_t start_server(struct sockaddr_in *sin0, struct sockaddr_un *sun0)
 {
-	struct sockaddr_in sin1 = *sin0;
 	pid_t pid;
+	socklen_t slen = sizeof(*sin0);
+
+	sin0->sin_family = AF_INET;
+	sin0->sin_port = 0; /* pick random free port */
+	sin0->sin_addr.s_addr = INADDR_ANY;
 
 	/* set up inet socket */
 	sfd = socket(PF_INET, SOCK_STREAM, 0);
@@ -471,7 +475,7 @@ static pid_t start_server(struct sockaddr_in *sin0, struct sockaddr_un *sun0)
 			 strerror(errno));
 		return -1;
 	}
-	if (bind(sfd, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
+	if (bind(sfd, (struct sockaddr *)sin0, sizeof(*sin0)) < 0) {
 		tst_brkm(TBROK, cleanup, "server bind failed: %s",
 			 strerror(errno));
 		return -1;
@@ -481,6 +485,9 @@ static pid_t start_server(struct sockaddr_in *sin0, struct sockaddr_un *sun0)
 			 strerror(errno));
 		return -1;
 	}
+	if (getsockname(sfd, (struct sockaddr *)sin0, &slen) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+
 	/* set up UNIX-domain socket */
 	ufd = socket(PF_UNIX, SOCK_DGRAM, 0);
 	if (ufd < 0) {
@@ -577,10 +584,6 @@ static void setup(void)
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 
-	/* initialize sockaddr's */
-	sin1.sin_family = AF_INET;
-	sin1.sin_port = htons((getpid() % 32768) + 11000);
-	sin1.sin_addr.s_addr = INADDR_ANY;
 
 	tst_tmpdir();
 	snprintf(tmpsunpath, 1024, "udsock%ld", (long)time(NULL));
@@ -713,7 +716,7 @@ static void setup5(void)
 	 * 5-tuple than already connected
 	 */
 	sin2 = sin1;
-	sin2.sin_port++;
+	sin2.sin_port = tst_get_unused_port(cleanup, AF_INET, SOCK_STREAM);
 }
 
 static void setup6(void)
diff --git a/testcases/kernel/syscalls/sendto/sendto01.c b/testcases/kernel/syscalls/sendto/sendto01.c
index e2422ea..723ffde 100644
--- a/testcases/kernel/syscalls/sendto/sendto01.c
+++ b/testcases/kernel/syscalls/sendto/sendto01.c
@@ -237,15 +237,19 @@ static char *argv0;
 
 static pid_t start_server(struct sockaddr_in *sin0)
 {
-	struct sockaddr_in sin1 = *sin0;
 	pid_t pid;
+	socklen_t slen = sizeof(*sin0);
+
+	sin0->sin_family = AF_INET;
+	sin0->sin_port = 0; /* pick random free port */
+	sin0->sin_addr.s_addr = INADDR_ANY;
 
 	sfd = socket(PF_INET, SOCK_STREAM, 0);
 	if (sfd < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup, "server socket failed");
 		return -1;
 	}
-	if (bind(sfd, (struct sockaddr *)&sin1, sizeof(sin1)) < 0) {
+	if (bind(sfd, (struct sockaddr *)sin0, sizeof(*sin0)) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup, "server bind failed");
 		return -1;
 	}
@@ -253,6 +257,9 @@ static pid_t start_server(struct sockaddr_in *sin0)
 		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
 		return -1;
 	}
+	if (getsockname(sfd, (struct sockaddr *)sin0, &slen) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "getsockname failed");
+
 	switch ((pid = FORK_OR_VFORK())) {
 	case 0:
 #ifdef UCLINUX
@@ -372,10 +379,6 @@ static void setup(void)
 {
 	TEST_PAUSE;
 
-	/* initialize sockaddr's */
-	sin1.sin_family = AF_INET;
-	sin1.sin_port = htons((getpid() % 32768) + 11000);
-	sin1.sin_addr.s_addr = INADDR_ANY;
 	server_pid = start_server(&sin1);
 
 	signal(SIGPIPE, SIG_IGN);
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
