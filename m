Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NTJS0-0000Km-W7
	for ltp-list@lists.sourceforge.net; Fri, 08 Jan 2010 18:20:44 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NTJRz-0000y7-Vn
	for ltp-list@lists.sourceforge.net; Fri, 08 Jan 2010 18:20:44 +0000
Received: by pwj11 with SMTP id 11so198662pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Fri, 08 Jan 2010 10:20:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1262893258.2821.50.camel@moss-pluto.epoch.ncsc.mil>
References: <1262791548.15424.31.camel@moss-pluto.epoch.ncsc.mil>
	<20100106185019.GA19647@us.ibm.com>
	<1262893258.2821.50.camel@moss-pluto.epoch.ncsc.mil>
Date: Fri, 8 Jan 2010 10:20:38 -0800
Message-ID: <364299f41001081020r7ee941f4w1b91bcb79849b406@mail.gmail.com>
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

On Thu, Jan 7, 2010 at 11:40 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2010-01-06 at 12:50 -0600, Serge E. Hallyn wrote:
>> Quoting Stephen Smalley (sds@tycho.nsa.gov):
>> > It seems the Makefile rewrite last October broke the selinux testsuite.
>> > Is it unreasonable to expect that someone who rewrote the Makefile wou=
ld
>> > actually try running the testsuite?
>> >
>> > Please, revert the changes or fix them.
>> >
>> > See testcases/kernel/security/selinux-testsuite/README for the
>> > instructions.
>>
>> Frankly I think reverting the Makefiles is best since it doesn't get
>> auto-compiled anyway. =A0The new Makefile is much longer and more compli=
cated
>> for no apparent gain.
>>
>> The following patch makes policy compilation work on rhel 5, but I doubt
>> it'll work anywhere else.
>
> Right, this won't work for Fedora.
>
>> Running the testsuite still fails due to the change to running ltp from
>> a different dir (i.e.
>> /usr/bin/chcon: /root/ltp-full-20091231/testcases/bin: No such file or d=
irectory
>> ).
>>
>> -serge
>>
>> diff -Nrup ltp-full-20091231.orig/testcases/kernel/security/selinux-test=
suite/refpolicy/Makefile ltp-full-20091231/testcases/kernel/security/selinu=
x-testsuite/refpolicy/Makefile
>> --- ltp-full-20091231.orig/testcases/kernel/security/selinux-testsuite/r=
efpolicy/Makefile =A0 =A0 2009-10-10 19:53:29.000000000 -0400
>> +++ ltp-full-20091231/testcases/kernel/security/selinux-testsuite/refpol=
icy/Makefile =A02010-01-06 13:43:19.000000000 -0500
>> @@ -33,19 +33,16 @@ CHECKPOLICY_VERS =A0?=3D $(shell $(CHECKPOLIC
>>
>> =A0CLEAN_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D test_policy.te
>>
>> -INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D *.te
>> +INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(REDHAT_VERS)/*.te
>> +INSTALL_TARGETS_FULL :=3D $(builddir)/redhat/$(REDHAT_VERS)/*.te
>
> Using the .te files under redhat/$(REDHAT_VERS) needs to be conditional
> on actually running on rhel. =A0 There was logic for that down below but
> it looks like it has a typo.
>
>> =A0ifeq ($(CHECKPOLICY_VERS),24)
>> =A0INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(filter-out %/test_b=
ounds.te,$(INSTALL_TARGETS))
>> +INSTALL_TARGES_FULL =A0 =A0 =A0 =A0 =A0:=3D $(filter-out %/test_bounds.=
te,$(INSTALL_TARGES_FULL))
>
> Typo: =A0TARGES vs TARGETS
>
>> =A0endif
>>
>> =A0TE_SRCDIR =A0 =A0 =A0 =A0 =A0 =A0:=3D $(abs_srcdir)
>>
>> -ifeq (redhat-release-, $(findstring redhat-release-, $(REDHAT_RELEASE)))
>> -ifneq ($(wildcard $(abs_srcdir)/redhat/$(REDHAT_VER)),)
>> -TE_SRCDIR =A0 =A0 =A0 =A0 =A0 =A0:=3D $(abs_srcdir)/redhat/$(REDHAT_VER)
>> -endif
>> -endif
>
> This is what should have pulled in the redhat/5 .te files, but it seems
> buggy - there is a typo (VER vs VERS) and I'm not sure why there is the
> inner ifneq block - that didn't exist in the original Makefile.
>
>> =A0.PHONY: all clean cleanup install load
>>
>> @@ -60,14 +57,18 @@ cleanup:
>> =A0install: all
>>
>> =A0# load remains for backwards compatibility...
>> -load: $(builddir)/test_policy.te
>> +load:
>> +ifeq (redhat-release-, $(findstring redhat-release-, $(REDHAT_RELEASE)))
>> + =A0 =A0 $(MAKE) -C redhat/$(REDHAT_VERS)
>> +else
>
> This reverts to what was in the original Makefile, which takes us back
> to just using the makefile down in redhat/5, which wasn't updated.
>
>> =A0 =A0 =A0 @if [ -d "$(POLICYDEVEL)" ]; then \
>> - =A0 =A0 =A0 =A0 cp -p $(builddir)/test_policy.* $(INSTALL_TARGETS) $(P=
OLICY_DEVEL); \
>> + =A0 =A0 =A0 =A0 cp -p $(builddir)/test_policy.* $(INSTALL_TARGETS_FULL=
) $(POLICYDEVEL); \
>
> Only test_policy.* should be copied to $POLICYDEVEL, not the
> individual .te files.
>
>> =A0 =A0 =A0 =A0 =A0 $(MAKE) -C $(POLICYDEVEL) clean test_policy.pp; \
>> =A0 =A0 =A0 =A0 =A0 $(SEMODULE) -i $(POLICYDEVEL)/test_policy.pp; \
>> =A0 =A0 =A0 else \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0echo "ERROR: You must have selinux-policy-dev=
el installed."; \
>> =A0 =A0 =A0 fi
>> +endif
>>
>> =A0$(builddir)/test_policy.te:
>> =A0 =A0 =A0 (cd "$(TE_SRCDIR)" && cat $(INSTALL_TARGETS)) > "$@";

    Thanks for the feedback and details Stephen.
    Would you be kind enough to try out the version from CVS to see
whether or not it resolves your issue? You'll also need to update
$LTPROOT/scripts in order to use the new version as I added a distro
detection script which opens up /etc/redhat-release (for redhat) as
opposed to using rpm to query the release.
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
