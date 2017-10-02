From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  2 Oct 2017 15:33:41 +0200
Subject: [LTP] [PATCH v2 1/1] syscalls/profil01: Fix build for libc without
	profil() support
Message-ID: <20171002133341.30855-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

uClibc and uClibc-ng (at least) have no profil() support atm.

Patch taken from buildroot project (thanks!), adjusted it not to be
only uClibc/uClibc-ng specific.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Reported-by: Erico Nunes <nunes.erico@gmail.com>
---
 configure.ac                                | 2 ++
 testcases/kernel/syscalls/profil/profil01.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/configure.ac b/configure.ac
index 458a5b13f..465655e7b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -46,6 +46,8 @@ AC_CHECK_HEADERS([ \
     sys/prctl.h \
 ])
 
+AC_CHECK_FUNCS([profil])
+
 # Tools knobs
 
 # Expect
diff --git a/testcases/kernel/syscalls/profil/profil01.c b/testcases/kernel/syscalls/profil/profil01.c
index 2fc47aaf5..ff330d0b9 100644
--- a/testcases/kernel/syscalls/profil/profil01.c
+++ b/testcases/kernel/syscalls/profil/profil01.c
@@ -28,6 +28,8 @@
 #include "test.h"
 #include "safe_macros.h"
 
+#if HAVE_PROFIL
+
 #define PROFIL_TIME 5
 
 /* Should be large enough to hold data for test_profil() .text,
@@ -37,6 +39,7 @@
 #define PROFIL_BUFLEN (32*1024)
 
 char *TCID = "profil01";
+
 int TST_TOTAL = 1;
 
 static volatile sig_atomic_t profil_done;
@@ -124,3 +127,9 @@ int main(int ac, char *av[])
 
 	tst_exit();
 }
+#else /* systems without profil() */
+int main(void)
+{
+        tst_brkm(TCONF, NULL, "system doesn't have profil() support");
+}
+#endif
-- 
2.14.2

