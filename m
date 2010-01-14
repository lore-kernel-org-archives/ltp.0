Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NVXIg-00023N-Ap
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 21:32:18 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NVXIf-000875-FP
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 21:32:18 +0000
Received: by pxi38 with SMTP id 38so719500pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Jan 2010 13:32:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41001141329j25c85101u37f2eda55faf04b9@mail.gmail.com>
References: <364299f41001120855r653842d3x630cdaa6ec4129b6@mail.gmail.com>
	<1263412198.901.11.camel@moss-pluto.epoch.ncsc.mil>
	<20100113220021.GA838@us.ibm.com>
	<1263420212.901.64.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001131449w751889b8r98aca16ea1e8957a@mail.gmail.com>
	<1263478021.8548.3.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001141210o49c97980yc703601e7340362f@mail.gmail.com>
	<1263501350.8548.60.camel@moss-pluto.epoch.ncsc.mil>
	<1263501847.8548.65.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001141329j25c85101u37f2eda55faf04b9@mail.gmail.com>
Date: Thu, 14 Jan 2010 13:32:10 -0800
Message-ID: <364299f41001141332y62d5cb5pd4202c1baad5b78c@mail.gmail.com>
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
Cc: Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>, ltp-list@lists.sourceforge.net

On Thu, Jan 14, 2010 at 1:29 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Thu, Jan 14, 2010 at 12:44 PM, Stephen Smalley <sds@tycho.nsa.gov> wro=
te:
>> On Thu, 2010-01-14 at 15:35 -0500, Stephen Smalley wrote:
>>> I guess I'm not being clear. =A0Most of the work presently done by 'loa=
d'
>>> can be done during make all/install. =A0In particular, everything except
>>> for running semodule -i can be done during make all, and then make
>>> install should just copy test_policy.pp (the output of make all) to
>>> the /opt/ltp tree. =A0Then test_selinux.sh only needs to run semodule
>>> -i /path/to/test_policy.pp before the tests and semodule -r test_policy
>>> afterward. =A0We can also avoid copying test_policy.te to the system
>>> policy devel directory altogether. =A0Something like this patch (and
>>> Makefile.selinux can then be removed altogether):
>>
>> Oops, wrong variable expansion syntax in test_selinux.sh. =A0Corrected
>> patch is below. =A0This one actually runs ;)
>>
>> Index: testscripts/test_selinux.sh
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> RCS file: /cvsroot/ltp/ltp/testscripts/test_selinux.sh,v
>> retrieving revision 1.15
>> diff -u -r1.15 test_selinux.sh
>> --- testscripts/test_selinux.sh 13 Jan 2010 18:50:53 -0000 =A0 =A0 =A01.=
15
>> +++ testscripts/test_selinux.sh 14 Jan 2010 20:41:22 -0000
>> @@ -89,11 +89,10 @@
>> =A0config_allow_domain_fd_use 0
>>
>> =A0# build and install the test policy...
>> -echo "building and installing test_policy module..."
>> -cd $POLICYDIR
>> -make load
>> +echo "installing test_policy module..."
>> +$SEMODULE -i $POLICYDIR/test_policy.pp
>> =A0if [ $? !=3D 0 ]; then
>> - =A0 =A0 =A0 echo "Failed to build and load test_policy module, abortin=
g test run."
>> + =A0 =A0 =A0 echo "Failed to install load test_policy module, aborting =
test run."
>> =A0 =A0 =A0 =A0config_unset_expandcheck
>> =A0 =A0 =A0 =A0exit 1
>> =A0else
>> @@ -126,8 +125,7 @@
>> =A0/usr/bin/chcon -t $SAVEBINTYPE $LTPROOT/testcases/bin
>>
>> =A0echo "Removing test_policy module..."
>> -cd $POLICYDIR
>> -make cleanup 2>&1
>> +$SEMODULE -r test_policy
>> =A0if [ $? !=3D 0 ]; then
>> =A0 =A0 =A0 =A0echo "Failed to remove test_policy module."
>> =A0 =A0 =A0 =A0exit 1
>> Index: testcases/kernel/security/selinux-testsuite/refpolicy/Makefile
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/r=
efpolicy/Makefile,v
>> retrieving revision 1.17
>> diff -u -r1.17 Makefile
>> --- testcases/kernel/security/selinux-testsuite/refpolicy/Makefile =A0 =
=A0 =A014 Jan 2010 12:40:58 -0000 =A0 =A0 =A01.17
>> +++ testcases/kernel/security/selinux-testsuite/refpolicy/Makefile =A0 =
=A0 =A014 Jan 2010 20:41:22 -0000
>> @@ -39,10 +39,11 @@
>>
>> =A0CHECKPOLICY =A0 =A0 =A0 =A0 =A0 =A0?=3D $(DESTDIR)/usr/bin/checkpolicy
>> =A0CHECKPOLICY_VERS =A0 =A0 =A0 ?=3D $(shell $(CHECKPOLICY) -V |cut -f 1=
 -d ' ')
>> +POLICY_DEVEL_DIR =A0 =A0 =A0 ?=3D $(DESTDIR)/usr/share/selinux/devel
>>
>> =A0INSTALL_DIR =A0 =A0 =A0 =A0 =A0 =A0:=3D testcases/kernel/security/sel=
inux-testsuite/refpolicy
>>
>> -INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D Makefile.selinux
>> +INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D test_policy.pp
>>
>> =A0TEST_POLICY_DIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(abs_srcdir)/pol=
icy_files
>>
>> @@ -63,8 +64,17 @@
>> =A0POLICY_FILES =A0 =A0 =A0 =A0 =A0 :=3D test_global.te \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $(filter-out test_gl=
obal.te,$(notdir $(wildcard $(TEST_POLICY_DIR)/*.te)))
>>
>> +all: test_policy.pp
>> +
>> +test_policy.pp: test_policy.te
>> + =A0 =A0 =A0 @set -e; if [ -d "$(POLICY_DEVEL_DIR)" ]; then \
>> + =A0 =A0 =A0 =A0 =A0 $(MAKE) -f $(POLICY_DEVEL_DIR)/Makefile test_polic=
y.pp; \
>> + =A0 =A0 =A0 else \
>> + =A0 =A0 =A0 =A0 =A0 =A0echo "ERROR: You must have selinux-policy?-deve=
l? installed."; \
>> + =A0 =A0 =A0 =A0 =A0 false; \
>> + =A0 =A0 =A0 fi
>> +
>> =A0test_policy.te: $(addprefix $(TEST_POLICY_DIR)/,$(POLICY_FILES))
>> =A0 =A0 =A0 =A0(cd "$(TEST_POLICY_DIR)" && cat $(POLICY_FILES)) > $@
>>
>> =A0include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> -include $(abs_srcdir)/Makefile.selinux
>
> Cool! This is a lot easier than I originally thought it would be.
>
> Everything specified with all should be specified instead with the

s/Everything specified with all/All dependencies of all/

MAKE_TARGETS variable. This is because it adds everything in
> MAKE_TARGETS to variables (CLEAN_TARGETS, INSTALL_TARGETS), which then
> handle it appropriately via clean and install.
>
> All I have to do after this is resolve the (semodule?) security bit
> enabling for the tests, and we'll be in good shape for all build,
> install, and test scenarios with selinux.

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
