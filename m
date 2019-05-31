From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 May 2019 11:43:00 +0200
Subject: [LTP] [COMMITTED] [PATCH] insmod01: Add license to the dummy module
Message-ID: <20190531094300.8409-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes "Missing module licence" taint when module is inserted into
the kernel.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/commands/insmod/ltp_insmod01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/commands/insmod/ltp_insmod01.c b/testcases/commands/insmod/ltp_insmod01.c
index 398714e78..9e859510a 100644
--- a/testcases/commands/insmod/ltp_insmod01.c
+++ b/testcases/commands/insmod/ltp_insmod01.c
@@ -31,5 +31,7 @@ static void test_exit(void)
 
 }
 
+MODULE_LICENSE("GPL");
+
 module_init(test_init);
 module_exit(test_exit);
-- 
2.19.2

