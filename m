Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1N65gF-0002jA-IW
	for ltp-list@lists.sourceforge.net; Thu, 05 Nov 2009 16:59:27 +0000
Date: Thu, 5 Nov 2009 17:59:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091105165913.GD19831@schrodinger.suse.cz>
References: <20091105131852.GA13908@schrodinger.suse.cz>
	<200911051129.18046.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <200911051129.18046.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] replacing -Wextra with -W
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> > Lately gcc developers introduced -Wextra flag that does the same as -W but
> >  is more descriptive. According to this using -W flag should be safe (as
> >  gcc is backward compatlible) but using -Wextra is limited to newer gcc
> >  releases.
> > 
> > Attached patch replaces all -Wextra occurences with -W and thus fixes
> > compliation failures with older gcc (mine was gcc-3.3.3 on sles).
> 
> it'd be better if we had configure tests for -W flags, but that would take a 
> bit more effort, and i dont think it should preclude applying your patch.  
> however, please make this change first:
>  - integrated Makefiles shouldnt be setting flags at all, so just delete the 
> whole line in testcases/kernel/controllers/{cpuctl,cgroup}_fj/Makefile
> 

Patch that should be applied over the previous one attached.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--jq0ap7NbKX2Kqbes
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="remove_cppflags.patch"

Index: delme/testcases/kernel/controllers/cpuctl_fj/Makefile
===================================================================
--- delme.orig/testcases/kernel/controllers/cpuctl_fj/Makefile
+++ delme/testcases/kernel/controllers/cpuctl_fj/Makefile
@@ -25,8 +25,6 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
-CPPFLAGS		+= -Wall -O2 -W
-
 INSTALL_TARGETS		:= *.sh
 
 LDLIBS			+= -lm
Index: delme/testcases/kernel/controllers/cgroup_fj/Makefile
===================================================================
--- delme.orig/testcases/kernel/controllers/cgroup_fj/Makefile
+++ delme/testcases/kernel/controllers/cgroup_fj/Makefile
@@ -25,8 +25,6 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
-CPPFLAGS		+= -Wall -O2 -W
-
 INSTALL_TARGETS		:= *.sh
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
Index: delme/testcases/kernel/controllers/cpuacct/Makefile
===================================================================
--- delme.orig/testcases/kernel/controllers/cpuacct/Makefile
+++ delme/testcases/kernel/controllers/cpuacct/Makefile
@@ -25,8 +25,6 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
-CPPFLAGS		+= -Wall
-
 INSTALL_TARGETS		:= *.sh
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
Index: delme/testcases/kernel/io/disktest/Makefile
===================================================================
--- delme.orig/testcases/kernel/io/disktest/Makefile
+++ delme/testcases/kernel/io/disktest/Makefile
@@ -188,7 +188,7 @@ include $(top_srcdir)/include/mk/env_pre
 
 VER		:= `grep VER_STR $(abs_srcdir)/main.h | awk -F\" '{print $$2}'`
 
-CPPFLAGS	+= -g -Wall -O -DLINUX -D_THREAD_SAFE -D_GNU_SOURCE -D_LARGE_FILES -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 $(RPM_OPT_FLAGS)
+CPPFLAGS	+= -g -O -DLINUX -D_THREAD_SAFE -D_GNU_SOURCE -D_LARGE_FILES -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 $(RPM_OPT_FLAGS)
 
 DISTRO_FILES	:= Makefile* *.[ch] LICENSE README CHANGELOG
 

--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--jq0ap7NbKX2Kqbes--

