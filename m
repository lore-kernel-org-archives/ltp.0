From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 14 Jun 2017 15:39:09 +0800
Subject: [LTP] [PATCH] syscalls/add_key02: add the "logon" key type
Message-ID: <1497425949-4213-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This key type is introduced in kernel:
'9f6ed2ca257f(keys: add a "logon" key type)'

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/add_key/add_key02.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/add_key/add_key02.c b/testcases/kernel/syscalls/add_key/add_key02.c
index 2e3308d..8d5b61f 100644
--- a/testcases/kernel/syscalls/add_key/add_key02.c
+++ b/testcases/kernel/syscalls/add_key/add_key02.c
@@ -56,6 +56,7 @@ struct tcase {
 	{ "rxrpc",		64 },
 	{ "rxrpc_s",		 8 },
 	{ "user",		64 },
+	{ "logon",               64 },
 };
 #endif /* HAVE_LINUX_KEYCTL_H */
 
-- 
1.8.3.1



