From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Oct 2020 17:47:51 +0100
Subject: [LTP] [PATCH 14/19] Unify error handling in moved functions
In-Reply-To: <20201026164756.30556-1-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
Message-ID: <20201026164756.30556-15-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Properly format caller file:line location
- Pedantically check invalid syscall return values

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 lib/tst_safe_macros.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index 5c51e0872..aa03a6d5c 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -403,9 +403,13 @@ int safe_dup(const char *file, const int lineno, int oldfd)
 	int rval;
 
 	rval = dup(oldfd);
+
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			 "dup(%i) failed", oldfd);
+			"dup(%i) failed", oldfd);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid dup(%i) return value %d", oldfd, rval);
 	}
 
 	return rval;
@@ -437,7 +441,6 @@ void safe_cmd(const char *file, const int lineno, const char *const argv[],
 	case 0:
 		break;
 	default:
-		tst_brk(TBROK, "%s:%d: %s failed (%d)", file, lineno, argv[0],
-			rval);
+		tst_brk_(file, lineno, TBROK, "%s failed (%d)", argv[0], rval);
 	}
 }
-- 
2.28.0

