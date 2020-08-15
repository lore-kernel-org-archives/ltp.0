From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Sat, 15 Aug 2020 13:13:11 +0800
Subject: [LTP] [PATCH 1/2] safe_macros: Add SAFE_SIGFILLSET()
Message-ID: <20200815051312.25002-1-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/tst_safe_macros.h |  5 +++++
 lib/tst_safe_macros.c     | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 45fd0500a..000381c4f 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -446,6 +446,11 @@ void safe_sigemptyset(const char *file, const int lineno,
 #define SAFE_SIGEMPTYSET(sigs) \
 	safe_sigemptyset(__FILE__, __LINE__, (sigs))
 
+void safe_sigfillset(const char *file, const int lineno,
+		     sigset_t *sigs);
+#define SAFE_SIGFILLSET(sigs) \
+	safe_sigfillset(__FILE__, __LINE__, (sigs))
+
 void safe_sigprocmask(const char *file, const int lineno,
                       int how, sigset_t *set, sigset_t *oldset);
 #define SAFE_SIGPROCMASK(how, set, oldset) \
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index f18cb4625..25c37dfd8 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -166,6 +166,16 @@ void safe_sigemptyset(const char *file, const int lineno,
 		tst_brk_(file, lineno, TBROK | TERRNO, "sigemptyset() failed");
 }
 
+void safe_sigfillset(const char *file, const int lineno,
+		     sigset_t *sigs)
+{
+	int rval;
+
+	rval = sigfillset(sigs);
+	if (rval == -1)
+		tst_brk_(file, lineno, TBROK | TERRNO, "sigfillset() failed");
+}
+
 static const char *strhow(int how)
 {
 	switch (how) {
-- 
2.21.0



