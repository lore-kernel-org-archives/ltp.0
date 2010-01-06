Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NSay2-00064i-VR
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 18:50:50 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSay1-0004YO-Sp
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 18:50:50 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o06Iiolh009972
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Jan 2010 11:44:50 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o06IoLDm151758
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Jan 2010 11:50:22 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o06IoKsh013120
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Jan 2010 11:50:20 -0700
Date: Wed, 6 Jan 2010 12:50:19 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100106185019.GA19647@us.ibm.com>
References: <1262791548.15424.31.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1262791548.15424.31.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [LTP] regression:  selinux testsuite broken since October
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
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list@lists.sourceforge.net, James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> It seems the Makefile rewrite last October broke the selinux testsuite.
> Is it unreasonable to expect that someone who rewrote the Makefile would
> actually try running the testsuite?
> 
> Please, revert the changes or fix them.
> 
> See testcases/kernel/security/selinux-testsuite/README for the
> instructions.

Frankly I think reverting the Makefiles is best since it doesn't get
auto-compiled anyway.  The new Makefile is much longer and more complicated
for no apparent gain.

The following patch makes policy compilation work on rhel 5, but I doubt
it'll work anywhere else.

Running the testsuite still fails due to the change to running ltp from
a different dir (i.e.
/usr/bin/chcon: /root/ltp-full-20091231/testcases/bin: No such file or directory
).

-serge

diff -Nrup ltp-full-20091231.orig/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile ltp-full-20091231/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile
--- ltp-full-20091231.orig/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile	2009-10-10 19:53:29.000000000 -0400
+++ ltp-full-20091231/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile	2010-01-06 13:43:19.000000000 -0500
@@ -33,19 +33,16 @@ CHECKPOLICY_VERS	?= $(shell $(CHECKPOLIC
 
 CLEAN_TARGETS		:= test_policy.te
 
-INSTALL_TARGETS		:= *.te
+INSTALL_TARGETS		:= $(REDHAT_VERS)/*.te
+INSTALL_TARGETS_FULL	:= $(builddir)/redhat/$(REDHAT_VERS)/*.te
 
 ifeq ($(CHECKPOLICY_VERS),24)
 INSTALL_TARGETS		:= $(filter-out %/test_bounds.te,$(INSTALL_TARGETS))
+INSTALL_TARGES_FULL		:= $(filter-out %/test_bounds.te,$(INSTALL_TARGES_FULL))
 endif
 
 TE_SRCDIR		:= $(abs_srcdir)
 
-ifeq (redhat-release-, $(findstring redhat-release-, $(REDHAT_RELEASE)))
-ifneq ($(wildcard $(abs_srcdir)/redhat/$(REDHAT_VER)),)
-TE_SRCDIR		:= $(abs_srcdir)/redhat/$(REDHAT_VER)
-endif
-endif
 
 .PHONY: all clean cleanup install load
 
@@ -60,14 +57,18 @@ cleanup:
 install: all
 
 # load remains for backwards compatibility...
-load: $(builddir)/test_policy.te
+load:
+ifeq (redhat-release-, $(findstring redhat-release-, $(REDHAT_RELEASE)))
+	$(MAKE) -C redhat/$(REDHAT_VERS)
+else
 	@if [ -d "$(POLICYDEVEL)" ]; then \
-	    cp -p $(builddir)/test_policy.* $(INSTALL_TARGETS) $(POLICY_DEVEL); \
+	    cp -p $(builddir)/test_policy.* $(INSTALL_TARGETS_FULL) $(POLICYDEVEL); \
 	    $(MAKE) -C $(POLICYDEVEL) clean test_policy.pp; \
 	    $(SEMODULE) -i $(POLICYDEVEL)/test_policy.pp; \
 	else \
             echo "ERROR: You must have selinux-policy-devel installed."; \
 	fi
+endif
 
 $(builddir)/test_policy.te:
 	(cd "$(TE_SRCDIR)" && cat $(INSTALL_TARGETS)) > "$@";

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
