Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MIZjZ-00009C-Vr
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 02:58:13 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MIZjY-0003Ew-3s
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 02:58:13 +0000
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id D0FB61043907E
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Jun 2009 02:32:48 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp06.web.de with asmtp (WEB.DE 4.110 #277) id 1MIXSq-0006E0-00
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 02:32:48 +0200
Date: Wed, 17 Jun 2009 20:40:43 +0200
From: "Jiri Palecek >" <"<jirka"@suse.de>(none)
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.uvwg9bqqlwynca@debian>
Subject: [LTP] [PATCH] Fix makefiles ignoring build failures
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20090617184043.DQpRfPJDQtSGItYYGegT7NEP72SyLgAfwghzCmkj6XI@z>

Hello,

some makefiles ignore errors from commads ran in shell loops. This patch fixes that.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 doc/man1/Makefile                                  |    2 +-
 doc/man3/Makefile                                  |    2 +-
 include/Makefile                                   |    2 +-
 testcases/ballista/ballista/MakefileTarget.dist    |    2 +-
 testcases/commands/unzip/Makefile                  |    2 +-
 testcases/kernel/containers/netns/Makefile         |    2 +-
 testcases/kernel/controllers/cpuset/Makefile       |    4 ++--
 .../cpuset/cpuset_base_ops_test/Makefile           |    2 +-
 .../cpuset/cpuset_exclusive_test/Makefile          |    2 +-
 .../cpuset/cpuset_hierarchy_test/Makefile          |    2 +-
 .../cpuset/cpuset_hotplug_test/Makefile            |    2 +-
 .../cpuset/cpuset_inherit_test/Makefile            |    2 +-
 .../kernel/controllers/cpuset/cpuset_lib/Makefile  |    2 +-
 .../cpuset/cpuset_load_balance_test/Makefile       |    2 +-
 .../cpuset/cpuset_syscall_test/Makefile            |    2 +-
 testcases/kernel/fs/scsi/ltpscsi/Makefile          |   10 +++++-----
 16 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/doc/man1/Makefile b/doc/man1/Makefile
index d11ac50..87f4e59 100644
--- a/doc/man1/Makefile
+++ b/doc/man1/Makefile
@@ -6,7 +6,7 @@ MANPAGES=ltp-bump.1 doio.1 iogen.1 ltp-pan.1
 all:
 
 install: $(MANPAGES)
-	for i in $(MANPAGES); do \
+	@set -e; for i in $(MANPAGES); do \
 		install -D -m 644 $$i $(DESTDIR)/$(PREFIX)/share/man/man1/$$i; \
 	done
 
diff --git a/doc/man3/Makefile b/doc/man3/Makefile
index 987ddc5..bcd2a26 100644
--- a/doc/man3/Makefile
+++ b/doc/man3/Makefile
@@ -9,7 +9,7 @@ MANPAGES=forker.3 get_attrib.3 parse_open_flags.3 parse_opts.3 \
 all:
 
 install: $(MANPAGES)
-	for i in $(MANPAGES); do \
+	@set -e; for i in $(MANPAGES); do \
 		install -D -m 644 $$i $(DESTDIR)/$(PREFIX)/share/man/man3/$$i; \
 	done
 
diff --git a/include/Makefile b/include/Makefile
index 461eb93..b5944aa 100644
--- a/include/Makefile
+++ b/include/Makefile
@@ -10,7 +10,7 @@ HEADERS=compiler.h dataascii.h databin.h file_lock.h forker.h open_flags.h \
 all:
 
 install: $(HEADERS)
-	for i in $(HEADERS); do \
+	@set -e; for i in $(HEADERS); do \
 		install -D -m 644 $$i $(DESTDIR)/$(PREFIX)/include/ltp/$$i; \
 	done
 
diff --git a/testcases/ballista/ballista/MakefileTarget.dist b/testcases/ballista/ballista/MakefileTarget.dist
index a5a70e3..e76cc55 100644
--- a/testcases/ballista/ballista/MakefileTarget.dist
+++ b/testcases/ballista/ballista/MakefileTarget.dist
@@ -104,7 +104,7 @@ executeTestCase.h : dataTypes
 	/bin/echo "// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA." >> executeTestCase.h
 	/bin/echo " " >> executeTestCase.h
 	/bin/echo '#'include \"userIncludes.h\" >> executeTestCase.h
-	for A in `echo ${OBLIST:.o=.h}`; do \
+	@set -e; for A in `echo ${OBLIST:.o=.h}`; do \
 		/bin/echo '#'include \"$$A\" >> executeTestCase.h; \
 	done
 
diff --git a/testcases/commands/unzip/Makefile b/testcases/commands/unzip/Makefile
index a001ffa..7c7aa60 100644
--- a/testcases/commands/unzip/Makefile
+++ b/testcases/commands/unzip/Makefile
@@ -20,7 +20,7 @@ tst_unzip.dir: unzip_genfile.sh
 	./unzip_genfile.sh tst_unzip.dir
 
 install: all
-	for i in $(BINS) ; do \
+	@set -e; for i in $(BINS); do \
 		ln -f $$i ../../bin/$$i ; \
 	done
 
diff --git a/testcases/kernel/containers/netns/Makefile b/testcases/kernel/containers/netns/Makefile
index 4d00bf2..f12fa2d 100644
--- a/testcases/kernel/containers/netns/Makefile
+++ b/testcases/kernel/containers/netns/Makefile
@@ -44,7 +44,7 @@ all: $(TARGETS)
 
 install:
 ifeq ($(HAS_UNSHARE),y)
-	for i in $(TARGETS) $(SCRIPTS) runnetnstest.sh check_netns_enabled; do ln -f $$i ../../../bin/$$i ; chmod +x runnetnstest.sh ; done
+	@set -e; for i in $(TARGETS) $(SCRIPTS) runnetnstest.sh check_netns_enabled; do ln -f $$i ../../../bin/$$i ; chmod +x runnetnstest.sh ; done
 endif
 
 clean:
diff --git a/testcases/kernel/controllers/cpuset/Makefile b/testcases/kernel/controllers/cpuset/Makefile
index 036af7f..6621667 100644
--- a/testcases/kernel/controllers/cpuset/Makefile
+++ b/testcases/kernel/controllers/cpuset/Makefile
@@ -4,11 +4,11 @@ SUBDIRS += cpuset_hotplug_test cpuset_load_balance_test
 SUBDIRS += cpuset_memory_pressure_test cpuset_memory_spread_test
 SUBDIRS += cpuset_memory_test
 all:
-	@set -e;
+	@set -e; \
 	for i in $(SUBDIRS); do $(MAKE) -C $$i $@ ;done;
 
 install:
-	@set -e;
+	@set -e; \
 	for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done;
 	ln -f run_cpuset_test.sh ../../../bin/run_cpuset_test.sh;
 	chmod +x run_cpuset_test.sh;
diff --git a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile
index 592d716..70d1bc2 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile
@@ -7,6 +7,6 @@ clean:
 	@true
 
 install:
-	@set -e;
+	@set -e; \
 	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile
index 592d716..70d1bc2 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile
@@ -7,6 +7,6 @@ clean:
 	@true
 
 install:
-	@set -e;
+	@set -e; \
 	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile
index 592d716..70d1bc2 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile
@@ -7,6 +7,6 @@ clean:
 	@true
 
 install:
-	@set -e;
+	@set -e; \
 	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile
index 24058b4..c4b6bba 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile
@@ -16,7 +16,7 @@ clean:
 	rm -f $(TARGETS) $(OBJECTS) $(LIBOBJECTS)
 
 install:
-	@set -e;
+	@set -e; \
 	for i in $(TARGETS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
 	ln -f cpuset_hotplug_test.sh ../../../../bin/cpuset_hotplug_test.sh;
 	chmod +x cpuset_hotplug_test.sh;
diff --git a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile
index 592d716..70d1bc2 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile
@@ -7,6 +7,6 @@ clean:
 	@true
 
 install:
-	@set -e;
+	@set -e; \
 	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile b/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
index 1b3f7a7..43df1bc 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
@@ -11,6 +11,6 @@ clean:
 	rm -f $(TARGETS)
 
 install:
-	@set -e;
+	@set -e; \
 	ln -f cpuset_funcs.sh ../../../../bin/cpuset_funcs.sh;
 	chmod +x cpuset_funcs.sh;
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile
index 4aaeeb9..923d065 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile
@@ -16,7 +16,7 @@ clean:
 	rm -f $(TARGETS) $(OBJECTS) $(LIBOBJECTS)
 
 install:
-	@set -e;
+	@set -e; \
 	for i in $(TARGETS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
 	ln -f cpuset_load_balance_test.sh ../../../../bin/cpuset_load_balance_test.sh;
 	ln -f cpuset_sched_domains_test.sh ../../../../bin/cpuset_sched_domains_test.sh;
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
index 9f0a3f3..fc5f2e7 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
@@ -11,6 +11,6 @@ clean:
 	rm -rf cpuset_syscall_test
 
 install:
-	@set -e;
+	@set -e; \
 	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
 	ln -f cpuset_syscall_test ../../../../bin/cpuset_syscall_test;
diff --git a/testcases/kernel/fs/scsi/ltpscsi/Makefile b/testcases/kernel/fs/scsi/ltpscsi/Makefile
index 40dfc9e..c635c67 100644
--- a/testcases/kernel/fs/scsi/ltpscsi/Makefile
+++ b/testcases/kernel/fs/scsi/ltpscsi/Makefile
@@ -18,7 +18,7 @@ LDFLAGS =
 all: $(EXECS)
 
 depend dep:
-	for i in *.c; do $(CC) $(INCLUDES) $(CFLAGS) -M $$i; \
+	@set -e; for i in *.c; do $(CC) $(INCLUDES) $(CFLAGS) -M $$i; \
 	done > .depend
 
 clean:
@@ -29,21 +29,21 @@ scsimain: scsimain.o sg_err.o llseek.o
 
 install: $(EXECS)
 	install -d $(INSTDIR)
-	for name in $^; \
+	@set -e; for name in $^; \
 	 do install -s -o root -g root -m 755 $$name $(INSTDIR); \
 	done
 	install -d $(MANDIR)/$(MAN_PREF)
-	for mp in $(MAN_PGS); \
+	@set -e; for mp in $(MAN_PGS); \
 	 do install -o root -g root -m 644 $$mp $(MANDIR)/$(MAN_PREF); \
 	 gzip -9f $(MANDIR)/$(MAN_PREF)/$$mp; \
 	done
 
 uninstall:
 	dists="$(EXECS)"; \
-	for name in $$dists; do \
+	@set -e; for name in $$dists; do \
 	 rm -f $(INSTDIR)/$$name; \
 	done
-	for mp in $(MAN_PGS); do \
+	@set -e; for mp in $(MAN_PGS); do \
 	 rm -f $(MANDIR)/$(MAN_PREF)/$$mp.gz; \
 	done
 
-- 
1.6.3.1




------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
