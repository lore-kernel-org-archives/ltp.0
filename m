From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 Jul 2020 14:15:06 +0200
Subject: [LTP] [PATCH 1/3] build system: Add explicit make rules
In-Reply-To: <20200731121508.12805-1-chrubis@suse.cz>
References: <20200731121508.12805-1-chrubis@suse.cz>
Message-ID: <20200731121508.12805-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commit adds explicit build rules, the main motivation are recent
build failures caused by library orderings. To fix that this commit
introduces LTPLDLIBS special variable that is passed to linker before
the LDLIBS which avoids the need for tricks as
"LDLIBS := -lltpfoo $(LDLIBS)" in the Makefiles.

This commit also silences the output by default a bit, the verbose
output could be enabled by VERBOSE=1 env variable, which is probably
what most of the build systems will do if this gets commited. I guess
that we can as well silence a bit the "make entering/leaving directory"
if this the right way to go.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/mk/env_post.mk |  2 ++
 include/mk/rules.mk    | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 include/mk/rules.mk

diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index f4169ad66..bdf8c696d 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -107,4 +107,6 @@ $(error You must define $$(prefix) before executing install)
 endif # END $(filter-out install,$(MAKECMDGOALS)),$(MAKECMDGOALS)
 endif
 
+include $(top_srcdir)/include/mk/rules.mk
+
 endif
diff --git a/include/mk/rules.mk b/include/mk/rules.mk
new file mode 100644
index 000000000..e9b9c35ef
--- /dev/null
+++ b/include/mk/rules.mk
@@ -0,0 +1,29 @@
+%.o: %.c
+ifdef VERBOSE
+	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
+else
+	@$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
+	@echo CC $@
+endif
+
+ifdef VERBOSE
+COMPILE.c=$(CC) $(CPPFLAGS) $(CFLAGS) -c
+else
+COMPILE.c=@echo CC $@; $(CC) $(CPPFLAGS) $(CFLAGS) -c
+endif
+
+%: %.o
+ifdef VERBOSE
+	$(CC) $(LDFLAGS) $^ $(LTPLDLIBS) $(LDLIBS) -o $@
+else
+	@$(CC) $(LDFLAGS) $^ $(LTPLDLIBS) $(LDLIBS) -o $@
+	@echo LD $@
+endif
+
+%: %.c
+ifdef VERBOSE
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ $(LTPLDLIBS) $(LDLIBS) -o $@
+else
+	@$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ $(LTPLDLIBS) $(LDLIBS) -o $@
+	@echo CC $@
+endif
-- 
2.26.2

