From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri,  8 Mar 2019 13:42:57 +0100
Subject: [LTP] [PATCH 2/2 v2] libs: Hook up libs into the build system
In-Reply-To: <20190308124257.25282-1-chrubis@suse.cz>
References: <20190308124257.25282-1-chrubis@suse.cz>
Message-ID: <20190308124257.25282-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This hooks up libs/ subdirectories into the build system so that tests
needs only specify which library from libs/ directory we should link
againts. Which sets up the path to the library in LDFLAGS and also
causes the library to be rebuild even when make is executed from the
directory with testcases.

Now the test only needs to set up LTPLIBS variable with a list of
optional libraries to link against and LDLIBS, since as far as I know we
have to maintain the order of the libraries manually.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Jan Stancek <jstancek@redhat.com>
CC: Petr Vorel <pvorel@suse.cz>
---
 include/mk/testcases.mk                          | 16 +++++++++++++++-
 testcases/kernel/syscalls/set_mempolicy/Makefile |  3 ++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index bf97384a7..131854ec7 100644
--- a/include/mk/testcases.mk
+++ b/include/mk/testcases.mk
@@ -41,5 +41,19 @@ INSTALL_DIR	:= testcases/bin
 
 LDLIBS		+= -lltp
 
-$(APICMDS_DIR) $(LIBLTP_DIR): %:
+ifdef LTPLIBS
+
+LTPLIBS_DIRS = $(addprefix $(abs_top_builddir)/libs/lib, $(LTPLIBS))
+LTPLIBS_FILES = $(addsuffix .a, $(addprefix $(abs_top_builddir)/libs/, $(foreach LIB,$(LTPLIBS),lib$(LIB)/lib$(LIB))))
+
+MAKE_DEPS += $(LTPLIBS_FILES)
+
+$(LTPLIBS_FILES): $(LTPLIBS_DIRS)
+	$(MAKE) -C "$^" -f "$^/Makefile" all
+
+LDFLAGS += $(addprefix -L$(top_builddir)/libs/lib, $(LTPLIBS))
+
+endif
+
+$(LTPLIBS_DIRS) $(APICMDS_DIR) $(LIBLTP_DIR): %:
 	mkdir -p "$@"
diff --git a/testcases/kernel/syscalls/set_mempolicy/Makefile b/testcases/kernel/syscalls/set_mempolicy/Makefile
index b79a53faf..a0b79d6e1 100644
--- a/testcases/kernel/syscalls/set_mempolicy/Makefile
+++ b/testcases/kernel/syscalls/set_mempolicy/Makefile
@@ -1,8 +1,9 @@
 top_srcdir		?= ../../../..
 
+LTPLIBS = ltpnuma
+
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDFLAGS += -L$(top_builddir)/libs/libltpnuma
 LDLIBS  += $(NUMA_LIBS) -lltpnuma
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.19.2

