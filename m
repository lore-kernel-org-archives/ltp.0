From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 19 Mar 2019 11:25:02 +0800
Subject: [LTP] [PATCH] lib/tst_af_alg.c: Fix wrong errno for unsupported
	AF_ALG
Message-ID: <1552965902-22452-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

According to socket(2) manpage and source code, socket(2) actually
returns EAFNOSUPPORT instead of EPROTONOSUPPORT when AF_ALG is not
supported by kernel.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 lib/tst_af_alg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_af_alg.c b/lib/tst_af_alg.c
index 9ce1ca4..97be548 100644
--- a/lib/tst_af_alg.c
+++ b/lib/tst_af_alg.c
@@ -16,7 +16,7 @@ int tst_alg_create(void)
 	TEST(socket(AF_ALG, SOCK_SEQPACKET, 0));
 	if (TST_RET >= 0)
 		return TST_RET;
-	if (TST_ERR == EPROTONOSUPPORT)
+	if (TST_ERR == EAFNOSUPPORT)
 		tst_brk(TCONF, "kernel doesn't support AF_ALG");
 	tst_brk(TBROK | TTERRNO, "unexpected error creating AF_ALG socket");
 	return -1;
-- 
1.8.3.1



