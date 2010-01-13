Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NV92B-0004P1-1P
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 19:37:39 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NV928-0005d3-5h
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 19:37:38 +0000
Received: by pwj11 with SMTP id 11so3699272pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Jan 2010 11:37:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1263410323.901.5.camel@moss-pluto.epoch.ncsc.mil>
References: <364299f41001081338u37e77cd3q3d9535f3dec71331@mail.gmail.com>
	<1263302168.14187.13.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001120855r653842d3x630cdaa6ec4129b6@mail.gmail.com>
	<364299f41001120919w3b56bfefoc5b7a1e6a4e96f1@mail.gmail.com>
	<364299f41001120926s45ab6b24i485a0fd0ba499f41@mail.gmail.com>
	<1263323555.16277.11.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001122251v49ec2743j6c57ada7bd6eaf3f@mail.gmail.com>
	<1263390194.31509.4.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001131052s27019ebl53f4e3f76bb4598e@mail.gmail.com>
	<1263410323.901.5.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 13 Jan 2010 11:37:27 -0800
Message-ID: <364299f41001131137j36d1c665r45cb8b6163263428@mail.gmail.com>
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

On Wed, Jan 13, 2010 at 11:18 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2010-01-13 at 10:52 -0800, Garrett Cooper wrote:
>> On Wed, Jan 13, 2010 at 5:43 AM, Stephen Smalley <sds@tycho.nsa.gov> wro=
te:
>> > On Tue, 2010-01-12 at 22:51 -0800, Garrett Cooper wrote:
>> >> On Tue, Jan 12, 2010 at 11:12 AM, Stephen Smalley <sds@tycho.nsa.gov>=
 wrote:
>> >> > On Tue, 2010-01-12 at 09:26 -0800, Garrett Cooper wrote:
>> >> >> > Also, if you guys can try out this patch for refpolicy/Makefile,=
 I'd
>> >> >> > prefer to check it in (it unifies the RHEL 4.x and `generic' ref=
policy
>> >> >> > Make logic):
>> >> >> >
>> >> >> > Index: refpolicy/Makefile
>> >> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> >> > RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-tes=
tsuite/refpolicy/Makefile,v
>> >> >> > retrieving revision 1.12
>> >> >> > diff -u -r1.12 Makefile
>> >> >> > --- refpolicy/Makefile =A08 Jan 2010 09:39:20 -0000 =A0 =A0 =A0 =
1.12
>> >> >> > +++ refpolicy/Makefile =A012 Jan 2010 17:17:27 -0000
>> >> >> > @@ -17,7 +17,7 @@
>> >> >> > =A0# =A0 =A0with this program; if not, write to the Free Softwar=
e Foundation, Inc.,
>> >> >> > =A0# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-13=
01 USA.
>> >> >> > =A0#
>> >> >> > -# Garrett Cooper, August 2009
>> >> >> > +# Garrett Cooper, January 2010
>> >> >> > =A0#
>> >> >> >
>> >> >> > =A0top_srcdir =A0 =A0 =A0 =A0 =A0 =A0 ?=3D ../../../../..
>> >> >> > @@ -32,6 +32,7 @@
>> >> >> >
>> >> >> > =A0DISTRO_VER =A0 =A0 =A0 =A0 =A0 =A0 :=3D $(shell $(top_srcdir)=
/scripts/detect_distro.sh $(ARGS))
>> >> >> >
>> >> >> > +# Avoid empty strings.
>> >> >> > =A0ifeq ($(strip $(DISTRO_VER)),)
>> >> >> > =A0DISTRO_VER =A0 =A0 =A0 =A0 =A0 =A0 :=3D generic
>> >> >> > =A0endif
>> >> >> > @@ -41,10 +42,17 @@
>> >> >> > =A0POLICY_DEVEL_DIR =A0 =A0 =A0 ?=3D $(DESTDIR)/usr/share/selinu=
x/devel
>> >> >> > =A0SEMODULE =A0 =A0 =A0 =A0 =A0 =A0 =A0 ?=3D $(DESTDIR)/usr/sbin=
/semodule
>> >> >> >
>> >> >> > -INSTALL_DIR =A0 =A0 =A0 =A0 =A0 =A0:=3D testcases/kernel/securi=
ty/selinux-testsuite
>> >> >> > +INSTALL_DIR =A0 =A0 =A0 =A0 =A0 =A0:=3D testcases/selinux-tests=
uite/refpolicy
>> >> >> >
>> >> >> > =A0TEST_POLICY_DIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(abs_src=
dir)/policy_files
>> >> >> >
>> >> >> > +# Do we have a special set of policies in the SCM to install?
>> >> >> > +ifneq ($(wildcard $(TEST_POLICY_DIR)/$(DISTRO_VER)/),)
>> >> >> > +TEST_POLICY_DIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(TEST_POLI=
CY_DIR)/$(DISTRO_VER)
>> >> >> > +else
>> >> >> > +TEST_POLICY_DIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(TEST_POLI=
CY_DIR)/generic
>> >> >> > +endif
>> >> >> > +
>> >> >> > =A0.PHONY: all clean cleanup install load
>> >> >> >
>> >> >> > =A0CLEAN_DEPS =A0 =A0 =A0 =A0 =A0 =A0 :=3D cleanup
>> >> >> > @@ -55,34 +63,24 @@
>> >> >> > =A0 =A0 =A0 =A0-$(SEMODULE) -r test_policy
>> >> >> > =A0 =A0 =A0 =A0$(RM) -f $(POLICY_DEVEL_DIR)/test_policy.* test_p=
olicy.te
>> >> >> >
>> >> >> > -ifneq ($(wildcard $(TEST_POLICY_DIR)/$(DISTRO_VER)/Makefile),)
>> >> >> > -MAKE_TARGETS =A0 =A0 =A0 =A0 =A0 :=3D
>> >> >> > -
>> >> >> > -TEST_POLICY_DIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(TEST_POLI=
CY_DIR)/$(DISTRO_VER)
>> >> >> > -
>> >> >> > -# load remains for backwards compatibility...
>> >> >> > -load:
>> >> >> > - =A0 =A0 =A0 $(MAKE) -C $(TEST_POLICY_DIR)
>> >> >> > -else
>> >> >> > -
>> >> >> > =A0MAKE_TARGETS =A0 =A0 =A0 =A0 =A0 :=3D test_policy.te
>> >> >> >
>> >> >> > -TEST_POLICY_DIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(TEST_POLI=
CY_DIR)/generic
>> >> >> > -
>> >> >> > -POLICY_FILES =A0 =A0 =A0 =A0 =A0 :=3D test_global.te $(filter-o=
ut test_global.te,$(notdir
>> >> >> > $(wildcard $(TEST_POLICY_DIR)/*.te)))
>> >> >> > -
>> >> >> > =A0ifneq ($(CHECKPOLICY_VERS),24)
>> >> >> > =A0POLICY_FILES =A0 =A0 =A0 =A0 =A0 :=3D $(filter-out test_bound=
s.te,$(POLICY_FILES))
>> >> >> > =A0endif
>> >> >> >
>> >> >> > +# This is being done to preserve precedence; test_global.te mus=
t come first.
>> >> >> > +POLICY_FILES =A0 =A0 =A0 =A0 =A0 :=3D test_global.te \
>> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$(filter-ou=
t test_global.te,$(notdir $(wildcard
>> >> >> > $(TEST_POLICY_DIR)/*.te)))
>> >> >> > +
>> >> >> > =A0load:
>> >> >> > - =A0 =A0 =A0 @if [ -d "$(POLICY_DEVEL_DIR)" ]; then \
>> >> >> > - =A0 =A0 =A0 =A0 =A0 cp -p $(TEST_POLICY_DIR)/test_policy.* $(P=
OLICY_DEVEL_DIR); \
>> >> >> > + =A0 =A0 =A0 @set -e; if [ -d "$(POLICY_DEVEL_DIR)" ]; then \
>> >> >> > + =A0 =A0 =A0 =A0 =A0 cp -p test_policy.* $(POLICY_DEVEL_DIR); \
>> >> >> > =A0 =A0 =A0 =A0 =A0 =A0$(MAKE) -C $(POLICY_DEVEL_DIR) clean; \
>> >> >> > =A0 =A0 =A0 =A0 =A0 =A0$(MAKE) -C $(POLICY_DEVEL_DIR) test_polic=
y.pp; \
>> >> >> > =A0 =A0 =A0 =A0 =A0 =A0$(SEMODULE) -i $(POLICY_DEVEL_DIR)/test_p=
olicy.pp; \
>> >> >> > =A0 =A0 =A0 =A0else \
>> >> >> > - =A0 =A0 =A0 =A0 =A0 =A0echo "ERROR: You must have selinux-poli=
cy-devel installed."; \
>> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0echo "ERROR: You must have selinux-poli=
cy?-devel? installed."; \
>> >> >> > =A0 =A0 =A0 =A0 =A0 =A0false; \
>> >> >> > =A0 =A0 =A0 =A0fi
>> >> >>
>> >> >> There's a stray endif on line 90 of refpolicy/Makefile that needs =
to
>> >> >> be deleted as well, FYI...
>> >> >
>> >> > Ok. =A0test policy appears to build (on Fedora) when running make b=
y hand
>> >> > from the refpolicy directory, but you still can't run the tests, ei=
ther
>> >> > from /opt/ltp or from the source tree.
>> >> >
>> >> > # cd /opt/ltp/testscripts && ./test_selinux.sh
>> >> > Running with security context=3Dunconfined_u:unconfined_r:unconfine=
d_t:s0-s0:c0.c1023
>> >> > /etc/selinux /opt/ltp
>> >> > /opt/ltp
>> >> > allow_domain_fd_use --> off
>> >> > allow_domain_fd_use exists setting
>> >> > building and installing test_policy module...
>> >> > ./test_selinux.sh: line 92: cd: /opt/ltp/testcases/kernel/security/=
selinux-testsuite/refpolicy: No such file or directory
>> >> > make: *** No rule to make target `load'. =A0Stop.
>> >> > Failed to build and load test_policy module, aborting test run.
>> >> > /etc/selinux /opt/ltp
>> >> > /opt/ltp
>> >> >
>> >> > # cd LTP_SRCDIR/testscripts && ./test_selinux.sh
>> >> > Running with security context=3Dunconfined_u:unconfined_r:unconfine=
d_t:s0-s0:c0.c1023
>> >> > /etc/selinux /home/sds/ltp
>> >> > /home/sds/ltp
>> >> > allow_domain_fd_use --> off
>> >> > allow_domain_fd_use exists setting
>> >> > building and installing test_policy module...
>> >> > make[1]: Entering directory `/usr/share/selinux/devel'
>> >> > rm -fR tmp
>> >> > rm -f *.pp
>> >> > make[1]: Leaving directory `/usr/share/selinux/devel'
>> >> > make[1]: Entering directory `/usr/share/selinux/devel'
>> >> > Compiling targeted test_policy module
>> >> > /usr/bin/checkmodule: =A0loading policy configuration from tmp/test=
_policy.tmp
>> >> > /usr/bin/checkmodule: =A0policy configuration loaded
>> >> > /usr/bin/checkmodule: =A0writing binary representation (version 10)=
 to tmp/test_policy.mod
>> >> > Creating targeted test_policy.pp policy package
>> >> > rm tmp/test_policy.mod tmp/test_policy.mod.fc
>> >> > make[1]: Leaving directory `/usr/share/selinux/devel'
>> >> > Successfully built and loaded test_policy module.
>> >> > /etc/selinux /home/sds/ltp/testcases/kernel/security/selinux-testsu=
ite/refpolicy
>> >> > /home/sds/ltp/testcases/kernel/security/selinux-testsuite/refpolicy
>> >> > Running the SELinux testsuite...
>> >> > ls: cannot access /home/sds/ltp/testcases/bin: No such file or dire=
ctory
>> >> > /usr/bin/chcon: cannot access `/home/sds/ltp/testcases/bin': No suc=
h file or directory
>> >> > ./test_selinux.sh: line 119: /home/sds/ltp/bin/ltp-pan: No such fil=
e or directory
>> >> > /usr/bin/chcon: missing operand
>> >> > Try `/usr/bin/chcon --help' for more information.
>> >> > Removing test_policy module...
>> >> > /usr/sbin/semodule -r test_policy
>> >> > rm -f -f /usr/share/selinux/devel/test_policy.* test_policy.te
>> >> > allow_domain_fd_use --> off
>> >> > allow_domain_fd_use exists setting
>> >> > Done.
>> >> >
>> >> > Both test_selinux.sh and tests/runtest.sh need to be updated.
>> >> >
>> >> > --
>> >> > Stephen Smalley
>> >> > National Security Agency
>> >>
>> >> =A0 =A0 Ok, next patch then... Let me know how this goes (I took a qu=
ick
>> >> look and I didn't see anything suspicious in the test scripts
>> >> themselves..).
>> >> Thanks,
>> >> -Garrett
>> >
>> > patching file ../../../../testscripts/test_selinux.sh
>> > Hunk #2 FAILED at 23.
>> > Hunk #3 FAILED at 57.
>> > 2 out of 5 hunks FAILED -- saving rejects to file ../../../../testscri=
pts/test_selinux.sh.rej
>> >
>> > I think it would work better if you just committed all of the patches
>> > thus far and I can just re-test cvs head.
>> >
>> > If you do post any further patches, please make them relative to the t=
op
>> > of the tree.
>>
>> =A0 =A0 Ugh, I hate CVS diffs too (so I understand)... I was trying to
>> avoid committing intermediate work, but as long as this gets fixed
>> before the next snapshot, I guess that's fine. Committed the next step
>> to CVS.
>
> # cd /opt/ltp
> # ./testscripts/test_selinux.sh
> Running with security context=3Dunconfined_u:unconfined_r:unconfined_t:s0=
-s0:c0.c1023
> /etc/selinux /opt/ltp
> /opt/ltp
> allow_domain_fd_use --> off
> allow_domain_fd_use exists setting
> building and installing test_policy module...
> make: *** No rule to make target `load'. =A0Stop.
> Failed to build and load test_policy module, aborting test run.
> /etc/selinux /opt/ltp/testcases/kernel/security/selinux-testsuite/refpoli=
cy
> /opt/ltp/testcases/kernel/security/selinux-testsuite/refpolicy
>
> There is no Makefile
> under /opt/ltp/testcases/kernel/security/selinux-testsuite/refpolicy,
> only in the source tree.

Yeah, you're right. I was trying to beat around this bush by not
copying these over, but it's better to have the test running and be
improperly designed than it is for regressions to leak by today, until
the day comes where these items are fixed.

1. So, Makefile is now copied over by default.
2. load is no longer done as part of all / install (test_selinux.sh
was performing that function).

So once the tests have been written to make and install independent of
selinux-devel, etc... we'll be in good shape and I will switch these
back to all / install dependent targets. I was trying to do it that
way to avoid requiring make on the target under test, but I need to
better understand the subject matter under test before we get to that
point.

Thanks,
-Garrett

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
