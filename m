Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WpaDl-0002Ls-Hp
	for ltp-list@lists.sourceforge.net; Wed, 28 May 2014 09:32:29 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WpaDX-0002N9-Ca
	for ltp-list@lists.sourceforge.net; Wed, 28 May 2014 09:32:29 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s4S9W4bW023601
	for <ltp-list@lists.sourceforge.net>; Wed, 28 May 2014 17:32:04 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 28 May 2014 17:29:36 +0800
Message-ID: <1401269376-6404-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] kernel/syscalls: fix wrong fork_flag passed to
	tst_sig()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Many test cases pass FORK flag to tst_sig() though they do not do
fork() at all, fix these.
---
 testcases/kernel/syscalls/access/access01.c                     | 2 +-
 testcases/kernel/syscalls/access/access02.c                     | 2 +-
 testcases/kernel/syscalls/asyncio/asyncio02.c                   | 2 +-
 testcases/kernel/syscalls/chmod/chmod06.c                       | 2 +-
 testcases/kernel/syscalls/chmod/chmod07.c                       | 2 +-
 testcases/kernel/syscalls/chown/chown03.c                       | 2 +-
 testcases/kernel/syscalls/chown/chown04.c                       | 2 +-
 testcases/kernel/syscalls/close/close01.c                       | 2 +-
 testcases/kernel/syscalls/close/close02.c                       | 2 +-
 testcases/kernel/syscalls/dup/dup01.c                           | 2 +-
 testcases/kernel/syscalls/dup/dup02.c                           | 2 +-
 testcases/kernel/syscalls/dup/dup03.c                           | 2 +-
 testcases/kernel/syscalls/dup/dup04.c                           | 2 +-
 testcases/kernel/syscalls/dup/dup05.c                           | 2 +-
 testcases/kernel/syscalls/dup2/dup204.c                         | 2 +-
 testcases/kernel/syscalls/fchmod/fchmod02.c                     | 2 +-
 testcases/kernel/syscalls/fchmod/fchmod05.c                     | 2 +-
 testcases/kernel/syscalls/fchmod/fchmod06.c                     | 2 +-
 testcases/kernel/syscalls/fchown/fchown01.c                     | 2 +-
 testcases/kernel/syscalls/fchown/fchown03.c                     | 2 +-
 testcases/kernel/syscalls/fcntl/fcntl01.c                       | 2 +-
 testcases/kernel/syscalls/fcntl/fcntl06.c                       | 2 +-
 testcases/kernel/syscalls/flock/flock02.c                       | 2 +-
 testcases/kernel/syscalls/fpathconf/fpathconf01.c               | 2 +-
 testcases/kernel/syscalls/getgroups/getgroups01.c               | 2 +-
 testcases/kernel/syscalls/gethostid/gethostid01.c               | 2 +-
 testcases/kernel/syscalls/lchown/lchown02.c                     | 2 +-
 testcases/kernel/syscalls/lstat/lstat01.c                       | 2 +-
 testcases/kernel/syscalls/mkdir/mkdir05.c                       | 2 +-
 testcases/kernel/syscalls/mlock/mlock03.c                       | 2 +-
 testcases/kernel/syscalls/mlockall/mlockall02.c                 | 2 +-
 testcases/kernel/syscalls/mlockall/mlockall03.c                 | 2 +-
 testcases/kernel/syscalls/mmap/mmap001.c                        | 2 +-
 testcases/kernel/syscalls/mmap/mmap01.c                         | 2 +-
 testcases/kernel/syscalls/mmap/mmap02.c                         | 2 +-
 testcases/kernel/syscalls/mmap/mmap11.c                         | 2 +-
 testcases/kernel/syscalls/mmap/mmap12.c                         | 2 +-
 testcases/kernel/syscalls/mmap/mmap14.c                         | 2 +-
 testcases/kernel/syscalls/modify_ldt/modify_ldt01.c             | 2 +-
 testcases/kernel/syscalls/mount/mount02.c                       | 2 +-
 testcases/kernel/syscalls/mount/mount04.c                       | 2 +-
 testcases/kernel/syscalls/mprotect/mprotect01.c                 | 2 +-
 testcases/kernel/syscalls/mremap/mremap02.c                     | 2 +-
 testcases/kernel/syscalls/mremap/mremap03.c                     | 2 +-
 testcases/kernel/syscalls/mremap/mremap04.c                     | 2 +-
 testcases/kernel/syscalls/munlock/munlock02.c                   | 2 +-
 testcases/kernel/syscalls/pipe/pipe07.c                         | 2 +-
 testcases/kernel/syscalls/ppoll/ppoll01.c                       | 2 +-
 testcases/kernel/syscalls/pread/pread01.c                       | 2 +-
 testcases/kernel/syscalls/pread/pread02.c                       | 2 +-
 testcases/kernel/syscalls/pread/pread03.c                       | 2 +-
 testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c | 2 +-
 testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c | 2 +-
 testcases/kernel/syscalls/rmdir/rmdir05.c                       | 2 +-
 testcases/kernel/syscalls/select/select01.c                     | 2 +-
 testcases/kernel/syscalls/select/select02.c                     | 2 +-
 testcases/kernel/syscalls/select/select03.c                     | 2 +-
 testcases/kernel/syscalls/setregid/setregid02.c                 | 2 +-
 testcases/kernel/syscalls/setregid/setregid04.c                 | 2 +-
 testcases/kernel/syscalls/setreuid/setreuid02.c                 | 2 +-
 testcases/kernel/syscalls/setreuid/setreuid03.c                 | 2 +-
 testcases/kernel/syscalls/setreuid/setreuid06.c                 | 2 +-
 testcases/kernel/syscalls/setrlimit/setrlimit03.c               | 2 +-
 testcases/kernel/syscalls/setuid/setuid03.c                     | 2 +-
 testcases/kernel/syscalls/sigaltstack/sigaltstack01.c           | 2 +-
 testcases/kernel/syscalls/sigaltstack/sigaltstack02.c           | 2 +-
 testcases/kernel/syscalls/sigprocmask/sigprocmask01.c           | 2 +-
 testcases/kernel/syscalls/sigsuspend/sigsuspend01.c             | 2 +-
 testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c           | 2 +-
 testcases/kernel/syscalls/swapoff/swapoff01.c                   | 2 +-
 testcases/kernel/syscalls/swapoff/swapoff02.c                   | 2 +-
 testcases/kernel/syscalls/swapon/swapon01.c                     | 2 +-
 testcases/kernel/syscalls/swapon/swapon02.c                     | 2 +-
 testcases/kernel/syscalls/switch/endian_switch01.c              | 2 +-
 testcases/kernel/syscalls/symlink/symlink01.c                   | 2 +-
 testcases/kernel/syscalls/sysinfo/sysinfo01.c                   | 2 +-
 testcases/kernel/syscalls/sysinfo/sysinfo02.c                   | 2 +-
 testcases/kernel/syscalls/umount/umount02.c                     | 2 +-
 testcases/kernel/syscalls/uname/uname02.c                       | 2 +-
 testcases/kernel/syscalls/uname/uname03.c                       | 2 +-
 testcases/kernel/syscalls/utime/utime01.c                       | 2 +-
 testcases/kernel/syscalls/utime/utime05.c                       | 2 +-
 testcases/kernel/syscalls/wait4/wait402.c                       | 2 +-
 testcases/kernel/syscalls/write/write01.c                       | 2 +-
 testcases/kernel/syscalls/writev/writev01.c                     | 2 +-
 testcases/kernel/syscalls/writev/writev02.c                     | 2 +-
 testcases/kernel/syscalls/writev/writev04.c                     | 2 +-
 87 files changed, 87 insertions(+), 87 deletions(-)

diff --git a/testcases/kernel/syscalls/access/access01.c b/testcases/kernel/syscalls/access/access01.c
index a59774b..9a057ee 100644
--- a/testcases/kernel/syscalls/access/access01.c
+++ b/testcases/kernel/syscalls/access/access01.c
@@ -113,7 +113,7 @@ static void setup(void)
 	int fd;
 	struct stat stbuf;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	umask(0);
 	TEST_PAUSE;
diff --git a/testcases/kernel/syscalls/access/access02.c b/testcases/kernel/syscalls/access/access02.c
index b784ca4..fc78b3b 100644
--- a/testcases/kernel/syscalls/access/access02.c
+++ b/testcases/kernel/syscalls/access/access02.c
@@ -125,7 +125,7 @@ static void setup(void)
 	int i;
 
 	tst_require_root(NULL);
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	ltpuser = getpwnam(nobody_uid);
 	if (ltpuser == NULL)
diff --git a/testcases/kernel/syscalls/asyncio/asyncio02.c b/testcases/kernel/syscalls/asyncio/asyncio02.c
index adbd27b..8f45a18 100644
--- a/testcases/kernel/syscalls/asyncio/asyncio02.c
+++ b/testcases/kernel/syscalls/asyncio/asyncio02.c
@@ -280,7 +280,7 @@ int testrun(int flag, int bytes, int ti)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/chmod/chmod06.c b/testcases/kernel/syscalls/chmod/chmod06.c
index a17a242..3deaa6a 100644
--- a/testcases/kernel/syscalls/chmod/chmod06.c
+++ b/testcases/kernel/syscalls/chmod/chmod06.c
@@ -258,7 +258,7 @@ void setup(void)
 {
 	int i;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	test_home = get_current_dir_name();
 
diff --git a/testcases/kernel/syscalls/chmod/chmod07.c b/testcases/kernel/syscalls/chmod/chmod07.c
index 240247a..47bb1bc 100644
--- a/testcases/kernel/syscalls/chmod/chmod07.c
+++ b/testcases/kernel/syscalls/chmod/chmod07.c
@@ -170,7 +170,7 @@ void setup(void)
 	gid_t group1_gid;	/* user and process group id's */
 	uid_t user1_uid;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/chown/chown03.c b/testcases/kernel/syscalls/chown/chown03.c
index 533f349..96d2b28 100644
--- a/testcases/kernel/syscalls/chown/chown03.c
+++ b/testcases/kernel/syscalls/chown/chown03.c
@@ -168,7 +168,7 @@ void setup(void)
 
 	tst_require_root(NULL);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/chown/chown04.c b/testcases/kernel/syscalls/chown/chown04.c
index 4b5a6cc..f366862 100644
--- a/testcases/kernel/syscalls/chown/chown04.c
+++ b/testcases/kernel/syscalls/chown/chown04.c
@@ -216,7 +216,7 @@ void setup(void)
 
 	tst_mkfs(NULL, device, fstype, NULL);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	ltpuser = getpwnam("nobody");
 	if (ltpuser == NULL)
diff --git a/testcases/kernel/syscalls/close/close01.c b/testcases/kernel/syscalls/close/close01.c
index 977b62a..caa2156 100644
--- a/testcases/kernel/syscalls/close/close01.c
+++ b/testcases/kernel/syscalls/close/close01.c
@@ -145,7 +145,7 @@ void setup(void)
 {
 	int mypid;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	umask(0);
 
diff --git a/testcases/kernel/syscalls/close/close02.c b/testcases/kernel/syscalls/close/close02.c
index dbf71a5..da039cc 100644
--- a/testcases/kernel/syscalls/close/close02.c
+++ b/testcases/kernel/syscalls/close/close02.c
@@ -115,7 +115,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	umask(0);
 
diff --git a/testcases/kernel/syscalls/dup/dup01.c b/testcases/kernel/syscalls/dup/dup01.c
index 6b1177f..7ca10fa 100644
--- a/testcases/kernel/syscalls/dup/dup01.c
+++ b/testcases/kernel/syscalls/dup/dup01.c
@@ -181,7 +181,7 @@ void setup(void)
 {
 	fd = -1;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/dup/dup02.c b/testcases/kernel/syscalls/dup/dup02.c
index 9743da9..364f80e 100644
--- a/testcases/kernel/syscalls/dup/dup02.c
+++ b/testcases/kernel/syscalls/dup/dup02.c
@@ -176,7 +176,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/dup/dup03.c b/testcases/kernel/syscalls/dup/dup03.c
index 8589f00..1d9c7df 100644
--- a/testcases/kernel/syscalls/dup/dup03.c
+++ b/testcases/kernel/syscalls/dup/dup03.c
@@ -186,7 +186,7 @@ void setup(void)
 		tst_brkm(TBROK | TERRNO, NULL, "malloc failed");
 	fd[0] = -1;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/dup/dup04.c b/testcases/kernel/syscalls/dup/dup04.c
index 2652915..9554e34 100644
--- a/testcases/kernel/syscalls/dup/dup04.c
+++ b/testcases/kernel/syscalls/dup/dup04.c
@@ -195,7 +195,7 @@ void setup(void)
 {
 	fd[0] = -1;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/dup/dup05.c b/testcases/kernel/syscalls/dup/dup05.c
index cf15a22..7c57919 100644
--- a/testcases/kernel/syscalls/dup/dup05.c
+++ b/testcases/kernel/syscalls/dup/dup05.c
@@ -171,7 +171,7 @@ void setup(void)
 {
 	fd = -1;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/dup2/dup204.c b/testcases/kernel/syscalls/dup2/dup204.c
index 2770ad6..96b134f 100644
--- a/testcases/kernel/syscalls/dup2/dup204.c
+++ b/testcases/kernel/syscalls/dup2/dup204.c
@@ -117,7 +117,7 @@ void setup(void)
 {
 	fd[0] = -1;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/fchmod/fchmod02.c b/testcases/kernel/syscalls/fchmod/fchmod02.c
index 5558d91..7c8a314 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod02.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod02.c
@@ -176,7 +176,7 @@ void setup(void)
 	gid_t group1_gid;	/* user and process group id's */
 	uid_t user1_uid;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/fchmod/fchmod05.c b/testcases/kernel/syscalls/fchmod/fchmod05.c
index 04caa26..c44ff53 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod05.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod05.c
@@ -179,7 +179,7 @@ void setup(void)
 	struct passwd *nobody_u;
 	struct group *bin_group;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* Check that the test process id is not super/root  */
 	if (geteuid() != 0) {
diff --git a/testcases/kernel/syscalls/fchmod/fchmod06.c b/testcases/kernel/syscalls/fchmod/fchmod06.c
index d9a1b80..6372ae8 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod06.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod06.c
@@ -136,7 +136,7 @@ static void setup(void)
 {
 	static struct passwd *ltpuser;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	tst_require_root(NULL);
 
diff --git a/testcases/kernel/syscalls/fchown/fchown01.c b/testcases/kernel/syscalls/fchown/fchown01.c
index 5c7fa50..21e8508 100644
--- a/testcases/kernel/syscalls/fchown/fchown01.c
+++ b/testcases/kernel/syscalls/fchown/fchown01.c
@@ -159,7 +159,7 @@ void setup(void)
 {
 	char fname[1024];
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/fchown/fchown03.c b/testcases/kernel/syscalls/fchown/fchown03.c
index d505f7f..69663ff 100644
--- a/testcases/kernel/syscalls/fchown/fchown03.c
+++ b/testcases/kernel/syscalls/fchown/fchown03.c
@@ -191,7 +191,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* Switch to nobody user for correct error code collection */
 	if (geteuid() != 0) {
diff --git a/testcases/kernel/syscalls/fcntl/fcntl01.c b/testcases/kernel/syscalls/fcntl/fcntl01.c
index a20ef8d..29ee77a 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl01.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl01.c
@@ -176,7 +176,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	umask(0);
 	TEST_PAUSE;
 	tst_tmpdir();
diff --git a/testcases/kernel/syscalls/fcntl/fcntl06.c b/testcases/kernel/syscalls/fcntl/fcntl06.c
index 91b8c1e..69edafa 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl06.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl06.c
@@ -122,7 +122,7 @@ void setup(void)
 	char *buf = STRING;
 	char template[PATH_MAX];
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	umask(0);
 
diff --git a/testcases/kernel/syscalls/flock/flock02.c b/testcases/kernel/syscalls/flock/flock02.c
index 4fb550c..e4b4c64 100644
--- a/testcases/kernel/syscalls/flock/flock02.c
+++ b/testcases/kernel/syscalls/flock/flock02.c
@@ -147,7 +147,7 @@ int main(int argc, char **argv)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_EXP_ENOS(exp_enos);
 
diff --git a/testcases/kernel/syscalls/fpathconf/fpathconf01.c b/testcases/kernel/syscalls/fpathconf/fpathconf01.c
index c6a77a7..b4c788e 100644
--- a/testcases/kernel/syscalls/fpathconf/fpathconf01.c
+++ b/testcases/kernel/syscalls/fpathconf/fpathconf01.c
@@ -114,7 +114,7 @@ int main(int ac, char **av)
 
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/getgroups/getgroups01.c b/testcases/kernel/syscalls/getgroups/getgroups01.c
index 1f9b0c7..ff7a262 100644
--- a/testcases/kernel/syscalls/getgroups/getgroups01.c
+++ b/testcases/kernel/syscalls/getgroups/getgroups01.c
@@ -182,7 +182,7 @@ int main(int ac, char **av)
 
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
diff --git a/testcases/kernel/syscalls/gethostid/gethostid01.c b/testcases/kernel/syscalls/gethostid/gethostid01.c
index 00fb22e..d9673cc 100644
--- a/testcases/kernel/syscalls/gethostid/gethostid01.c
+++ b/testcases/kernel/syscalls/gethostid/gethostid01.c
@@ -250,7 +250,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/lchown/lchown02.c b/testcases/kernel/syscalls/lchown/lchown02.c
index 30370fc..f669a9d 100644
--- a/testcases/kernel/syscalls/lchown/lchown02.c
+++ b/testcases/kernel/syscalls/lchown/lchown02.c
@@ -172,7 +172,7 @@ static void setup(void)
 {
 	int i;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	tst_require_root(NULL);
 
diff --git a/testcases/kernel/syscalls/lstat/lstat01.c b/testcases/kernel/syscalls/lstat/lstat01.c
index 8cdfd76..5dc80a1 100644
--- a/testcases/kernel/syscalls/lstat/lstat01.c
+++ b/testcases/kernel/syscalls/lstat/lstat01.c
@@ -197,7 +197,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/mkdir/mkdir05.c b/testcases/kernel/syscalls/mkdir/mkdir05.c
index 30dc92b..aab78b4 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir05.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir05.c
@@ -181,7 +181,7 @@ void setup(void)
 		perror("setuid");
 	}
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/mlock/mlock03.c b/testcases/kernel/syscalls/mlock/mlock03.c
index 227c83d..e675b33 100644
--- a/testcases/kernel/syscalls/mlock/mlock03.c
+++ b/testcases/kernel/syscalls/mlock/mlock03.c
@@ -113,7 +113,7 @@ void setup(void)
 {
 	tst_require_root(NULL);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 }
 
diff --git a/testcases/kernel/syscalls/mlockall/mlockall02.c b/testcases/kernel/syscalls/mlockall/mlockall02.c
index abae78a..f056b99 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall02.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall02.c
@@ -172,7 +172,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
diff --git a/testcases/kernel/syscalls/mlockall/mlockall03.c b/testcases/kernel/syscalls/mlockall/mlockall03.c
index 3f45ddc..0335db6 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall03.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall03.c
@@ -192,7 +192,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
diff --git a/testcases/kernel/syscalls/mmap/mmap001.c b/testcases/kernel/syscalls/mmap/mmap001.c
index cc857ed..c8dadf1 100644
--- a/testcases/kernel/syscalls/mmap/mmap001.c
+++ b/testcases/kernel/syscalls/mmap/mmap001.c
@@ -53,7 +53,7 @@ static void setup(void)
 	 * setup a default signal hander and a
 	 * temporary working directory.
 	 */
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
index 3d04059..8b3eb16 100644
--- a/testcases/kernel/syscalls/mmap/mmap01.c
+++ b/testcases/kernel/syscalls/mmap/mmap01.c
@@ -154,7 +154,7 @@ static void setup(void)
 	char Path_name[PATH_MAX];
 	char write_buf[] = "hello world\n";
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/mmap/mmap02.c b/testcases/kernel/syscalls/mmap/mmap02.c
index 78553be..888deb1 100644
--- a/testcases/kernel/syscalls/mmap/mmap02.c
+++ b/testcases/kernel/syscalls/mmap/mmap02.c
@@ -128,7 +128,7 @@ static void setup(void)
 {
 	char *tst_buff;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/mmap/mmap11.c b/testcases/kernel/syscalls/mmap/mmap11.c
index 03f7522..9e9bb16 100644
--- a/testcases/kernel/syscalls/mmap/mmap11.c
+++ b/testcases/kernel/syscalls/mmap/mmap11.c
@@ -84,7 +84,7 @@ void setup(void)
 {
 	tst_require_root(NULL);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 }
 
diff --git a/testcases/kernel/syscalls/mmap/mmap12.c b/testcases/kernel/syscalls/mmap/mmap12.c
index 871118f..bf55190 100644
--- a/testcases/kernel/syscalls/mmap/mmap12.c
+++ b/testcases/kernel/syscalls/mmap/mmap12.c
@@ -150,7 +150,7 @@ static int page_check(void)
 
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	if ((tst_kvercmp(2, 6, 25)) < 0)
 		tst_brkm(TCONF, NULL,
diff --git a/testcases/kernel/syscalls/mmap/mmap14.c b/testcases/kernel/syscalls/mmap/mmap14.c
index 77348ad..6c518a0 100644
--- a/testcases/kernel/syscalls/mmap/mmap14.c
+++ b/testcases/kernel/syscalls/mmap/mmap14.c
@@ -124,7 +124,7 @@ static void setup(void)
 {
 	tst_require_root(NULL);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
diff --git a/testcases/kernel/syscalls/modify_ldt/modify_ldt01.c b/testcases/kernel/syscalls/modify_ldt/modify_ldt01.c
index a0931d5..ed0b715 100644
--- a/testcases/kernel/syscalls/modify_ldt/modify_ldt01.c
+++ b/testcases/kernel/syscalls/modify_ldt/modify_ldt01.c
@@ -241,7 +241,7 @@ int create_segment(void *seg, size_t size)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
diff --git a/testcases/kernel/syscalls/mount/mount02.c b/testcases/kernel/syscalls/mount/mount02.c
index 2f20386..12434ce 100644
--- a/testcases/kernel/syscalls/mount/mount02.c
+++ b/testcases/kernel/syscalls/mount/mount02.c
@@ -313,7 +313,7 @@ static void cleanup_test(int i)
 
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	tst_require_root(NULL);
 	tst_mkfs(NULL, device, fstype, NULL);
diff --git a/testcases/kernel/syscalls/mount/mount04.c b/testcases/kernel/syscalls/mount/mount04.c
index 4804bad..0a688a1 100644
--- a/testcases/kernel/syscalls/mount/mount04.c
+++ b/testcases/kernel/syscalls/mount/mount04.c
@@ -130,7 +130,7 @@ static void setup(void)
 	char nobody_uid[] = "nobody";
 	struct passwd *ltpuser;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	tst_require_root(NULL);
 	tst_mkfs(NULL, device, fstype, NULL);
diff --git a/testcases/kernel/syscalls/mprotect/mprotect01.c b/testcases/kernel/syscalls/mprotect/mprotect01.c
index 018407d..2d6346a 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect01.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect01.c
@@ -163,7 +163,7 @@ static void setup3(struct test_case *self)
 
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
diff --git a/testcases/kernel/syscalls/mremap/mremap02.c b/testcases/kernel/syscalls/mremap/mremap02.c
index fa14a33..1ee137a 100644
--- a/testcases/kernel/syscalls/mremap/mremap02.c
+++ b/testcases/kernel/syscalls/mremap/mremap02.c
@@ -159,7 +159,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/mremap/mremap03.c b/testcases/kernel/syscalls/mremap/mremap03.c
index 3c911f2..da8a72e 100644
--- a/testcases/kernel/syscalls/mremap/mremap03.c
+++ b/testcases/kernel/syscalls/mremap/mremap03.c
@@ -162,7 +162,7 @@ void setup(void)
 {
 	int page_sz;		/* system page size */
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/mremap/mremap04.c b/testcases/kernel/syscalls/mremap/mremap04.c
index ef16a31..a3ae77d 100644
--- a/testcases/kernel/syscalls/mremap/mremap04.c
+++ b/testcases/kernel/syscalls/mremap/mremap04.c
@@ -179,7 +179,7 @@ void setup(void)
 {
 	key_t shmkey;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/munlock/munlock02.c b/testcases/kernel/syscalls/munlock/munlock02.c
index 2967b81..58b7dd2 100644
--- a/testcases/kernel/syscalls/munlock/munlock02.c
+++ b/testcases/kernel/syscalls/munlock/munlock02.c
@@ -158,7 +158,7 @@ void setup(void)
 
 	char *address;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
diff --git a/testcases/kernel/syscalls/pipe/pipe07.c b/testcases/kernel/syscalls/pipe/pipe07.c
index 351581e..f421d83 100644
--- a/testcases/kernel/syscalls/pipe/pipe07.c
+++ b/testcases/kernel/syscalls/pipe/pipe07.c
@@ -104,7 +104,7 @@ int main(int ac, char **av)
 static void setup(void)
 {
 	TEST_EXP_ENOS(exp_enos);
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 
 	record_open_fds();
diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
index 7713d65..7cf8ee7 100644
--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -99,7 +99,7 @@ void cleanup(void)
 
 void setup(void)
 {
-	tst_sig(FORK, sighandler, cleanup);
+	tst_sig(NOFORK, sighandler, cleanup);
 
 	TEST_PAUSE;
 	tst_tmpdir();
diff --git a/testcases/kernel/syscalls/pread/pread01.c b/testcases/kernel/syscalls/pread/pread01.c
index 770072e..9914f88 100644
--- a/testcases/kernel/syscalls/pread/pread01.c
+++ b/testcases/kernel/syscalls/pread/pread01.c
@@ -203,7 +203,7 @@ void setup(void)
 {
 	int nwrite = 0;		/* no. of bytes written by pwrite() */
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/pread/pread02.c b/testcases/kernel/syscalls/pread/pread02.c
index 0857933..d585216 100644
--- a/testcases/kernel/syscalls/pread/pread02.c
+++ b/testcases/kernel/syscalls/pread/pread02.c
@@ -188,7 +188,7 @@ void setup(void)
 {
 	int i;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/pread/pread03.c b/testcases/kernel/syscalls/pread/pread03.c
index 63ad4c5..f4f9ec6 100644
--- a/testcases/kernel/syscalls/pread/pread03.c
+++ b/testcases/kernel/syscalls/pread/pread03.c
@@ -159,7 +159,7 @@ void setup(void)
 {
 	char *cur_dir = NULL;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
index fe98a6b..ba53298 100644
--- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
+++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
@@ -222,7 +222,7 @@ again:
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
index 8288d6f..d68be42 100644
--- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
+++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
@@ -270,7 +270,7 @@ void setup(void)
 {
 	int i, j;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* set the expected erronos */
 	TEST_EXP_ENOS(exp_enos);
diff --git a/testcases/kernel/syscalls/rmdir/rmdir05.c b/testcases/kernel/syscalls/rmdir/rmdir05.c
index eaa98a1..1df5a8d 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir05.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir05.c
@@ -429,7 +429,7 @@ int main(int argc, char **argv)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/select/select01.c b/testcases/kernel/syscalls/select/select01.c
index c7bb029..cbd4002 100644
--- a/testcases/kernel/syscalls/select/select01.c
+++ b/testcases/kernel/syscalls/select/select01.c
@@ -214,7 +214,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/select/select02.c b/testcases/kernel/syscalls/select/select02.c
index 13a4e56..6b1f7ad 100644
--- a/testcases/kernel/syscalls/select/select02.c
+++ b/testcases/kernel/syscalls/select/select02.c
@@ -215,7 +215,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/select/select03.c b/testcases/kernel/syscalls/select/select03.c
index 9e015a4..5d78441 100644
--- a/testcases/kernel/syscalls/select/select03.c
+++ b/testcases/kernel/syscalls/select/select03.c
@@ -219,7 +219,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/setregid/setregid02.c b/testcases/kernel/syscalls/setregid/setregid02.c
index e518768..f842d23 100644
--- a/testcases/kernel/syscalls/setregid/setregid02.c
+++ b/testcases/kernel/syscalls/setregid/setregid02.c
@@ -138,7 +138,7 @@ static void setup(void)
 
 	tst_require_root(NULL);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	ltpuser = getpwnam("nobody");
 	if (ltpuser == NULL)
diff --git a/testcases/kernel/syscalls/setregid/setregid04.c b/testcases/kernel/syscalls/setregid/setregid04.c
index 4c81921..4b9331a 100644
--- a/testcases/kernel/syscalls/setregid/setregid04.c
+++ b/testcases/kernel/syscalls/setregid/setregid04.c
@@ -128,7 +128,7 @@ static void setup(void)
 {
 	tst_require_root(NULL);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	SAFE_GETGROUP(root);
 	SAFE_GETGROUP(users);
diff --git a/testcases/kernel/syscalls/setreuid/setreuid02.c b/testcases/kernel/syscalls/setreuid/setreuid02.c
index ddb9f6d..7e52dc4 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid02.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid02.c
@@ -109,7 +109,7 @@ static void setup(void)
 {
 	tst_require_root(NULL);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	if (getpwnam("nobody") == NULL)
 		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
diff --git a/testcases/kernel/syscalls/setreuid/setreuid03.c b/testcases/kernel/syscalls/setreuid/setreuid03.c
index daf025b..cad8584 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid03.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid03.c
@@ -160,7 +160,7 @@ static void setup(void)
 {
 	tst_require_root(NULL);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	if (getpwnam("nobody") == NULL)
 		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
diff --git a/testcases/kernel/syscalls/setreuid/setreuid06.c b/testcases/kernel/syscalls/setreuid/setreuid06.c
index ad63fab..f9857f4 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid06.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid06.c
@@ -81,7 +81,7 @@ static void setup(void)
 {
 	tst_require_root(NULL);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	umask(0);
 
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit03.c b/testcases/kernel/syscalls/setrlimit/setrlimit03.c
index 0fd8991..6c5d0f2 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit03.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit03.c
@@ -115,7 +115,7 @@ void setup(void)
 		tst_brkm(TBROK, NULL, "must run test as root");
 	}
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
diff --git a/testcases/kernel/syscalls/setuid/setuid03.c b/testcases/kernel/syscalls/setuid/setuid03.c
index d6dabf0..c1db4d1 100644
--- a/testcases/kernel/syscalls/setuid/setuid03.c
+++ b/testcases/kernel/syscalls/setuid/setuid03.c
@@ -96,7 +96,7 @@ static void setup(void)
 		perror("setuid");
 	}
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	umask(0);
 
diff --git a/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c b/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c
index 93363f6..3e7277c 100644
--- a/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c
+++ b/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c
@@ -197,7 +197,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c b/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c
index 6e3baeb..82cf810 100644
--- a/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c
+++ b/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c
@@ -186,7 +186,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/sigprocmask/sigprocmask01.c b/testcases/kernel/syscalls/sigprocmask/sigprocmask01.c
index 686965c..868d69d 100644
--- a/testcases/kernel/syscalls/sigprocmask/sigprocmask01.c
+++ b/testcases/kernel/syscalls/sigprocmask/sigprocmask01.c
@@ -224,7 +224,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c b/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
index 34aec8a..2203f75 100644
--- a/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
+++ b/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
@@ -174,7 +174,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
index c7be444..ca564ea 100644
--- a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
+++ b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
@@ -77,7 +77,7 @@ static void empty_handler(int sig)
 
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	signal(SIGUSR1, empty_handler);
 	signal(SIGALRM, empty_handler);
 	signal(SIGUSR2, SIG_IGN);
diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index 21ed003..d8cb09e 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -82,7 +82,7 @@ static void verify_swapoff(void)
 
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	tst_require_root(NULL);
 
diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c b/testcases/kernel/syscalls/swapoff/swapoff02.c
index 586a128..89d2b08 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff02.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
@@ -135,7 +135,7 @@ static void setup(void)
 	long type;
 	struct passwd *nobody;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_EXP_ENOS(exp_enos);
 
diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index e507379..0098c96 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -80,7 +80,7 @@ int main(int ac, char **av)
 
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	tst_require_root(NULL);
 
diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index 74aa07f..a7a5aa0 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -129,7 +129,7 @@ static void setup(void)
 {
 	struct passwd *nobody;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_EXP_ENOS(exp_enos);
 
diff --git a/testcases/kernel/syscalls/switch/endian_switch01.c b/testcases/kernel/syscalls/switch/endian_switch01.c
index d794808..f3e34b7 100644
--- a/testcases/kernel/syscalls/switch/endian_switch01.c
+++ b/testcases/kernel/syscalls/switch/endian_switch01.c
@@ -67,7 +67,7 @@ int TST_TOTAL = 1;
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/symlink/symlink01.c b/testcases/kernel/syscalls/symlink/symlink01.c
index e2ac44f..3d41023 100644
--- a/testcases/kernel/syscalls/symlink/symlink01.c
+++ b/testcases/kernel/syscalls/symlink/symlink01.c
@@ -1961,7 +1961,7 @@ void do_open(struct all_test_cases *tc_ptr)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/sysinfo/sysinfo01.c b/testcases/kernel/syscalls/sysinfo/sysinfo01.c
index 55a42f2..771cd97 100644
--- a/testcases/kernel/syscalls/sysinfo/sysinfo01.c
+++ b/testcases/kernel/syscalls/sysinfo/sysinfo01.c
@@ -164,7 +164,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	umask(0);
 
diff --git a/testcases/kernel/syscalls/sysinfo/sysinfo02.c b/testcases/kernel/syscalls/sysinfo/sysinfo02.c
index fb97ed6..45d2594 100644
--- a/testcases/kernel/syscalls/sysinfo/sysinfo02.c
+++ b/testcases/kernel/syscalls/sysinfo/sysinfo02.c
@@ -137,7 +137,7 @@ int main(void)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	umask(0);
 
diff --git a/testcases/kernel/syscalls/umount/umount02.c b/testcases/kernel/syscalls/umount/umount02.c
index c69197d..714119e 100644
--- a/testcases/kernel/syscalls/umount/umount02.c
+++ b/testcases/kernel/syscalls/umount/umount02.c
@@ -255,7 +255,7 @@ void cleanup_test(int i)
 static void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	tst_require_root(NULL);
 	tst_mkfs(NULL, device, fstype, NULL);
diff --git a/testcases/kernel/syscalls/uname/uname02.c b/testcases/kernel/syscalls/uname/uname02.c
index 65a030b..aa71ba1 100644
--- a/testcases/kernel/syscalls/uname/uname02.c
+++ b/testcases/kernel/syscalls/uname/uname02.c
@@ -110,7 +110,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_EXP_ENOS(exp_enos);
 
diff --git a/testcases/kernel/syscalls/uname/uname03.c b/testcases/kernel/syscalls/uname/uname03.c
index 97d4422..cfea5a4 100644
--- a/testcases/kernel/syscalls/uname/uname03.c
+++ b/testcases/kernel/syscalls/uname/uname03.c
@@ -129,7 +129,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
diff --git a/testcases/kernel/syscalls/utime/utime01.c b/testcases/kernel/syscalls/utime/utime01.c
index 203c227..fe6fd3b 100644
--- a/testcases/kernel/syscalls/utime/utime01.c
+++ b/testcases/kernel/syscalls/utime/utime01.c
@@ -210,7 +210,7 @@ void setup(void)
 {
 	int fildes;		/* file handle for temp file */
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* Check that the test process id is super/root  */
 	if (geteuid() != 0) {
diff --git a/testcases/kernel/syscalls/utime/utime05.c b/testcases/kernel/syscalls/utime/utime05.c
index bee0dd7..008f9be 100644
--- a/testcases/kernel/syscalls/utime/utime05.c
+++ b/testcases/kernel/syscalls/utime/utime05.c
@@ -186,7 +186,7 @@ void setup(void)
 {
 	int fildes;		/* file handle for temp file */
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* Switch to nobody user for correct error code collection */
 	if (geteuid() != 0) {
diff --git a/testcases/kernel/syscalls/wait4/wait402.c b/testcases/kernel/syscalls/wait4/wait402.c
index e4b9f0e..8e40a4e 100644
--- a/testcases/kernel/syscalls/wait4/wait402.c
+++ b/testcases/kernel/syscalls/wait4/wait402.c
@@ -96,7 +96,7 @@ int main(int ac, char **av)
 static void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_EXP_ENOS(exp_enos);
 
diff --git a/testcases/kernel/syscalls/write/write01.c b/testcases/kernel/syscalls/write/write01.c
index d586048..e0615b9 100644
--- a/testcases/kernel/syscalls/write/write01.c
+++ b/testcases/kernel/syscalls/write/write01.c
@@ -167,7 +167,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/writev/writev01.c b/testcases/kernel/syscalls/writev/writev01.c
index e59b3e5..a74644c 100644
--- a/testcases/kernel/syscalls/writev/writev01.c
+++ b/testcases/kernel/syscalls/writev/writev01.c
@@ -319,7 +319,7 @@ int main(int argc, char **argv)
 void setup(void)
 {
 
-	tst_sig(FORK, sighandler, cleanup);
+	tst_sig(NOFORK, sighandler, cleanup);
 
 	TEST_EXP_ENOS(exp_enos);
 
diff --git a/testcases/kernel/syscalls/writev/writev02.c b/testcases/kernel/syscalls/writev/writev02.c
index f093736..864107a 100644
--- a/testcases/kernel/syscalls/writev/writev02.c
+++ b/testcases/kernel/syscalls/writev/writev02.c
@@ -182,7 +182,7 @@ int main(int argc, char **argv)
 
 void setup(void)
 {
-	tst_sig(FORK, sighandler, cleanup);
+	tst_sig(NOFORK, sighandler, cleanup);
 
 	TEST_EXP_ENOS(exp_enos);
 
diff --git a/testcases/kernel/syscalls/writev/writev04.c b/testcases/kernel/syscalls/writev/writev04.c
index 3152df1..794c0bb 100644
--- a/testcases/kernel/syscalls/writev/writev04.c
+++ b/testcases/kernel/syscalls/writev/writev04.c
@@ -292,7 +292,7 @@ int main(void)
 void setup(void)
 {
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_EXP_ENOS(exp_enos);
 
-- 
1.8.2.1


------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

