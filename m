From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Tue, 2 Apr 2019 10:53:26 +0800
Subject: [LTP] [PATCH] syscalls/accept04_01.c: Correcting ltp_syscall to
	tst_syscall
Message-ID: <1554173606-20291-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/accept4/accept4_01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/accept4/accept4_01.c b/testcases/kernel/syscalls/accept4/accept4_01.c
index c423b2a..dd289cf 100644
--- a/testcases/kernel/syscalls/accept4/accept4_01.c
+++ b/testcases/kernel/syscalls/accept4/accept4_01.c
@@ -50,9 +50,9 @@ accept4_01(int fd, struct sockaddr *sockaddr, socklen_t *addrlen, int flags)
 	args[2] = (long)addrlen;
 	args[3] = flags;
 
-	return ltp_syscall(__NR_socketcall, SYS_ACCEPT4, args);
+	return tst_syscall(__NR_socketcall, SYS_ACCEPT4, args);
 #else
-	return ltp_syscall(__NR_accept4, fd, sockaddr, addrlen, flags);
+	return tst_syscall(__NR_accept4, fd, sockaddr, addrlen, flags);
 #endif
 }
 #endif
-- 
1.8.3.1



