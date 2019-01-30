From: Petr Vorel <petr.vorel@gmail.com>
Date: Wed, 30 Jan 2019 12:28:26 +0100
Subject: [LTP] [PATCH 3/3] lib: Build tst_path_has_mnt_flags.c also on
	Android
In-Reply-To: <20190130112826.7157-1-petr.vorel@gmail.com>
References: <20190130112826.7157-1-petr.vorel@gmail.com>
Message-ID: <20190130112826.7157-4-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes android build, as since 7313a879d7 is needed in library:
tst_test.c:737: error: undefined reference to 'tst_path_has_mnt_flags_'

Fixes: 7313a879d7 ("lib/tst_test.c: Add .needs_devfs flag")

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Makefile b/lib/Makefile
index 4ab7c394a..e7fc753da 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -29,7 +29,7 @@ CFLAGS			+= -I. -DLTPLIB
 ifneq ($(ANDROID),1)
 FILTER_OUT_DIRS		+= android_libpthread android_librt
 else
-FILTER_OUT_LIBSRCS	+= tlibio.c tst_path_has_mnt_flags.c tst_safe_sysv_ipc.c
+FILTER_OUT_LIBSRCS	+= tlibio.c tst_safe_sysv_ipc.c
 endif
 
 LIB			:= libltp.a
-- 
2.20.1

