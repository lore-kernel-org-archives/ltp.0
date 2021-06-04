From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 4 Jun 2021 16:11:52 +0200
Subject: [LTP] [RFC PATCH v2 1/2] Add 'make check' and clang-check to
 build system
In-Reply-To: <YLo0XKY9b+S2ROQQ@pevik>
References: <20210604111434.21422-1-rpalethorpe@suse.com>
 <20210604111434.21422-2-rpalethorpe@suse.com>
 <YLo0XKY9b+S2ROQQ@pevik>
Message-ID: <YLo0qHmuGHSCTOTN@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> make -C "/home/pvorel/install/src/ltp.git/lib" -f "/src/ltp/lib/Makefile" all
> make[1]: Entering directory '/src/ltp/lib'
> make[2]: Nothing to be done for 'all'.
> make[2]: Nothing to be done for 'all'.
> make[1]: Leaving directory '/src/ltp/lib'
> CC testcases/kernel/syscalls/chown/chown01.o
> LD testcases/kernel/syscalls/chown/chown01
> CC testcases/kernel/syscalls/chown/chown02.o
> LD testcases/kernel/syscalls/chown/chown02
> CC testcases/kernel/syscalls/chown/chown03.o
> LD testcases/kernel/syscalls/chown/chown03
> CC testcases/kernel/syscalls/chown/chown04.o
> LD testcases/kernel/syscalls/chown/chown04
> CC testcases/kernel/syscalls/chown/chown05.o
> LD testcases/kernel/syscalls/chown/chown05
> make: *** No rule to make target 'chown01_16.c', needed by 'chown01_16'.  Stop.
> rm chown01.o chown03.o chown02.o chown05.o chown04.o
> 
> This is a newly introduced failure caused by some change in include/mk/ in this
> commit.

This is caused by the definition of CHECK_TARGETS in the env_post.mk,
the foo_16 binaries are generated from foo.c sources and there is no
foo_16.c which in turn confuses the check code. I.e. what this means is
that MAKE_TARGETS != list of sources without suffix and we have to do:

diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index 8903a934d..c6367b0a5 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -89,7 +89,7 @@ $(error You must define $$(prefix) before executing install)
 endif # END $(filter-out install,$(MAKECMDGOALS)),$(MAKECMDGOALS)
 endif
 
-CHECK_TARGETS                  ?= $(addprefix check-,$(MAKE_TARGETS))
+CHECK_TARGETS                  ?= $(addprefix check-, $(patsubst %.c,%,$(sort $(wildcard $(abs_srcdir)/*.c))))
 CHECK                          ?= $(abs_top_srcdir)/tools/clang-check/main
 CHECK_FLAGS                    ?= -resource-dir $(shell $(CLANG) -print-resource-dir)


> Also make check on regular test expect it's a library. IMHO these two must be
> probably separated:
> 
> $ cd testcases/kernel/syscalls/fchown/ && make check
> CHECK testcases/kernel/syscalls/fchown/fchown01.c
> CHECK testcases/kernel/syscalls/fchown/fchown02.c
> CHECK testcases/kernel/syscalls/fchown/fchown03.c
> CHECK testcases/kernel/syscalls/fchown/fchown04.c
> fchown05.c:80:4: CHECK ERROR: TEST() macro should not be used in library
> make: *** [../../../../include/mk/rules.mk:46: check-fchown05] Error 1

I guess that we can pass different flags to the binary so that it gets
the context right.

-- 
Cyril Hrubis
chrubis@suse.cz
