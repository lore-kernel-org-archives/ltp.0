From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 Apr 2019 15:38:35 +0200
Subject: [LTP] [PATCH 1/2] testcases.mk: Fix libs/ path for out-of-tree build
Message-ID: <20190430133836.28400-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The path to the Makefile was not correct for the out-of-tree build
because it was pointing to the build directory rather than to the source
directory.

Apparently this also caused random failures for out-of-tree build. For
some reason when building syscalls/set_mempolicy/ testcases the rebuild
of the libltpnuma.a library is triggered for out-of-tree build for about
10% of the cases on massively parallel build. Which as far as I can tell
shouldn't happen since we build everything in the libs/ directory as a
prerequisite of the testcases/ directory. So there is likely some
strange race condition happening and while this does not fix the actual
race it makes it quite harmless since the target was already build and
the make in the libs/libltpnuma/ directory will be no-op.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Petr Vorel <pvorel@suse.cz>
CC: Jan Stancek <jstancek@redhat.com>
---
 include/mk/testcases.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index 131854ec7..684655fbf 100644
--- a/include/mk/testcases.mk
+++ b/include/mk/testcases.mk
@@ -49,7 +49,7 @@ LTPLIBS_FILES = $(addsuffix .a, $(addprefix $(abs_top_builddir)/libs/, $(foreach
 MAKE_DEPS += $(LTPLIBS_FILES)
 
 $(LTPLIBS_FILES): $(LTPLIBS_DIRS)
-	$(MAKE) -C "$^" -f "$^/Makefile" all
+	$(MAKE) -C "$^" -f "$(subst $(abs_top_builddir),$(abs_top_srcdir),$^)/Makefile" all
 
 LDFLAGS += $(addprefix -L$(top_builddir)/libs/lib, $(LTPLIBS))
 
-- 
2.19.2

