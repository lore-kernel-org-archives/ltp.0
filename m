From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 May 2017 14:38:26 +0200
Subject: [LTP] [COMMITTED] [PATCH] ffsb: Fix out of bounds access
Message-ID: <20170519123826.19006-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The constant string "\0" composes of two null characters and hence the
memcpy(unit, "\0", 3) was reading one byte after end of the constant
buffer.

Fixes #155

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 utils/ffsb-6.0-rc2/parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/ffsb-6.0-rc2/parser.c b/utils/ffsb-6.0-rc2/parser.c
index 64c89e1..7ec3d73 100644
--- a/utils/ffsb-6.0-rc2/parser.c
+++ b/utils/ffsb-6.0-rc2/parser.c
@@ -116,7 +116,7 @@ static uint64_t size64_convert(char *buf)
 	goto do_multiplier;
 
 try_single:
-	memcpy(unit, "\0", 3);
+	memset(unit, 0, sizeof(unit));
 	strcpy(unit, buf + (buf_size - 1));
 	if (isdigit(unit[0])) {
 		unit[0] = 0;
-- 
2.10.2

