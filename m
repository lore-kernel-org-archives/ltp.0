From: Nicolas Joly <njoly@pasteur.fr>
Date: Sun, 24 Jul 2016 11:48:09 +0200
Subject: [LTP] [PATCH] Fix a small typo in comments
Message-ID: <20160724094809.GA4303@issan.sis.pasteur.fr>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

Please find a tiny patch that fix a typo "discriptor" instead of
"descriptor" found in comments.

Thanks.

-- 
Nicolas Joly

Cluster & Computing Group
Biology IT Center
Institut Pasteur, Paris.
-------------- next part --------------
commit cf102e6b4e2bdb5dfe10dba2c885838c5a05b0b6
Author: Nicolas Joly <njoly@pasteur.fr>
Date:   Sun Jul 24 11:44:50 2016 +0200

    Fix a small typo in comments.
    
    Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify01.c b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
index 5c7846c..1f1d4f6 100644
--- a/testcases/kernel/syscalls/mq_notify/mq_notify01.c
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
@@ -177,7 +177,7 @@ static int do_test(struct test_case *tc)
 	abs_timeout.tv_nsec = 0;
 
 	/*
-	 * When test ended with SIGTERM etc, mq discriptor is left remains.
+	 * When test ended with SIGTERM etc, mq descriptor is left remains.
 	 * So we delete it first.
 	 */
 	mq_unlink(QUEUE_NAME);
diff --git a/testcases/kernel/syscalls/mq_open/mq_open01.c b/testcases/kernel/syscalls/mq_open/mq_open01.c
index f53b4bc..1ab8185 100644
--- a/testcases/kernel/syscalls/mq_open/mq_open01.c
+++ b/testcases/kernel/syscalls/mq_open/mq_open01.c
@@ -270,7 +270,7 @@ static int do_test(struct test_case *tc)
 	struct mq_attr new, old, *p_attr;
 
 	/*
-	 * When test ended with SIGTERM etc, mq discriptor is left remains.
+	 * When test ended with SIGTERM etc, mq descriptor is left remains.
 	 * So we delete it first.
 	 */
 	TEST(mq_unlink(QUEUE_NAME));
diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index b524e45..d3d4977 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -304,7 +304,7 @@ static int do_test(struct test_case *tc)
 	size_t msg_len;
 
 	/*
-	 * When test ended with SIGTERM etc, mq discriptor is left remains.
+	 * When test ended with SIGTERM etc, mq descriptor is left remains.
 	 * So we delete it first.
 	 */
 	TEST(mq_unlink(QUEUE_NAME));
diff --git a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
index 53190d7..77198ce 100644
--- a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
+++ b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
@@ -307,7 +307,7 @@ static int do_test(struct test_case *tc)
 	unsigned prio;
 
 	/*
-	 * When test ended with SIGTERM etc, mq discriptor is left remains.
+	 * When test ended with SIGTERM etc, mq descriptor is left remains.
 	 * So we delete it first.
 	 */
 	TEST(mq_unlink(QUEUE_NAME));
diff --git a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
index 9ac0868..6306efc 100644
--- a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
+++ b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
@@ -208,7 +208,7 @@ static int do_test(struct test_case *tc)
 	uid_t old_uid = -1;
 
 	/*
-	 * When test ended with SIGTERM etc, mq discriptor is left remains.
+	 * When test ended with SIGTERM etc, mq descriptor is left remains.
 	 * So we delete it first.
 	 */
 	TEST(mq_unlink(QUEUE_NAME));
diff --git a/testcases/kernel/syscalls/writev/writev01.c b/testcases/kernel/syscalls/writev/writev01.c
index bfa5bba..8e4f756 100644
--- a/testcases/kernel/syscalls/writev/writev01.c
+++ b/testcases/kernel/syscalls/writev/writev01.c
@@ -226,7 +226,7 @@ int main(int argc, char **argv)
 
 		tst_resm(TINFO, "Exit block 3");
 
-//block4: /* given bad file discriptor, writev return EBADF. */
+//block4: /* given bad file descriptor, writev return EBADF. */
 		tst_resm(TPASS, "Enter block 4");
 
 		TEST(writev(fd[1], (wr_iovec + 9), 1));
diff --git a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
index 4163988..ebb10c9 100644
--- a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
+++ b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
@@ -477,7 +477,7 @@ static int rm_file_dir(int numsdir,	/* how many subdirs to remove         */
 static void *crte_mk_rm(void *args)
 {
 	int dircnt;		/* index to the number of subdirectories      */
-	int fd;			/* file discriptor of the files genetated     */
+	int fd;			/* file descriptor of the files genetated     */
 	int filecnt;		/* index to the number of ".c" files created  */
 	int numchar[2];		/* number of characters written to buffer     */
 	char *dirname;		/* name of the directory/idirectory tree      */
