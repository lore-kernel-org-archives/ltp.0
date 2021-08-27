From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 27 Aug 2021 10:52:10 +0100
Subject: [LTP] [PATCH 2/2] Add CHECK_NOFLAGS and checkpatch.pl to 'make
 check'
In-Reply-To: <20210827095210.23602-1-rpalethorpe@suse.com>
References: <20210827095210.23602-1-rpalethorpe@suse.com>
Message-ID: <20210827095210.23602-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add another check command type. CHECK_NOFLAGS just takes the source
file name as an argument. By default it is set to
scripts/checkpatch.pl which is probably the only thing we want to use
it for. OTOH you can set it to clang-tidy instead.

It is run with '-' because of the large number of errors it presently
produces. Also of course, check errors are not actually fatal. If we
wish to stop on errors in the future (e.g. for CI) then a "strict"
option can be introduced.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/mk/env_post.mk | 1 +
 include/mk/rules.mk    | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index 4722da907..eb76b38a4 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -92,6 +92,7 @@ endif
 CHECK_TARGETS			?= $(addprefix check-,$(notdir $(patsubst %.c,%,$(sort $(wildcard $(abs_srcdir)/*.c)))))
 CHECK_TARGETS			:= $(filter-out $(addprefix check-, $(FILTER_OUT_MAKE_TARGETS)), $(CHECK_TARGETS))
 CHECK				?= $(abs_top_srcdir)/tools/sparse/sparse-ltp
+CHECK_NOFLAGS			?= $(abs_top_srcdir)/scripts/checkpatch.pl -f --no-tree --terse --no-summary --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING
 
 ifeq ($(CHECK),$(abs_top_srcdir)/tools/sparse/sparse-ltp)
 CHECK_DEPS			+= $(CHECK)
diff --git a/include/mk/rules.mk b/include/mk/rules.mk
index 2a04b2b67..6bd184841 100644
--- a/include/mk/rules.mk
+++ b/include/mk/rules.mk
@@ -41,8 +41,10 @@ endif
 .PHONY: $(CHECK_TARGETS)
 $(CHECK_TARGETS): check-%: %.c
 ifdef VERBOSE
-	$(CHECK) $(CHECK_FLAGS) $(CPPFLAGS) $(CFLAGS) $<
+	-$(CHECK_NOFLAGS) $<
+	-$(CHECK) $(CHECK_FLAGS) $(CPPFLAGS) $(CFLAGS) $<
 else
-	@$(CHECK) $(CHECK_FLAGS) $(CPPFLAGS) $(CFLAGS) $<
 	@echo CHECK $(target_rel_dir)$<
+	@-$(CHECK_NOFLAGS) $<
+	@-$(CHECK) $(CHECK_FLAGS) $(CPPFLAGS) $(CFLAGS) $<
 endif
-- 
2.31.1

