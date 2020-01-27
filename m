From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 27 Jan 2020 10:39:35 +0100
Subject: [LTP] [PATCH] Blacklist vhangup() syscall in crash02 test
Message-ID: <20200127093935.8223-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The vhangup() syscall logs the current terminal out which some external
testing tools interpret as a failure. Blacklist the syscall in crash02 test
since there's no combination of arguments that could cause a kernel crash.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/misc/crash/crash02.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/misc/crash/crash02.c b/testcases/misc/crash/crash02.c
index cddedc102..f69edf7e1 100644
--- a/testcases/misc/crash/crash02.c
+++ b/testcases/misc/crash/crash02.c
@@ -470,6 +470,9 @@ int in_blacklist(int sysno)
 #endif /* __ia64__ */
 #if defined(__NR_clone) && __NR_clone
 		SYS_clone,
+#endif
+#if defined(__NR_vhangup) && __NR_vhangup
+		__NR_vhangup,	/* int vhangup(void); - terminal logout */
 #endif
 		-1
 	};
-- 
2.24.1

