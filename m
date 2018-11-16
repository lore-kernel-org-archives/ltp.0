From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Nov 2018 08:51:19 +0200
Subject: [LTP] [PATCH 5/5] syscalls/fanotify10: add tests for
	FAN_MARK_FILESYSTEM and ignore mask
In-Reply-To: <20181116065119.6912-1-amir73il@gmail.com>
References: <20181116065119.6912-1-amir73il@gmail.com>
Message-ID: <20181116065119.6912-6-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

A watch with FAN_MARK_FILESYSTEM should ignore events that were
generated on files whose inode have an ignore mask and ignore events
generated on a mount that has a mark with ignore mask.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify10.c     | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 2b96de2f1..820c50a8a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -66,11 +66,13 @@ static int bind_mount_created;
 enum {
 	FANOTIFY_INODE,
 	FANOTIFY_MOUNT,
+	FANOTIFY_FILESYSTEM,
 };
 
 static struct fanotify_mark_type fanotify_mark_types[] = {
 	INIT_FANOTIFY_MARK_TYPE(INODE),
 	INIT_FANOTIFY_MARK_TYPE(MOUNT),
+	INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
 };
 
 static struct tcase {
@@ -106,9 +108,33 @@ static struct tcase {
 		MNT2_PATH, FANOTIFY_MOUNT,
 		FILE_PATH, 1
 	},
+	{
+		"ignore fs events created on a specific file",
+		MOUNT_PATH, FANOTIFY_FILESYSTEM,
+		FILE_PATH, FANOTIFY_INODE,
+		FILE_PATH, 0
+	},
+	{
+		"don't ignore mount events created on another file",
+		MOUNT_PATH, FANOTIFY_FILESYSTEM,
+		FILE_PATH, FANOTIFY_INODE,
+		FILE2_PATH, 1
+	},
+	{
+		"ignore fs events created on a specific mount point",
+		MOUNT_PATH, FANOTIFY_FILESYSTEM,
+		MNT2_PATH, FANOTIFY_MOUNT,
+		FILE_MNT2, 0
+	},
+	{
+		"don't ignore fs events created on another mount point",
+		MOUNT_PATH, FANOTIFY_FILESYSTEM,
+		MNT2_PATH, FANOTIFY_MOUNT,
+		FILE_PATH, 1
+	},
 };
 
-static void create_fanotify_groups(unsigned int n)
+static int create_fanotify_groups(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 	struct fanotify_mark_type *mark, *ignore_mark;
@@ -129,6 +155,13 @@ static void create_fanotify_groups(unsigned int n)
 					    FAN_MARK_ADD | mark->flag,
 					    FAN_OPEN, AT_FDCWD, tc->mark_path);
 			if (ret < 0) {
+				if (errno == EINVAL &&
+				    tc->mark_type == FANOTIFY_FILESYSTEM) {
+					tst_res(TCONF,
+						"FAN_MARK_FILESYSTEM not "
+						"supported in kernel?");
+					return -1;
+				}
 				tst_brk(TBROK | TERRNO,
 					"fanotify_mark(%d, FAN_MARK_ADD | %s,"
 					"FAN_OPEN, AT_FDCWD, %s) failed",
@@ -155,6 +188,7 @@ static void create_fanotify_groups(unsigned int n)
 			}
 		}
 	}
+	return 0;
 }
 
 static void cleanup_fanotify_groups(void)
@@ -198,7 +232,8 @@ static void test_fanotify(unsigned int n)
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
-	create_fanotify_groups(n);
+	if (create_fanotify_groups(n) != 0)
+		goto cleanup;
 
 	mark = &fanotify_mark_types[tc->mark_type];
 	ignore_mark = &fanotify_mark_types[tc->ignore_mark_type];
@@ -268,6 +303,7 @@ static void test_fanotify(unsigned int n)
 			}
 		}
 	}
+cleanup:
 	cleanup_fanotify_groups();
 }
 
-- 
2.17.1

