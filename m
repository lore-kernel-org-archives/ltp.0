From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 20 Mar 2019 11:07:23 +0100
Subject: [LTP] [PATCH] libs: fix sporadic out-of-tree build failures related
	to libs
Message-ID: <3fedf790971b876b20533ee3d6b5dff27b54fae3.1553076284.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Petr reported that out-of-tree builds are sporadically failing:
  make[4]: Entering directory '/usr/src/ltp-build/testcases/kernel/syscalls/set_mempolicy'
  make -C "/usr/src/ltp-build/libs/libltpnuma" -f "/usr/src/ltp-build/libs/libltpnuma/Makefile" all
  make[5]: Entering directory '/usr/src/ltp-build/libs/libltpnuma'
  make[5]: /usr/src/ltp-build/libs/libltpnuma/Makefile: No such file or directory
  make[5]: *** No rule to make target '/usr/src/ltp-build/libs/libltpnuma/Makefile'.  Stop.

It can be triggered reliably by:
    make -C $(pwd)/../ltp-build/testcases/kernel/syscalls/set_mempolicy/ \
    -f $(pwd)/testcases/kernel/syscalls/set_mempolicy/Makefile \
    top_srcdir=$(pwd) top_builddir=$(pwd)/../ltp-build

This happens when libltpnuma is pulled in as dependency and it's not built yet.
Make rules construct path for Makefile based on abs_top_builddir rather
than abs_top_srcdir:
  $(LTPLIBS_FILES): $(LTPLIBS_DIRS)
          $(MAKE) -C "$^" -f "$^/Makefile" all

Fix that by making LTPLIBS_DIRS relative, and add top_{build/src}dir
prefix where appropriate. This also moves LTPLIBS_DIRS mkdir target
into 'ifdef LTPLIBS' block.

Reported-by: Petr Vorel <pvorel@suse.cz>
Cc: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/mk/testcases.mk | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index 131854ec7346..4cbb37640687 100644
--- a/include/mk/testcases.mk
+++ b/include/mk/testcases.mk
@@ -43,17 +43,19 @@ LDLIBS		+= -lltp
 
 ifdef LTPLIBS
 
-LTPLIBS_DIRS = $(addprefix $(abs_top_builddir)/libs/lib, $(LTPLIBS))
+LTPLIBS_DIRS = $(addprefix libs/lib, $(LTPLIBS))
 LTPLIBS_FILES = $(addsuffix .a, $(addprefix $(abs_top_builddir)/libs/, $(foreach LIB,$(LTPLIBS),lib$(LIB)/lib$(LIB))))
 
 MAKE_DEPS += $(LTPLIBS_FILES)
 
 $(LTPLIBS_FILES): $(LTPLIBS_DIRS)
-	$(MAKE) -C "$^" -f "$^/Makefile" all
+	$(MAKE) -C "$(abs_top_builddir)/$^" -f "$(abs_top_srcdir)/$^/Makefile" all
 
 LDFLAGS += $(addprefix -L$(top_builddir)/libs/lib, $(LTPLIBS))
 
+$(LTPLIBS_DIRS): %:
+	mkdir -p "$(abs_top_builddir)/$@"
 endif
 
-$(LTPLIBS_DIRS) $(APICMDS_DIR) $(LIBLTP_DIR): %:
+$(APICMDS_DIR) $(LIBLTP_DIR): %:
 	mkdir -p "$@"
-- 
1.8.3.1

