Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NGbZ8-0004NK-HU
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 17:03:34 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NGbZ4-0000cl-6D
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 17:03:34 +0000
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 964F613F9A298
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Dec 2009 18:03:24 +0100 (CET)
Received: from [90.180.172.144] (helo=debian)
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314) id 1NGbYy-0003LY-00
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 18:03:24 +0100
Date: Fri, 04 Dec 2009 17:58:13 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u4faz50icfnueu@debian>
Subject: [LTP] [PATCH] Don't install datafiles with executable mode
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
Message-ID: <20091204165813.83qfyiBorIpYoGBlWbfmN7mjDz_ht_66-Ha4WxfQxyE@z>

Hello,

the makefiles install all files with executable mode by default. This patch changes it for some of the Makefiles, that install data files, which should IMHO not be executable. The change makes INSTALL_MODE decide the actual mode when it is expanded inside the install rule (depending on $@, which is the install target name).

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/commands/ade/ar/Makefile             |    2 ++
 testcases/commands/ade/ldd/Makefile            |    2 ++
 testcases/commands/ade/nm/Makefile             |    2 ++
 testcases/commands/cron/Makefile               |    2 ++
 testcases/kernel/io/stress_floppy/Makefile     |    1 +
 testcases/kernel/sched/clisrv/Makefile         |    2 ++
 testcases/kernel/sched/sched_stress/Makefile   |    2 ++
 testcases/network/multicast/mc_member/Makefile |    2 ++
 8 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/testcases/commands/ade/ar/Makefile b/testcases/commands/ade/ar/Makefile
index b6ab633..baf4b5b 100644
--- a/testcases/commands/ade/ar/Makefile
+++ b/testcases/commands/ade/ar/Makefile
@@ -33,4 +33,6 @@ MAKE_TARGETS		:= $(patsubst $(abs_srcdir)/%.c,%.obj,$(wildcard $(abs_srcdir)/*.c
 $(MAKE_TARGETS): %.obj: %.o
 	mv "$^" "$@"
 
+INSTALL_MODE = $(if $(filter %ar01,$@), 0755, 0644)
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/ade/ldd/Makefile b/testcases/commands/ade/ldd/Makefile
index eae06cd..ce5e64f 100644
--- a/testcases/commands/ade/ldd/Makefile
+++ b/testcases/commands/ade/ldd/Makefile
@@ -30,6 +30,8 @@ INSTALL_TARGETS		:= ldd01
 
 MAKE_TARGETS		:= $(patsubst $(abs_srcdir)/%.c,%.obj,$(wildcard $(abs_srcdir)/*.c))
 
+INSTALL_MODE = $(if $(filter %ldd01,$@), 0755, 0644)
+
 $(MAKE_TARGETS): %.obj: %.o
 	mv $^ $@
 
diff --git a/testcases/commands/ade/nm/Makefile b/testcases/commands/ade/nm/Makefile
index de8e3b4..ca03462 100644
--- a/testcases/commands/ade/nm/Makefile
+++ b/testcases/commands/ade/nm/Makefile
@@ -28,6 +28,8 @@ INSTALL_TARGETS		:= nm01 nmfile.c
 
 MAKE_TARGETS		:= $(patsubst $(abs_srcdir)/%.c,%.obj,$(wildcard $(abs_srcdir)/*.c))
 
+INSTALL_MODE = $(if $(filter %nm01,$@), 0755, 0644)
+
 $(MAKE_TARGETS): %.obj: %.o
 	mv $^ $@
 
diff --git a/testcases/commands/cron/Makefile b/testcases/commands/cron/Makefile
index 1b49488..53c0956 100644
--- a/testcases/commands/cron/Makefile
+++ b/testcases/commands/cron/Makefile
@@ -26,4 +26,6 @@ include $(top_srcdir)/include/mk/env_pre.mk
 
 INSTALL_TARGETS		:= cron0[23] cron_illegal_cron_lines cron_allow01 cron_deny01 cron_dirs_checks01 *.sh
 
+INSTALL_MODE = $(if $(filter %cron_illegal_cron_lines,$@), 0644, 0755)
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/io/stress_floppy/Makefile b/testcases/kernel/io/stress_floppy/Makefile
index 0a590b3..ad9f9b0 100644
--- a/testcases/kernel/io/stress_floppy/Makefile
+++ b/testcases/kernel/io/stress_floppy/Makefile
@@ -26,6 +26,7 @@ INSTALL_DEPS		:= dumpdir
 
 MAKE_TARGETS		:=
 
+
 # dumpdir's a directory.
 RM			+= -r
 
diff --git a/testcases/kernel/sched/clisrv/Makefile b/testcases/kernel/sched/clisrv/Makefile
index 0c293d3..ffe45ea 100644
--- a/testcases/kernel/sched/clisrv/Makefile
+++ b/testcases/kernel/sched/clisrv/Makefile
@@ -29,6 +29,8 @@ LDLIBS			+= -lpthread
 
 INSTALL_TARGETS		:= data run_sched_cliserv.sh
 
+INSTALL_MODE = $(if $(filter %data,$@), 0644, 0755)
+
 MAKE_TARGETS		:= pthcli pthserv
 
 $(MAKE_TARGETS): %: %.o readline.o writen.o
diff --git a/testcases/kernel/sched/sched_stress/Makefile b/testcases/kernel/sched/sched_stress/Makefile
index 140b630..a85a5e8 100644
--- a/testcases/kernel/sched/sched_stress/Makefile
+++ b/testcases/kernel/sched/sched_stress/Makefile
@@ -36,6 +36,8 @@ $(filter-out sched_datafile,$(MAKE_TARGETS)): %: %.o sched.o
 
 MAKE_TARGETS		+= sched_datafile
 
+INSTALL_MODE = $(if $(filter %sched_datafile,$@), 0644, 0755)
+
 sched_datafile:
 	"$(top_srcdir)/tools/make-file.sh" "$@" 1200010
 
diff --git a/testcases/network/multicast/mc_member/Makefile b/testcases/network/multicast/mc_member/Makefile
index afd1114..44aa5d4 100644
--- a/testcases/network/multicast/mc_member/Makefile
+++ b/testcases/network/multicast/mc_member/Makefile
@@ -26,4 +26,6 @@ include $(top_srcdir)/include/mk/env_pre.mk
 
 INSTALL_TARGETS		:= mc_member *ManyGroups
 
+INSTALL_MODE = $(if $(filter %mc_member,$@), 0755, 0644)
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
1.6.4.3




------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
