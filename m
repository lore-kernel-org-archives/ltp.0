From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Wed, 17 Jun 2020 00:56:12 +0200
Subject: [LTP] [PATCH 2/2] tests: test for setns() EINVAL regression
In-Reply-To: <20200616225612.4068799-1-christian.brauner@ubuntu.com>
References: <https://lore.kernel.org/lkml/20200615213843.2ojgm3ob7kp3qq6a@wittgenstein>
 <20200616225612.4068799-1-christian.brauner@ubuntu.com>
Message-ID: <20200616225612.4068799-2-christian.brauner@ubuntu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Verify that setns() reports EINVAL when an fd is passed that refers to an
open file but the file is not a file descriptor useable to interact with
namespaces.

Cc: Jan Stancek <jstancek@redhat.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
Link: https://lore.kernel.org/lkml/20200615085836.GR12456@shao2-debian
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 tools/testing/selftests/pidfd/pidfd.h            |  5 +++++
 tools/testing/selftests/pidfd/pidfd_getfd_test.c |  5 -----
 tools/testing/selftests/pidfd/pidfd_setns_test.c | 12 ++++++++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index c1921a53dbed..8d728eda783d 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -95,4 +95,9 @@ static inline int sys_pidfd_getfd(int pidfd, int fd, int flags)
 	return syscall(__NR_pidfd_getfd, pidfd, fd, flags);
 }
 
+static inline int sys_memfd_create(const char *name, unsigned int flags)
+{
+	return syscall(__NR_memfd_create, name, flags);
+}
+
 #endif /* __PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index 401a7c1d0312..84b65ecccb04 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -34,11 +34,6 @@ static int sys_kcmp(pid_t pid1, pid_t pid2, int type, unsigned long idx1,
 	return syscall(__NR_kcmp, pid1, pid2, type, idx1, idx2);
 }
 
-static int sys_memfd_create(const char *name, unsigned int flags)
-{
-	return syscall(__NR_memfd_create, name, flags);
-}
-
 static int __child(int sk, int memfd)
 {
 	int ret;
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 133ec5b6cda8..9418108eae13 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -470,4 +470,16 @@ TEST_F(current_nsset, no_foul_play)
 	}
 }
 
+TEST(setns_einval)
+{
+	int fd;
+
+	fd = sys_memfd_create("rostock", 0);
+	EXPECT_GT(fd, 0);
+
+	ASSERT_NE(setns(fd, 0), 0);
+	EXPECT_EQ(errno, EINVAL);
+	close(fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.27.0

