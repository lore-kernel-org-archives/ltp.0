From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  1 Dec 2020 09:41:43 +0100
Subject: [LTP] [PATCH] [COMMITTED] lib: tst_resm() put back redirection to
 newlib
Message-ID: <20201201084143.22991-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We do have new library code calling back to old library tst_brkm() at
least in move_pages/move_pages12.c hence we have to keep the redirection
in the test library for the time being.

Fixes #745

Fixes: 61db712e3557 (lib: Fix SAFE_MACROS() redirection to new library)
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_res.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tst_res.c b/lib/tst_res.c
index c9ba0fa66..8d86b48a4 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -587,6 +587,8 @@ void tst_brkm__(const char *file, const int lineno, int ttype,
 			tst_brk_(file, lineno, TBROK,
 			         "Non-NULL cleanup in newlib!");
 		}
+
+		tst_brk_(file, lineno, ttype, "%s", tmesg);
 	}
 
 	tst_brk__(file, lineno, ttype, func, "%s", tmesg);
-- 
2.26.2

