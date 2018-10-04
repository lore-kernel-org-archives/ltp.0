From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  4 Oct 2018 16:31:10 +0200
Subject: [LTP] [PATCH] [COMMITTED] safe_macros: Make safe_*xattr more verbose
Message-ID: <20181004143110.6489-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Print parameters passed to SAFE_*XATTR() on failure

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/safe_macros.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 9588ef5bc..bac34cdb7 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -854,8 +854,9 @@ ssize_t safe_getxattr(const char *file, const int lineno, const char *path,
 				 "without user_xattr option", file, lineno);
 		}
 
-		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: getxattr() failed",
-			 file, lineno);
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: getxattr(%s, %s, %p, %zu) failed",
+			 file, lineno, path, name, value, size);
 	}
 
 	return rval;
@@ -875,8 +876,9 @@ int safe_setxattr(const char *file, const int lineno, const char *path,
 				 "without user_xattr option", file, lineno);
 		}
 
-		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: setxattr() failed",
-			     file, lineno);
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: setxattr(%s, %s, %p, %zu) failed",
+			 file, lineno, path, name, value, size);
 	}
 
 	return rval;
@@ -896,8 +898,9 @@ int safe_lsetxattr(const char *file, const int lineno, const char *path,
 				 "without user_xattr option", file, lineno);
 		}
 
-		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: lsetxattr() failed",
-			     file, lineno);
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: lsetxattr(%s, %s, %p, %zu, %i) failed",
+			 file, lineno, path, name, value, size, flags);
 	}
 
 	return rval;
@@ -917,8 +920,9 @@ int safe_fsetxattr(const char *file, const int lineno, int fd, const char *name,
 				 "without user_xattr option", file, lineno);
 		}
 
-		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: fsetxattr() failed",
-			     file, lineno);
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: fsetxattr(%i, %s, %p, %zu, %i) failed",
+			 file, lineno, fd, name, value, size, flags);
 	}
 
 	return rval;
@@ -938,8 +942,9 @@ int safe_removexattr(const char *file, const int lineno, const char *path,
 				"without user_xattr option", file, lineno);
 		}
 
-		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: removexattr() failed",
-			file, lineno);
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: removexattr(%s, %s) failed",
+			 file, lineno, path, name);
 	}
 
 	return rval;
@@ -959,8 +964,9 @@ int safe_lremovexattr(const char *file, const int lineno, const char *path,
 				"without user_xattr option", file, lineno);
 		}
 
-		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: lremovexattr() failed",
-			file, lineno);
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: lremovexattr(%s, %s) failed",
+			 file, lineno, path, name);
 	}
 
 	return rval;
@@ -980,8 +986,9 @@ int safe_fremovexattr(const char *file, const int lineno, int fd,
 				"without user_xattr option", file, lineno);
 		}
 
-		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: fremovexattr() failed",
-			file, lineno);
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: fremovexattr(%i, %s) failed",
+			 file, lineno, fd, name);
 	}
 
 	return rval;
-- 
2.16.4

