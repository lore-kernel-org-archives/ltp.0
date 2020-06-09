From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 9 Jun 2020 18:59:21 +0200
Subject: [LTP] [PATCH v3] Wrapper for Syzkaller reproducers
In-Reply-To: <20200609113421.10936-1-rpalethorpe@suse.com>
References: <20200609113421.10936-1-rpalethorpe@suse.com>
Message-ID: <20200609165921.GA28805@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> So this has now being floating in limbo for some time. My preference is to
> merge it to make it easy for users to try out with plenty of time before the
> next LTP release. It shouldn't break anything because it is hidden behind a
> configure switch.
+1

Reviewed-by: Petr Vorel <pvorel@suse.cz>

I plan to test it a bit and appreciate if somebody else also test it,
but I see no problem to include this patchset.

> V3:
> + Updated linux-arts commit (thanks Dmitry and Shuah for updating those!)
> + Fixed AC macro

...
> +ifeq ($(WITH_SYZKALLER_REPROS),yes)
> +
> +# This is mainly due to the -m32 flag, but there could be other problems.
> +ifneq ($(HOST_CPU), x86_64))
nit: I guess, there should not be space, it should be
ifneq ($(HOST_CPU),x86_64))

include/mk/config.mk
HOST_CPU		:= x86_64
=> I thought that the trailing space is omitted.
But working with it => not important.

> +$(error "We currently only support building the Syzkaller reproducers on x86_64")
> +endif
> +
> +# The number of reproducers in each runtest file
> +SYZKALLER_RUNFILES_SIZE ?= 100
> +
> +# Extra arguments to pass to syzwrap. Uncomment the below to add some
> +# sandboxing.
> +# SYZWRAP_ARGS ?= -s
> +
> +# Location where reproducers are installed
> +SYZKALLER_INSTALL_DIR ?= $(abspath $(DESTDIR)/$(prefix)/testcases/bin)
> +
> +# If the reproducers directory is missing then we automatically clone the repo.
> +# We then have to call make recursively to revaluate the targets
> +SYZKALLER_REPROS_DIR ?= $(abs_top_srcdir)/testcases/linux-arts/syzkaller-repros/linux
> +$(SYZKALLER_REPROS_DIR):
> +	git submodule update --init $(abs_top_srcdir)/testcases/linux-arts
> +	$(MAKE) syzkaller_runfiles
> +
> +SYZKALLER_REPROS_SRCS = $(wildcard $(SYZKALLER_REPROS_DIR)/*.c)
> +
> +# Some useful compiler flags for the LTP will cause problems with the
> +# syzkaller repros so the repros have seperate flags
> +SYZKALLER_CFLAGS ?= -pthread
> +SYZKALLER_REPROS = $(subst $(abs_top_srcdir),$(abs_top_builddir),$(SYZKALLER_REPROS_SRCS:.c=))

> +$(SYZKALLER_REPROS): %: %.c
> +	-@if grep -q "__NR_mmap2" $^; then \
> +		M32="-m32"; \
> +	fi; \
> +	$(CC) $(SYZKALLER_CFLAGS) $$M32 $(SYZKALLER_LDFLAGS) $^ -o $@; \
> +	echo $(CC) $(SYZKALLER_CFLAGS) $$M32 $(SYZKALLER_LDFLAGS) $^ -o $@;
nit: it'd be worth to mention 32bit compilation environment.
And I like this Makefile :)

I experimentally enabled it on all intel native builds in my LTP fork travis [1]
and it runs well. Failed only in minimal variant [2] (no surprise).
Fedora required to add glibc-devel.i686, other have support by default.
It failed on ubuntu eon on timeout.
I'd suggest to chose one target where this would be running.
Whole job was prolonged from 2 hrs to 2,75 hrs, but running a single job
wouldn't be that bad.

[1] https://travis-ci.org/github/pevik/ltp/builds/696513565
[2] https://travis-ci.org/github/pevik/ltp/jobs/696513571

> +
> +# Generate the names of the runtest files. This uses Shell arithmetic to
> +# calculate how many runtest files there will be.
> +define SYZKALLER_RUNFILES !=
> +	n=$(words $(SYZKALLER_REPROS));
> +	m=$(SYZKALLER_RUNFILES_SIZE);
> +	i=$$(( $$n / $$m + ($$n % $$m > 0) ));
> +	while test $$i -gt 0;
> +	do
> +		echo $(top_srcdir)/runtest/syzkaller$$i;
> +		i=$$(($$i - 1));
> +	done
> +endef
> +
> +++ b/testcases/kernel/syzkaller-repros/README.md
...
> +## Instructions
> +
> +1. Run `ltp/configure` with `--with-syzkaller-repros`.
nit: I'd omit ltp/ (=> ./configure).

> +2. Build and install the LTP as normal.
> +3. Run one or more of syzkallerN runtest files where N is a number.


Kind regards,
Petr
