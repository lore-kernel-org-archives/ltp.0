From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 15 Sep 2021 17:46:59 +0200
Subject: [LTP] [PATCH] misc/crash02: Update syscall blacklist
Message-ID: <20210915154659.26931-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- fork() and vfork() are not mutually exclusive, blacklist both
- read() will sleep indefinitely if the first argument is 0

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/misc/crash/crash02.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/misc/crash/crash02.c b/testcases/misc/crash/crash02.c
index 66f308b70..c68f580ef 100644
--- a/testcases/misc/crash/crash02.c
+++ b/testcases/misc/crash/crash02.c
@@ -464,7 +464,8 @@ int in_blacklist(int sysno)
 		 */
 #if defined(__NR_vfork) && __NR_vfork
 		SYS_vfork,
-#elif defined(__NR_fork) && __NR_fork
+#endif
+#if defined(__NR_fork) && __NR_fork
 		SYS_fork,
 #endif
 #endif /* __ia64__ */
@@ -476,6 +477,13 @@ int in_blacklist(int sysno)
 #endif
 #if defined(__NR_pause) && __NR_pause
 		__NR_pause,	/* int pause(void); - sleep indefinitely */
+#endif
+#if defined(__NR_read) && __NR_read
+		/*
+		 * ssize_t read(int fd, void *buf, size_t count); - will sleep
+		 * indefinitely if the first argument is 0
+		 */
+		__NR_read,
 #endif
 		-1
 	};
-- 
2.33.0

