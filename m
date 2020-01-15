From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Jan 2020 12:25:09 +0100
Subject: [LTP] [COMMITTED][PATCH 1/1] tst_mkfs.c: Fix arg order in error
 message
Message-ID: <20200115112509.29110-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes remaining typos from b0a30feb0.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_mkfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index a33d36a6b..5d208eceb 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -98,7 +98,7 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 			 "%s:%d: %s not found in $PATH", file, lineno, mkfs);
 	default:
 		tst_brkm(TBROK, cleanup_fn,
-			 "%s:%d: %s failed with %i", mkfs, ret, file, lineno);
+			 "%s:%d: %s failed with %i", file, lineno, mkfs, ret);
 	}
 }
 
-- 
2.24.1

