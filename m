Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7aA-0000b0-Fu
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:06:46 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7a9-00060L-4x
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:06:46 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NExPOv007850
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 08:59:25 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NF6YGP139822
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:06:35 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NF6Y1c029506
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:06:34 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906220255.n5M2t4sh031684@e2.ny.us.ibm.com>
References: <200906220255.n5M2t4sh031684@e2.ny.us.ibm.com>
Date: Tue, 23 Jun 2009 20:20:02 +0530
Message-Id: <1245768602.4860.81.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix makefiles ignoring build failures
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Wed, 2009-06-17 at 20:40 +0200, Jiri Palecek > wrote: 
> Hello,
> 
> some makefiles ignore errors from commads ran in shell loops. This patch fixes that.
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  doc/man1/Makefile                                  |    2 +-
>  doc/man3/Makefile                                  |    2 +-
>  include/Makefile                                   |    2 +-
>  testcases/ballista/ballista/MakefileTarget.dist    |    2 +-
>  testcases/commands/unzip/Makefile                  |    2 +-
>  testcases/kernel/containers/netns/Makefile         |    2 +-
>  testcases/kernel/controllers/cpuset/Makefile       |    4 ++--
>  .../cpuset/cpuset_base_ops_test/Makefile           |    2 +-
>  .../cpuset/cpuset_exclusive_test/Makefile          |    2 +-
>  .../cpuset/cpuset_hierarchy_test/Makefile          |    2 +-
>  .../cpuset/cpuset_hotplug_test/Makefile            |    2 +-
>  .../cpuset/cpuset_inherit_test/Makefile            |    2 +-
>  .../kernel/controllers/cpuset/cpuset_lib/Makefile  |    2 +-
>  .../cpuset/cpuset_load_balance_test/Makefile       |    2 +-
>  .../cpuset/cpuset_syscall_test/Makefile            |    2 +-
>  testcases/kernel/fs/scsi/ltpscsi/Makefile          |   10 +++++-----
>  16 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/doc/man1/Makefile b/doc/man1/Makefile
> index d11ac50..87f4e59 100644
> --- a/doc/man1/Makefile
> +++ b/doc/man1/Makefile
> @@ -6,7 +6,7 @@ MANPAGES=ltp-bump.1 doio.1 iogen.1 ltp-pan.1
>  all:
> 
>  install: $(MANPAGES)
> -	for i in $(MANPAGES); do \
> +	@set -e; for i in $(MANPAGES); do \
>  		install -D -m 644 $$i $(DESTDIR)/$(PREFIX)/share/man/man1/$$i; \
>  	done
> 
> diff --git a/doc/man3/Makefile b/doc/man3/Makefile
> index 987ddc5..bcd2a26 100644
> --- a/doc/man3/Makefile
> +++ b/doc/man3/Makefile
> @@ -9,7 +9,7 @@ MANPAGES=forker.3 get_attrib.3 parse_open_flags.3 parse_opts.3 \
>  all:
> 
>  install: $(MANPAGES)
> -	for i in $(MANPAGES); do \
> +	@set -e; for i in $(MANPAGES); do \
>  		install -D -m 644 $$i $(DESTDIR)/$(PREFIX)/share/man/man3/$$i; \
>  	done
> 
> diff --git a/include/Makefile b/include/Makefile
> index 461eb93..b5944aa 100644
> --- a/include/Makefile
> +++ b/include/Makefile
> @@ -10,7 +10,7 @@ HEADERS=compiler.h dataascii.h databin.h file_lock.h forker.h open_flags.h \
>  all:
> 
>  install: $(HEADERS)
> -	for i in $(HEADERS); do \
> +	@set -e; for i in $(HEADERS); do \
>  		install -D -m 644 $$i $(DESTDIR)/$(PREFIX)/include/ltp/$$i; \
>  	done
> 
> diff --git a/testcases/ballista/ballista/MakefileTarget.dist b/testcases/ballista/ballista/MakefileTarget.dist
> index a5a70e3..e76cc55 100644
> --- a/testcases/ballista/ballista/MakefileTarget.dist
> +++ b/testcases/ballista/ballista/MakefileTarget.dist
> @@ -104,7 +104,7 @@ executeTestCase.h : dataTypes
>  	/bin/echo "// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA." >> executeTestCase.h
>  	/bin/echo " " >> executeTestCase.h
>  	/bin/echo '#'include \"userIncludes.h\" >> executeTestCase.h
> -	for A in `echo ${OBLIST:.o=.h}`; do \
> +	@set -e; for A in `echo ${OBLIST:.o=.h}`; do \
>  		/bin/echo '#'include \"$$A\" >> executeTestCase.h; \
>  	done
> 
> diff --git a/testcases/commands/unzip/Makefile b/testcases/commands/unzip/Makefile
> index a001ffa..7c7aa60 100644
> --- a/testcases/commands/unzip/Makefile
> +++ b/testcases/commands/unzip/Makefile
> @@ -20,7 +20,7 @@ tst_unzip.dir: unzip_genfile.sh
>  	./unzip_genfile.sh tst_unzip.dir
> 
>  install: all
> -	for i in $(BINS) ; do \
> +	@set -e; for i in $(BINS); do \
>  		ln -f $$i ../../bin/$$i ; \
>  	done
> 
> diff --git a/testcases/kernel/containers/netns/Makefile b/testcases/kernel/containers/netns/Makefile
> index 4d00bf2..f12fa2d 100644
> --- a/testcases/kernel/containers/netns/Makefile
> +++ b/testcases/kernel/containers/netns/Makefile
> @@ -44,7 +44,7 @@ all: $(TARGETS)
> 
>  install:
>  ifeq ($(HAS_UNSHARE),y)
> -	for i in $(TARGETS) $(SCRIPTS) runnetnstest.sh check_netns_enabled; do ln -f $$i ../../../bin/$$i ; chmod +x runnetnstest.sh ; done
> +	@set -e; for i in $(TARGETS) $(SCRIPTS) runnetnstest.sh check_netns_enabled; do ln -f $$i ../../../bin/$$i ; chmod +x runnetnstest.sh ; done
>  endif
> 
>  clean:
> diff --git a/testcases/kernel/controllers/cpuset/Makefile b/testcases/kernel/controllers/cpuset/Makefile
> index 036af7f..6621667 100644
> --- a/testcases/kernel/controllers/cpuset/Makefile
> +++ b/testcases/kernel/controllers/cpuset/Makefile
> @@ -4,11 +4,11 @@ SUBDIRS += cpuset_hotplug_test cpuset_load_balance_test
>  SUBDIRS += cpuset_memory_pressure_test cpuset_memory_spread_test
>  SUBDIRS += cpuset_memory_test
>  all:
> -	@set -e;
> +	@set -e; \
>  	for i in $(SUBDIRS); do $(MAKE) -C $$i $@ ;done;
> 
>  install:
> -	@set -e;
> +	@set -e; \
>  	for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done;
>  	ln -f run_cpuset_test.sh ../../../bin/run_cpuset_test.sh;
>  	chmod +x run_cpuset_test.sh;
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile
> index 592d716..70d1bc2 100644
> --- a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile
> +++ b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile
> @@ -7,6 +7,6 @@ clean:
>  	@true
> 
>  install:
> -	@set -e;
> +	@set -e; \
>  	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
> 
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile
> index 592d716..70d1bc2 100644
> --- a/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile
> +++ b/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile
> @@ -7,6 +7,6 @@ clean:
>  	@true
> 
>  install:
> -	@set -e;
> +	@set -e; \
>  	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
> 
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile
> index 592d716..70d1bc2 100644
> --- a/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile
> +++ b/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile
> @@ -7,6 +7,6 @@ clean:
>  	@true
> 
>  install:
> -	@set -e;
> +	@set -e; \
>  	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
> 
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile
> index 24058b4..c4b6bba 100644
> --- a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile
> +++ b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile
> @@ -16,7 +16,7 @@ clean:
>  	rm -f $(TARGETS) $(OBJECTS) $(LIBOBJECTS)
> 
>  install:
> -	@set -e;
> +	@set -e; \
>  	for i in $(TARGETS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
>  	ln -f cpuset_hotplug_test.sh ../../../../bin/cpuset_hotplug_test.sh;
>  	chmod +x cpuset_hotplug_test.sh;
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile
> index 592d716..70d1bc2 100644
> --- a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile
> +++ b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile
> @@ -7,6 +7,6 @@ clean:
>  	@true
> 
>  install:
> -	@set -e;
> +	@set -e; \
>  	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
> 
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile b/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
> index 1b3f7a7..43df1bc 100644
> --- a/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
> +++ b/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
> @@ -11,6 +11,6 @@ clean:
>  	rm -f $(TARGETS)
> 
>  install:
> -	@set -e;
> +	@set -e; \
>  	ln -f cpuset_funcs.sh ../../../../bin/cpuset_funcs.sh;
>  	chmod +x cpuset_funcs.sh;
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile
> index 4aaeeb9..923d065 100644
> --- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile
> +++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile
> @@ -16,7 +16,7 @@ clean:
>  	rm -f $(TARGETS) $(OBJECTS) $(LIBOBJECTS)
> 
>  install:
> -	@set -e;
> +	@set -e; \
>  	for i in $(TARGETS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
>  	ln -f cpuset_load_balance_test.sh ../../../../bin/cpuset_load_balance_test.sh;
>  	ln -f cpuset_sched_domains_test.sh ../../../../bin/cpuset_sched_domains_test.sh;
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
> index 9f0a3f3..fc5f2e7 100644
> --- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
> +++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
> @@ -11,6 +11,6 @@ clean:
>  	rm -rf cpuset_syscall_test
> 
>  install:
> -	@set -e;
> +	@set -e; \
>  	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
>  	ln -f cpuset_syscall_test ../../../../bin/cpuset_syscall_test;
> diff --git a/testcases/kernel/fs/scsi/ltpscsi/Makefile b/testcases/kernel/fs/scsi/ltpscsi/Makefile
> index 40dfc9e..c635c67 100644
> --- a/testcases/kernel/fs/scsi/ltpscsi/Makefile
> +++ b/testcases/kernel/fs/scsi/ltpscsi/Makefile
> @@ -18,7 +18,7 @@ LDFLAGS =
>  all: $(EXECS)
> 
>  depend dep:
> -	for i in *.c; do $(CC) $(INCLUDES) $(CFLAGS) -M $$i; \
> +	@set -e; for i in *.c; do $(CC) $(INCLUDES) $(CFLAGS) -M $$i; \
>  	done > .depend
> 
>  clean:
> @@ -29,21 +29,21 @@ scsimain: scsimain.o sg_err.o llseek.o
> 
>  install: $(EXECS)
>  	install -d $(INSTDIR)
> -	for name in $^; \
> +	@set -e; for name in $^; \
>  	 do install -s -o root -g root -m 755 $$name $(INSTDIR); \
>  	done
>  	install -d $(MANDIR)/$(MAN_PREF)
> -	for mp in $(MAN_PGS); \
> +	@set -e; for mp in $(MAN_PGS); \
>  	 do install -o root -g root -m 644 $$mp $(MANDIR)/$(MAN_PREF); \
>  	 gzip -9f $(MANDIR)/$(MAN_PREF)/$$mp; \
>  	done
> 
>  uninstall:
>  	dists="$(EXECS)"; \
> -	for name in $$dists; do \
> +	@set -e; for name in $$dists; do \
>  	 rm -f $(INSTDIR)/$$name; \
>  	done
> -	for mp in $(MAN_PGS); do \
> +	@set -e; for mp in $(MAN_PGS); do \
>  	 rm -f $(MANDIR)/$(MAN_PREF)/$$mp.gz; \
>  	done
> 


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
