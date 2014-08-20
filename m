Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XK2PY-0002r8-Bq
	for ltp-list@lists.sourceforge.net; Wed, 20 Aug 2014 09:42:32 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XK2PW-0007M7-Nu
	for ltp-list@lists.sourceforge.net; Wed, 20 Aug 2014 09:42:32 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7K9gNGB018711
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 20 Aug 2014 05:42:23 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s7K9gLuE001648
	for <ltp-list@lists.sourceforge.net>; Wed, 20 Aug 2014 05:42:22 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 20 Aug 2014 11:42:20 +0200
Message-Id: <e20fc51f1c2cd8c19583050135c50b807677ee40.1408527528.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] truncate03: impose max file size limit for EFBIG test
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

Using LLONG_MAX as maximum can fail on XFS, because here the maximum
file size is 2^63-1, so this test may unexpectedly succeed.

Impose limit via setrlimit(RLIMIT_FSIZE,..) and set value used
in EFBIG test to be twice that much.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/truncate/truncate03.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/truncate/truncate03.c b/testcases/kernel/syscalls/truncate/truncate03.c
index ed5073d..54b7d3c 100644
--- a/testcases/kernel/syscalls/truncate/truncate03.c
+++ b/testcases/kernel/syscalls/truncate/truncate03.c
@@ -50,6 +50,7 @@
 #include <string.h>
 #include <signal.h>
 #include <pwd.h>
+#include <sys/resource.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -65,6 +66,7 @@
 #define NEW_MODE	S_IRUSR | S_IRGRP | S_IROTH
 #define DIR_MODE	S_IRWXU
 #define TRUNC_LEN	256
+#define MAX_FSIZE	(16*1024*1024)
 
 static char long_pathname[PATH_MAX + 2];
 
@@ -82,7 +84,7 @@ static struct test_case_t {
 	{ long_pathname, TRUNC_LEN, ENAMETOOLONG },
 	{ "", TRUNC_LEN, ENOENT },
 	{ TEST_DIR1, TRUNC_LEN, EISDIR },
-	{ TEST_FILE3, LLONG_MAX, EFBIG },
+	{ TEST_FILE3, MAX_FSIZE*2, EFBIG },
 	{ TEST_SYM1, TRUNC_LEN, ELOOP }
 };
 
@@ -124,6 +126,8 @@ void setup(void)
 {
 	struct passwd *ltpuser;
 	char *bad_addr;
+	struct rlimit rlim;
+	sigset_t sigset;
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
@@ -156,6 +160,18 @@ void setup(void)
 
 	SAFE_SYMLINK(cleanup, TEST_SYM1, TEST_SYM2);
 	SAFE_SYMLINK(cleanup, TEST_SYM2, TEST_SYM1);
+
+	rlim.rlim_cur = MAX_FSIZE;
+	rlim.rlim_max = MAX_FSIZE;
+	TEST(setrlimit(RLIMIT_FSIZE, &rlim));
+	if (TEST_RETURN != 0)
+		tst_brkm(TBROK | TTERRNO, cleanup, "setrlimit");
+
+	sigemptyset(&sigset);
+	sigaddset(&sigset, SIGXFSZ);
+	TEST(sigprocmask(SIG_BLOCK, &sigset, NULL));
+	if (TEST_RETURN != 0)
+		tst_brkm(TBROK | TTERRNO, cleanup, "sigprocmask");
 }
 
 void truncate_verify(struct test_case_t *tc)
-- 
1.7.1


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
