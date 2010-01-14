Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sds@tycho.nsa.gov>) id 1NVWOk-0005Cx-P4
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 20:34:30 +0000
Received: from msux-gh1-uea02.nsa.gov ([63.239.67.2])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NVWOi-00029j-C3
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 20:34:30 +0000
From: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <364299f41001141210o49c97980yc703601e7340362f@mail.gmail.com>
References: <364299f41001120855r653842d3x630cdaa6ec4129b6@mail.gmail.com>
	<1263390194.31509.4.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001131052s27019ebl53f4e3f76bb4598e@mail.gmail.com>
	<1263410323.901.5.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001131137j36d1c665r45cb8b6163263428@mail.gmail.com>
	<1263412198.901.11.camel@moss-pluto.epoch.ncsc.mil>
	<20100113220021.GA838@us.ibm.com>
	<1263420212.901.64.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001131449w751889b8r98aca16ea1e8957a@mail.gmail.com>
	<1263478021.8548.3.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001141210o49c97980yc703601e7340362f@mail.gmail.com>
Date: Thu, 14 Jan 2010 15:35:50 -0500
Message-Id: <1263501350.8548.60.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Subject: Re: [LTP] regression: selinux testsuite broken since October
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>, ltp-list@lists.sourceforge.net

On Thu, 2010-01-14 at 12:10 -0800, Garrett Cooper wrote:
> On Thu, Jan 14, 2010 at 6:07 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Wed, 2010-01-13 at 14:49 -0800, Garrett Cooper wrote:
> >> Which is what it's doing now, but the original author of the test
> >> wrote the load logic and unload logic so that it used make instead of
> >> using a bourne shell script, etc.
> >
> > To clarify, there are two things happening under that load target
> > presently, one of which is properly handled at build time and one of
> > which is properly handled at test execution time.  The first part is
> > building test_policy.pp.  The latter is running semodule -i
> > test_policy.pp.  So we could split up the Makefile so that the first
> > part is done by the make all/install, and test_selinux.sh merely runs
> > semodule -i test_policy.pp before the test and semodule -r test_policy
> > after the test.  One other item I notice is that the current logic
> > copies test_policy* to $POLICY_DEVEL_DIR and runs make there, which
> > isn't necessary - you could just leave them in the refpolicy directory
> > and run make -f $POLICY_DEVEL_DIR/Makefile test_policy.pp.
> 
> Ok, this is interesting. So -- is there any particular reason why
> clean (which in this case just called cleanup) should be called before
> load?
> 
> So at the end of the day, all of the junk done as part of `load' could
> in fact be done in test_selinux.sh // runtests.sh (I assume the only
> step that couldn't be done is semodule -i? I don't have any hard
> feelings for not putting that logic in those scripts...

I guess I'm not being clear.  Most of the work presently done by 'load'
can be done during make all/install.  In particular, everything except
for running semodule -i can be done during make all, and then make
install should just copy test_policy.pp (the output of make all) to
the /opt/ltp tree.  Then test_selinux.sh only needs to run semodule
-i /path/to/test_policy.pp before the tests and semodule -r test_policy
afterward.  We can also avoid copying test_policy.te to the system
policy devel directory altogether.  Something like this patch (and
Makefile.selinux can then be removed altogether):

Index: testscripts/test_selinux.sh
===================================================================
RCS file: /cvsroot/ltp/ltp/testscripts/test_selinux.sh,v
retrieving revision 1.15
diff -u -r1.15 test_selinux.sh
--- testscripts/test_selinux.sh	13 Jan 2010 18:50:53 -0000	1.15
+++ testscripts/test_selinux.sh	14 Jan 2010 20:32:35 -0000
@@ -89,11 +89,10 @@
 config_allow_domain_fd_use 0
 
 # build and install the test policy...
-echo "building and installing test_policy module..."
-cd $POLICYDIR
-make load
+echo "installing test_policy module..."
+$(SEMODULE) -i $POLICYDIR/test_policy.pp
 if [ $? != 0 ]; then
-	echo "Failed to build and load test_policy module, aborting test run."
+	echo "Failed to install load test_policy module, aborting test run."
 	config_unset_expandcheck
 	exit 1
 else
@@ -126,8 +125,7 @@
 /usr/bin/chcon -t $SAVEBINTYPE $LTPROOT/testcases/bin
 
 echo "Removing test_policy module..."
-cd $POLICYDIR
-make cleanup 2>&1
+$(SEMODULE) -r test_policy
 if [ $? != 0 ]; then
 	echo "Failed to remove test_policy module."
 	exit 1
Index: testcases/kernel/security/selinux-testsuite/refpolicy/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile,v
retrieving revision 1.17
diff -u -r1.17 Makefile
--- testcases/kernel/security/selinux-testsuite/refpolicy/Makefile	14 Jan 2010 12:40:58 -0000	1.17
+++ testcases/kernel/security/selinux-testsuite/refpolicy/Makefile	14 Jan 2010 20:32:35 -0000
@@ -39,10 +39,11 @@
 
 CHECKPOLICY		?= $(DESTDIR)/usr/bin/checkpolicy
 CHECKPOLICY_VERS	?= $(shell $(CHECKPOLICY) -V |cut -f 1 -d ' ')
+POLICY_DEVEL_DIR	?= $(DESTDIR)/usr/share/selinux/devel
 
 INSTALL_DIR		:= testcases/kernel/security/selinux-testsuite/refpolicy
 
-INSTALL_TARGETS		:= Makefile.selinux
+INSTALL_TARGETS		:= test_policy.pp
 
 TEST_POLICY_DIR		:= $(abs_srcdir)/policy_files
 
@@ -63,8 +64,17 @@
 POLICY_FILES		:= test_global.te \
 			   $(filter-out test_global.te,$(notdir $(wildcard $(TEST_POLICY_DIR)/*.te)))
 
+all: test_policy.pp
+
+test_policy.pp: test_policy.te
+	@set -e; if [ -d "$(POLICY_DEVEL_DIR)" ]; then \
+	    $(MAKE) -f $(POLICY_DEVEL_DIR)/Makefile test_policy.pp; \
+	else \
+            echo "ERROR: You must have selinux-policy?-devel? installed."; \
+	    false; \
+	fi
+
 test_policy.te: $(addprefix $(TEST_POLICY_DIR)/,$(POLICY_FILES))
 	(cd "$(TEST_POLICY_DIR)" && cat $(POLICY_FILES)) > $@
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-include $(abs_srcdir)/Makefile.selinux


-- 
Stephen Smalley
National Security Agency


------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
