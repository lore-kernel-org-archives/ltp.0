From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 May 2020 17:17:28 +0200
Subject: [LTP] [PATCH 1/3] [COMMITTED] lib/tst_mkfs.c: Fix fall through
 warning
Message-ID: <20200512151730.10201-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_mkfs.c: In function 'tst_mkfs_':
../include/old/test.h:139:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
  139 |  if (tst_test) \
      |     ^
tst_mkfs.c:98:3: note: in expansion of macro 'tst_brkm'
   98 |   tst_brkm(TCONF, cleanup_fn,
      |   ^~~~~~~~
tst_mkfs.c:100:2: note: here
  100 |  default:
      |  ^~~~~~~

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_mkfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 3860545eb..38b2e7151 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -97,6 +97,7 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 	case 255:
 		tst_brkm(TCONF, cleanup_fn,
 			 "%s:%d: %s not found in $PATH", file, lineno, mkfs);
+	break;
 	default:
 		tst_brkm(TBROK, cleanup_fn,
 			 "%s:%d: %s failed with %i", file, lineno, mkfs, ret);
-- 
2.26.2

