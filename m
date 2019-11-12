From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 12 Nov 2019 18:20:38 +0800
Subject: [LTP] [PATCH] testcases/kernel: use linux git and CVE tags for more
 cases
Message-ID: <1573554038-26993-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../kernel/mem/hugetlb/hugemmap/hugemmap06.c      | 15 +++++++++++----
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat05.c    | 15 +++++++++++----
 testcases/kernel/pty/pty02.c                      |  4 ++++
 testcases/kernel/sched/autogroup/autogroup01.c    |  4 ++++
 testcases/kernel/security/dirtyc0w/dirtyc0w.c     |  5 +++++
 testcases/kernel/syscalls/add_key/add_key03.c     |  4 ++++
 testcases/kernel/syscalls/add_key/add_key04.c     |  5 +++++
 testcases/kernel/syscalls/execveat/execveat03.c   |  5 +++++
 testcases/kernel/syscalls/fanotify/fanotify06.c   |  5 +++++
 testcases/kernel/syscalls/fanotify/fanotify09.c   |  7 ++++++-
 testcases/kernel/syscalls/fanotify/fanotify10.c   |  6 +++++-
 testcases/kernel/syscalls/fanotify/fanotify13.c   |  6 +++++-
 testcases/kernel/syscalls/fcntl/fcntl35.c         |  6 +++++-
 testcases/kernel/syscalls/getxattr/getxattr04.c   |  6 +++++-
 testcases/kernel/syscalls/ipc/shmat/shmat03.c     |  9 ++++++++-
 testcases/kernel/syscalls/ipc/shmctl/shmctl05.c   |  4 ++++
 testcases/kernel/syscalls/keyctl/keyctl03.c       |  4 ++++
 testcases/kernel/syscalls/keyctl/keyctl06.c       |  5 +++++
 testcases/kernel/syscalls/keyctl/keyctl07.c       |  5 +++++
 testcases/kernel/syscalls/keyctl/keyctl08.c       |  5 +++++
 testcases/kernel/syscalls/madvise/madvise05.c     |  4 ++++
 testcases/kernel/syscalls/madvise/madvise06.c     |  4 ++++
 testcases/kernel/syscalls/mbind/mbind02.c         |  4 ++++
 .../syscalls/migrate_pages/migrate_pages03.c      |  4 ++++
 testcases/kernel/syscalls/ptrace/ptrace07.c       |  6 ++++++
 testcases/kernel/syscalls/readahead/readahead02.c |  5 +++++
 testcases/kernel/syscalls/recvmsg/recvmsg02.c     |  4 ++++
 testcases/kernel/syscalls/recvmsg/recvmsg03.c     |  6 +++++-
 .../kernel/syscalls/request_key/request_key03.c   |  7 +++++++
 .../kernel/syscalls/request_key/request_key04.c   |  5 +++++
 .../kernel/syscalls/timer_create/timer_create01.c |  4 ++++
 .../kernel/syscalls/timer_create/timer_create03.c |  5 +++++
 32 files changed, 168 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
index a230bb798..d66183479 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
@@ -22,10 +22,10 @@
  *   the region structure, so it can be modified by two processes concurrently.
  *
  *   This bug was fixed on stable kernel by commits:
- *       f522c3ac00(mm, hugetlb: change variable name reservations to resv)
- *       9119a41e90(mm, hugetlb: unify region structure handling)
- *       7b24d8616b(mm, hugetlb: fix race in region tracking)
- *       1406ec9ba6(mm, hugetlb: improve, cleanup resv_map parameters)
+ *       f522c3ac00a4(mm, hugetlb: change variable name reservations to resv)
+ *       9119a41e9091(mm, hugetlb: unify region structure handling)
+ *       7b24d8616be3(mm, hugetlb: fix race in region tracking)
+ *       1406ec9ba6c6(mm, hugetlb: improve, cleanup resv_map parameters)
  *
  * AUTHOR:
  *    Herton R. Krzesinski <herton@redhat.com>
@@ -147,4 +147,11 @@ static struct tst_test test = {
 	.test = do_mmap,
 	.setup = setup,
 	.cleanup = cleanup,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "f522c3ac00a4"},
+		{"linux-git", "9119a41e9091"},
+		{"linux-git", "7b24d8616be3"},
+		{"linux-git", "1406ec9ba6c6"},
+		{}
+	}
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
index a58739163..587110ad3 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
@@ -24,11 +24,11 @@
  *	This bug is present in all RHEL6 versions, but not in RHEL7. It looks
  *	like this was fixed in mainline kernel > v3.3 by the following patches:
  *
- *	091d0d5 (shm: fix null pointer deref when userspace specifies
+ *	091d0d55b286 (shm: fix null pointer deref when userspace specifies
  *		 invalid hugepage size)
- *	af73e4d (hugetlbfs: fix mmap failure in unaligned size request)
- *	42d7395 (mm: support more pagesizes for MAP_HUGETLB/SHM_HUGETLB)
- *	40716e2 (hugetlbfs: fix alignment of huge page requests)
+ *	af73e4d9506d (hugetlbfs: fix mmap failure in unaligned size request)
+ *	42d7395feb56 (mm: support more pagesizes for MAP_HUGETLB/SHM_HUGETLB)
+ *	40716e29243d (hugetlbfs: fix alignment of huge page requests)
  *
  * AUTHORS
  *	Vladislav Dronov <vdronov@redhat.com>
@@ -109,4 +109,11 @@ static struct tst_test test = {
 	.test_all = test_hugeshmat,
 	.setup = setup,
 	.cleanup = cleanup,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "091d0d55b286"},
+		{"linux-git", "af73e4d9506d"},
+		{"linux-git", "42d7395feb56"},
+		{"linux-git", "40716e29243d"},
+		{}
+	}
 };
diff --git a/testcases/kernel/pty/pty02.c b/testcases/kernel/pty/pty02.c
index e2cafb3cd..fc60b6256 100644
--- a/testcases/kernel/pty/pty02.c
+++ b/testcases/kernel/pty/pty02.c
@@ -59,4 +59,8 @@ static void do_test(void)
 
 static struct tst_test test = {
 	.test_all = do_test,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "966031f34018"},
+		{}
+	}
 };
diff --git a/testcases/kernel/sched/autogroup/autogroup01.c b/testcases/kernel/sched/autogroup/autogroup01.c
index 2360ec3b4..f14f28fc2 100644
--- a/testcases/kernel/sched/autogroup/autogroup01.c
+++ b/testcases/kernel/sched/autogroup/autogroup01.c
@@ -80,4 +80,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = do_test,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "18f649ef3441"},
+		{}
+	}
 };
diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w.c b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
index 3a3aae1c3..e7857037d 100644
--- a/testcases/kernel/security/dirtyc0w/dirtyc0w.c
+++ b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
@@ -98,4 +98,9 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.setup = setup,
 	.test_all = dirtyc0w_test,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "4ceb5db9757a"},
+		{"linux-git", "9be0eaffa3ac"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/add_key/add_key03.c b/testcases/kernel/syscalls/add_key/add_key03.c
index 962f1b925..d26912cb7 100644
--- a/testcases/kernel/syscalls/add_key/add_key03.c
+++ b/testcases/kernel/syscalls/add_key/add_key03.c
@@ -83,4 +83,8 @@ static void do_test(void)
 static struct tst_test test = {
 	.test_all = do_test,
 	.needs_root = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "237bbd29f7a0"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/add_key/add_key04.c b/testcases/kernel/syscalls/add_key/add_key04.c
index 12a169eda..aa02fdd1d 100644
--- a/testcases/kernel/syscalls/add_key/add_key04.c
+++ b/testcases/kernel/syscalls/add_key/add_key04.c
@@ -84,4 +84,9 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = do_test,
 	.forks_child = 1,
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2017-12193"},
+		{"linux-git", "ea6789980fda"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/execveat/execveat03.c b/testcases/kernel/syscalls/execveat/execveat03.c
index 921c9c374..b0d9033e3 100644
--- a/testcases/kernel/syscalls/execveat/execveat03.c
+++ b/testcases/kernel/syscalls/execveat/execveat03.c
@@ -84,4 +84,9 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = verify_execveat,
 	.resource_files = resource_files,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "8db6c34f1dbc"},
+		{"linux-git", "355139a8dba4"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index 273c1f0c4..4e6977954 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -256,6 +256,11 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = mntpoint,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "8edc6e1688fc"},
+		{"linux-git", "d989903058a8"},
+		{}
+	}
 };
 
 #else
diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 0f926c49b..0f6a9e864 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -264,7 +264,12 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
-	.needs_root = 1
+	.needs_root = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "54a307ba8d3c"},
+		{"linux-git", "b469e7e47c8a"},
+		{}
+	}
 };
 
 #else
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 43465b8f5..1d1712e98 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -443,7 +443,11 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.forks_child = 1,
-	.resource_files = resource_files
+	.resource_files = resource_files,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "9bdda4e9cf2d"},
+		{}
+	}
 };
 
 #else
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 030734285..69935fcd1 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -324,7 +324,11 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
-	.all_filesystems = 1
+	.all_filesystems = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "c285a2f01d69"},
+		{}
+	}
 };
 
 #else
diff --git a/testcases/kernel/syscalls/fcntl/fcntl35.c b/testcases/kernel/syscalls/fcntl/fcntl35.c
index 468c9559f..c5a071def 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl35.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl35.c
@@ -120,5 +120,9 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
-	.test = do_test
+	.test = do_test,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "086e774a57fb"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/getxattr/getxattr04.c b/testcases/kernel/syscalls/getxattr/getxattr04.c
index ad83e3ec6..0ac83775a 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr04.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr04.c
@@ -113,7 +113,11 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.forks_child = 1,
 	.test_all = verify_getxattr,
-	.setup = setup
+	.setup = setup,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "5a93790d4e2d"},
+		{}
+	}
 };
 
 #else /* HAVE_SYS_XATTR_H */
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat03.c b/testcases/kernel/syscalls/ipc/shmat/shmat03.c
index 18d3db028..9f303353b 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat03.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat03.c
@@ -18,7 +18,7 @@
  *
  * The timeline went as:
  *
- * 95e91b831f (ipc/shm: Fix shmat mmap nil-page protection)
+ * 95e91b831f87 (ipc/shm: Fix shmat mmap nil-page protection)
  * a73ab244f0da (Revert "ipc/shm: Fix shmat mmap nil-page protect...)
  * 8f89c007b6de (ipc/shm: fix shmat() nil address after round-dow...)
  *
@@ -100,4 +100,11 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run,
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2017-5669"},
+		{"linux-git", "95e91b831f87"},
+		{"linux-git", "a73ab244f0da"},
+		{"linux-git", "8f89c007b6de"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
index b24fd1d11..50196ae99 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -96,4 +96,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = do_test,
 	.cleanup = cleanup,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "3f05317d9889"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/keyctl/keyctl03.c b/testcases/kernel/syscalls/keyctl/keyctl03.c
index fd8b30b62..9d7b9a0b5 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl03.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl03.c
@@ -41,4 +41,8 @@ static void do_test(void)
 
 static struct tst_test test = {
 	.test_all = do_test,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "f05819df10d7"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/keyctl/keyctl06.c b/testcases/kernel/syscalls/keyctl/keyctl06.c
index 065d482f3..f76a85ff2 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl06.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl06.c
@@ -62,4 +62,9 @@ static void do_test(void)
 
 static struct tst_test test = {
 	.test_all = do_test,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "e645016abc80"},
+		{"linux-git", "3239b6f29bdf"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/keyctl/keyctl07.c b/testcases/kernel/syscalls/keyctl/keyctl07.c
index 69199af69..875ef0bb8 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl07.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl07.c
@@ -103,4 +103,9 @@ static void do_test(void)
 static struct tst_test test = {
 	.test_all = do_test,
 	.forks_child = 1,
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2017-12912"},
+		{"linux-git", "37863c43b2c6"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/keyctl/keyctl08.c b/testcases/kernel/syscalls/keyctl/keyctl08.c
index 2ed9c901c..bc01192e7 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl08.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl08.c
@@ -29,4 +29,9 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.min_kver = "2.6.13",
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2016-9604"},
+		{"linux-git", "ee8f844e3c5a"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/madvise/madvise05.c b/testcases/kernel/syscalls/madvise/madvise05.c
index 0aa652052..3ab4a8749 100644
--- a/testcases/kernel/syscalls/madvise/madvise05.c
+++ b/testcases/kernel/syscalls/madvise/madvise05.c
@@ -48,4 +48,8 @@ static void verify_madvise(void)
 static struct tst_test test = {
 	.min_kver = "3.9.0",
 	.test_all = verify_madvise,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "ee53664bda16"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index 9a4b0829b..37840d005 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -173,4 +173,8 @@ static struct tst_test test = {
 	.min_kver = "3.10.0",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "55231e5c898c"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/mbind/mbind02.c b/testcases/kernel/syscalls/mbind/mbind02.c
index 0843b4b4a..01b3b3c69 100644
--- a/testcases/kernel/syscalls/mbind/mbind02.c
+++ b/testcases/kernel/syscalls/mbind/mbind02.c
@@ -105,6 +105,10 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = verify_mbind,
 	.tcnt = ARRAY_SIZE(modes),
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "a7f40cfe3b7a"},
+		{}
+	}
 };
 
 #else
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
index f5d793f8b..c6afb4cce 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
@@ -139,6 +139,10 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = migrate_test,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "4b0ece6fa016"},
+		{}
+	}
 };
 
 #else
diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c b/testcases/kernel/syscalls/ptrace/ptrace07.c
index ab8983554..9e3f7511d 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace07.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
@@ -178,6 +178,12 @@ static struct tst_test test = {
 	.test_all = do_test,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "814fb7bb7db5"},
+		{"CVE", "2017-15537"},
+		{}
+	}
+
 };
 
 #else /* !__x86_64__ */
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index ac4dfd876..56739be28 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -409,4 +409,9 @@ static struct tst_test test = {
 	.options = options,
 	.test = test_readahead,
 	.tcnt = ARRAY_SIZE(tcases),
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "b833a3660394"},
+		{"linux-git", "5b910bd615ba"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg02.c b/testcases/kernel/syscalls/recvmsg/recvmsg02.c
index a94f45bfe..b15b37867 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg02.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg02.c
@@ -97,4 +97,8 @@ static struct tst_test test = {
 	.min_kver = "2.6.27",
 	.test_all = verify_recvmsg,
 	.cleanup = cleanup,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "197c949e7798"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg03.c b/testcases/kernel/syscalls/recvmsg/recvmsg03.c
index b641b95d8..e23a7c3a9 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg03.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg03.c
@@ -148,5 +148,9 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.setup = setup,
-	.test_all = verify_recvmsg
+	.test_all = verify_recvmsg,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "06b6a1cf6e77"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/request_key/request_key03.c b/testcases/kernel/syscalls/request_key/request_key03.c
index 6f4a5630f..b508ddc38 100644
--- a/testcases/kernel/syscalls/request_key/request_key03.c
+++ b/testcases/kernel/syscalls/request_key/request_key03.c
@@ -188,4 +188,11 @@ static struct tst_test test = {
 	.test_all = do_test,
 	.forks_child = 1,
 	.options = options,
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2017-15299"},
+		{"linux-git", "60ff5b2f547a"},
+		{"CVE", "2017-15951"},
+		{"linux-git", "363b02dab09b"},
+		{},
+	}
 };
diff --git a/testcases/kernel/syscalls/request_key/request_key04.c b/testcases/kernel/syscalls/request_key/request_key04.c
index 6609517eb..da036bf3a 100644
--- a/testcases/kernel/syscalls/request_key/request_key04.c
+++ b/testcases/kernel/syscalls/request_key/request_key04.c
@@ -72,4 +72,9 @@ static void do_test(void)
 
 static struct tst_test test = {
 	.test_all = do_test,
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2017-17807"},
+		{"linux-git", "4dca6ea1d943"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/timer_create/timer_create01.c b/testcases/kernel/syscalls/timer_create/timer_create01.c
index 1d0e400d3..b03d184dd 100644
--- a/testcases/kernel/syscalls/timer_create/timer_create01.c
+++ b/testcases/kernel/syscalls/timer_create/timer_create01.c
@@ -108,4 +108,8 @@ static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(types),
 	.needs_root = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "f18ddc13af98"},
+		{}
+	}
 };
diff --git a/testcases/kernel/syscalls/timer_create/timer_create03.c b/testcases/kernel/syscalls/timer_create/timer_create03.c
index 38d6e98fe..dd797c3fc 100644
--- a/testcases/kernel/syscalls/timer_create/timer_create03.c
+++ b/testcases/kernel/syscalls/timer_create/timer_create03.c
@@ -64,4 +64,9 @@ static void run(void)
 
 static struct tst_test test = {
 	.test_all = run,
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2017-18344"},
+		{"linux-git", "cef31d9af908"},
+		{}
+	}
 };
-- 
2.18.0



