From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 10 Oct 2017 17:05:10 +0200
Subject: [LTP] [PATCH 2/6] lib: move tst_get_startwd() to old_tmpdir header
In-Reply-To: <7fe9947329b48673f7f9ee2e0b127619fdfe0c34.1507647255.git.jstancek@redhat.com>
References: <7fe9947329b48673f7f9ee2e0b127619fdfe0c34.1507647255.git.jstancek@redhat.com>
Message-ID: <b9195e40257e0d6a3077969f26abbdd7c1ac9bbb.1507647255.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Newlib can't include ltp_priv.h due to conflicts with oldlib.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/old/ltp_priv.h   | 3 ---
 include/old/old_tmpdir.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/old/ltp_priv.h b/include/old/ltp_priv.h
index e678a28682eb..0552457e591f 100644
--- a/include/old/ltp_priv.h
+++ b/include/old/ltp_priv.h
@@ -24,9 +24,6 @@
 
 #include <stdarg.h>
 
-/* declared in tst_tmpdir.c */
-const char *tst_get_startwd(void);
-
 /*
  * This is the default temporary directory used by tst_tmpdir().
  *
diff --git a/include/old/old_tmpdir.h b/include/old/old_tmpdir.h
index b39b615a8bdb..9c61172fd71c 100644
--- a/include/old/old_tmpdir.h
+++ b/include/old/old_tmpdir.h
@@ -50,4 +50,7 @@ char *tst_get_tmpdir(void);
  */
 int tst_tmpdir_created(void);
 
+/* declared in tst_tmpdir.c */
+const char *tst_get_startwd(void);
+
 #endif	/* OLD_TMPDIR_H__ */
-- 
1.8.3.1

