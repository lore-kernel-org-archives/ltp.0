Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sds@tycho.nsa.gov>) id 1Nbx2g-0001mH-OW
	for ltp-list@lists.sourceforge.net; Mon, 01 Feb 2010 14:14:18 +0000
Received: from msux-gh1-uea01.nsa.gov ([63.239.67.1])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nbx2e-0006A3-Cl
	for ltp-list@lists.sourceforge.net; Mon, 01 Feb 2010 14:14:18 +0000
From: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <364299f41002010044j269258fep9cfd31c8c0f897ac@mail.gmail.com>
References: <001201caa315$d351baf0$79f530d0$@co.jp>
	<364299f41002010044j269258fep9cfd31c8c0f897ac@mail.gmail.com>
Date: Mon, 01 Feb 2010 09:20:17 -0500
Message-Id: <1265034017.12435.7.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Subject: Re: [LTP] 2010-02-01 cvs make problem
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
Cc: LTP list <ltp-list@lists.sourceforge.net>, Mitani <mitani@ryobi.co.jp>

On Mon, 2010-02-01 at 00:44 -0800, Garrett Cooper wrote:
> On Mon, Feb 1, 2010 at 12:09 AM, Mitani <mitani@ryobi.co.jp> wrote:
> > Hi,
> >
> > I tried to build 2010-02-01 cvs in RHEL5.4 system.
> > (Archecture : x86 and x86_64)
> >
> >
> > "make" failed with following message:
> > ------------
> > [...]
> > make[5]: Entering directory
> > `/home/LTP/ltp-2010-02-01/testcases/kernel/security/selinux-testsuite/refpol
> > icy'
> > (cd
> > "/home/LTP/ltp-2010-02-01/testcases/kernel/security/selinux-testsuite/refpol
> > icy/policy_files/generic" && cat test_global.te test_bounds.te

Hmm...this indicates that your Makefile rewrite still isn't working
properly on RHEL5, where it is supposed to use the files under
refpolicy/policy_files/redhat-5 instead of generic.

> > test_capable_file.te test_capable_net.te test_capable_sys.te
> > test_dyntrace.te test_dyntrans.te test_entrypoint.te test_execshare.te
> > test_exectrace.te test_execute_no_trans.te test_fdreceive.te test_file.te
> > test_inherit.te test_ioctl.te test_ipc.te test_link.te test_mkdir.te
> > test_open.te test_ptrace.te test_readlink.te test_relabel.te test_rename.te
> > test_rxdir.te test_setattr.te test_setnice.te test_sigkill.te test_stat.te
> > test_sysctl.te test_task_create.te test_task_getpgid.te
> > test_task_getsched.te test_task_getsid.te test_task_setpgid.te
> > test_task_setsched.te test_transition.te test_wait.te) > test_policy.te
> > cat: /selinux/mls: No such file or directory

And this suggests that the tester does not have SELinux enabled in his
kernel.  You shouldn't enable the SELinux testsuite unless SELinux is
enabled in the kernel.  You can test with something akin to:
if [ -x /usr/sbin/selinuxenabled ] && selinuxenabled; then
	<run selinux testsuite>
fi
	

> > make[6]: Entering directory
> > `/home/LTP/ltp-2010-02-01/testcases/kernel/security/selinux-testsuite/refpol
> > icy'
> > Compiling targeted test_policy module
> > test_policy.te:129:ERROR 'syntax error' at token 'typebounds' on line 93991:
> > # Definition of boundary relationship
> > typebounds test_bounds_parent_t test_bounds_child_t;
> > /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> > /usr/bin/checkmodule:  loading policy configuration from tmp/test_policy.tmp

And apparently your Makefile logic to exclude test_bounds.te if
CHECKPOLICYVERS is not 24 isn't working either, although it wouldn't try
if it was using the right subdirectory.

-- 
Stephen Smalley
National Security Agency


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
