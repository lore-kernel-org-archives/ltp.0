From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 18 Jul 2017 09:33:16 +0200
Subject: [LTP] [PATCH 1/4] configure.ac: Add check for aio_abi.h
In-Reply-To: <20170718073319.23543-1-rpalethorpe@suse.com>
References: <20170718073319.23543-1-rpalethorpe@suse.com>
Message-ID: <20170718073319.23543-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Not all aio tests need aiolib, sometimes aio_abi.h is good enough if it exists.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index 658003972..a5032bf42 100644
--- a/configure.ac
+++ b/configure.ac
@@ -37,6 +37,7 @@ AC_CHECK_HEADERS([ \
     mm.h \
     pthread.h \
     sys/xattr.h \
+    linux/aio_abi.h \
     linux/genetlink.h \
     linux/mempolicy.h \
     linux/module.h \
-- 
2.13.2

