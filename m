Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NUx56-0005mE-9R
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 06:51:52 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NUx55-0006WX-75
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 06:51:52 +0000
Received: by pxi38 with SMTP id 38so11091600pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jan 2010 22:51:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1263323555.16277.11.camel@moss-pluto.epoch.ncsc.mil>
References: <364299f41001081338u37e77cd3q3d9535f3dec71331@mail.gmail.com>
	<20100111201936.GA24711@us.ibm.com>
	<20100111205858.GA26412@us.ibm.com>
	<20100111210006.GA26554@us.ibm.com>
	<20100111213100.GA28138@us.ibm.com>
	<1263302168.14187.13.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001120855r653842d3x630cdaa6ec4129b6@mail.gmail.com>
	<364299f41001120919w3b56bfefoc5b7a1e6a4e96f1@mail.gmail.com>
	<364299f41001120926s45ab6b24i485a0fd0ba499f41@mail.gmail.com>
	<1263323555.16277.11.camel@moss-pluto.epoch.ncsc.mil>
Date: Tue, 12 Jan 2010 22:51:45 -0800
Message-ID: <364299f41001122251v49ec2743j6c57ada7bd6eaf3f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>, ltp-list@lists.sourceforge.net

On Tue, Jan 12, 2010 at 11:12 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2010-01-12 at 09:26 -0800, Garrett Cooper wrote:
>> > Also, if you guys can try out this patch for refpolicy/Makefile, I'd
>> > prefer to check it in (it unifies the RHEL 4.x and `generic' refpolicy
>> > Make logic):
>> >
>> > Index: refpolicy/Makefile
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite=
/refpolicy/Makefile,v
>> > retrieving revision 1.12
>> > diff -u -r1.12 Makefile
>> > --- refpolicy/Makefile =A08 Jan 2010 09:39:20 -0000 =A0 =A0 =A0 1.12
>> > +++ refpolicy/Makefile =A012 Jan 2010 17:17:27 -0000
>> > @@ -17,7 +17,7 @@
>> > =A0# =A0 =A0with this program; if not, write to the Free Software Foun=
dation, Inc.,
>> > =A0# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> > =A0#
>> > -# Garrett Cooper, August 2009
>> > +# Garrett Cooper, January 2010
>> > =A0#
>> >
>> > =A0top_srcdir =A0 =A0 =A0 =A0 =A0 =A0 ?=3D ../../../../..
>> > @@ -32,6 +32,7 @@
>> >
>> > =A0DISTRO_VER =A0 =A0 =A0 =A0 =A0 =A0 :=3D $(shell $(top_srcdir)/scrip=
ts/detect_distro.sh $(ARGS))
>> >
>> > +# Avoid empty strings.
>> > =A0ifeq ($(strip $(DISTRO_VER)),)
>> > =A0DISTRO_VER =A0 =A0 =A0 =A0 =A0 =A0 :=3D generic
>> > =A0endif
>> > @@ -41,10 +42,17 @@
>> > =A0POLICY_DEVEL_DIR =A0 =A0 =A0 ?=3D $(DESTDIR)/usr/share/selinux/devel
>> > =A0SEMODULE =A0 =A0 =A0 =A0 =A0 =A0 =A0 ?=3D $(DESTDIR)/usr/sbin/semod=
ule
>> >
>> > -INSTALL_DIR =A0 =A0 =A0 =A0 =A0 =A0:=3D testcases/kernel/security/sel=
inux-testsuite
>> > +INSTALL_DIR =A0 =A0 =A0 =A0 =A0 =A0:=3D testcases/selinux-testsuite/r=
efpolicy
>> >
>> > =A0TEST_POLICY_DIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(abs_srcdir)/p=
olicy_files
>> >
>> > +# Do we have a special set of policies in the SCM to install?
>> > +ifneq ($(wildcard $(TEST_POLICY_DIR)/$(DISTRO_VER)/),)
>> > +TEST_POLICY_DIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(TEST_POLICY_DIR=
)/$(DISTRO_VER)
>> > +else
>> > +TEST_POLICY_DIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(TEST_POLICY_DIR=
)/generic
>> > +endif
>> > +
>> > =A0.PHONY: all clean cleanup install load
>> >
>> > =A0CLEAN_DEPS =A0 =A0 =A0 =A0 =A0 =A0 :=3D cleanup
>> > @@ -55,34 +63,24 @@
>> > =A0 =A0 =A0 =A0-$(SEMODULE) -r test_policy
>> > =A0 =A0 =A0 =A0$(RM) -f $(POLICY_DEVEL_DIR)/test_policy.* test_policy.=
te
>> >
>> > -ifneq ($(wildcard $(TEST_POLICY_DIR)/$(DISTRO_VER)/Makefile),)
>> > -MAKE_TARGETS =A0 =A0 =A0 =A0 =A0 :=3D
>> > -
>> > -TEST_POLICY_DIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(TEST_POLICY_DIR=
)/$(DISTRO_VER)
>> > -
>> > -# load remains for backwards compatibility...
>> > -load:
>> > - =A0 =A0 =A0 $(MAKE) -C $(TEST_POLICY_DIR)
>> > -else
>> > -
>> > =A0MAKE_TARGETS =A0 =A0 =A0 =A0 =A0 :=3D test_policy.te
>> >
>> > -TEST_POLICY_DIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(TEST_POLICY_DIR=
)/generic
>> > -
>> > -POLICY_FILES =A0 =A0 =A0 =A0 =A0 :=3D test_global.te $(filter-out tes=
t_global.te,$(notdir
>> > $(wildcard $(TEST_POLICY_DIR)/*.te)))
>> > -
>> > =A0ifneq ($(CHECKPOLICY_VERS),24)
>> > =A0POLICY_FILES =A0 =A0 =A0 =A0 =A0 :=3D $(filter-out test_bounds.te,$=
(POLICY_FILES))
>> > =A0endif
>> >
>> > +# This is being done to preserve precedence; test_global.te must come=
 first.
>> > +POLICY_FILES =A0 =A0 =A0 =A0 =A0 :=3D test_global.te \
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$(filter-out test=
_global.te,$(notdir $(wildcard
>> > $(TEST_POLICY_DIR)/*.te)))
>> > +
>> > =A0load:
>> > - =A0 =A0 =A0 @if [ -d "$(POLICY_DEVEL_DIR)" ]; then \
>> > - =A0 =A0 =A0 =A0 =A0 cp -p $(TEST_POLICY_DIR)/test_policy.* $(POLICY_=
DEVEL_DIR); \
>> > + =A0 =A0 =A0 @set -e; if [ -d "$(POLICY_DEVEL_DIR)" ]; then \
>> > + =A0 =A0 =A0 =A0 =A0 cp -p test_policy.* $(POLICY_DEVEL_DIR); \
>> > =A0 =A0 =A0 =A0 =A0 =A0$(MAKE) -C $(POLICY_DEVEL_DIR) clean; \
>> > =A0 =A0 =A0 =A0 =A0 =A0$(MAKE) -C $(POLICY_DEVEL_DIR) test_policy.pp; \
>> > =A0 =A0 =A0 =A0 =A0 =A0$(SEMODULE) -i $(POLICY_DEVEL_DIR)/test_policy.=
pp; \
>> > =A0 =A0 =A0 =A0else \
>> > - =A0 =A0 =A0 =A0 =A0 =A0echo "ERROR: You must have selinux-policy-dev=
el installed."; \
>> > + =A0 =A0 =A0 =A0 =A0 =A0echo "ERROR: You must have selinux-policy?-de=
vel? installed."; \
>> > =A0 =A0 =A0 =A0 =A0 =A0false; \
>> > =A0 =A0 =A0 =A0fi
>>
>> There's a stray endif on line 90 of refpolicy/Makefile that needs to
>> be deleted as well, FYI...
>
> Ok. =A0test policy appears to build (on Fedora) when running make by hand
> from the refpolicy directory, but you still can't run the tests, either
> from /opt/ltp or from the source tree.
>
> # cd /opt/ltp/testscripts && ./test_selinux.sh
> Running with security context=3Dunconfined_u:unconfined_r:unconfined_t:s0=
-s0:c0.c1023
> /etc/selinux /opt/ltp
> /opt/ltp
> allow_domain_fd_use --> off
> allow_domain_fd_use exists setting
> building and installing test_policy module...
> ./test_selinux.sh: line 92: cd: /opt/ltp/testcases/kernel/security/selinu=
x-testsuite/refpolicy: No such file or directory
> make: *** No rule to make target `load'. =A0Stop.
> Failed to build and load test_policy module, aborting test run.
> /etc/selinux /opt/ltp
> /opt/ltp
>
> # cd LTP_SRCDIR/testscripts && ./test_selinux.sh
> Running with security context=3Dunconfined_u:unconfined_r:unconfined_t:s0=
-s0:c0.c1023
> /etc/selinux /home/sds/ltp
> /home/sds/ltp
> allow_domain_fd_use --> off
> allow_domain_fd_use exists setting
> building and installing test_policy module...
> make[1]: Entering directory `/usr/share/selinux/devel'
> rm -fR tmp
> rm -f *.pp
> make[1]: Leaving directory `/usr/share/selinux/devel'
> make[1]: Entering directory `/usr/share/selinux/devel'
> Compiling targeted test_policy module
> /usr/bin/checkmodule: =A0loading policy configuration from tmp/test_polic=
y.tmp
> /usr/bin/checkmodule: =A0policy configuration loaded
> /usr/bin/checkmodule: =A0writing binary representation (version 10) to tm=
p/test_policy.mod
> Creating targeted test_policy.pp policy package
> rm tmp/test_policy.mod tmp/test_policy.mod.fc
> make[1]: Leaving directory `/usr/share/selinux/devel'
> Successfully built and loaded test_policy module.
> /etc/selinux /home/sds/ltp/testcases/kernel/security/selinux-testsuite/re=
fpolicy
> /home/sds/ltp/testcases/kernel/security/selinux-testsuite/refpolicy
> Running the SELinux testsuite...
> ls: cannot access /home/sds/ltp/testcases/bin: No such file or directory
> /usr/bin/chcon: cannot access `/home/sds/ltp/testcases/bin': No such file=
 or directory
> ./test_selinux.sh: line 119: /home/sds/ltp/bin/ltp-pan: No such file or d=
irectory
> /usr/bin/chcon: missing operand
> Try `/usr/bin/chcon --help' for more information.
> Removing test_policy module...
> /usr/sbin/semodule -r test_policy
> rm -f -f /usr/share/selinux/devel/test_policy.* test_policy.te
> allow_domain_fd_use --> off
> allow_domain_fd_use exists setting
> Done.
>
> Both test_selinux.sh and tests/runtest.sh need to be updated.
>
> --
> Stephen Smalley
> National Security Agency

    Ok, next patch then... Let me know how this goes (I took a quick
look and I didn't see anything suspicious in the test scripts
themselves..).
Thanks,
-Garrett

Index: tests/runtest.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/test=
s/runtest.sh,v
retrieving revision 1.2
diff -u -r1.2 runtest.sh
--- tests/runtest.sh	6 Apr 2008 10:27:36 -0000	1.2
+++ tests/runtest.sh	13 Jan 2010 06:49:48 -0000
@@ -12,7 +12,7 @@
 global_setup()
 {
 	# Must be root to run the selinux testsuite
-	if [ $UID !=3D 0 ]
+	if [ $(id -ru) -ne 0 ]
 	then
         	echo "FAILED: Must be root to execute this script"
         	exit 1
@@ -38,14 +38,14 @@
 		exit
 	fi

-	# Save and later restore /tmp's type.
+	# Save and later restore $TMP's type.
 	# We need to change it's type to work within test domain
-	SAVETMPTYPE=3D`ls -Zd /tmp | awk '{ print $4 }' | awk -F: '{ print $3 }'`
-	chcon -t test_file_t /tmp
+	SAVETMPTYPE=3D`ls -Zd $TMP | awk '{ print $4 }' | awk -F: '{ print $3 }'`
+	chcon -t test_file_t $TMP

-	mkdir /tmp/selinux > /dev/null 2>&1
-	chcon -t test_file_t /tmp/selinux
-	export SELINUXTMPDIR=3D/tmp/selinux
+	mkdir $TMP/selinux > /dev/null 2>&1
+	chcon -t test_file_t $TMP/selinux
+	export SELINUXTMPDIR=3D$TMP/selinux
 	=

 	# It seems LTP wants executables to reside in the
 	# $LTPROOT/testcases/bin directory. However, this directory
@@ -61,9 +61,9 @@
 global_cleanup()
 {

-	# Restore original type of /tmp
-	chcon -t $SAVETMPTYPE /tmp
-	rm -rf /tmp/selinux
+	# Restore original type of $TMP
+	chcon -t $SAVETMPTYPE $TMP
+	rm -rf $TMP/selinux

 	# Restore original type of .../testcases/bin directory
 	chcon -t $SAVEBINTYPE $LTPBIN
@@ -71,6 +71,7 @@
 	exit 0
 }

+export TMP=3D${TMP:-/tmp}
 global_setup
-./$1/selinux_$1.sh
+selinux_$1.sh
 global_cleanup
Index: ../../../../testscripts/test_selinux.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testscripts/test_selinux.sh,v
retrieving revision 1.14
diff -u -r1.14 test_selinux.sh
--- ../../../../testscripts/test_selinux.sh	12 Jan 2010 08:35:59 -0000	1.14
+++ ../../../../testscripts/test_selinux.sh	13 Jan 2010 06:49:48 -0000
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) International Business Machines  Corp., 2005
 #
@@ -23,32 +23,33 @@
 }

 config_allow_domain_fd_use () {
-    setval=3D$1
-    /usr/sbin/getsebool allow_domain_fd_use
-    getseRC=3D$?
-    if [ "$getseRC" -eq "0" ]; then
-	echo "allow_domain_fd_use exists setting"
-	/usr/sbin/setsebool allow_domain_fd_use=3D$setval
-    fi
+	setval=3D$1
+	if /usr/sbin/getsebool allow_domain_fd_use; then
+		echo "allow_domain_fd_use exists setting"
+		/usr/sbin/setsebool allow_domain_fd_use=3D$setval
+	fi
 }

 # Must be root to run the selinux testsuite
-if [ $UID !=3D 0 ]
+if [ $(id -ru) -ne 0 ]
 then
         echo "FAILED: Must be root to execute this script"
         exit 1
 fi

 # set the LTPROOT directory
-cd `dirname $0`
-LTPROOT=3D${PWD}
-TMP=3D${TMP:-/tmp}
-echo $LTPROOT | grep testscripts > /dev/null 2>&1
-if [ $? -eq 0 ]
+LTPROOT=3D${LTPROOT:=3D${0%/*}}
+cd "$LTPROOT"
+export TMP=3D${TMP:-/tmp}
+# If we're in the testscripts directory, go down a dir..
+LTPROOT_TMP=3D${LTPROOT%/testscripts}
+if [ "x${LTPROOT_TMP}" !=3D "x${LTPROOT}" ]
 then
 	cd ..
-	LTPROOT=3D${PWD}
+	LTPROOT=3D$LTPROOT_TMP
 fi
+export LTPROOT
+unset LTPROOT_TMP

 # set the PATH to include testcase/bin

@@ -57,11 +58,8 @@

 # We will store the logfiles in $LTPROOT/results, so make sure
 # it exists.
-if [ ! -d $LTPROOT/results ]
-then
-	/bin/mkdir $LTPROOT/results
-fi
-	=

+test -d $LTPROOT/results || /bin/mkdir $LTPROOT/results
+
 # Check the role and mode testsuite is being executed under.

 SELINUX_CONTEXT=3D`/usr/bin/id | sed 's/.* //'`
@@ -78,10 +76,12 @@

 SEMODULE=3D"/usr/sbin/semodule"

-if [ -f $SEMODULE ]; then
-    POLICYDIR=3D"$LTPROOT/testcases/selinux-testsuite/refpolicy"
+POLICYDIR=3D"$LTPROOT/testcases/kernel/security/selinux-testsuite"
+
+if [ -x $SEMODULE ]; then
+	POLICYDIR=3D"$POLICYDIR/refpolicy"
 else
-    POLICYDIR=3D"$LTPROOT/testcases/selinux-testsuite/policy"
+	POLICYDIR=3D"$POLICYDIR/policy"
 fi

 config_set_expandcheck
@@ -137,4 +137,3 @@

 cd $LTPROOT
 echo "Done."
-exit 0

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
