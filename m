Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sds@tycho.nsa.gov>) id 1NUm9Z-0002gP-HV
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 19:11:45 +0000
Received: from msux-gh1-uea01.nsa.gov ([63.239.67.1])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NUm9X-0003Wl-2O
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 19:11:45 +0000
From: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <364299f41001120926s45ab6b24i485a0fd0ba499f41@mail.gmail.com>
References: <364299f41001081338u37e77cd3q3d9535f3dec71331@mail.gmail.com>
	<20100111195043.GA23360@us.ibm.com>
	<1263239706.5091.11.camel@moss-pluto.epoch.ncsc.mil>
	<20100111201936.GA24711@us.ibm.com> <20100111205858.GA26412@us.ibm.com>
	<20100111210006.GA26554@us.ibm.com> <20100111213100.GA28138@us.ibm.com>
	<1263302168.14187.13.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001120855r653842d3x630cdaa6ec4129b6@mail.gmail.com>
	<364299f41001120919w3b56bfefoc5b7a1e6a4e96f1@mail.gmail.com>
	<364299f41001120926s45ab6b24i485a0fd0ba499f41@mail.gmail.com>
Date: Tue, 12 Jan 2010 14:12:35 -0500
Message-Id: <1263323555.16277.11.camel@moss-pluto.epoch.ncsc.mil>
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
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>, ltp-list@lists.sourceforge.net

On Tue, 2010-01-12 at 09:26 -0800, Garrett Cooper wrote:
> > Also, if you guys can try out this patch for refpolicy/Makefile, I'd
> > prefer to check it in (it unifies the RHEL 4.x and `generic' refpolicy
> > Make logic):
> >
> > Index: refpolicy/Makefile
> > ===================================================================
> > RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile,v
> > retrieving revision 1.12
> > diff -u -r1.12 Makefile
> > --- refpolicy/Makefile  8 Jan 2010 09:39:20 -0000       1.12
> > +++ refpolicy/Makefile  12 Jan 2010 17:17:27 -0000
> > @@ -17,7 +17,7 @@
> >  #    with this program; if not, write to the Free Software Foundation, Inc.,
> >  #    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> >  #
> > -# Garrett Cooper, August 2009
> > +# Garrett Cooper, January 2010
> >  #
> >
> >  top_srcdir             ?= ../../../../..
> > @@ -32,6 +32,7 @@
> >
> >  DISTRO_VER             := $(shell $(top_srcdir)/scripts/detect_distro.sh $(ARGS))
> >
> > +# Avoid empty strings.
> >  ifeq ($(strip $(DISTRO_VER)),)
> >  DISTRO_VER             := generic
> >  endif
> > @@ -41,10 +42,17 @@
> >  POLICY_DEVEL_DIR       ?= $(DESTDIR)/usr/share/selinux/devel
> >  SEMODULE               ?= $(DESTDIR)/usr/sbin/semodule
> >
> > -INSTALL_DIR            := testcases/kernel/security/selinux-testsuite
> > +INSTALL_DIR            := testcases/selinux-testsuite/refpolicy
> >
> >  TEST_POLICY_DIR                := $(abs_srcdir)/policy_files
> >
> > +# Do we have a special set of policies in the SCM to install?
> > +ifneq ($(wildcard $(TEST_POLICY_DIR)/$(DISTRO_VER)/),)
> > +TEST_POLICY_DIR                := $(TEST_POLICY_DIR)/$(DISTRO_VER)
> > +else
> > +TEST_POLICY_DIR                := $(TEST_POLICY_DIR)/generic
> > +endif
> > +
> >  .PHONY: all clean cleanup install load
> >
> >  CLEAN_DEPS             := cleanup
> > @@ -55,34 +63,24 @@
> >        -$(SEMODULE) -r test_policy
> >        $(RM) -f $(POLICY_DEVEL_DIR)/test_policy.* test_policy.te
> >
> > -ifneq ($(wildcard $(TEST_POLICY_DIR)/$(DISTRO_VER)/Makefile),)
> > -MAKE_TARGETS           :=
> > -
> > -TEST_POLICY_DIR                := $(TEST_POLICY_DIR)/$(DISTRO_VER)
> > -
> > -# load remains for backwards compatibility...
> > -load:
> > -       $(MAKE) -C $(TEST_POLICY_DIR)
> > -else
> > -
> >  MAKE_TARGETS           := test_policy.te
> >
> > -TEST_POLICY_DIR                := $(TEST_POLICY_DIR)/generic
> > -
> > -POLICY_FILES           := test_global.te $(filter-out test_global.te,$(notdir
> > $(wildcard $(TEST_POLICY_DIR)/*.te)))
> > -
> >  ifneq ($(CHECKPOLICY_VERS),24)
> >  POLICY_FILES           := $(filter-out test_bounds.te,$(POLICY_FILES))
> >  endif
> >
> > +# This is being done to preserve precedence; test_global.te must come first.
> > +POLICY_FILES           := test_global.te \
> > +                          $(filter-out test_global.te,$(notdir $(wildcard
> > $(TEST_POLICY_DIR)/*.te)))
> > +
> >  load:
> > -       @if [ -d "$(POLICY_DEVEL_DIR)" ]; then \
> > -           cp -p $(TEST_POLICY_DIR)/test_policy.* $(POLICY_DEVEL_DIR); \
> > +       @set -e; if [ -d "$(POLICY_DEVEL_DIR)" ]; then \
> > +           cp -p test_policy.* $(POLICY_DEVEL_DIR); \
> >            $(MAKE) -C $(POLICY_DEVEL_DIR) clean; \
> >            $(MAKE) -C $(POLICY_DEVEL_DIR) test_policy.pp; \
> >            $(SEMODULE) -i $(POLICY_DEVEL_DIR)/test_policy.pp; \
> >        else \
> > -            echo "ERROR: You must have selinux-policy-devel installed."; \
> > +            echo "ERROR: You must have selinux-policy?-devel? installed."; \
> >            false; \
> >        fi
> 
> There's a stray endif on line 90 of refpolicy/Makefile that needs to
> be deleted as well, FYI...

Ok.  test policy appears to build (on Fedora) when running make by hand
from the refpolicy directory, but you still can't run the tests, either
from /opt/ltp or from the source tree.

# cd /opt/ltp/testscripts && ./test_selinux.sh 
Running with security context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
/etc/selinux /opt/ltp
/opt/ltp
allow_domain_fd_use --> off
allow_domain_fd_use exists setting
building and installing test_policy module...
./test_selinux.sh: line 92: cd: /opt/ltp/testcases/kernel/security/selinux-testsuite/refpolicy: No such file or directory
make: *** No rule to make target `load'.  Stop.
Failed to build and load test_policy module, aborting test run.
/etc/selinux /opt/ltp
/opt/ltp

# cd LTP_SRCDIR/testscripts && ./test_selinux.sh
Running with security context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
/etc/selinux /home/sds/ltp
/home/sds/ltp
allow_domain_fd_use --> off
allow_domain_fd_use exists setting
building and installing test_policy module...
make[1]: Entering directory `/usr/share/selinux/devel'
rm -fR tmp
rm -f *.pp
make[1]: Leaving directory `/usr/share/selinux/devel'
make[1]: Entering directory `/usr/share/selinux/devel'
Compiling targeted test_policy module
/usr/bin/checkmodule:  loading policy configuration from tmp/test_policy.tmp
/usr/bin/checkmodule:  policy configuration loaded
/usr/bin/checkmodule:  writing binary representation (version 10) to tmp/test_policy.mod
Creating targeted test_policy.pp policy package
rm tmp/test_policy.mod tmp/test_policy.mod.fc
make[1]: Leaving directory `/usr/share/selinux/devel'
Successfully built and loaded test_policy module.
/etc/selinux /home/sds/ltp/testcases/kernel/security/selinux-testsuite/refpolicy
/home/sds/ltp/testcases/kernel/security/selinux-testsuite/refpolicy
Running the SELinux testsuite...
ls: cannot access /home/sds/ltp/testcases/bin: No such file or directory
/usr/bin/chcon: cannot access `/home/sds/ltp/testcases/bin': No such file or directory
./test_selinux.sh: line 119: /home/sds/ltp/bin/ltp-pan: No such file or directory
/usr/bin/chcon: missing operand
Try `/usr/bin/chcon --help' for more information.
Removing test_policy module...
/usr/sbin/semodule -r test_policy
rm -f -f /usr/share/selinux/devel/test_policy.* test_policy.te
allow_domain_fd_use --> off
allow_domain_fd_use exists setting
Done.

Both test_selinux.sh and tests/runtest.sh need to be updated.

-- 
Stephen Smalley
National Security Agency


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
