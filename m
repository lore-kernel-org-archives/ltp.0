From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  2 Sep 2021 12:37:39 +0200
Subject: [LTP] [PATCH 3/4] rules.mk: Add checkbashisms to 'make check' for
 *.sh
In-Reply-To: <20210902103740.19446-1-pvorel@suse.cz>
References: <20210902103740.19446-1-pvorel@suse.cz>
Message-ID: <20210902103740.19446-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Similarly to 3c83485d1 it runs checkbashisms part of 'make check' and
'make check-$TCID.sh' for particular script only, e.g. 'make
check-tst_net.sh' (deliberately kept *.sh suffix to be different for C
targets, because shell targets itself does not have make target).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/mk/env_post.mk              | 2 ++
 include/mk/generic_leaf_target.inc  | 2 +-
 include/mk/generic_trunk_target.inc | 2 +-
 include/mk/rules.mk                 | 9 +++++++++
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index eb76b38a4..ec045c40d 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -93,6 +93,8 @@ CHECK_TARGETS			?= $(addprefix check-,$(notdir $(patsubst %.c,%,$(sort $(wildcar
 CHECK_TARGETS			:= $(filter-out $(addprefix check-, $(FILTER_OUT_MAKE_TARGETS)), $(CHECK_TARGETS))
 CHECK				?= $(abs_top_srcdir)/tools/sparse/sparse-ltp
 CHECK_NOFLAGS			?= $(abs_top_srcdir)/scripts/checkpatch.pl -f --no-tree --terse --no-summary --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING
+SHELL_CHECK			?= $(abs_top_srcdir)/scripts/checkbashisms.pl --force --extra
+SHELL_CHECK_TARGETS		?= $(addprefix check-,$(notdir $(sort $(wildcard $(abs_srcdir)/*.sh))))
 
 ifeq ($(CHECK),$(abs_top_srcdir)/tools/sparse/sparse-ltp)
 CHECK_DEPS			+= $(CHECK)
diff --git a/include/mk/generic_leaf_target.inc b/include/mk/generic_leaf_target.inc
index aa092a5a3..33e9c9ea0 100644
--- a/include/mk/generic_leaf_target.inc
+++ b/include/mk/generic_leaf_target.inc
@@ -110,6 +110,6 @@ $(INSTALL_FILES): | $(INSTALL_DEPS)
 install: $(INSTALL_FILES)
 
 $(CHECK_TARGETS): | $(CHECK_DEPS)
-check: $(CHECK_TARGETS)
+check: $(CHECK_TARGETS) $(SHELL_CHECK_TARGETS)
 
 # vim: syntax=make
diff --git a/include/mk/generic_trunk_target.inc b/include/mk/generic_trunk_target.inc
index 32a108fbf..82aece7c0 100644
--- a/include/mk/generic_trunk_target.inc
+++ b/include/mk/generic_trunk_target.inc
@@ -69,7 +69,7 @@ $(INSTALL_FILES): | $(INSTALL_DEPS)
 trunk-install: $(INSTALL_FILES)
 
 $(CHECK_TARGETS): | $(CHECK_DEPS)
-trunk-check: $(CHECK_TARGETS)
+trunk-check: $(CHECK_TARGETS) $(SHELL_CHECK_TARGETS)
 
 # Avoid creating duplicate .PHONY references to all, clean, and install. IIRC,
 # I've seen some indeterministic behavior when one does this in the past with
diff --git a/include/mk/rules.mk b/include/mk/rules.mk
index 6bd184841..a60e6705a 100644
--- a/include/mk/rules.mk
+++ b/include/mk/rules.mk
@@ -48,3 +48,12 @@ else
 	@-$(CHECK_NOFLAGS) $<
 	@-$(CHECK) $(CHECK_FLAGS) $(CPPFLAGS) $(CFLAGS) $<
 endif
+
+.PHONY: $(SHELL_CHECK_TARGETS)
+$(SHELL_CHECK_TARGETS): check-%.sh: %.sh
+ifdef VERBOSE
+	-$(SHELL_CHECK) $<
+else
+	@echo CHECK $(target_rel_dir)$<
+	@-$(SHELL_CHECK) $<
+endif
-- 
2.33.0

