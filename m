Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NUkVv-0008ME-RB
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 17:26:43 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NUkVr-0008Am-A9
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 17:26:41 +0000
Received: by pzk31 with SMTP id 31so1208505pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jan 2010 09:26:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41001120919w3b56bfefoc5b7a1e6a4e96f1@mail.gmail.com>
References: <364299f41001081338u37e77cd3q3d9535f3dec71331@mail.gmail.com>
	<20100111195043.GA23360@us.ibm.com>
	<1263239706.5091.11.camel@moss-pluto.epoch.ncsc.mil>
	<20100111201936.GA24711@us.ibm.com>
	<20100111205858.GA26412@us.ibm.com>
	<20100111210006.GA26554@us.ibm.com>
	<20100111213100.GA28138@us.ibm.com>
	<1263302168.14187.13.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001120855r653842d3x630cdaa6ec4129b6@mail.gmail.com>
	<364299f41001120919w3b56bfefoc5b7a1e6a4e96f1@mail.gmail.com>
Date: Tue, 12 Jan 2010 09:26:30 -0800
Message-ID: <364299f41001120926s45ab6b24i485a0fd0ba499f41@mail.gmail.com>
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

On Tue, Jan 12, 2010 at 9:19 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Tue, Jan 12, 2010 at 8:55 AM, Garrett Cooper <yanegomi@gmail.com> wrot=
e:
>> On Tue, Jan 12, 2010 at 5:16 AM, Stephen Smalley <sds@tycho.nsa.gov> wro=
te:
>>> On Mon, 2010-01-11 at 15:31 -0600, Serge E. Hallyn wrote:
>>>> Quoting Serge E. Hallyn (serue@us.ibm.com):
>>>> > Quoting Serge E. Hallyn (serue@us.ibm.com):
>>>> > > Quoting Serge E. Hallyn (serue@us.ibm.com):
>>>> > > > Quoting Stephen Smalley (sds@tycho.nsa.gov):
>>>> > > > > On Mon, 2010-01-11 at 13:50 -0600, Serge E. Hallyn wrote:
>>>> > > > > > > Fails with:
>>>> > > > > > > cp: cannot stat
>>>> > > > > > > `/home/sds/ltp/testcases/kernel/security/selinux-testsuite=
/refpolicy/policy_files/generic/test_policy.*': No such file or directory
>>>> > > > > >
>>>> > > > > > You ran /home/sds/ltp/testscripts/test_selinux.sh, right?
>>>> > > > > >
>>>> > > > > > I think we are supposed to actually be running
>>>> > > > > > /opt/ltp/testscripts/test_selinux.sh. =A0So then the first q=
uestion for
>>>> > > > > > Garrett is how should we deduce /home/sds/ltp as $LTP_SRCDIR=
 from a
>>>> > > > > > testscript? =A0Or should the policy sources be copied into /=
opt?
>>>> > > > >
>>>> > > > > Ok, but regardless: =A0the refpolicy Makefile is still broken.
>>>> > > >
>>>> > > > Yup.
>>>> > >
>>>> > > All right, baby-steps.
>>>> > >
>>>> > > The attached test_selinux.diff is not to be applied, but something
>>>> > > like it is needed. =A0Should we have the ltp 'make install' fill in
>>>> > > TOP_SRCDIR in /opt/ltp/testscripts/test_selinux.sh? =A0BTW, Garret=
t,
>>>> > > that is the issue I was saying is shared between test_selinux.sh
>>>> > > and some others including test_robind.sh. =A0That's why I'm not ju=
st
>>>> > > sending a patch to make it work, bc i think we need more general
>>>> > > guidance.
>>>> > >
>>>> > > The second match makes the 'make load' part of test_selinux.sh
>>>> > > succeed on rhel5.4. =A0Stephen, how does it do on fedora?
>>>> > >
>>>> > > After loading policy it fails to execute ltp-pan, but I figure let=
's
>>>> > > get policy loading working first.
>>>>
>>>> All right well just doing
>>>>
>>>> --- /root/ltp_cvs_orig/ltp/testscripts/test_selinux.sh =A0 =A0 =A0 =A0=
2009-05-19 05:39:11.000000000 -0400
>>>> +++ /opt/ltp/testscripts/test_selinux.sh =A0 =A0 =A02010-01-11 16:26:1=
2.000000000 -0500
>>>> @@ -115,7 +117,7 @@
>>>> =A0SAVEBINTYPE=3D`ls -Zd $LTPROOT/testcases/bin | awk '{ print $4 }' |=
 awk -F: '{ print $3 }'`
>>>> =A0/usr/bin/chcon -t test_file_t $LTPROOT/testcases/bin
>>>>
>>>> -$LTPROOT/pan/ltp-pan -S -a $LTPROOT/results/selinux -n ltp-selinux -l=
 $LTPROOT/results/selinux.logfile -o $LTPROOT/results/selinux.outfile -p -f=
 $LTPROOT/runtest/selinux
>>>> +$LTPROOT/bin/ltp-pan -S -a $LTPROOT/results/selinux -n ltp-selinux -l=
 $LTPROOT/results/selinux.logfile -o $LTPROOT/results/selinux.outfile -p -f=
 $LTPROOT/runtest/selinux
>>>>
>>>> =A0# cleanup before exiting
>>>>
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> in test_selinux.sh makes the testsuite mostly pass (test 39 fails, all
>>>> up to then pass)
>>>>
>>>> Again this is on RHEL5.4.
>>>
>>> test39 isn't supposed to be run on RHEL5.4.
>>> The old tests/Makefile had conditional logic to exclude certain tests on
>>> RHEL4 and on RHEL5, as their kernels wouldn't support newer tests.
>>
>>
>> Something that fell through the cracks because I didn't take the time
>> to actually determine _what_ the requirements were for the tests so
>> they would report configuration failure instead of failure. Please try
>> this (I properly pasted it this time instead of using my xterm window
>> and paste):
>>
>> Index: tests/Makefile
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/t=
ests/Makefile,v
>> retrieving revision 1.7
>> diff -u -r1.7 Makefile
>> --- tests/Makefile =A0 =A0 =A09 Oct 2009 17:55:51 -0000 =A0 =A0 =A0 1.7
>> +++ tests/Makefile =A0 =A0 =A012 Jan 2010 16:53:57 -0000
>> @@ -24,11 +24,26 @@
>>
>> =A0include =A0 =A0 =A0 =A0$(top_srcdir)/include/mk/env_pre.mk
>>
>> -RECURSIVE_TARGETS =A0 =A0 =A0:=3D install
>> +ARGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D -m
>> +# Don't want to pass the -d option unless DESTDIR is a non-zero length =
string.
>> +ifneq ($(strip $(DESTDIR)),)
>> +ARGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D -d $(DESTDIR)
>> +endif
>>
>> -include $(top_srcdir)/include/mk/generic_trunk_target.mk
>> +DISTRO_VER =A0 =A0 =A0 =A0 =A0 =A0 :=3D $(shell $(top_srcdir)/scripts/d=
etect_distro.sh $(ARGS))
>> +
>> +#
>> +# Certain tests should be excluded on RHEL [45].x as their kernels don't
>> +# support the tests.
>> +#
>> +# XXX (garrcoop): actually complete the work to add proper checks to th=
e tests
>> +# to report TCONF on configuration failure.
>> +#
>> +ifneq ($(findstring $(DISTRO_VER),redhat-4 redhat-5),)
>> +FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D dyntrace dyntrans
>> +endif
>> +ifeq (redhat-4,$(DISTRO_VER))
>> +FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D bounds
>> +endif
>>
>> -all:
>> - =A0 =A0 =A0 @set -e; for i in $(SUBDIRS); do \
>> - =A0 =A0 =A0 =A0 =A0 $(MAKE) -C $$i $@; \
>> - =A0 =A0 =A0 done
>> +include $(top_srcdir)/include/mk/generic_trunk_target.mk
>>
>
> The conditional checks didn't make sense with what Stephen mentioned
> above to you Serge, so I respun the diff:
>
> Index: tests/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/te=
sts/Makefile,v
> retrieving revision 1.7
> diff -u -r1.7 Makefile
> --- tests/Makefile =A0 =A0 =A09 Oct 2009 17:55:51 -0000 =A0 =A0 =A0 1.7
> +++ tests/Makefile =A0 =A0 =A012 Jan 2010 17:16:09 -0000
> @@ -24,11 +24,28 @@
>
> =A0include =A0 =A0 =A0 =A0$(top_srcdir)/include/mk/env_pre.mk
>
> -RECURSIVE_TARGETS =A0 =A0 =A0:=3D install
> +ARGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D -m
> +# Don't want to pass the -d option unless DESTDIR is a non-zero length s=
tring.
> +ifneq ($(strip $(DESTDIR)),)
> +ARGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D -d $(DESTDIR)
> +endif
>
> -include $(top_srcdir)/include/mk/generic_trunk_target.mk
> +DISTRO_VER =A0 =A0 =A0 =A0 =A0 =A0 :=3D $(shell $(top_srcdir)/scripts/de=
tect_distro.sh $(ARGS))
> +
> +#
> +# Certain tests should be excluded on RHEL [45].x as their kernels don't
> +# support the tests.
> +#
> +# XXX (garrcoop): actually complete the work to add proper checks to the=
 tests
> +# to report TCONF on configuration failure.
>
> -all:
> - =A0 =A0 =A0 @set -e; for i in $(SUBDIRS); do \
> - =A0 =A0 =A0 =A0 =A0 $(MAKE) -C $$i $@; \
> - =A0 =A0 =A0 done
> +# RHEL 4.x doesn't support the dyntrace and dyntrans tests.
> +ifneq ($(findstring $(DISTRO_VER),redhat-4),)
> +FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D dyntrace dyntrans
> +endif
> +# RHEL 5.x doesn't support the bounds test.
> +ifeq (redhat-5,$(DISTRO_VER))
> +FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D bounds
> +endif
> +
> +include $(top_srcdir)/include/mk/generic_trunk_target.mk
>
> Also, if you guys can try out this patch for refpolicy/Makefile, I'd
> prefer to check it in (it unifies the RHEL 4.x and `generic' refpolicy
> Make logic):
>
> Index: refpolicy/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/re=
fpolicy/Makefile,v
> retrieving revision 1.12
> diff -u -r1.12 Makefile
> --- refpolicy/Makefile =A08 Jan 2010 09:39:20 -0000 =A0 =A0 =A0 1.12
> +++ refpolicy/Makefile =A012 Jan 2010 17:17:27 -0000
> @@ -17,7 +17,7 @@
> =A0# =A0 =A0with this program; if not, write to the Free Software Foundat=
ion, Inc.,
> =A0# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> =A0#
> -# Garrett Cooper, August 2009
> +# Garrett Cooper, January 2010
> =A0#
>
> =A0top_srcdir =A0 =A0 =A0 =A0 =A0 =A0 ?=3D ../../../../..
> @@ -32,6 +32,7 @@
>
> =A0DISTRO_VER =A0 =A0 =A0 =A0 =A0 =A0 :=3D $(shell $(top_srcdir)/scripts/=
detect_distro.sh $(ARGS))
>
> +# Avoid empty strings.
> =A0ifeq ($(strip $(DISTRO_VER)),)
> =A0DISTRO_VER =A0 =A0 =A0 =A0 =A0 =A0 :=3D generic
> =A0endif
> @@ -41,10 +42,17 @@
> =A0POLICY_DEVEL_DIR =A0 =A0 =A0 ?=3D $(DESTDIR)/usr/share/selinux/devel
> =A0SEMODULE =A0 =A0 =A0 =A0 =A0 =A0 =A0 ?=3D $(DESTDIR)/usr/sbin/semodule
>
> -INSTALL_DIR =A0 =A0 =A0 =A0 =A0 =A0:=3D testcases/kernel/security/selinu=
x-testsuite
> +INSTALL_DIR =A0 =A0 =A0 =A0 =A0 =A0:=3D testcases/selinux-testsuite/refp=
olicy
>
> =A0TEST_POLICY_DIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(abs_srcdir)/poli=
cy_files
>
> +# Do we have a special set of policies in the SCM to install?
> +ifneq ($(wildcard $(TEST_POLICY_DIR)/$(DISTRO_VER)/),)
> +TEST_POLICY_DIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(TEST_POLICY_DIR)/$=
(DISTRO_VER)
> +else
> +TEST_POLICY_DIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(TEST_POLICY_DIR)/g=
eneric
> +endif
> +
> =A0.PHONY: all clean cleanup install load
>
> =A0CLEAN_DEPS =A0 =A0 =A0 =A0 =A0 =A0 :=3D cleanup
> @@ -55,34 +63,24 @@
> =A0 =A0 =A0 =A0-$(SEMODULE) -r test_policy
> =A0 =A0 =A0 =A0$(RM) -f $(POLICY_DEVEL_DIR)/test_policy.* test_policy.te
>
> -ifneq ($(wildcard $(TEST_POLICY_DIR)/$(DISTRO_VER)/Makefile),)
> -MAKE_TARGETS =A0 =A0 =A0 =A0 =A0 :=3D
> -
> -TEST_POLICY_DIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(TEST_POLICY_DIR)/$=
(DISTRO_VER)
> -
> -# load remains for backwards compatibility...
> -load:
> - =A0 =A0 =A0 $(MAKE) -C $(TEST_POLICY_DIR)
> -else
> -
> =A0MAKE_TARGETS =A0 =A0 =A0 =A0 =A0 :=3D test_policy.te
>
> -TEST_POLICY_DIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(TEST_POLICY_DIR)/g=
eneric
> -
> -POLICY_FILES =A0 =A0 =A0 =A0 =A0 :=3D test_global.te $(filter-out test_g=
lobal.te,$(notdir
> $(wildcard $(TEST_POLICY_DIR)/*.te)))
> -
> =A0ifneq ($(CHECKPOLICY_VERS),24)
> =A0POLICY_FILES =A0 =A0 =A0 =A0 =A0 :=3D $(filter-out test_bounds.te,$(PO=
LICY_FILES))
> =A0endif
>
> +# This is being done to preserve precedence; test_global.te must come fi=
rst.
> +POLICY_FILES =A0 =A0 =A0 =A0 =A0 :=3D test_global.te \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$(filter-out test_gl=
obal.te,$(notdir $(wildcard
> $(TEST_POLICY_DIR)/*.te)))
> +
> =A0load:
> - =A0 =A0 =A0 @if [ -d "$(POLICY_DEVEL_DIR)" ]; then \
> - =A0 =A0 =A0 =A0 =A0 cp -p $(TEST_POLICY_DIR)/test_policy.* $(POLICY_DEV=
EL_DIR); \
> + =A0 =A0 =A0 @set -e; if [ -d "$(POLICY_DEVEL_DIR)" ]; then \
> + =A0 =A0 =A0 =A0 =A0 cp -p test_policy.* $(POLICY_DEVEL_DIR); \
> =A0 =A0 =A0 =A0 =A0 =A0$(MAKE) -C $(POLICY_DEVEL_DIR) clean; \
> =A0 =A0 =A0 =A0 =A0 =A0$(MAKE) -C $(POLICY_DEVEL_DIR) test_policy.pp; \
> =A0 =A0 =A0 =A0 =A0 =A0$(SEMODULE) -i $(POLICY_DEVEL_DIR)/test_policy.pp;=
 \
> =A0 =A0 =A0 =A0else \
> - =A0 =A0 =A0 =A0 =A0 =A0echo "ERROR: You must have selinux-policy-devel =
installed."; \
> + =A0 =A0 =A0 =A0 =A0 =A0echo "ERROR: You must have selinux-policy?-devel=
? installed."; \
> =A0 =A0 =A0 =A0 =A0 =A0false; \
> =A0 =A0 =A0 =A0fi

There's a stray endif on line 90 of refpolicy/Makefile that needs to
be deleted as well, FYI...
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
