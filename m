From: Steve Muckle <smuckle.linux@gmail.com>
Date: Tue,  8 Aug 2017 14:14:30 -0700
Subject: [LTP] [PATCH] lib: detect ARM64 32-bit compat mode as 64-bit kernel
Message-ID: <20170808211430.90017-1-smuckle.linux@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ARM64 (aarch64) identifies itself in 32-bit compatibility mode as armv8l
or armv8b depending on endianness. Detect these modes as a 64-bit
kernel.

This fixes the following issues on ARM64:
 - mmapstress03 segfaults in 32-bit compat mode due to a larger than expected
   address space
 - cve-2016-4997 which was a vulnerability in a 32-bit compat syscall, but the
   test does not correctly identify 32-bit compat and wouldn't run
 - vma03 which only runs on 32-bit arches, it would incorrectly be run
   on arm64 32-bit mode and fail

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
---
Tested on armv8l, aarch64, x86-64 and x86-64 32-bit compat.

 lib/tst_kernel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index 71303fc36..fd648b1f2 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -31,6 +31,13 @@ int tst_kernel_bits(void)
 
 	kernel_bits = strstr(buf.machine, "64") ? 64 : 32;
 
+	/*
+	 * ARM64 (aarch64) defines 32-bit compatibility modes as
+	 * armv8l and armv8b (little and big endian).
+	 */
+	if (!strcmp(buf.machine, "armv8l") || !strcmp(buf.machine, "armv8b"))
+		kernel_bits = 64;
+
 	tst_resm(TINFO, "uname.machine=%s kernel is %ibit",
 	         buf.machine, kernel_bits);
 
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

