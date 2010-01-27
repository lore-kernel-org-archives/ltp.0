Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Na1Uz-0005Dx-6O
	for ltp-list@lists.sourceforge.net; Wed, 27 Jan 2010 06:35:33 +0000
Received: from mail-yw0-f174.google.com ([209.85.211.174])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Na1Uy-0005i7-3Z
	for ltp-list@lists.sourceforge.net; Wed, 27 Jan 2010 06:35:33 +0000
Received: by ywh4 with SMTP id 4so3619709ywh.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 26 Jan 2010 22:35:25 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1077)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <1264516245.19890.22.camel@moss-pluto.epoch.ncsc.mil>
Date: Tue, 26 Jan 2010 22:34:51 -0800
Message-Id: <23804BFE-0FC7-45F8-939D-3729E39DB431@gmail.com>
References: <1262988051.20881.42.camel@moss-pluto.epoch.ncsc.mil>
	<1263237132.5091.1.camel@moss-pluto.epoch.ncsc.mil>
	<20100111195043.GA23360@us.ibm.com>
	<1263239706.5091.11.camel@moss-pluto.epoch.ncsc.mil>
	<20100111201936.GA24711@us.ibm.com>
	<20100111205858.GA26412@us.ibm.com>
	<20100111210006.GA26554@us.ibm.com>
	<364299f41001120029x15b2e7adwe30d925717a1dc89@mail.gmail.com>
	<20100112153827.GB7975@us.ibm.com>
	<364299f41001150948u4df35c36g3d4b07b16af49f90@mail.gmail.com>
	<364299f41001260031h2529b9b0j1bbbacd9d3d85eae@mail.gmail.com>
	<1264516245.19890.22.camel@moss-pluto.epoch.ncsc.mil>
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
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>, ltp-list@lists.sourceforge.net

On Jan 26, 2010, at 6:30 AM, Stephen Smalley wrote:

> On Tue, 2010-01-26 at 00:31 -0800, Garrett Cooper wrote:
>> On Fri, Jan 15, 2010 at 9:48 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
>>> On Tue, Jan 12, 2010 at 7:38 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
>>>> Quoting Garrett Cooper (yanegomi@gmail.com):
>>>>> On Mon, Jan 11, 2010 at 1:00 PM, Serge E. Hallyn <serue@us.ibm.com> wrote:
>>>>>> Quoting Serge E. Hallyn (serue@us.ibm.com):
>>>>>>> Quoting Serge E. Hallyn (serue@us.ibm.com):
>>>>>>>> Quoting Stephen Smalley (sds@tycho.nsa.gov):
>>>>>>>>> On Mon, 2010-01-11 at 13:50 -0600, Serge E. Hallyn wrote:
>>>>>>>>>>> Fails with:
>>>>>>>>>>> cp: cannot stat
>>>>>>>>>>> `/home/sds/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/policy_files/generic/test_policy.*': No such file or directory
>>>>>>>>>> 
>>>>>>>>>> You ran /home/sds/ltp/testscripts/test_selinux.sh, right?
>>>>>>>>>> 
>>>>>>>>>> I think we are supposed to actually be running
>>>>>>>>>> /opt/ltp/testscripts/test_selinux.sh.  So then the first question for
>>>>>>>>>> Garrett is how should we deduce /home/sds/ltp as $LTP_SRCDIR from a
>>>>>>>>>> testscript?  Or should the policy sources be copied into /opt?
>>>>>>>>> 
>>>>>>>>> Ok, but regardless:  the refpolicy Makefile is still broken.
>>>>>>>> 
>>>>>>>> Yup.
>>>>>>> 
>>>>>>> All right, baby-steps.
>>>>>>> 
>>>>>>> The attached test_selinux.diff is not to be applied, but something
>>>>>>> like it is needed.  Should we have the ltp 'make install' fill in
>>>>>>> TOP_SRCDIR in /opt/ltp/testscripts/test_selinux.sh?  BTW, Garrett,
>>>>>>> that is the issue I was saying is shared between test_selinux.sh
>>>>>>> and some others including test_robind.sh.  That's why I'm not just
>>>>>>> sending a patch to make it work, bc i think we need more general
>>>>>>> guidance.
>>>>>>> 
>>>>>>> The second match makes the 'make load' part of test_selinux.sh
>>>>>>> succeed on rhel5.4.  Stephen, how does it do on fedora?
>>>>>>> 
>>>>>>> After loading policy it fails to execute ltp-pan, but I figure let's
>>>>>>> get policy loading working first.
>>>>>>> 
>>>>>>> -serge
>>>>>> 
>>>>>> gah, attaching the actual patches this time.
>>>>>> 
>>>>>> -serge
>>>>> 
>>>>> 1. I'm rejecting the test_selinux.diff solely because it has /root/ltp
>>>>> hardcoded as LTPROOT.
>>>> 
>>>> I said 'not to be applied'.  You're not rejecting.
>>>> 
>>>>> 2. Why is the redhat stuff support to work
>>>>> agnostic to the major and minor version?
>>>> 
>>>> It's not agnostic to the major version.  Only the minor version.
>>>> 
>>>> And since you've made ltp not compile on rhel4 (requiring make-3.81.  feh)
>>>> i suppose we can just get rid of rhel4 support selinux-testsuite.
>>> 
>>> No. 1. Compiling make 3.81 today and installing it is trivial, so it
>>> shouldn't be removed today. 2. I've finally decided that I'm going to
>>> look outside of the box into providing equivalent functionality via
>>> shell functions using purely built-in commands [and test(1)] to fill
>>> in the feature gaps for make 3.80. I've gotten to the point where I
>>> just gave up trying to ride out what I possibly can in make 3.80, so
>>> it's time to pull in some external pieces to get the job done.
>> 
>>    All of the install junk works now, but the modes need fixing, or
>> some such fun. Please analyze the test_selinux.sh script and tell me
>> what to commit next to fix everything.
> 
> Hi Garrett,
> 
> I needed to apply the patch below to make test_selinux.sh run
> successfully on Fedora 12.  The problems were:
> - The setting of LTPROOT in test_selinux.sh was incorrect, leading to
> problems with invoking everything else.  Note that I invoke it by doing:
> cd /opt/ltp && ./testscripts/test_selinux.sh
> and thus $0 is a relative path, whereas we want an absolute one.
> - You don't need to cd to $POLICYDIR at all since you specify
> $POLICYDIR/test_policy.pp to semodule -i and semodule -r is acting on
> the installed policy module.
> - The attempt to extract paths from runtest/selinux and invoke chcon on
> them wasn't working as $LTPROOT wasn't being expanded; easier to just do
> a chcon -R there as before.
> - runtest/selinux had the wrong paths to the test programs (or
> alternatively, they aren't being installed to the right location - they
> all get installed directly to $LTPROOT/testcases/bin.
> 
> Index: testscripts/test_selinux.sh
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testscripts/test_selinux.sh,v
> retrieving revision 1.20
> diff -u -r1.20 test_selinux.sh
> --- testscripts/test_selinux.sh	26 Jan 2010 07:05:02 -0000	1.20
> +++ testscripts/test_selinux.sh	26 Jan 2010 14:20:40 -0000
> @@ -37,15 +37,14 @@
> fi
> 
> # set the LTPROOT directory
> -LTPROOT=${LTPROOT:=${0%/*}}
> -cd "$LTPROOT"
> +LTPROOT=`pwd`
> export TMP=${TMP:-/tmp}
> -# If we're in the testscripts directory, go down a dir..
> +# If we're in the testscripts directory, go up a dir..
> LTPROOT_TMP=${LTPROOT%/testscripts}
> if [ "x${LTPROOT_TMP}" != "x${LTPROOT}" ]
> then
> 	cd ..
> -	LTPROOT=$LTPROOT_TMP
> +	LTPROOT=`pwd`
> fi
> export LTPROOT
> unset LTPROOT_TMP
> @@ -89,7 +88,6 @@
> 
> # install the test policy...
> echo "Installing test_policy module..."
> -cd $POLICYDIR
> if ! semodule -i $POLICYDIR/test_policy.pp; then
> 	echo "Failed to install test_policy module, aborting test run."
> 	config_unset_expandcheck
> @@ -100,9 +98,6 @@
> 
> config_unset_expandcheck
> 
> -# go back to test's root directory
> -cd $LTPROOT
> -
> echo "Running the SELinux testsuite..."
> 
> mkdir $TMP/selinux > /dev/null 2>&1
> @@ -112,8 +107,7 @@
> # The ../testcases/bin directory needs to have the test_file_t type.
> # Save and restore later.
> SAVEBINTYPE=`ls -Zd $LTPROOT/testcases/bin | awk '{ print $4 }' | awk -F: '{ print $3 }'`
> -/usr/bin/chcon -t test_file_t	$LTPROOT/testcases/bin \
> -				$(awk '$1 !~ /^#/ { print $2 }' "$LTPROOT/runtest/selinux")
> +/usr/bin/chcon -R -t test_file_t	$LTPROOT/testcases/bin
> 
> $LTPROOT/bin/ltp-pan -S -a $LTPROOT/results/selinux -n ltp-selinux \
> 	-l $LTPROOT/results/selinux.logfile \
> @@ -127,7 +121,6 @@
> /usr/bin/chcon -R -t $SAVEBINTYPE $LTPROOT/testcases/bin
> 
> echo "Removing test_policy module..."
> -cd $POLICYDIR
> if ! semodule -r test_policy; then
> 	echo "Failed to remove test_policy module."
> 	exit 1
> Index: runtest/selinux
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/runtest/selinux,v
> retrieving revision 1.4
> diff -u -r1.4 selinux
> --- runtest/selinux	25 Jan 2010 12:44:59 -0000	1.4
> +++ runtest/selinux	26 Jan 2010 14:20:40 -0000
> @@ -1,40 +1,40 @@
> #DESCRIPTION:Security-Enhanced Linux
> -SELinux01	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_capable_file.sh
> -SELinux02	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_capable_net.sh
> -SELinux03	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_capable_sys.sh
> -SELinux04	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_domain_trans.sh
> -SELinux05	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_entrypoint.sh
> -SELinux06	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_execshare.sh
> -SELinux07	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_exectrace.sh
> -SELinux08	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_execute_no_trans.sh
> -SELinux09	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_fdreceive.sh
> -SELinux10	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_file.sh
> -SELinux11	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_inherit.sh
> -SELinux12	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_ioctl.sh
> -SELinux13	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_link.sh
> -SELinux14	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_mkdir.sh
> -SELinux15	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_msg.sh
> -SELinux16	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_open.sh
> -SELinux17	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_ptrace.sh
> -SELinux18	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_readlink.sh
> -SELinux19	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_relabel.sh
> -SELinux20	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_rename.sh
> -SELinux21	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_rxdir.sh
> -SELinux22	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_sem.sh
> -SELinux23	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_setattr.sh
> -SELinux24	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_setnice.sh
> -SELinux25	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_shm.sh
> -SELinux26	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_sigkill.sh
> -SELinux27	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_stat.sh
> -SELinux28	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_sysctl.sh
> -SELinux29	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_task_create.sh
> -SELinux30	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_task_getpgid.sh
> -SELinux31	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_task_getscheduler.sh
> -SELinux32	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_task_getsid.sh
> -SELinux33	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_task_setnice.sh
> -SELinux34	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_task_setpgid.sh
> -SELinux35	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_task_setscheduler.sh
> -SELinux36	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_wait.sh
> -SELinux37	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_dyntrace.sh
> -SELinux38	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_dyntrans.sh
> -SELinux39	$LTPROOT/testcases/bin/kernel/security/selinux-testsuite/tests/selinux_bounds.sh
> +SELinux01	$LTPROOT/testcases/bin/selinux_capable_file.sh
> +SELinux02	$LTPROOT/testcases/bin/selinux_capable_net.sh
> +SELinux03	$LTPROOT/testcases/bin/selinux_capable_sys.sh
> +SELinux04	$LTPROOT/testcases/bin/selinux_domain_trans.sh
> +SELinux05	$LTPROOT/testcases/bin/selinux_entrypoint.sh
> +SELinux06	$LTPROOT/testcases/bin/selinux_execshare.sh
> +SELinux07	$LTPROOT/testcases/bin/selinux_exectrace.sh
> +SELinux08	$LTPROOT/testcases/bin/selinux_execute_no_trans.sh
> +SELinux09	$LTPROOT/testcases/bin/selinux_fdreceive.sh
> +SELinux10	$LTPROOT/testcases/bin/selinux_file.sh
> +SELinux11	$LTPROOT/testcases/bin/selinux_inherit.sh
> +SELinux12	$LTPROOT/testcases/bin/selinux_ioctl.sh
> +SELinux13	$LTPROOT/testcases/bin/selinux_link.sh
> +SELinux14	$LTPROOT/testcases/bin/selinux_mkdir.sh
> +SELinux15	$LTPROOT/testcases/bin/selinux_msg.sh
> +SELinux16	$LTPROOT/testcases/bin/selinux_open.sh
> +SELinux17	$LTPROOT/testcases/bin/selinux_ptrace.sh
> +SELinux18	$LTPROOT/testcases/bin/selinux_readlink.sh
> +SELinux19	$LTPROOT/testcases/bin/selinux_relabel.sh
> +SELinux20	$LTPROOT/testcases/bin/selinux_rename.sh
> +SELinux21	$LTPROOT/testcases/bin/selinux_rxdir.sh
> +SELinux22	$LTPROOT/testcases/bin/selinux_sem.sh
> +SELinux23	$LTPROOT/testcases/bin/selinux_setattr.sh
> +SELinux24	$LTPROOT/testcases/bin/selinux_setnice.sh
> +SELinux25	$LTPROOT/testcases/bin/selinux_shm.sh
> +SELinux26	$LTPROOT/testcases/bin/selinux_sigkill.sh
> +SELinux27	$LTPROOT/testcases/bin/selinux_stat.sh
> +SELinux28	$LTPROOT/testcases/bin/selinux_sysctl.sh
> +SELinux29	$LTPROOT/testcases/bin/selinux_task_create.sh
> +SELinux30	$LTPROOT/testcases/bin/selinux_task_getpgid.sh
> +SELinux31	$LTPROOT/testcases/bin/selinux_task_getscheduler.sh
> +SELinux32	$LTPROOT/testcases/bin/selinux_task_getsid.sh
> +SELinux33	$LTPROOT/testcases/bin/selinux_task_setnice.sh
> +SELinux34	$LTPROOT/testcases/bin/selinux_task_setpgid.sh
> +SELinux35	$LTPROOT/testcases/bin/selinux_task_setscheduler.sh
> +SELinux36	$LTPROOT/testcases/bin/selinux_wait.sh
> +SELinux37	$LTPROOT/testcases/bin/selinux_dyntrace.sh
> +SELinux38	$LTPROOT/testcases/bin/selinux_dyntrans.sh
> +SELinux39	$LTPROOT/testcases/bin/selinux_bounds.sh

Ok -- I think that we just resolved the last of the selinux test suite saga by properly 

The difference between your suggested patch above and what I committed was the line were it determined LTPROOT. Assuming that LTPROOT is the directory where the script was run isn't a smart idea, and I'm pretty sure that you were doing this purely because test_selinux.sh was in your path.

After the above items were committed, this is the end result:

Total Tests: 39
Total Failures: 0
Kernel Version: 2.6.31.9-174.fc12.i686.PAE
Machine Architecture: i686
Hostname: localhost.localdomain

I highly encourage others to test this out as well -- maybe we can enable it in the default build after I can get some RHEL4 folks to test the port...?

Thanks,
-Garrett
------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
