From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Oct 2017 13:10:56 +0200
Subject: [LTP] [PATCH v5 02/12] kernel/io: Build all directories even
	without libaio
In-Reply-To: <20171018111106.17215-1-pvorel@suse.cz>
References: <20171018111106.17215-1-pvorel@suse.cz>
Message-ID: <20171018111106.17215-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

With fixed build without missing libaio or it's headers there is
no need to filter out directories.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/io/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/kernel/io/Makefile b/testcases/kernel/io/Makefile
index 88ba99692..7db02882a 100644
--- a/testcases/kernel/io/Makefile
+++ b/testcases/kernel/io/Makefile
@@ -24,6 +24,4 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-FILTER_OUT_DIRS		:= $(if $(AIO_LIBS),,aio ltp-aiodio)
-
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
-- 
2.14.2

