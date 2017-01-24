From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Jan 2017 10:35:26 +0100
Subject: [LTP] [PATCH 1/1] lib: Remove reference to already deleted
	mount_utils.c
Message-ID: <20170124093526.3799-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

mount_utils.c was removed in
da3f4ba60 lib: Remove unused mount_utils.c

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 24d1faa25..d27c2a66b 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -26,8 +26,6 @@ include $(top_srcdir)/include/mk/env_pre.mk
 
 CFLAGS			+= -I.
 
-FILTER_OUT_LIBSRCS	:= mount_utils.c
-
 LIB			:= libltp.a
 
 pc_file			:= $(DESTDIR)/$(datarootdir)/pkgconfig/ltp.pc
-- 
2.11.0

