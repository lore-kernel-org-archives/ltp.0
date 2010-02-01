Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nc2To-0004dc-U5
	for ltp-list@lists.sourceforge.net; Mon, 01 Feb 2010 20:02:40 +0000
Received: from mail-pz0-f190.google.com ([209.85.222.190])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nc2To-0005F5-4j
	for ltp-list@lists.sourceforge.net; Mon, 01 Feb 2010 20:02:40 +0000
Received: by pzk28 with SMTP id 28so4476829pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 01 Feb 2010 12:02:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1265034017.12435.7.camel@moss-pluto.epoch.ncsc.mil>
References: <001201caa315$d351baf0$79f530d0$@co.jp>
	<364299f41002010044j269258fep9cfd31c8c0f897ac@mail.gmail.com>
	<1265034017.12435.7.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 1 Feb 2010 12:02:34 -0800
Message-ID: <364299f41002011202o5771b118k917f899b44e36bec@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: LTP list <ltp-list@lists.sourceforge.net>, Mitani <mitani@ryobi.co.jp>

On Mon, Feb 1, 2010 at 6:20 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2010-02-01 at 00:44 -0800, Garrett Cooper wrote:
>> On Mon, Feb 1, 2010 at 12:09 AM, Mitani <mitani@ryobi.co.jp> wrote:
>> > Hi,
>> >
>> > I tried to build 2010-02-01 cvs in RHEL5.4 system.
>> > (Archecture : x86 and x86_64)
>> >
>> >
>> > "make" failed with following message:
>> > ------------
>> > [...]
>> > make[5]: Entering directory
>> > `/home/LTP/ltp-2010-02-01/testcases/kernel/security/selinux-testsuite/=
refpol
>> > icy'
>> > (cd
>> > "/home/LTP/ltp-2010-02-01/testcases/kernel/security/selinux-testsuite/=
refpol
>> > icy/policy_files/generic" && cat test_global.te test_bounds.te
>
> Hmm...this indicates that your Makefile rewrite still isn't working
> properly on RHEL5, where it is supposed to use the files under
> refpolicy/policy_files/redhat-5 instead of generic.
>
>> > test_capable_file.te test_capable_net.te test_capable_sys.te
>> > test_dyntrace.te test_dyntrans.te test_entrypoint.te test_execshare.te
>> > test_exectrace.te test_execute_no_trans.te test_fdreceive.te test_file=
.te
>> > test_inherit.te test_ioctl.te test_ipc.te test_link.te test_mkdir.te
>> > test_open.te test_ptrace.te test_readlink.te test_relabel.te test_rena=
me.te
>> > test_rxdir.te test_setattr.te test_setnice.te test_sigkill.te test_sta=
t.te
>> > test_sysctl.te test_task_create.te test_task_getpgid.te
>> > test_task_getsched.te test_task_getsid.te test_task_setpgid.te
>> > test_task_setsched.te test_transition.te test_wait.te) > test_policy.te
>> > cat: /selinux/mls: No such file or directory
>
> And this suggests that the tester does not have SELinux enabled in his
> kernel. =A0You shouldn't enable the SELinux testsuite unless SELinux is
> enabled in the kernel. =A0You can test with something akin to:
> if [ -x /usr/sbin/selinuxenabled ] && selinuxenabled; then
> =A0 =A0 =A0 =A0<run selinux testsuite>
> fi
>
>
>> > make[6]: Entering directory
>> > `/home/LTP/ltp-2010-02-01/testcases/kernel/security/selinux-testsuite/=
refpol
>> > icy'
>> > Compiling targeted test_policy module
>> > test_policy.te:129:ERROR 'syntax error' at token 'typebounds' on line =
93991:
>> > # Definition of boundary relationship
>> > typebounds test_bounds_parent_t test_bounds_child_t;
>> > /usr/bin/checkmodule: =A0error(s) encountered while parsing configurat=
ion
>> > /usr/bin/checkmodule: =A0loading policy configuration from tmp/test_po=
licy.tmp
>
> And apparently your Makefile logic to exclude test_bounds.te if
> CHECKPOLICYVERS is not 24 isn't working either, although it wouldn't try
> if it was using the right subdirectory.

Mitani-san -- could you do the following please?

1. cat out your /etc/issue file.
2. Provide the output for $srcdir/scripts/detect_distro.sh

Thanks!
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
