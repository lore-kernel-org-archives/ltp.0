From: Heiko Carstens <hca@linux.ibm.com>
Date: Tue, 23 Mar 2021 22:58:19 +0100
Subject: [LTP] [PATCH 3/3] lib/vdso: remove struct arch_vdso_data from vdso
 data struct
In-Reply-To: <20210323215819.4161164-1-hca@linux.ibm.com>
References: <YFmUrVOyX4q+8Dy9@osiris>
 <20210323215819.4161164-1-hca@linux.ibm.com>
Message-ID: <20210323215819.4161164-4-hca@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since commit d60d7de3e16d ("lib/vdso: Allow to add architecture-specific
vdso data") it is possible to provide arch specific VDSO data.

This was only added for s390, which doesn't make use this anymore.
Therefore remove it again.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/Kconfig            |  3 ---
 include/vdso/datapage.h | 10 ----------
 2 files changed, 13 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index ecfd3520b676..35c7114f7ea3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1147,9 +1147,6 @@ config HAVE_SPARSE_SYSCALL_NR
 	  entries at 4000, 5000 and 6000 locations. This option turns on syscall
 	  related optimizations for a given architecture.
 
-config ARCH_HAS_VDSO_DATA
-	bool
-
 config HAVE_STATIC_CALL
 	bool
 
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 73eb622e7663..ee810cae4e1e 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,12 +19,6 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
-#ifdef CONFIG_ARCH_HAS_VDSO_DATA
-#include <asm/vdso/data.h>
-#else
-struct arch_vdso_data {};
-#endif
-
 #define VDSO_BASES	(CLOCK_TAI + 1)
 #define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
 			 BIT(CLOCK_MONOTONIC)		| \
@@ -70,8 +64,6 @@ struct vdso_timestamp {
  * @tz_dsttime:		type of DST correction
  * @hrtimer_res:	hrtimer resolution
  * @__unused:		unused
- * @arch_data:		architecture specific data (optional, defaults
- *			to an empty struct)
  *
  * vdso_data will be accessed by 64 bit and compat code at the same time
  * so we should be careful before modifying this structure.
@@ -105,8 +97,6 @@ struct vdso_data {
 	s32			tz_dsttime;
 	u32			hrtimer_res;
 	u32			__unused;
-
-	struct arch_vdso_data	arch_data;
 };
 
 /*
-- 
2.25.1

