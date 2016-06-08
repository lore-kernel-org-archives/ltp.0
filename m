From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 8 Jun 2016 03:42:28 -0400 (EDT)
Subject: [LTP] ltp-full-20160510 compile failed
In-Reply-To: <20160607161258.GB4397@rei.lan>
References: <20160518082726.GA3920@localhost.localdomain>
 <1923642895.3898894.1463574897794.JavaMail.zimbra@redhat.com>
 <20160518145325.GC17880@rei.lan> <20160607161258.GB4397@rei.lan>
Message-ID: <404843569.4500543.1465371748586.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Cc: "Han Pingtian" <hanpt@linux.vnet.ibm.com>, "Jan Stancek" <jstancek@redhat.com>
> Sent: Tuesday, 7 June, 2016 6:12:58 PM
> Subject: Re: [LTP] ltp-full-20160510 compile failed
> 
> Hi!
> > Just non-parallel build for the Makefiles as far as I remember.
> > 
> > Sorry that this issue was left unsolved, I will try to look into it
> > again. Until then you can workaround it by forcing the nonparallel build
> > for CRITICAL_MAKEFILES as does the patch in the email thread.
> 
> Looking at the problem again, the Makefile in question is wrong.
> 
> What it does (simplified) is:
> 
> CRITICAL_MAKEFILES=conformance functional stress
> 
> all: $(CRITICAL_MAKEFILES)
> 
> $(CRITICAL_MAKEFILES):
> 	$(MAKE) generate-makefiles
> 
> 
> No wonder that it runs $(MAKE) generate-makefiles for each Makefile in
> CRITICAL_MAKEFILES.
> 
> Well it runs only two instances of the generate-makefiles.sh script
> because there is a typo, the CRITICAL_SECTION_MAKEFILE should probably
> have been CRITICAL_STRESS_MAKEFILE.
> 
> And as it looks to me, the original intend was to pass the directory
> (i.e. conformance, functional or stress) to the generate-makefiles.sh
> script and subsequently to the locate-test script.
> 
> The obvious fix would be changing the makefile to depend only on single
> critical Makefile in order to figure out if Makefiles were generated or
> not.
> 
> For me following patch seems to fix the issue.
> 
> Jan: Can you have a look?

ACK. Worked for me.

I keep thinking if we can avoid all this makefile
generation.


> Han: Does this patch work for you?
> 
> diff --git a/testcases/open_posix_testsuite/Makefile
> b/testcases/open_posix_testsuite/Makefile
> index 500ddc2..e1c7bcd 100644
> --- a/testcases/open_posix_testsuite/Makefile
> +++ b/testcases/open_posix_testsuite/Makefile
> @@ -6,13 +6,7 @@
>  
>  # Makefiles that are considered critical to execution; if they don't exist
>  # all of the Makefiles will be rebuilt by default.
> -CRITICAL_CONFORMANCE_MAKEFILE=	conformance/interfaces/timer_settime/Makefile
> -CRITICAL_FUNCTIONAL_MAKEFILE=	functional/threads/pi_test/Makefile
> -CRITICAL_SECTION_MAKEFILE=	stress/threads/sem_open/Makefile
> -
> -CRITICAL_MAKEFILES=	$(CRITICAL_CONFORMANCE_MAKEFILE) \
> -			$(CRITICAL_FUNCTIONAL_MAKEFILE) \
> -			$(CRITICAL_SECTION_MAKEFILE)
> +CRITICAL_MAKEFILE=	conformance/interfaces/timer_settime/Makefile
>  
>  # The default logfile for the tests.
>  LOGFILE?=		logfile
> @@ -44,7 +38,7 @@ ifeq ($(shell uname -s), Linux)
>  include Makefile.linux
>  endif
>  
> -clean: $(CRITICAL_MAKEFILES)
> +clean: $(CRITICAL_MAKEFILE)
>  	@rm -f $(LOGFILE)*
>  	@for dir in $(SUBDIRS) tools; do \
>  	    $(MAKE) -C $$dir clean >/dev/null; \
> @@ -67,7 +61,7 @@ install: bin-install conformance-install functional-install
> stress-install
>  test: conformance-test functional-test stress-test
>  
>  # Test build and execution targets.
> -conformance-all: $(CRITICAL_CONFORMANCE_MAKEFILE)
> +conformance-all: $(CRITICAL_MAKEFILE)
>  	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else
>  	echo "\`pwd\`/$(LOGFILE)"; fi`.$@
>  	@$(BUILD_MAKE) -C conformance -j1 all
>  
> @@ -78,7 +72,7 @@ conformance-test:
>  	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else
>  	echo "\`pwd\`/$(LOGFILE)"; fi`.$@
>  	@$(TEST_MAKE) -C conformance test
>  
> -functional-all: $(CRITICAL_FUNCTIONAL_MAKEFILE)
> +functional-all: $(CRITICAL_MAKEFILE)
>  	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else
>  	echo "\`pwd\`/$(LOGFILE)"; fi`.$@
>  	@$(BUILD_MAKE) -C functional -j1 all
>  
> @@ -89,7 +83,7 @@ functional-test:
>  	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else
>  	echo "\`pwd\`/$(LOGFILE)"; fi`.$@
>  	@$(TEST_MAKE) -C functional test
>  
> -stress-all: $(CRITICAL_STRESS_MAKEFILE)
> +stress-all: $(CRITICAL_MAKEFILE)
>  	@rm -f `if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else
>  	echo "\`pwd\`/$(LOGFILE)"; fi`.$@
>  	@$(BUILD_MAKE) -C stress -j1 all
>  
> @@ -107,12 +101,9 @@ bin-install:
>  tools-all:
>  	@$(MAKE) -C tools all
>  
> -$(CRITICAL_MAKEFILES): \
> +$(CRITICAL_MAKEFILE): \
>      $(top_srcdir)/scripts/generate-makefiles.sh	\
>      $(top_srcdir)/CFLAGS			\
>      $(top_srcdir)/LDFLAGS			\
>      $(top_srcdir)/LDLIBS
>  	@$(MAKE) generate-makefiles
> -
> -#tests-pretty:
> -#	$(MAKE) all | column -t -s:
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
