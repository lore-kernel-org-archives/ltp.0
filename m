From: Khem Raj <raj.khem@gmail.com>
Date: Fri,  8 Jan 2016 08:11:25 +0000
Subject: [LTP] [PATCH 05/31] kernel/controllers: Link with libfts explicitly
	on musl
In-Reply-To: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
References: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452240711-51180-5-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

musl does not implement fts like glibc and therefore it depends on
external implementation for all fts APIs

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/controllers/Makefile.inc        | 3 +++
 testcases/kernel/controllers/cpuset/Makefile.inc | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/testcases/kernel/controllers/Makefile.inc b/testcases/kernel/controllers/Makefile.inc
index b106283..ef5fc0c 100644
--- a/testcases/kernel/controllers/Makefile.inc
+++ b/testcases/kernel/controllers/Makefile.inc
@@ -36,6 +36,9 @@ MAKE_DEPS		:= $(LIB)
 CPPFLAGS		+= -I$(abs_srcdir)/../$(LIBDIR)
 
 LDFLAGS			+= -L$(abs_builddir)/../$(LIBDIR)
+ifeq ($(LIBC),musl)
+LDLIBS			+= -lfts
+endif
 
 INSTALL_TARGETS		?= *.sh
 
diff --git a/testcases/kernel/controllers/cpuset/Makefile.inc b/testcases/kernel/controllers/cpuset/Makefile.inc
index 9e002f4..e0fcb9c 100644
--- a/testcases/kernel/controllers/cpuset/Makefile.inc
+++ b/testcases/kernel/controllers/cpuset/Makefile.inc
@@ -42,6 +42,9 @@ MAKE_DEPS		:= $(LIBCONTROLLERS) $(LIBCPUSET)
 LDFLAGS			+= -L$(abs_builddir)/$(LIBCPUSET_DIR) -L$(abs_builddir)/$(LIBCONTROLLERS_DIR)
 
 LDLIBS			+= -lcpu_set -lcontrollers -lltp
+ifeq ($(LIBC),musl)
+LDLIBS			+= -lfts
+endif
 
 INSTALL_TARGETS		?= *.sh
 
-- 
2.7.0

