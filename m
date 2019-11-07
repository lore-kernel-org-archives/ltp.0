From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu,  7 Nov 2019 16:34:57 +0100
Subject: [LTP] [PATCH 1/2] Wrapper for Syzkaller reproducers
In-Reply-To: <20191107153458.16917-1-rpalethorpe@suse.com>
References: <20191107153458.16917-1-rpalethorpe@suse.com>
Message-ID: <20191107153458.16917-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Allows one to run the Syzkaller reproducers as part of the LTP.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 .gitmodules                                  |   5 +
 configure.ac                                 |  11 ++
 include/mk/features.mk.default               |   2 +
 include/mk/features.mk.in                    |   2 +
 runtest/.gitignore                           |   1 +
 testcases/kernel/Makefile                    |   1 +
 testcases/kernel/syzkaller-repros/.gitignore |   1 +
 testcases/kernel/syzkaller-repros/Makefile   | 100 ++++++++++++++
 testcases/kernel/syzkaller-repros/README.md  |  45 +++++++
 testcases/kernel/syzkaller-repros/syzwrap.c  | 133 +++++++++++++++++++
 10 files changed, 301 insertions(+)
 create mode 100644 runtest/.gitignore
 create mode 100644 testcases/kernel/syzkaller-repros/.gitignore
 create mode 100644 testcases/kernel/syzkaller-repros/Makefile
 create mode 100644 testcases/kernel/syzkaller-repros/README.md
 create mode 100644 testcases/kernel/syzkaller-repros/syzwrap.c

diff --git a/.gitmodules b/.gitmodules
index 1c9e9c38a..6a2d31f51 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -1,3 +1,8 @@
 [submodule "testcases/kernel/mce-test"]
 	path = testcases/kernel/mce-test
 	url = git://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/mce-test.git
+[submodule "testcases/linux-arts"]
+	path = testcases/linux-arts
+	url = https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-arts.git
+	shallow = true
+	ignore = all
diff --git a/configure.ac b/configure.ac
index 3785dff63..ec4cae483 100644
--- a/configure.ac
+++ b/configure.ac
@@ -184,6 +184,17 @@ else
     AC_SUBST([WITH_OPEN_POSIX_TESTSUITE],["no"])
 fi
 
+AC_ARG_WITH([syzkaller-repros],
+  [AC_HELP_STRING([--with-syzkaller-repros],
+    [compile and install Syzkaller reproducers (default=no)])],
+  [with_syzkaller_repros=$withval]
+)
+if test "x$with_syzkaller_repros" = xyes; then
+    AC_SUBST([WITH_SYZKALLER_REPROS],["yes"])
+else
+    AC_SUBST([WITH_SYZKALLER_REPROS],["no"])
+fi
+
 # testcases/realtime requires bash and python.
 if test "x$with_bash" = xyes && test "x$with_python" = xyes; then
     AC_ARG_WITH([realtime-testsuite],
diff --git a/include/mk/features.mk.default b/include/mk/features.mk.default
index 3a6cc5176..71fb48c60 100644
--- a/include/mk/features.mk.default
+++ b/include/mk/features.mk.default
@@ -47,3 +47,5 @@ WITH_REALTIME_TESTSUITE		:= no
 else
 WITH_REALTIME_TESTSUITE		:= no
 endif
+
+WITH_SYZKALLER_REPROS		:= no
diff --git a/include/mk/features.mk.in b/include/mk/features.mk.in
index 8e561b738..3ab7f4721 100644
--- a/include/mk/features.mk.in
+++ b/include/mk/features.mk.in
@@ -47,3 +47,5 @@ WITH_REALTIME_TESTSUITE		:= no
 else
 WITH_REALTIME_TESTSUITE		:= @WITH_REALTIME_TESTSUITE@
 endif
+
+WITH_SYZKALLER_REPROS		:= @WITH_SYZKALLER_REPROS@
diff --git a/runtest/.gitignore b/runtest/.gitignore
new file mode 100644
index 000000000..2ae05bfac
--- /dev/null
+++ b/runtest/.gitignore
@@ -0,0 +1 @@
+syzkaller*
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 3319b3163..0150cfb4f 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -53,6 +53,7 @@ SUBDIRS			+= connectors \
 			   sched \
 			   security \
 			   sound \
+			   syzkaller-repros \
 			   tracing \
 			   uevents \
 
diff --git a/testcases/kernel/syzkaller-repros/.gitignore b/testcases/kernel/syzkaller-repros/.gitignore
new file mode 100644
index 000000000..dbda1c71f
--- /dev/null
+++ b/testcases/kernel/syzkaller-repros/.gitignore
@@ -0,0 +1 @@
+syzwrap
diff --git a/testcases/kernel/syzkaller-repros/Makefile b/testcases/kernel/syzkaller-repros/Makefile
new file mode 100644
index 000000000..d40d61ac1
--- /dev/null
+++ b/testcases/kernel/syzkaller-repros/Makefile
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Linux Test Project
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+CFLAGS			+= -D_GNU_SOURCE
+
+ifeq ($(WITH_SYZKALLER_REPROS),yes)
+
+# The number of reproducers in each runtest file
+SYZKALLER_RUNFILES_SIZE ?= 100
+
+# Extra arguments to pass to syzwrap. Uncomment the below to add some
+# sandboxing.
+# SYZWRAP_ARGS ?= -s
+
+# Location where reproducers are installed
+SYZKALLER_INSTALL_DIR ?= $(abspath $(DESTDIR)/$(prefix)/testcases/bin)
+
+# If the reproducers directory is missing then we automatically clone the repo.
+# We then have to call make recursively to revaluate the targets
+SYZKALLER_REPROS_DIR ?= $(abs_top_srcdir)/testcases/linux-arts/syzkaller-repros/linux
+$(SYZKALLER_REPROS_DIR):
+	git submodule update --init $(abs_top_srcdir)/testcases/linux-arts
+	$(MAKE) syzkaller_runfiles
+
+SYZKALLER_REPROS_SRCS = $(wildcard $(SYZKALLER_REPROS_DIR)/*.c)
+
+# Some useful compiler flags for the LTP will cause problems with the
+# syzkaller repros so the repros have seperate flags
+SYZKALLER_CFLAGS ?= -pthread
+SYZKALLER_REPROS = $(subst $(abs_top_srcdir),$(abs_top_builddir),$(SYZKALLER_REPROS_SRCS:.c=))
+$(SYZKALLER_REPROS): %: %.c
+	-@if grep -q "__NR_mmap2" $^; then \
+		M32="-m32"; \
+	fi; \
+	$(CC) $(SYZKALLER_CFLAGS) $$M32 $(SYZKALLER_LDFLAGS) $^ -o $@; \
+	echo $(CC) $(SYZKALLER_CFLAGS) $$M32 $(SYZKALLER_LDFLAGS) $^ -o $@;
+
+# Generate the names of the runtest files. This uses Shell arithmetic to
+# calculate how many runtest files there will be.
+define SYZKALLER_RUNFILES !=
+	n=$(words $(SYZKALLER_REPROS));
+	m=$(SYZKALLER_RUNFILES_SIZE);
+	i=$$(( $$n / $$m + ($$n % $$m > 0) ));
+	while test $$i -gt 0;
+	do
+		echo $(top_srcdir)/runtest/syzkaller$$i;
+		i=$$(($$i - 1));
+	done
+endef
+
+# Get the index part of a runtest files name
+syz_n = $(subst $(top_srcdir)/runtest/syzkaller,,$(1))
+syz_m = $(SYZKALLER_RUNFILES_SIZE)
+# Gives the index of the first reproducer in a runtest file
+syz_i = $(shell echo $$((($(call syz_n,$(1)) - 1) * $(2) + 1)))
+# Gives the index of the last reproducer in a runtest file
+syz_j = $(shell echo $$(( $(call syz_i,$(1),$(2)) + $(2) - 1 )))
+# Gvien a runtest file name, get the reproducers it should contain
+syz_wordlist = $(wordlist $(call syz_i,$(1),$(syz_m)),$(call syz_j,$(1),$(syz_m)),$(SYZKALLER_REPROS))
+
+define syz_runfile_line
+$(notdir $(exe)) syzwrap $(SYZWRAP_ARGS) -d $(SYZKALLER_INSTALL_DIR) -n $(notdir $(exe))
+
+endef
+
+# Generate the runtest files based on the reproducer names and batch size.
+$(SYZKALLER_RUNFILES): $(SYZKALLER_REPROS)
+	@echo "Writing $@"
+	$(file >$@)
+	$(foreach exe,$(call syz_wordlist,$@),$(file >>$@,$(syz_runfile_line)))
+
+.PHONY: syzkaller_runfiles
+syzkaller_runfiles: $(SYZKALLER_RUNFILES) | $(SYZKALLER_REPROS_DIR)
+
+all: $(SYZKALLER_RUNFILES) | $(SYZKALLER_REPROS_DIR)
+
+# There are too many reproducers to pass all at once to rm, so we just pass
+# one at a time
+syzkaller_clean:
+	$(foreach f, $(SYZKALLER_REPROS), $(RM) $(f))
+CLEAN_DEPS += syzkaller_clean
+CLEAN_TARGETS += $(SYZKALLER_RUNFILES)
+
+INSTALL_MODE ?= 0775
+
+# For some reason part of the path is missing if we just try to install these
+# by adding them to INSTALL_FILES
+SYZKALLER_REPROS_INSTALLED := $(subst $(SYZKALLER_REPROS_DIR),$(SYZKALLER_INSTALL_DIR),$(SYZKALLER_REPROS))
+$(SYZKALLER_REPROS_INSTALLED): $(SYZKALLER_INSTALL_DIR)/%: $(SYZKALLER_REPROS_DIR)/%
+	install -m $(INSTALL_MODE) -T $< $@
+
+install: $(SYZKALLER_REPROS_INSTALLED)
+
+endif
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syzkaller-repros/README.md b/testcases/kernel/syzkaller-repros/README.md
new file mode 100644
index 000000000..2c88efd01
--- /dev/null
+++ b/testcases/kernel/syzkaller-repros/README.md
@@ -0,0 +1,45 @@
+# LTP wrapper for Syzkaller reproducers
+
+This allows you to run the autogenerated C bug reproducers from the Syzkaller
+fuzzer within the LTP framework. Meaning that you may use an existing test
+runner compatible with the LTP (with some constraints, see below).
+
+## Instructions
+
+1. Run `ltp/configure` with `--with-syzkaller-repros`.
+2. Build and install the LTP as normal.
+3. Run one or more of syzkallerN runtest files where N is a number.
+
+Make will automatically download the reproducers into `testcases/linux-arts`
+using git-submodule if necessary.
+
+By default each runtest file contains 100 reproducers. You may change this by
+overriding `SYZKALLER_RUNFILES_SIZE`.
+
+Extra parameters can be sent to syzwrap using `SYZWRAP_ARGS`. See `syzwrap
+-h`.
+
+## Kernel Requirements
+
+It is strongly recommended that you use KASAN and other debugging kernel
+features. See the Syzkaller documentation for the configuration you should
+use.
+
+## Test Runner Requirements
+
+Unlike most LTP tests these reproducers can leave your system in a broken
+state even if no bug is triggered.
+
+You will need to:
+
+A) Reboot the SUT
+B) Reset at least the root filesystem to a known good state
+
+Every time syzwrap fails. 
+
+If syzwrap fails with TBROK or fails to run@all, then you probably need to
+reset the system and rerun that test. If a test fails with TFAIL, you may also
+want to run it once again with a clean state.
+
+It might be the case that some reproducers write to random devices or do other
+things which can effect the outside world.
diff --git a/testcases/kernel/syzkaller-repros/syzwrap.c b/testcases/kernel/syzkaller-repros/syzwrap.c
new file mode 100644
index 000000000..9f5d16078
--- /dev/null
+++ b/testcases/kernel/syzkaller-repros/syzwrap.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
+ *
+ * Run a single reproducer generated by the Syzkaller fuzzer.
+ */
+
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/prctl.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <pwd.h>
+
+#include "tst_test.h"
+#include "tst_taint.h"
+#include "tst_safe_stdio.h"
+
+#define SANDBOX_HELP "\n"\
+	"-s\t Add some sandboxing around the reproducer. This will prevent some\n"\
+	"\t reproducers from creating network devices and thus prevent them from\n"\
+	"\t working. However it will also prevent some reproducers from trashing\n"\
+	"\t the system using root privileges. Note that you may generate the\n"\
+	"\t reproducers with various types of sandboxing built in using\n"\
+	"\t syz-reprolist"
+
+static char *dir;
+static char *name;
+static char *path;
+
+static char *sandbox;
+
+static struct tst_option options[] = {
+	{"d:", &dir, "\n-d PATH\t Mandatory directory containing reproducers"},
+	{"n:", &name, "-n NAME\t Mandatory executable name of reproducer"},
+	{"s", &sandbox, SANDBOX_HELP},
+	{NULL, NULL, NULL}
+};
+
+static void become_nobody(void)
+{
+	struct passwd *pw;
+	int gid, uid;
+
+	setgroups(0, NULL);
+
+	pw = getpwnam("nobody");
+	if (pw) {
+		gid = pw->pw_gid;
+		uid = pw->pw_uid;
+	} else {
+		gid = 65534;
+		uid = 65534;
+	}
+
+	SAFE_SETREGID(gid, gid);
+	SAFE_SETREUID(uid, uid);
+}
+
+static void setup(void)
+{
+	tst_taint_init(TST_TAINT_W | TST_TAINT_D | TST_TAINT_L);
+
+	if (!dir)
+		tst_brk(TBROK, "No reproducer directory specified");
+
+	if (!name)
+		tst_brk(TBROK, "No reproducer name specified");
+
+	tst_res(TINFO, "https://syzkaller.appspot.com/bug?id=%s", name);
+
+	SAFE_ASPRINTF(&path, "%s/%s", dir, name);
+	tst_res(TINFO, "%s", path);
+}
+
+static void run(void)
+{
+	unsigned int backoff = 100;
+	int rem, status, sent_kill = 0;
+	float exec_time_start = (float)tst_timeout_remaining();
+	int pid;
+
+	if (sandbox)
+		SAFE_UNSHARE(CLONE_NEWPID);
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		if (sandbox) {
+			SAFE_UNSHARE(CLONE_NEWNET);
+			become_nobody();
+		}
+
+		if (prctl(PR_SET_DUMPABLE, 1, 0, 0, 0)) {
+			tst_res(TWARN | TERRNO,
+				"Failed to set dumpable; won't be able to open /proc/self/*");
+		}
+
+		execl(path, name, NULL);
+		tst_brk(TBROK | TERRNO, "Failed to exec reproducer");
+	}
+
+	while (!waitpid(pid, &status, WNOHANG)) {
+		rem = tst_timeout_remaining();
+
+		if (!sent_kill && rem / exec_time_start < 0.5) {
+			tst_res(TINFO, "Timeout; killing reproducer");
+
+			TEST(kill(pid, SIGKILL));
+			if (TST_RET == -1)
+				tst_res(TWARN | TTERRNO, "kill() failed");
+			else
+				sent_kill = 1;
+		}
+
+		usleep(backoff);
+		backoff = MIN(2 * backoff, 1000000);
+	}
+
+	if (tst_taint_check()) {
+		tst_res(TFAIL, "Kernel is tainted");
+	} else {
+		tst_res(TPASS, "Kernel is not tainted");
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.options = options,
+	.needs_tmpdir = 1,
+	.forks_child = 1
+};
-- 
2.23.0

