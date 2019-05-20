From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 May 2019 23:49:11 +0200
Subject: [LTP] [PATCH] lapi/ustat.h: Replace daddr_t with long
Message-ID: <20190520214911.1460-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <petr.vorel@gmail.com>

daddr_t is usually typedef to __kernel_daddr_t,
which is int or long.
Using long as daddr_t is not defined at least on musl.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 include/lapi/ustat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/lapi/ustat.h b/include/lapi/ustat.h
index 12c073582..030179c4a 100644
--- a/include/lapi/ustat.h
+++ b/include/lapi/ustat.h
@@ -11,7 +11,7 @@
 # include <sys/ustat.h>
 #else
 struct ustat {
-	daddr_t f_tfree;
+	long f_tfree;
 	ino_t f_tinode;
 	char f_fname[6];
 	char f_fpack[6];
-- 
2.21.0

