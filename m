From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Dec 2018 15:10:38 +0800
Subject: [LTP] [PATCH] fcntl: fcntl F_SETLEASE return EAGAIN on overlapfs
Message-ID: <20181217071038.16255-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From Miklos's words:

The F_SETLEASE "failure" is caused by the simplistic way the
kernel currently determines if there's a possible local conflict
to a write lock:

check_conflicting_open(const struct dentry *dentry, const long arg, int flags)
{
/*...*/
	if ((arg == F_WRLCK) && ((d_count(dentry) > 1) ||
	    (atomic_read(&inode->i_count) > 1)))
		ret = -EAGAIN;
/*...*/

It reads the dentry count, and if there's any other reference
to the dentry or inode as the one held by this file, then it
is assumed to come from a conflicting open. Which is not true,
dentry references can come from variety of sources (e.g. O_PATH
opens are obviously non-conflicting). This causes failure on
tmpfs as well, which holds an extra reference on each dentry.

The extra ref on the dentry in overlayfs comes from the realfile
stored in the overlay file's private_data field.

The proper solution to this is probably to have an i_readcount,
matching the functionality of i_writecount, which would solve
the other problems with the current approach.

Note: this is not a failure in the sense that applications must
be written with the assumption that F_SETLEASE can fail with
-EAGAIN, so this error condition just makes the lease non-useful,
but shouldn't break anything.

==== Error log =====
fcntl24     1  TFAIL  :  fcntl24.c:148: fcntl(tfile_7254, F_SETLEASE, F_WRLCK) Failed, errno=11 : Resource temporarily unavailable
fcntl25     1  TFAIL  :  fcntl25.c:149: fcntl(tfile_7255, F_SETLEASE, F_WRLCK) Failed, errno=11 : Resource temporarily unavailable
fcntl26     1  TFAIL  :  fcntl26.c:149: fcntl(tfile_7256, F_SETLEASE, F_WRLCK) Failed, errno=11 : Resource temporarily unavailable
fcntl33.c:118: FAIL: fcntl() failed to set lease: EAGAIN/EWOULDBLOCK
fcntl33.c:118: FAIL: fcntl() failed to set lease: EAGAIN/EWOULDBLOCK
fcntl33.c:118: FAIL: fcntl() failed to set lease: EAGAIN/EWOULDBLOCK
fcntl33.c:118: FAIL: fcntl() failed to set lease: EAGAIN/EWOULDBLOCK

Reported-by: Xiong Zhou <xzhou@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Ye Chao <cye@redhat.com>
---
 include/tst_fs.h                          |  1 +
 lib/tst_fs_type.c                         |  2 ++
 testcases/kernel/syscalls/fcntl/fcntl24.c | 12 +++++++++---
 testcases/kernel/syscalls/fcntl/fcntl25.c | 12 +++++++++---
 testcases/kernel/syscalls/fcntl/fcntl26.c | 12 +++++++++---
 testcases/kernel/syscalls/fcntl/fcntl33.c |  8 +++++++-
 6 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index 8d3f1cfbc..23f139ded 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -41,6 +41,7 @@
 #define TST_F2FS_MAGIC     0xF2F52010
 #define TST_NILFS_MAGIC    0x3434
 #define TST_EXOFS_MAGIC    0x5DF5
+#define TST_OVERLAYFS_MAGIC 0x794c7630
 
 enum {
 	TST_BYTES = 1,
diff --git a/lib/tst_fs_type.c b/lib/tst_fs_type.c
index 5fbf0f436..1d0ac9669 100644
--- a/lib/tst_fs_type.c
+++ b/lib/tst_fs_type.c
@@ -82,6 +82,8 @@ const char *tst_fs_type_name(long f_type)
 		return "NILFS";
 	case TST_EXOFS_MAGIC:
 		return "EXOFS";
+	case TST_OVERLAYFS_MAGIC:
+		return "OVERLAYFS";
 	default:
 		return "Unknown";
 	}
diff --git a/testcases/kernel/syscalls/fcntl/fcntl24.c b/testcases/kernel/syscalls/fcntl/fcntl24.c
index 4711d52ff..167f245c4 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl24.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl24.c
@@ -143,9 +143,15 @@ int main(int ac, char **av)
 
 		/* check return code */
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "fcntl(%s, F_SETLEASE, F_WRLCK) Failed, errno=%d : %s",
-				 fname, TEST_ERRNO, strerror(TEST_ERRNO));
+			if (type == TST_OVERLAYFS_MAGIC && TEST_ERRNO == EAGAIN) {
+				tst_resm(TINFO | TTERRNO,
+					"fcntl(F_SETLEASE, F_WRLCK) "
+					"failed on overlapfs as expected");
+			} else {
+				tst_resm(TFAIL,
+					"fcntl(%s, F_SETLEASE, F_WRLCK) Failed, errno=%d : %s",
+					fname, TEST_ERRNO, strerror(TEST_ERRNO));
+			}
 		} else {
 			TEST(fcntl(fd, F_GETLEASE));
 			if (TEST_RETURN != F_WRLCK)
diff --git a/testcases/kernel/syscalls/fcntl/fcntl25.c b/testcases/kernel/syscalls/fcntl/fcntl25.c
index bf6dd1da5..052530c3c 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl25.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl25.c
@@ -144,9 +144,15 @@ int main(int ac, char **av)
 
 		/* check return code */
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "fcntl(%s, F_SETLEASE, F_WRLCK) Failed, errno=%d : %s",
-				 fname, TEST_ERRNO, strerror(TEST_ERRNO));
+			if (type == TST_OVERLAYFS_MAGIC && TEST_ERRNO == EAGAIN) {
+				tst_resm(TINFO | TTERRNO,
+						"fcntl(F_SETLEASE, F_WRLCK) "
+						"failed on overlapfs as expected");
+			} else {
+				tst_resm(TFAIL,
+					 "fcntl(%s, F_SETLEASE, F_WRLCK) Failed, errno=%d : %s",
+					 fname, TEST_ERRNO, strerror(TEST_ERRNO));
+			}
 		} else {
 			TEST(fcntl(fd, F_GETLEASE));
 			if (TEST_RETURN != F_WRLCK)
diff --git a/testcases/kernel/syscalls/fcntl/fcntl26.c b/testcases/kernel/syscalls/fcntl/fcntl26.c
index 8c2591b9f..b74c6a7a9 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl26.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl26.c
@@ -144,9 +144,15 @@ int main(int ac, char **av)
 
 		/* check return code */
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "fcntl(%s, F_SETLEASE, F_WRLCK) Failed, errno=%d : %s",
-				 fname, TEST_ERRNO, strerror(TEST_ERRNO));
+			if (type == TST_OVERLAYFS_MAGIC && TEST_ERRNO == EAGAIN) {
+				tst_resm(TINFO | TTERRNO,
+					"fcntl(F_SETLEASE, F_WRLCK) "
+					"failed on overlapfs as expected");
+			} else {
+				tst_resm(TFAIL,
+					"fcntl(%s, F_SETLEASE, F_WRLCK) Failed, errno=%d : %s",
+					fname, TEST_ERRNO, strerror(TEST_ERRNO));
+			}
 		} else {
 			TEST(fcntl(fd, F_GETLEASE));
 			if (TEST_RETURN != F_WRLCK)
diff --git a/testcases/kernel/syscalls/fcntl/fcntl33.c b/testcases/kernel/syscalls/fcntl/fcntl33.c
index ca7a796bf..9dd8b0721 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl33.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl33.c
@@ -115,7 +115,13 @@ static void do_test(unsigned int i)
 
 	TEST(fcntl(fd, F_SETLEASE, test_cases[i].lease_type));
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "fcntl() failed to set lease");
+		if (type == TST_OVERLAYFS_MAGIC && TST_ERR == EAGAIN) {
+			tst_res(TINFO | TTERRNO,
+				"fcntl(F_SETLEASE, F_WRLCK) "
+				"failed on overlapfs as expected");
+		} else {
+			tst_res(TFAIL | TTERRNO, "fcntl() failed to set lease");
+		}
 		goto exit;
 	}
 
-- 
2.14.5

