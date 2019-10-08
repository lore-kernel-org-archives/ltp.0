From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  8 Oct 2019 15:36:34 +0200
Subject: [LTP] [PATCH v2] pkeys: Fix uclibc build caused by conflicting
 signature
Message-ID: <20191008133634.12369-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Removing static fixes the problem.

uClibc defines pkey_{alloc,free,mprotect} signatures in
<bits/mman-shared.h>, which is included by <bits/mman-linux.h>. Because
it does not implement them, our implementation signature conflicts, as
it uses static. Add 'ltp_' prefix to our helper functions (suggested by Jan).

Fixed build error:
In file included from pkey01.c:32:0:
pkey.h:18:19: error: static declaration of ?pkey_mprotect? follows non-static declaration
 static inline int pkey_mprotect(void *addr, size_t len, int prot, int pkey)
                   ^
In file included from /opt/br-test-pkg/br-arm-full/host/arm-buildroot-linux-uclibcgnueabi/sysroot/usr/include/bits/mman-linux.h:115:0,
                 from /opt/br-test-pkg/br-arm-full/host/arm-buildroot-linux-uclibcgnueabi/sysroot/usr/include/bits/mman.h:40,
                 from /opt/br-test-pkg/br-arm-full/host/arm-buildroot-linux-uclibcgnueabi/sysroot/usr/include/sys/mman.h:41,
                 from pkey01.c:29:
/opt/br-test-pkg/br-arm-full/host/arm-buildroot-linux-uclibcgnueabi/sysroot/usr/include/bits/mman-shared.h:73:5: note: previous declaration of ?pkey_mprotect? was here
 int pkey_mprotect (void *__addr, size_t __len, int __prot, int __pkey) __THROW;
     ^
In file included from pkey01.c:32:0:

Found with test-pkg tool from Buildroot distribution.

Fixes: 90c2dc89f ("pkey: add test for memory protection keys")

Reported-by: Petr Vorel <petr.vorel@gmail.com>
Suggested-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/pkeys/pkey.h   | 15 ++++++++++-----
 testcases/kernel/syscalls/pkeys/pkey01.c |  4 ++--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/pkeys/pkey.h b/testcases/kernel/syscalls/pkeys/pkey.h
index d623244eb..3c1204978 100644
--- a/testcases/kernel/syscalls/pkeys/pkey.h
+++ b/testcases/kernel/syscalls/pkeys/pkey.h
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2019 Red Hat, Inc.
+ * Copyright (c) Linux Test Project, 2019
  */
 
 #ifndef PKEYS_H
@@ -15,25 +16,29 @@
 #endif
 
 #ifndef HAVE_PKEY_MPROTECT
-static inline int pkey_mprotect(void *addr, size_t len, int prot, int pkey)
+inline int ltp_pkey_mprotect(void *addr, size_t len, int prot, int pkey)
 {
 	return tst_syscall(__NR_pkey_mprotect, addr, len, prot, pkey);
 }
 
-static inline int pkey_alloc(unsigned int flags, unsigned int access_rights)
+inline int ltp_pkey_alloc(unsigned int flags, unsigned int access_rights)
 {
 	return tst_syscall(__NR_pkey_alloc, flags, access_rights);
 }
 
-static inline int pkey_free(int pkey)
+inline int ltp_pkey_free(int pkey)
 {
 	return tst_syscall(__NR_pkey_free, pkey);
 }
+#else
+#define ltp_pkey_alloc pkey_alloc
+#define ltp_pkey_free pkey_free
+#define ltp_pkey_mprotect pkey_mprotect
 #endif /* HAVE_PKEY_MPROTECT */
 
 static inline void check_pkey_support(void)
 {
-	int pkey = pkey_alloc(0, 0);
+	int pkey = ltp_pkey_alloc(0, 0);
 
 	if (pkey == -1) {
 		if (errno == ENOSYS)
@@ -44,7 +49,7 @@ static inline void check_pkey_support(void)
 			tst_brk(TCONF, "pkeys are not available for test");
 	}
 
-	pkey_free(pkey);
+	ltp_pkey_free(pkey);
 }
 
 #endif /* PKEYS_H */
diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c b/testcases/kernel/syscalls/pkeys/pkey01.c
index b6b7e5cba..21b98b242 100644
--- a/testcases/kernel/syscalls/pkeys/pkey01.c
+++ b/testcases/kernel/syscalls/pkeys/pkey01.c
@@ -162,7 +162,7 @@ static void pkey_test(struct tcase *tc, struct mmap_param *mpa)
 		tst_brk(TBROK | TERRNO, "pkey_alloc failed");
 
 	tst_res(TINFO, "Set %s on (%s) buffer", tc->name, flag_to_str(mpa->flags));
-	if (pkey_mprotect(buffer, size, mpa->prot, pkey) == -1)
+	if (ltp_pkey_mprotect(buffer, size, mpa->prot, pkey) == -1)
 		tst_brk(TBROK | TERRNO, "pkey_mprotect failed");
 
 	pid = SAFE_FORK();
@@ -189,7 +189,7 @@ static void pkey_test(struct tcase *tc, struct mmap_param *mpa)
                 tst_res(TFAIL, "Child: %s", tst_strstatus(status));
 
 	tst_res(TINFO, "Remove %s from the buffer", tc->name);
-	if (pkey_mprotect(buffer, size, mpa->prot, 0x0) == -1)
+	if (ltp_pkey_mprotect(buffer, size, mpa->prot, 0x0) == -1)
 		tst_brk(TBROK | TERRNO, "pkey_mprotect failed");
 
 	switch (mpa->prot) {
-- 
2.23.0

