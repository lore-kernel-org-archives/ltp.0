From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 21 May 2020 13:01:10 +0200
Subject: [LTP] [PATCH] crash02: Blacklist the pause() syscall
Message-ID: <20200521110110.11381-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

pause() causes the calling process/thread to sleep indefinitely until waken up
by a signal. This will cause test timeouts.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/misc/crash/crash02.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/misc/crash/crash02.c b/testcases/misc/crash/crash02.c
index f69edf7e1..e46c2aa66 100644
--- a/testcases/misc/crash/crash02.c
+++ b/testcases/misc/crash/crash02.c
@@ -473,6 +473,9 @@ int in_blacklist(int sysno)
 #endif
 #if defined(__NR_vhangup) && __NR_vhangup
 		__NR_vhangup,	/* int vhangup(void); - terminal logout */
+#endif
+#if defined(__NR_pause) && __NR_pause
+		__NR_pause,	/* int pause(void); - sleep indefinitely */
 #endif
 		-1
 	};
-- 
2.26.2

