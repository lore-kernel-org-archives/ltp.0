From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Jun 2020 11:52:04 +0200
Subject: [LTP] [PATCH V2 3/5] syscalls: semctl: Add new test to verify
 the _time_high fields
In-Reply-To: <20200616064047.7njwpmlmxzyoikwo@vireshk-i7>
References: <5d502fbc7070644ed83c423713941b457c3a7aff.1590057824.git.viresh.kumar@linaro.org>
 <7d7363384b5719fa48a5a5ba71b0aa581ebc91bd.1590131635.git.viresh.kumar@linaro.org>
 <20200615133125.GC25279@yuki.lan>
 <20200616064047.7njwpmlmxzyoikwo@vireshk-i7>
Message-ID: <20200616095204.GA6239@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/ipc/semctl/Makefile b/testcases/kernel/syscalls/ipc/semctl/Makefile
> index 6895fb1967a1..d7002872ab42 100644
> --- a/testcases/kernel/syscalls/ipc/semctl/Makefile
> +++ b/testcases/kernel/syscalls/ipc/semctl/Makefile
> @@ -3,7 +3,7 @@
>  
>  top_srcdir              ?= ../../../../..
>  
> -LTPLIBS = ltpipc
> +LTPLIBS = ltpipc ltpnewipc
>  
>  include $(top_srcdir)/include/mk/testcases.mk
>  
> @@ -11,4 +11,4 @@ semctl01 semctl02 semctl03 semctl04 semctl05 semctl06 semctl07: LDLIBS += -lltpi
>  semctl08: LDLIBS += -lltpnewipc
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> -LDFLAGS += -L$(top_builddir)/libs/libltpnewipc
> 
> This doesn't build for some reason.
> 
> make -C "/mnt/ssd/all/work/repos/tools/ltp/libs/libltpipc /mnt/ssd/all/work/repos/tools/ltp/libs/libltpnewipc" -f "/mnt/ssd/all/work/repos/tools/ltp/libs/libltpipc /mnt/ssd/all/work/repos/tools/ltp/libs/libltpnewipc/Makefile" all
> make[1]: *** /mnt/ssd/all/work/repos/tools/ltp/libs/libltpipc /mnt/ssd/all/work/repos/tools/ltp/libs/libltpnewipc: No such file or directory.  Stop.
> ../../../../../include/mk/testcases.mk:52: recipe for target '/mnt/ssd/all/work/repos/tools/ltp/libs/libltpnewipc/libltpnewipc.a' failed
> make: *** [/mnt/ssd/all/work/repos/tools/ltp/libs/libltpnewipc/libltpnewipc.a] Error 2

Ah, right, the rule that rebuilds the libraries does not work correctly
for more than one library because I do pass "$^" there which is the list
of directories and not a single directory.

As a quick hack this should fix it:

diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
index 684655fbf..7e0ec13f9 100644
--- a/include/mk/testcases.mk
+++ b/include/mk/testcases.mk
@@ -49,7 +49,9 @@ LTPLIBS_FILES = $(addsuffix .a, $(addprefix $(abs_top_builddir)/libs/, $(foreach
 MAKE_DEPS += $(LTPLIBS_FILES)
 
 $(LTPLIBS_FILES): $(LTPLIBS_DIRS)
-       $(MAKE) -C "$^" -f "$(subst $(abs_top_builddir),$(abs_top_srcdir),$^)/Makefile" all
+       for dir in $^; do \
+               $(MAKE) -C "$$dir" -f "$(subst $(abs_top_builddir),$(abs_top_srcdir),$$dir)/Makefile" all; \
+       done
 
 LDFLAGS += $(addprefix -L$(top_builddir)/libs/lib, $(LTPLIBS))


This does not parallelize the build but I guess that it would be fine since
when we rebuild LTP from top directory the libraries are build first anyways
and this is no-op.

-- 
Cyril Hrubis
chrubis@suse.cz
