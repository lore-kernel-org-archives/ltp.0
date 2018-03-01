From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu,  1 Mar 2018 12:22:16 +0300
Subject: [LTP] [PATCH] openposix: mmap/21-1: use all bits set as the invalid
	flag
In-Reply-To: <20180212151755.GA23827@rei>
References: <20180212151755.GA23827@rei>
Message-ID: <1519896136-23271-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test is trying to trigger EINVAL by passing an invalid flags
value to mmap(). Linux commit 50a8e840d050 ("mm: introduce MAP_SHARED_VALIDATE, a mechanism to safely define new mmap flags")
introduced a new flag (MAP_SHARED_VALIDATE) and that flag may not be the last one.

So instead of adding an 'if' for each new flag we use a value with all bits
set (which is unlikely to be a valid flag).

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../conformance/interfaces/mmap/21-1.c             |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/21-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/21-1.c
index dc0cc13..ce636cf 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/21-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/21-1.c
@@ -33,7 +33,7 @@ int main(void)
 
 	void *pa;
 	size_t size = 1024;
-	int flag;
+	int flag = ~0;
 	int fd;
 
 	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_21_1_%d", getpid());
@@ -50,10 +50,6 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	flag = MAP_SHARED;
-	while (flag == MAP_SHARED || flag == MAP_PRIVATE || flag == MAP_FIXED)
-		flag++;
-
 	pa = mmap(NULL, size, PROT_READ | PROT_WRITE, flag, fd, 0);
 	if (pa == MAP_FAILED && errno == EINVAL) {
 		printf("Test PASSED\n");
-- 
1.7.1

