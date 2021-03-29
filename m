From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Mar 2021 19:41:35 +0200
Subject: [LTP] [PATCH 1/1] tst_safe_macros: Add SAFE_EXECVP()
Message-ID: <20210329174135.23890-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Fix for Joerg's patch [1], deliberatelly using execvp() instead of
execv() (more info at that patch).

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20210315092844.991073-1-lkml@jv-coder.de/

 include/tst_safe_macros.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 2a2b0088a..b9d9baa1a 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -487,6 +487,12 @@ int safe_sigwait(const char *file, const int lineno,
                 "execl(%s, %s, ...) failed", file, arg); 	\
        } while (0)
 
+#define SAFE_EXECVP(file, arg) do {                   \
+	execvp((file), (arg));              \
+	tst_brk_(__FILE__, __LINE__, TBROK | TERRNO,       \
+	         "execvp(%s, %p) failed", file, arg); \
+	} while (0)
+
 int safe_getpriority(const char *file, const int lineno, int which, id_t who);
 #define SAFE_GETPRIORITY(which, who) \
 	safe_getpriority(__FILE__, __LINE__, (which), (who))
-- 
2.30.2

