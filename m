From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Oct 2020 17:47:45 +0100
Subject: [LTP] [PATCH 08/19] Unify error handling in lib/tst_mkfs.c
In-Reply-To: <20201026164756.30556-1-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
Message-ID: <20201026164756.30556-9-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Properly format caller file:line location

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 lib/tst_mkfs.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 38b2e7151..45dd83ad3 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -33,14 +33,14 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 	char extra_opts_str[1024] = "";
 
 	if (!dev) {
-		tst_brkm(TBROK, cleanup_fn,
-			 "%s:%d: No device specified", file, lineno);
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"No device specified");
 		return;
 	}
 
 	if (!fs_type) {
-		tst_brkm(TBROK, cleanup_fn,
-			 "%s:%d: No fs_type specified", file, lineno);
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"No fs_type specified");
 		return;
 	}
 
@@ -51,9 +51,8 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 			argv[pos++] = fs_opts[i];
 
 			if (pos + 2 > OPTS_MAX) {
-				tst_brkm(TBROK, cleanup_fn,
-				         "%s:%d: Too much mkfs options",
-					 file, lineno);
+				tst_brkm_(file, lineno, TBROK, cleanup_fn,
+					"Too many mkfs options");
 				return;
 			}
 
@@ -70,8 +69,8 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 			argv[pos++] = extra_opts[i];
 
 			if (pos + 1 > OPTS_MAX) {
-				tst_brkm(TBROK, cleanup_fn,
-				         "%s:%d: Too much mkfs options", file, lineno);
+				tst_brkm_(file, lineno, TBROK, cleanup_fn,
+					"Too many mkfs options");
 				return;
 			}
 
@@ -83,11 +82,14 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	argv[pos] = NULL;
 
-	if (tst_clear_device(dev))
-		tst_brkm(TBROK, cleanup_fn, "tst_clear_device() failed");
+	if (tst_clear_device(dev)) {
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"tst_clear_device() failed");
+	}
 
-	tst_resm(TINFO, "Formatting %s with %s opts='%s' extra opts='%s'",
-	         dev, fs_type, fs_opts_str, extra_opts_str);
+	tst_resm_(file, lineno, TINFO,
+		"Formatting %s with %s opts='%s' extra opts='%s'",
+		dev, fs_type, fs_opts_str, extra_opts_str);
 	ret = tst_cmd(cleanup_fn, argv, "/dev/null", NULL, TST_CMD_PASS_RETVAL |
 				  TST_CMD_TCONF_ON_MISSING);
 
@@ -95,12 +97,12 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 	case 0:
 	break;
 	case 255:
-		tst_brkm(TCONF, cleanup_fn,
-			 "%s:%d: %s not found in $PATH", file, lineno, mkfs);
+		tst_brkm_(file, lineno, TCONF, cleanup_fn,
+			"%s not found in $PATH", mkfs);
 	break;
 	default:
-		tst_brkm(TBROK, cleanup_fn,
-			 "%s:%d: %s failed with %i", file, lineno, mkfs, ret);
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"%s failed with exit code %i", mkfs, ret);
 	}
 }
 
-- 
2.28.0

