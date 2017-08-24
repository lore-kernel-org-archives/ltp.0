From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 24 Aug 2017 08:53:25 +0800
Subject: [LTP] [PATCH] mem/vma: add the installation of vma05.sh
Message-ID: <1503536005-3751-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/mem/vma/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/mem/vma/Makefile b/testcases/kernel/mem/vma/Makefile
index 966148c..3a4e2b4 100644
--- a/testcases/kernel/mem/vma/Makefile
+++ b/testcases/kernel/mem/vma/Makefile
@@ -23,4 +23,7 @@ vma05_vdso: CFLAGS+=-ggdb3
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
+
+INSTALL_TARGETS		:= vma05.sh
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
1.8.3.1



