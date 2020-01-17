From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 17 Jan 2020 15:04:50 +0800
Subject: [LTP] [PATCH] syscalls/add_key02: add the "big_key" key type
Message-ID: <1579244690-22830-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This key type is introduced in kernel:
commit ab3c3587f8cd ("KEYS: Implement a big key type that can save to tmpfs")

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/add_key/add_key02.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/add_key/add_key02.c b/testcases/kernel/syscalls/add_key/add_key02.c
index 159234f67..98dd5b905 100644
--- a/testcases/kernel/syscalls/add_key/add_key02.c
+++ b/testcases/kernel/syscalls/add_key/add_key02.c
@@ -40,6 +40,7 @@ struct tcase {
 	{ "rxrpc_s",		 8 },
 	{ "user",		64 },
 	{ "logon",              64 },
+	{ "big_key",            64 },
 };
 
 static void verify_add_key(unsigned int i)
-- 
2.18.0



