From: Li Wang <liwang@redhat.com>
Date: Mon, 14 May 2018 17:26:35 +0800
Subject: [LTP] [PATCH 2/2] madvise: add ERRORS check for
	MADV_REMOVE/MADV_FREE/MADV_WIPEONFORK
Message-ID: <20180514092635.26100-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/madvise/madvise02.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index b773efd..af52741 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -72,12 +72,15 @@ static struct tcase {
 } tcases[] = {
 	{MADV_NORMAL,      "MADV_NORMAL",      &nonalign, EINVAL, 0},
 	{1212,             "MADV_NORMAL",      &file1,    EINVAL, 0},
+	{MADV_REMOVE,      "MADV_REMOVE",      &file1,    EINVAL, 0},
 	{MADV_DONTNEED,    "MADV_DONTNEED",    &file1,    EINVAL, 1},
 	{MADV_MERGEABLE,   "MADV_MERGEABLE",   &file1,    EINVAL, 0},
 	{MADV_UNMERGEABLE, "MADV_UNMERGEABLE", &file1,    EINVAL, 0},
 	{MADV_NORMAL,      "MADV_NORMAL",      &file2,    ENOMEM, 0},
 	{MADV_WILLNEED,    "MADV_WILLNEED",    &file2,    ENOMEM, 0},
 	{MADV_WILLNEED,    "MADV_WILLNEED",    &tmp_addr,  EBADF, 0},
+	{MADV_FREE,        "MADV_FREE",        &file1,    EINVAL, 0},
+	{MADV_WIPEONFORK,  "MADV_WIPEONFORK",  &file1,    EINVAL, 0},
 };
 
 static void tcases_filter(void)
@@ -95,7 +98,10 @@ static void tcases_filter(void)
 			tc->skip = 0;
 #endif /* if !defined(UCLINUX) */
 		break;
-
+		case MADV_REMOVE:
+			if ((tst_kvercmp(2, 6, 16)) < 0)
+				tc->skip = 1;
+		break;
 		case MADV_MERGEABLE:
 		case MADV_UNMERGEABLE:
 			if ((tst_kvercmp(2, 6, 32)) < 0)
@@ -114,6 +120,14 @@ static void tcases_filter(void)
 					tc->exp_errno == EBADF)
 				tc->skip = 1;
 		break;
+		case MADV_FREE:
+			if ((tst_kvercmp(4, 5, 0)) < 0)
+				tc->skip = 1;
+		break;
+		case MADV_WIPEONFORK:
+			if ((tst_kvercmp(4, 14, 0)) < 0)
+				tc->skip = 1;
+		break;
 		default:
 		break;
 		}
-- 
2.9.5

