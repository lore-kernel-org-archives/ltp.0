From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Oct 2020 17:47:54 +0100
Subject: [LTP] [PATCH 17/19] Unify error handling in include/tst_safe_prw.h
In-Reply-To: <20201026164756.30556-1-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
Message-ID: <20201026164756.30556-18-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Pedantically check syscall return values

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_safe_prw.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/tst_safe_prw.h b/include/tst_safe_prw.h
index 01a684da3..2e506cb41 100644
--- a/include/tst_safe_prw.h
+++ b/include/tst_safe_prw.h
@@ -15,8 +15,12 @@ static inline ssize_t safe_pread(const char *file, const int lineno,
 
 	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			 "pread(%d,%p,%zu,%lld) failed",
-			 fildes, buf, nbyte, (long long)offset);
+			"pread(%d,%p,%zu,%lld) failed",
+			fildes, buf, nbyte, (long long)offset);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid pread(%d,%p,%zu,%lld) return value %zd",
+			fildes, buf, nbyte, (long long)offset, rval);
 	}
 
 	return rval;
@@ -34,8 +38,12 @@ static inline ssize_t safe_pwrite(const char *file, const int lineno,
 	rval = pwrite(fildes, buf, nbyte, offset);
 	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-			 "pwrite(%d,%p,%zu,%lld) failed",
-			 fildes, buf, nbyte, (long long)offset);
+			"pwrite(%d,%p,%zu,%lld) failed",
+			fildes, buf, nbyte, (long long)offset);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid pwrite(%d,%p,%zu,%lld) return value %zd",
+			fildes, buf, nbyte, (long long)offset, rval);
 	}
 
 	return rval;
-- 
2.28.0

