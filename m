From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 10 Oct 2017 17:05:11 +0200
Subject: [LTP] [PATCH 3/6] safe_macros: add SAFE_SETENV()
In-Reply-To: <7fe9947329b48673f7f9ee2e0b127619fdfe0c34.1507647255.git.jstancek@redhat.com>
References: <7fe9947329b48673f7f9ee2e0b127619fdfe0c34.1507647255.git.jstancek@redhat.com>
Message-ID: <afc1fe5555ccb1b3c331b39e494002f3d50935ab.1507647255.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_safe_macros.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 1e034b8e29d7..5d8952544be3 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -447,5 +447,12 @@ int safe_personality(const char *filename, unsigned int lineno,
 		    unsigned long persona);
 #define SAFE_PERSONALITY(persona) safe_personality(__FILE__, __LINE__, persona)
 
+#define SAFE_SETENV(name, value, overwrite) do {		\
+	if (setenv(name, value, overwrite)) {			\
+		tst_brk_(__FILE__, __LINE__, TBROK | TERRNO,	\
+			"setenv(%s, %s, %d) failed",		\
+			name, value, overwrite);		\
+	}							\
+	} while (0)
 
 #endif /* SAFE_MACROS_H__ */
-- 
1.8.3.1

