From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 Jul 2020 14:15:08 +0200
Subject: [LTP] [PATCH 3/3] build system: Silence the output a bit more
In-Reply-To: <20200731121508.12805-1-chrubis@suse.cz>
References: <20200731121508.12805-1-chrubis@suse.cz>
Message-ID: <20200731121508.12805-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This hides a few more messages, mostly make entering/leaving directory
and the empty library check.

Now rebuilding a ltp library and test looks like:

$ make
BUILD libltpsigwait.a
CC sigwait.o
ar -rc "libltpsigwait.a" sigwait.o
ranlib "libltpsigwait.a"
CC sigwait01

While previously (or with a VERBOSE=1) it looks like:

$ VERBOSE=1 make
make -C "/home/metan/Work/ltp-dev/libs/libltpsigwait/" -f "/home/metan/Work/ltp-dev/libs/libltpsigwait//Makefile" all
make[1]: Entering directory '/home/metan/Work/ltp-dev/libs/libltpsigwait'
gcc  -I../../include -I../../include -I../../include/old/ -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -c -o sigwait.o sigwait.c
ar -rc "libltpsigwait.a" sigwait.o
ranlib "libltpsigwait.a"
make[1]: Leaving directory '/home/metan/Work/ltp-dev/libs/libltpsigwait'
gcc  -I../../../../include -I../../../../include -I../../../../include/old/ -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition   -L../../../../libs/libltpsigwait -L../../../../lib sigwait01.c -lltpsigwait  -lltp -o sigwait01

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/mk/generic_trunk_target.inc | 14 ++++++++++++++
 include/mk/lib.mk                   |  2 +-
 include/mk/testcases.mk             |  5 +++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/mk/generic_trunk_target.inc b/include/mk/generic_trunk_target.inc
index cc255c62a..e89c7f4e0 100644
--- a/include/mk/generic_trunk_target.inc
+++ b/include/mk/generic_trunk_target.inc
@@ -75,9 +75,16 @@ trunk-install: $(INSTALL_FILES)
 all: trunk-all
 
 clean:: trunk-clean
+ifdef VERBOSE
 	@set -e; for dir in $(SUBDIRS); do \
 	    $(MAKE) -C "$$dir" -f "$(abs_srcdir)/$$dir/Makefile" $@; \
 	done
+else
+	@set -e; for dir in $(SUBDIRS); do \
+	    echo "DIR $$dir"; \
+	    $(MAKE) --no-print-directory -C "$$dir" -f "$(abs_srcdir)/$$dir/Makefile" $@; \
+	done
+endif
 ifneq ($(abs_builddir),$(abs_srcdir))
 	$(RM) -Rf $(SUBDIRS)
 endif
@@ -90,9 +97,16 @@ ifeq ($(strip $(SUBDIRS)),)
 	$(error SUBDIRS empty -- did you want generic_leaf_target instead?)
 else
 $(RECURSIVE_TARGETS): %: | $(SUBDIRS)
+ifdef VERBOSE
 	@set -e; for dir in $(SUBDIRS); do \
 	    $(MAKE) -C $$dir -f "$(abs_srcdir)/$$dir/Makefile" $@; \
 	done
+else
+	@set -e; for dir in $(SUBDIRS); do \
+	    echo "DIR $$dir"; \
+	    $(MAKE) --no-print-directory -C $$dir -f "$(abs_srcdir)/$$dir/Makefile" $@; \
+	done
+endif
 endif
 
 # vim: syntax=make
diff --git a/include/mk/lib.mk b/include/mk/lib.mk
index 36e1ba17b..5c310b42a 100644
--- a/include/mk/lib.mk
+++ b/include/mk/lib.mk
@@ -63,7 +63,7 @@ LIBSRCS		:= $(filter-out $(FILTER_OUT_LIBSRCS),$(LIBSRCS))
 LIBOBJS		:= $(LIBSRCS:.c=.o)
 
 $(LIB): $(notdir $(LIBOBJS))
-	if [ -z "$(strip $^)" ] ; then \
+	@if [ -z "$(strip $^)" ] ; then \
 		echo "Cowardly refusing to create empty archive"; \
 		exit 1; \
 	fi
diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index bb22be82e..1c81773d0 100644
--- a/include/mk/testcases.mk
+++ b/include/mk/testcases.mk
@@ -53,7 +53,12 @@ MAKE_DEPS += $(LTPLIBS_FILES)
 $(LTPLIBS_FILES): $(LTPLIBS_DIRS)
 
 $(LTPLIBS_FILES): %:
+ifdef VERBOSE
 	$(MAKE) -C "$(dir $@)" -f "$(subst $(abs_top_builddir),$(abs_top_srcdir),$(dir $@))/Makefile" all
+else
+	@echo "BUILD $(notdir $@)"
+	@$(MAKE) --no-print-directory -C "$(dir $@)" -f "$(subst $(abs_top_builddir),$(abs_top_srcdir),$(dir $@))/Makefile" all
+endif
 
 LDFLAGS += $(addprefix -L$(top_builddir)/libs/lib, $(LTPLIBS))
 
-- 
2.26.2

