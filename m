From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 3 Aug 2020 09:47:46 +0200
Subject: [LTP] [PATCH 1/3] build system: Add explicit make rules
In-Reply-To: <20200731121508.12805-2-chrubis@suse.cz>
Message-ID: <550701550.5736445.1596440755258.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> This commit adds explicit build rules, the main motivation are recent
> build failures caused by library orderings. To fix that this commit
> introduces LTPLDLIBS special variable that is passed to linker before
> the LDLIBS which avoids the need for tricks as
> "LDLIBS := -lltpfoo $(LDLIBS)" in the Makefiles.
> 
> This commit also silences the output by default a bit, the verbose
> output could be enabled by VERBOSE=1 env variable, which is probably
> what most of the build systems will do if this gets commited. I guess
> that we can as well silence a bit the "make entering/leaving directory"
> if this the right way to go.

alias for V=0 / V=1 would be nice

LTPLDLIBS should probably be mentioned in doc/build-system-guide.txt


> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/mk/env_post.mk |  2 ++
>  include/mk/rules.mk    | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 include/mk/rules.mk
> 
> diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
> index f4169ad66..bdf8c696d 100644
> --- a/include/mk/env_post.mk
> +++ b/include/mk/env_post.mk
> @@ -107,4 +107,6 @@ $(error You must define $$(prefix) before executing
> install)
>  endif # END $(filter-out install,$(MAKECMDGOALS)),$(MAKECMDGOALS)
>  endif
>  
> +include $(top_srcdir)/include/mk/rules.mk
> +
>  endif
> diff --git a/include/mk/rules.mk b/include/mk/rules.mk
> new file mode 100644
> index 000000000..e9b9c35ef
> --- /dev/null
> +++ b/include/mk/rules.mk
> @@ -0,0 +1,29 @@
> +%.o: %.c
> +ifdef VERBOSE
> +	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
> +else
> +	@$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
> +	@echo CC $@
> +endif

What if we wouldn't print "DIR" (for non-clean targets) and printed relative paths instead?

CC lib/tst_timer_test.o
CC lib/tst_checkpoint.o
CC lib/tst_supported_fs_types.o
...
CC lib/tests/tst_dataroot03
CC lib/tests/tst_strerrno
..
CC lib/newlib_tests/test07
CC lib/newlib_tests/test13
CC lib/newlib_tests/test11
..
CC testcases/kernel/syscalls/execv/execv01_child
CC testcases/kernel/syscalls/execv/execv01
CC testcases/kernel/syscalls/exit/exit01
CC testcases/kernel/syscalls/exit/exit02
CC testcases/kernel/syscalls/setresgid/setresgid02.o
LD testcases/kernel/syscalls/setresgid/setresgid02
CC testcases/kernel/syscalls/setresgid/setresgid03.o
LD testcases/kernel/syscalls/setresgid/setresgid03



diff --git a/include/mk/env_pre.mk b/include/mk/env_pre.mk
index c4a1f470810e..abc7e7cf9e02 100644
--- a/include/mk/env_pre.mk
+++ b/include/mk/env_pre.mk
@@ -79,7 +79,9 @@ builddir			:= .
 
 abs_builddir			:= $(CURDIR)
 
-cwd_rel_from_top		:= $(subst $(abs_top_builddir),,$(abs_builddir))
+cwd_rel1			:= $(subst $(abs_top_builddir),,$(abs_builddir))
+cwd_rel2			:= $(subst $(abs_top_builddir)/,,$(abs_builddir))
+cwd_rel_from_top		:= $(if $(cwd_rel1),$(cwd_rel2),$(cwd_rel1))
 
 # Where's the source located at? Squish all of the / away by using abspath...
 ifdef MAKE_3_80_COMPAT
diff --git a/include/mk/generic_trunk_target.inc b/include/mk/generic_trunk_target.inc
index e89c7f4e0028..fc59f944fc14 100644
--- a/include/mk/generic_trunk_target.inc
+++ b/include/mk/generic_trunk_target.inc
@@ -103,7 +103,6 @@ ifdef VERBOSE
 	done
 else
 	@set -e; for dir in $(SUBDIRS); do \
-	    echo "DIR $$dir"; \
 	    $(MAKE) --no-print-directory -C $$dir -f "$(abs_srcdir)/$$dir/Makefile" $@; \
 	done
 endif
diff --git a/include/mk/rules.mk b/include/mk/rules.mk
index e9b9c35ef224..6a22e43af7ec 100644
--- a/include/mk/rules.mk
+++ b/include/mk/rules.mk
@@ -1,15 +1,17 @@
+target_rel_dir := $(if $(cwd_rel_from_top),$(cwd_rel_from_top)/,)
+
 %.o: %.c
 ifdef VERBOSE
 	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
 else
 	@$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
-	@echo CC $@
+	@echo CC $(target_rel_dir)$@
 endif
 
 ifdef VERBOSE
 COMPILE.c=$(CC) $(CPPFLAGS) $(CFLAGS) -c
 else
-COMPILE.c=@echo CC $@; $(CC) $(CPPFLAGS) $(CFLAGS) -c
+COMPILE.c=@echo CC $(target_rel_dir)$@; $(CC) $(CPPFLAGS) $(CFLAGS) -c
 endif
 
 %: %.o
@@ -17,7 +19,7 @@ ifdef VERBOSE
 	$(CC) $(LDFLAGS) $^ $(LTPLDLIBS) $(LDLIBS) -o $@
 else
 	@$(CC) $(LDFLAGS) $^ $(LTPLDLIBS) $(LDLIBS) -o $@
-	@echo LD $@
+	@echo LD $(target_rel_dir)$@
 endif
 
 %: %.c
@@ -25,5 +27,5 @@ ifdef VERBOSE
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ $(LTPLDLIBS) $(LDLIBS) -o $@
 else
 	@$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ $(LTPLDLIBS) $(LDLIBS) -o $@
-	@echo CC $@
+	@echo CC $(target_rel_dir)$@
 endif

