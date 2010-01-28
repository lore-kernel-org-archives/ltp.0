Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NaNN5-0004wY-3p
	for ltp-list@lists.sourceforge.net; Thu, 28 Jan 2010 05:56:51 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NaNN3-0004y5-WE
	for ltp-list@lists.sourceforge.net; Thu, 28 Jan 2010 05:56:51 +0000
Received: by pxi38 with SMTP id 38so276326pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Jan 2010 21:56:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41001271437k3f9bde57t64845d8d0054ba22@mail.gmail.com>
References: <1262988051.20881.42.camel@moss-pluto.epoch.ncsc.mil>
	<20100111210006.GA26554@us.ibm.com>
	<364299f41001120029x15b2e7adwe30d925717a1dc89@mail.gmail.com>
	<20100112153827.GB7975@us.ibm.com>
	<364299f41001150948u4df35c36g3d4b07b16af49f90@mail.gmail.com>
	<364299f41001260031h2529b9b0j1bbbacd9d3d85eae@mail.gmail.com>
	<1264516245.19890.22.camel@moss-pluto.epoch.ncsc.mil>
	<23804BFE-0FC7-45F8-939D-3729E39DB431@gmail.com>
	<1264619548.17372.27.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001271437k3f9bde57t64845d8d0054ba22@mail.gmail.com>
Date: Wed, 27 Jan 2010 21:56:43 -0800
Message-ID: <364299f41001272156p5f12bc94p4eba45d9df61fbc0@mail.gmail.com>
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

On Wed, Jan 27, 2010 at 2:37 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Wed, Jan 27, 2010 at 11:12 AM, Stephen Smalley <sds@tycho.nsa.gov> wro=
te:
>> On Tue, 2010-01-26 at 22:34 -0800, Garrett Cooper wrote:
>>> On Jan 26, 2010, at 6:30 AM, Stephen Smalley wrote:
>>>
>>> > On Tue, 2010-01-26 at 00:31 -0800, Garrett Cooper wrote:
>>> >> On Fri, Jan 15, 2010 at 9:48 AM, Garrett Cooper <yanegomi@gmail.com>=
 wrote:
>>> >>> On Tue, Jan 12, 2010 at 7:38 AM, Serge E. Hallyn <serue@us.ibm.com>=
 wrote:
>>> >>>> Quoting Garrett Cooper (yanegomi@gmail.com):
>>> >>>>> On Mon, Jan 11, 2010 at 1:00 PM, Serge E. Hallyn <serue@us.ibm.co=
m> wrote:
>>> >>>>>> Quoting Serge E. Hallyn (serue@us.ibm.com):
>>> >>>>>>> Quoting Serge E. Hallyn (serue@us.ibm.com):
>>> >>>>>>>> Quoting Stephen Smalley (sds@tycho.nsa.gov):
>>> >>>>>>>>> On Mon, 2010-01-11 at 13:50 -0600, Serge E. Hallyn wrote:
>>> >>>>>>>>>>> Fails with:
>>> >>>>>>>>>>> cp: cannot stat
>>> >>>>>>>>>>> `/home/sds/ltp/testcases/kernel/security/selinux-testsuite/=
refpolicy/policy_files/generic/test_policy.*': No such file or directory
>>> >>>>>>>>>>
>>> >>>>>>>>>> You ran /home/sds/ltp/testscripts/test_selinux.sh, right?
>>> >>>>>>>>>>
>>> >>>>>>>>>> I think we are supposed to actually be running
>>> >>>>>>>>>> /opt/ltp/testscripts/test_selinux.sh. =A0So then the first q=
uestion for
>>> >>>>>>>>>> Garrett is how should we deduce /home/sds/ltp as $LTP_SRCDIR=
 from a
>>> >>>>>>>>>> testscript? =A0Or should the policy sources be copied into /=
opt?
>>> >>>>>>>>>
>>> >>>>>>>>> Ok, but regardless: =A0the refpolicy Makefile is still broken.
>>> >>>>>>>>
>>> >>>>>>>> Yup.
>>> >>>>>>>
>>> >>>>>>> All right, baby-steps.
>>> >>>>>>>
>>> >>>>>>> The attached test_selinux.diff is not to be applied, but someth=
ing
>>> >>>>>>> like it is needed. =A0Should we have the ltp 'make install' fil=
l in
>>> >>>>>>> TOP_SRCDIR in /opt/ltp/testscripts/test_selinux.sh? =A0BTW, Gar=
rett,
>>> >>>>>>> that is the issue I was saying is shared between test_selinux.sh
>>> >>>>>>> and some others including test_robind.sh. =A0That's why I'm not=
 just
>>> >>>>>>> sending a patch to make it work, bc i think we need more general
>>> >>>>>>> guidance.
>>> >>>>>>>
>>> >>>>>>> The second match makes the 'make load' part of test_selinux.sh
>>> >>>>>>> succeed on rhel5.4. =A0Stephen, how does it do on fedora?
>>> >>>>>>>
>>> >>>>>>> After loading policy it fails to execute ltp-pan, but I figure =
let's
>>> >>>>>>> get policy loading working first.
>>> >>>>>>>
>>> >>>>>>> -serge
>>> >>>>>>
>>> >>>>>> gah, attaching the actual patches this time.
>>> >>>>>>
>>> >>>>>> -serge
>>> >>>>>
>>> >>>>> 1. I'm rejecting the test_selinux.diff solely because it has /roo=
t/ltp
>>> >>>>> hardcoded as LTPROOT.
>>> >>>>
>>> >>>> I said 'not to be applied'. =A0You're not rejecting.
>>> >>>>
>>> >>>>> 2. Why is the redhat stuff support to work
>>> >>>>> agnostic to the major and minor version?
>>> >>>>
>>> >>>> It's not agnostic to the major version. =A0Only the minor version.
>>> >>>>
>>> >>>> And since you've made ltp not compile on rhel4 (requiring make-3.8=
1. =A0feh)
>>> >>>> i suppose we can just get rid of rhel4 support selinux-testsuite.
>>> >>>
>>> >>> No. 1. Compiling make 3.81 today and installing it is trivial, so it
>>> >>> shouldn't be removed today. 2. I've finally decided that I'm going =
to
>>> >>> look outside of the box into providing equivalent functionality via
>>> >>> shell functions using purely built-in commands [and test(1)] to fill
>>> >>> in the feature gaps for make 3.80. I've gotten to the point where I
>>> >>> just gave up trying to ride out what I possibly can in make 3.80, so
>>> >>> it's time to pull in some external pieces to get the job done.
>>> >>
>>> >> =A0 =A0All of the install junk works now, but the modes need fixing,=
 or
>>> >> some such fun. Please analyze the test_selinux.sh script and tell me
>>> >> what to commit next to fix everything.
>>> >
>>> > Hi Garrett,
>>> >
>>> > I needed to apply the patch below to make test_selinux.sh run
>>> > successfully on Fedora 12. =A0The problems were:
>>> > - The setting of LTPROOT in test_selinux.sh was incorrect, leading to
>>> > problems with invoking everything else. =A0Note that I invoke it by d=
oing:
>>> > cd /opt/ltp && ./testscripts/test_selinux.sh
>>> > and thus $0 is a relative path, whereas we want an absolute one.
>>> > - You don't need to cd to $POLICYDIR at all since you specify
>>> > $POLICYDIR/test_policy.pp to semodule -i and semodule -r is acting on
>>> > the installed policy module.
>>> > - The attempt to extract paths from runtest/selinux and invoke chcon =
on
>>> > them wasn't working as $LTPROOT wasn't being expanded; easier to just=
 do
>>> > a chcon -R there as before.
>>> > - runtest/selinux had the wrong paths to the test programs (or
>>> > alternatively, they aren't being installed to the right location - th=
ey
>>> > all get installed directly to $LTPROOT/testcases/bin.
>>> >
>>> > Index: testscripts/test_selinux.sh
>>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> > RCS file: /cvsroot/ltp/ltp/testscripts/test_selinux.sh,v
>>> > retrieving revision 1.20
>>> > diff -u -r1.20 test_selinux.sh
>>> > --- testscripts/test_selinux.sh =A0 =A0 26 Jan 2010 07:05:02 -0000 =
=A0 =A0 =A01.20
>>> > +++ testscripts/test_selinux.sh =A0 =A0 26 Jan 2010 14:20:40 -0000
>>> > @@ -37,15 +37,14 @@
>>> > fi
>>> >
>>> > # set the LTPROOT directory
>>> > -LTPROOT=3D${LTPROOT:=3D${0%/*}}
>>> > -cd "$LTPROOT"
>>> > +LTPROOT=3D`pwd`
>>> > export TMP=3D${TMP:-/tmp}
>>> > -# If we're in the testscripts directory, go down a dir..
>>> > +# If we're in the testscripts directory, go up a dir..
>>> > LTPROOT_TMP=3D${LTPROOT%/testscripts}
>>> > if [ "x${LTPROOT_TMP}" !=3D "x${LTPROOT}" ]
>>> > then
>>> > =A0 =A0 cd ..
>>> > - =A0 LTPROOT=3D$LTPROOT_TMP
>>> > + =A0 LTPROOT=3D`pwd`
>>> > fi
>>> > export LTPROOT
>>> > unset LTPROOT_TMP
>>> > @@ -89,7 +88,6 @@
>>> >
>>> > # install the test policy...
>>> > echo "Installing test_policy module..."
>>> > -cd $POLICYDIR
>>> > if ! semodule -i $POLICYDIR/test_policy.pp; then
>>> > =A0 =A0 echo "Failed to install test_policy module, aborting test run=
."
>>> > =A0 =A0 config_unset_expandcheck
>>> > @@ -100,9 +98,6 @@
>>> >
>>> > config_unset_expandcheck
>>> >
>>> > -# go back to test's root directory
>>> > -cd $LTPROOT
>>> > -
>>> > echo "Running the SELinux testsuite..."
>>> >
>>> > mkdir $TMP/selinux > /dev/null 2>&1
>>> > @@ -112,8 +107,7 @@
>>> > # The ../testcases/bin directory needs to have the test_file_t type.
>>> > # Save and restore later.
>>> > SAVEBINTYPE=3D`ls -Zd $LTPROOT/testcases/bin | awk '{ print $4 }' | a=
wk -F: '{ print $3 }'`
>>> > -/usr/bin/chcon -t test_file_t =A0 =A0 =A0$LTPROOT/testcases/bin \
>>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $(awk '$1 !~ /^=
#/ { print $2 }' "$LTPROOT/runtest/selinux")
>>> > +/usr/bin/chcon -R -t test_file_t =A0 $LTPROOT/testcases/bin
>>> >
>>> > $LTPROOT/bin/ltp-pan -S -a $LTPROOT/results/selinux -n ltp-selinux \
>>> > =A0 =A0 -l $LTPROOT/results/selinux.logfile \
>>> > @@ -127,7 +121,6 @@
>>> > /usr/bin/chcon -R -t $SAVEBINTYPE $LTPROOT/testcases/bin
>>> >
>>> > echo "Removing test_policy module..."
>>> > -cd $POLICYDIR
>>> > if ! semodule -r test_policy; then
>>> > =A0 =A0 echo "Failed to remove test_policy module."
>>> > =A0 =A0 exit 1
>>> > Index: runtest/selinux
>>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> > RCS file: /cvsroot/ltp/ltp/runtest/selinux,v
>>> > retrieving revision 1.4
>>> > diff -u -r1.4 selinux
>>> > --- runtest/selinux 25 Jan 2010 12:44:59 -0000 =A0 =A0 =A01.4
>>> > +++ runtest/selinux 26 Jan 2010 14:20:40 -0000
>>> > @@ -1,40 +1,40 @@
>>> > #DESCRIPTION:Security-Enhanced Linux
>>> > -SELinux01 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_capable_file.sh
>>> > -SELinux02 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_capable_net.sh
>>> > -SELinux03 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_capable_sys.sh
>>> > -SELinux04 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_domain_trans.sh
>>> > -SELinux05 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_entrypoint.sh
>>> > -SELinux06 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_execshare.sh
>>> > -SELinux07 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_exectrace.sh
>>> > -SELinux08 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_execute_no_trans.sh
>>> > -SELinux09 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_fdreceive.sh
>>> > -SELinux10 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_file.sh
>>> > -SELinux11 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_inherit.sh
>>> > -SELinux12 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_ioctl.sh
>>> > -SELinux13 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_link.sh
>>> > -SELinux14 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_mkdir.sh
>>> > -SELinux15 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_msg.sh
>>> > -SELinux16 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_open.sh
>>> > -SELinux17 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_ptrace.sh
>>> > -SELinux18 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_readlink.sh
>>> > -SELinux19 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_relabel.sh
>>> > -SELinux20 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_rename.sh
>>> > -SELinux21 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_rxdir.sh
>>> > -SELinux22 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_sem.sh
>>> > -SELinux23 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_setattr.sh
>>> > -SELinux24 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_setnice.sh
>>> > -SELinux25 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_shm.sh
>>> > -SELinux26 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_sigkill.sh
>>> > -SELinux27 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_stat.sh
>>> > -SELinux28 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_sysctl.sh
>>> > -SELinux29 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_task_create.sh
>>> > -SELinux30 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_task_getpgid.sh
>>> > -SELinux31 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_task_getscheduler.sh
>>> > -SELinux32 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_task_getsid.sh
>>> > -SELinux33 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_task_setnice.sh
>>> > -SELinux34 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_task_setpgid.sh
>>> > -SELinux35 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_task_setscheduler.sh
>>> > -SELinux36 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_wait.sh
>>> > -SELinux37 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_dyntrace.sh
>>> > -SELinux38 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_dyntrans.sh
>>> > -SELinux39 =A0$LTPROOT/testcases/bin/kernel/security/selinux-testsuit=
e/tests/selinux_bounds.sh
>>> > +SELinux01 =A0$LTPROOT/testcases/bin/selinux_capable_file.sh
>>> > +SELinux02 =A0$LTPROOT/testcases/bin/selinux_capable_net.sh
>>> > +SELinux03 =A0$LTPROOT/testcases/bin/selinux_capable_sys.sh
>>> > +SELinux04 =A0$LTPROOT/testcases/bin/selinux_domain_trans.sh
>>> > +SELinux05 =A0$LTPROOT/testcases/bin/selinux_entrypoint.sh
>>> > +SELinux06 =A0$LTPROOT/testcases/bin/selinux_execshare.sh
>>> > +SELinux07 =A0$LTPROOT/testcases/bin/selinux_exectrace.sh
>>> > +SELinux08 =A0$LTPROOT/testcases/bin/selinux_execute_no_trans.sh
>>> > +SELinux09 =A0$LTPROOT/testcases/bin/selinux_fdreceive.sh
>>> > +SELinux10 =A0$LTPROOT/testcases/bin/selinux_file.sh
>>> > +SELinux11 =A0$LTPROOT/testcases/bin/selinux_inherit.sh
>>> > +SELinux12 =A0$LTPROOT/testcases/bin/selinux_ioctl.sh
>>> > +SELinux13 =A0$LTPROOT/testcases/bin/selinux_link.sh
>>> > +SELinux14 =A0$LTPROOT/testcases/bin/selinux_mkdir.sh
>>> > +SELinux15 =A0$LTPROOT/testcases/bin/selinux_msg.sh
>>> > +SELinux16 =A0$LTPROOT/testcases/bin/selinux_open.sh
>>> > +SELinux17 =A0$LTPROOT/testcases/bin/selinux_ptrace.sh
>>> > +SELinux18 =A0$LTPROOT/testcases/bin/selinux_readlink.sh
>>> > +SELinux19 =A0$LTPROOT/testcases/bin/selinux_relabel.sh
>>> > +SELinux20 =A0$LTPROOT/testcases/bin/selinux_rename.sh
>>> > +SELinux21 =A0$LTPROOT/testcases/bin/selinux_rxdir.sh
>>> > +SELinux22 =A0$LTPROOT/testcases/bin/selinux_sem.sh
>>> > +SELinux23 =A0$LTPROOT/testcases/bin/selinux_setattr.sh
>>> > +SELinux24 =A0$LTPROOT/testcases/bin/selinux_setnice.sh
>>> > +SELinux25 =A0$LTPROOT/testcases/bin/selinux_shm.sh
>>> > +SELinux26 =A0$LTPROOT/testcases/bin/selinux_sigkill.sh
>>> > +SELinux27 =A0$LTPROOT/testcases/bin/selinux_stat.sh
>>> > +SELinux28 =A0$LTPROOT/testcases/bin/selinux_sysctl.sh
>>> > +SELinux29 =A0$LTPROOT/testcases/bin/selinux_task_create.sh
>>> > +SELinux30 =A0$LTPROOT/testcases/bin/selinux_task_getpgid.sh
>>> > +SELinux31 =A0$LTPROOT/testcases/bin/selinux_task_getscheduler.sh
>>> > +SELinux32 =A0$LTPROOT/testcases/bin/selinux_task_getsid.sh
>>> > +SELinux33 =A0$LTPROOT/testcases/bin/selinux_task_setnice.sh
>>> > +SELinux34 =A0$LTPROOT/testcases/bin/selinux_task_setpgid.sh
>>> > +SELinux35 =A0$LTPROOT/testcases/bin/selinux_task_setscheduler.sh
>>> > +SELinux36 =A0$LTPROOT/testcases/bin/selinux_wait.sh
>>> > +SELinux37 =A0$LTPROOT/testcases/bin/selinux_dyntrace.sh
>>> > +SELinux38 =A0$LTPROOT/testcases/bin/selinux_dyntrans.sh
>>> > +SELinux39 =A0$LTPROOT/testcases/bin/selinux_bounds.sh
>>>
>>> Ok -- I think that we just resolved the last of the selinux test suite =
saga by properly
>>>
>>> The difference between your suggested patch above and what I committed
>>> was the line were it determined LTPROOT. Assuming that LTPROOT is the
>>> directory where the script was run isn't a smart idea, and I'm pretty
>>> sure that you were doing this purely because test_selinux.sh was in
>>> your path.
>>
>> So you require that the test script be invoked by absolute path, ala:
>> $ /opt/ltp/testscripts/test_selinux.sh
>>
>> I was invoking the tests via:
>> $ cd /opt/ltp
>> $ ./testscripts/test_selinux.sh
>>
>> The latter won't work with your current LTPROOT definition; it will end
>> up with a LTPROOT=3D. and LTPBIN=3D./testcases/bin, which then won't work
>> when it gets referenced by the individual test scripts particularly when
>> they change to a subdirectory for a particular test. =A0This yields a
>> couple of failures in the .log and 'No such file or directory' errors in
>> the .outfile.
>>
>>> After the above items were committed, this is the end result:
>>>
>>> Total Tests: 39
>>> Total Failures: 0
>>> Kernel Version: 2.6.31.9-174.fc12.i686.PAE
>>> Machine Architecture: i686
>>> Hostname: localhost.localdomain
>>>
>>> I highly encourage others to test this out as well -- maybe we can enab=
le it in the default build after I can get some RHEL4 folks to test the por=
t...?
>>
>> When invoked via cd /opt/ltp && ./testscripts/test_selinux.sh I get the
>> following errors in the .outfile:
>>
>> chcon: cannot access `selinux_wait_io': No such file or directory
>> ./testcases/bin/selinux_file.sh: line 188: tst_resm: command not found
>> runcon: selinux_wait_parent: No such file or directory
>> ./testcases/bin/selinux_wait.sh: line 35: tst_resm: command not found
>> runcon: selinux_wait_parent: No such file or directory
>> ./testcases/bin/selinux_wait.sh: line 51: tst_resm: command not found
>>
>> The first message actually shows up even when invoked
>> via /opt/ltp/testscripts/test_selinux.sh, although it doesn't appear to
>> cause any FAIL in that case. =A0The test_resm messages are odd - is that
>> not getting defined anywhere?
>
> Ok. Send me a patch that does a readlink -f of the LTPPATH and set
> your PATH to include $LTPROOT/testcases/bin, and you'll be good to go

    Nevermind. I just committed the change... please retest and
hopefully all goes well for you this time around.
Cheers,
-Garrett

---------------------------------------------------------------------------=
---
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the busine=
ss
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
