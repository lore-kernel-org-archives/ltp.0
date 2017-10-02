From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  2 Oct 2017 11:44:03 +0200
Subject: [LTP] [PATCH 1/1] uClibc-ng has no profil() support
Message-ID: <20171002094403.25417-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Erico Nunes <nunes.erico@gmail.com>

Patch taken from buildroot project (thanks!).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
I have rewritting to new API and use TST_TEST_TCONF() in my TODO list.
---
 testcases/kernel/syscalls/profil/profil01.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/syscalls/profil/profil01.c b/testcases/kernel/syscalls/profil/profil01.c
index 2fc47aaf5..f8afd57bf 100644
--- a/testcases/kernel/syscalls/profil/profil01.c
+++ b/testcases/kernel/syscalls/profil/profil01.c
@@ -37,6 +37,9 @@
 #define PROFIL_BUFLEN (32*1024)
 
 char *TCID = "profil01";
+
+#if !defined(__UCLIBC__)
+
 int TST_TOTAL = 1;
 
 static volatile sig_atomic_t profil_done;
@@ -124,3 +127,9 @@ int main(int ac, char *av[])
 
 	tst_exit();
 }
+#else /* systems that dont support profil */
+int main(void)
+{
+        tst_brkm(TCONF, NULL, "system doesn't have profil support");
+}
+#endif
-- 
2.14.1

