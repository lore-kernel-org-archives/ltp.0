From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 Apr 2017 17:24:49 +0200
Subject: [LTP] [PATCH 1/2] open_posix_testsuite: Fix recursive build
In-Reply-To: <20170405085821.13121-1-pvorel@suse.cz>
References: <20170405085821.13121-1-pvorel@suse.cz>
Message-ID: <20170406152448.GA4977@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -top_srcdir?=		.
> +open_posix_srcdir := $(if $(top_srcdir),$(top_srcdir)/testcases/open_posix_testsuite,$(abspath .))

I wonder if we want to be consistent with the rest of the LTP
buildsystem define the top_srcdir ?= ../.. here so that we could use
it below in both cases when the make is executed in the open posix
directory or from the top level Makefile.

Then we could define the open_posix_srcdir := $(top_srcdir)/testcases/open_posix_testsuite

> -prefix?=		`$(top_srcdir)/scripts/print_prefix.sh`
> +prefix?=		`$(open_posix_srcdir)/scripts/print_prefix.sh`
>  
>  datadir?=		$(prefix)/share
>  
> @@ -35,13 +35,13 @@ exec_prefix?=		$(prefix)
>  all: conformance-all functional-all stress-all tools-all
>  
>  ifeq ($(shell uname -s), Linux)
> -include Makefile.linux
> +include $(open_posix_srcdir)/Makefile.linux
>  endif
>  
>  clean: $(CRITICAL_MAKEFILE)
>  	@rm -f $(LOGFILE)*
>  	@for dir in $(SUBDIRS) tools; do \
> -	    $(MAKE) -C $$dir clean >/dev/null; \
> +	    $(MAKE) -C $(open_posix_srcdir)/$$dir clean >/dev/null; \
>  	done
>  
>  distclean: distclean-makefiles
> @@ -49,12 +49,12 @@ distclean: distclean-makefiles
>  # Clean out all of the generated Makefiles.
>  distclean-makefiles:
>  	@for dir in $(SUBDIRS); do \
> -		$(MAKE) -C $$dir $@; \
> +		$(MAKE) -C $(open_posix_srcdir)/$$dir $@; \
>  	done
>  
>  generate-makefiles: distclean-makefiles
> -	@env top_srcdir=$(top_srcdir) \
> -	    $(top_srcdir)/scripts/generate-makefiles.sh
> +	@env top_srcdir=$(open_posix_srcdir) \
> +	    $(open_posix_srcdir)/scripts/generate-makefiles.sh

Thinking of this, we still put the generated makefiles into the source
directory. I wonder if it's a good idea to even try to put the makefiles
into the build directory and overcomplicate the already overcomplicated
makefile generator.

And don't forget that the generate-makefile.sh script needs to get a
path to the config-openposix.mk which is located in the build directory
under include/mk/ otherwise the top level CFLAGS are not propagated.

Looks like this is really can of worms...

>  install: bin-install conformance-install functional-install stress-install
>  
> @@ -63,47 +63,47 @@ test: conformance-test functional-test stress-test
>  # Test build and execution targets.
>  conformance-all: $(CRITICAL_MAKEFILE)
>  	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
> -	@$(BUILD_MAKE) -C conformance -j1 all
> +	@$(BUILD_MAKE) -C $(open_posix_srcdir)/conformance -j1 all
>  
>  conformance-install:
> -	@$(MAKE) -C conformance install
> +	@$(MAKE) -C $(open_posix_srcdir)/conformance install
>  
>  conformance-test:
>  	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
> -	@$(TEST_MAKE) -C conformance test
> +	@$(TEST_MAKE) -C $(open_posix_srcdir)/conformance test
>  
>  functional-all: $(CRITICAL_MAKEFILE)
>  	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
> -	@$(BUILD_MAKE) -C functional -j1 all
> +	@$(BUILD_MAKE) -C $(open_posix_srcdir)/functional -j1 all
>  
>  functional-install:
> -	@$(MAKE) -C functional install
> +	@$(MAKE) -C $(open_posix_srcdir)/functional install
>  
>  functional-test:
>  	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
> -	@$(TEST_MAKE) -C functional test
> +	@$(TEST_MAKE) -C $(open_posix_srcdir)/functional test
>  
>  stress-all: $(CRITICAL_MAKEFILE)
>  	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
> -	@$(BUILD_MAKE) -C stress -j1 all
> +	@$(BUILD_MAKE) -C $(open_posix_srcdir)/stress -j1 all
>  
>  stress-install:
> -	@$(MAKE) -C stress install
> +	@$(MAKE) -C $(open_posix_srcdir)/stress install
>  
>  stress-test:
>  	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
> -	@$(TEST_MAKE) -C stress test
> +	@$(TEST_MAKE) -C $(open_posix_srcdir)/stress test
>  
>  # Tools build and install targets.
>  bin-install:
> -	@$(MAKE) -C bin install
> +	@$(MAKE) -C $(open_posix_srcdir)/bin install
>  
>  tools-all:
> -	@$(MAKE) -C tools all
> +	@$(MAKE) -C $(open_posix_srcdir)/tools all top_srcdir=$(open_posix_srcdir)
>  
>  $(CRITICAL_MAKEFILE): \
> -    $(top_srcdir)/scripts/generate-makefiles.sh	\
> -    $(top_srcdir)/CFLAGS			\
> -    $(top_srcdir)/LDFLAGS			\
> -    $(top_srcdir)/LDLIBS
> -	@$(MAKE) generate-makefiles
> +    $(open_posix_srcdir)/scripts/generate-makefiles.sh	\
> +    $(open_posix_srcdir)/CFLAGS			\
> +    $(open_posix_srcdir)/LDFLAGS			\
> +    $(open_posix_srcdir)/LDLIBS
> +	@$(MAKE) -f $(open_posix_srcdir)/Makefile generate-makefiles
> diff --git a/testcases/open_posix_testsuite/Makefile.linux b/testcases/open_posix_testsuite/Makefile.linux
> index 77e20a958..adef565a8 100644
> --- a/testcases/open_posix_testsuite/Makefile.linux
> +++ b/testcases/open_posix_testsuite/Makefile.linux
> @@ -8,7 +8,7 @@ cmd_disable = @set -e; \
>  
>  BROKEN :=
>  
> -kver_cmp = $(shell $(top_srcdir)/scripts/tst_kvercmp.sh 2 6 22)
> +kver_cmp = $(shell $(open_posix_srcdir)/scripts/tst_kvercmp.sh 2 6 22)
>  ifeq ($(kver_cmp), 1)
>  BROKEN += t_sigaction_16-1
>  endif
> diff --git a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
> index 67a60c8cb..d50d517ae 100755
> --- a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
> +++ b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
> @@ -22,7 +22,7 @@ generate_locate_test_makefile() {
>  
>  	echo "Generating $maketype Makefiles"
>  
> -	locate-test --$maketype | sed -e 's,^./,,g' > make-gen.$maketype
> +	locate-test --$maketype $top_srcdir | sed -e 's,^./,,g' > make-gen.$maketype
>  
>  	generate_makefiles make-gen.$maketype $*
>  
> -- 
> 2.12.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
