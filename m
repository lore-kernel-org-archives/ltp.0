From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Jun 2020 14:41:13 +0200
Subject: [LTP] [COMMITTED] [PATCH] testcases.mk: Fix LTPLIBS build rule
Message-ID: <20200616124113.14808-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The current code that attempts to rebuild libraries a test is depending
on is broken for more than one library since the "$^" is a list of all
prerequisities.

This fixes the problem by adding a proper pattern rule.

I've also added the libraries to the .PHONY target so that we attempt to
rebuild them regardless of the library archive existence since we do not
know the prerequisities of the library archive in the testcase directory
we cannot tell if some of the sources has been changed so the safest
course of action is to attempt the rebuild every time.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/mk/testcases.mk | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index 684655fbf..bb22be82e 100644
--- a/include/mk/testcases.mk
+++ b/include/mk/testcases.mk
@@ -48,8 +48,12 @@ LTPLIBS_FILES = $(addsuffix .a, $(addprefix $(abs_top_builddir)/libs/, $(foreach
 
 MAKE_DEPS += $(LTPLIBS_FILES)
 
+.PHONY: $(LTPLIBS_FILES)
+
 $(LTPLIBS_FILES): $(LTPLIBS_DIRS)
-	$(MAKE) -C "$^" -f "$(subst $(abs_top_builddir),$(abs_top_srcdir),$^)/Makefile" all
+
+$(LTPLIBS_FILES): %:
+	$(MAKE) -C "$(dir $@)" -f "$(subst $(abs_top_builddir),$(abs_top_srcdir),$(dir $@))/Makefile" all
 
 LDFLAGS += $(addprefix -L$(top_builddir)/libs/lib, $(LTPLIBS))
 
-- 
2.26.2

