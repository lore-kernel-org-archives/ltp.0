From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 24 Jul 2020 10:43:31 +0200
Subject: [LTP] [PATCH 2/4] libs: sigwait: Add SAFE_SIG*() macros
In-Reply-To: <8b0c584c86d4f45212ccf418e9840a53b6e62a09.1595511710.git.viresh.kumar@linaro.org>
References: <e51142a397858a2fe6a040563d3c0795a7d0bb05.1595511710.git.viresh.kumar@linaro.org>
 <8b0c584c86d4f45212ccf418e9840a53b6e62a09.1595511710.git.viresh.kumar@linaro.org>
Message-ID: <20200724084331.GD9768@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor change, thanks.

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 3fce473cc..f3f83cddd 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -438,8 +438,9 @@ static inline void safe_sigaddset(const char *file, const int lineno,
 
 	rval = sigaddset(sigs, signo);
 	if (rval == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO, "sigaddset(%d) failed",
-			 signo);
+		tst_brk_(file, lineno, TBROK | TERRNO,
+		         "sigaddset() %s (%i) failed",
+			 tst_strsig(signo), signo);
 	}
 }
 
@@ -453,8 +454,9 @@ static inline void safe_sigdelset(const char *file, const int lineno,
 
 	rval = sigdelset(sigs, signo);
 	if (rval == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO, "sigdelset(%d) failed",
-			 signo);
+		tst_brk_(file, lineno, TBROK | TERRNO,
+		         "sigdelset() %s (%i) failed",
+			 tst_strsig(signo), signo);
 	}
 }
 


-- 
Cyril Hrubis
chrubis@suse.cz
