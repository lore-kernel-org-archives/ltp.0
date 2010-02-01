Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nbru2-0001zg-AN
	for ltp-list@lists.sourceforge.net; Mon, 01 Feb 2010 08:45:02 +0000
Received: from mail-pz0-f199.google.com ([209.85.222.199])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nbrtz-00071K-RE
	for ltp-list@lists.sourceforge.net; Mon, 01 Feb 2010 08:45:02 +0000
Received: by pzk37 with SMTP id 37so3779360pzk.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 01 Feb 2010 00:44:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <001201caa315$d351baf0$79f530d0$@co.jp>
References: <001201caa315$d351baf0$79f530d0$@co.jp>
Date: Mon, 1 Feb 2010 00:44:53 -0800
Message-ID: <364299f41002010044j269258fep9cfd31c8c0f897ac@mail.gmail.com>
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
To: Mitani <mitani@ryobi.co.jp>
Cc: LTP list <ltp-list@lists.sourceforge.net>, Stephen Smalley <sds@tycho.nsa.gov>

On Mon, Feb 1, 2010 at 12:09 AM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> I tried to build 2010-02-01 cvs in RHEL5.4 system.
> (Archecture : x86 and x86_64)
>
>
> "make" failed with following message:
> ------------
> [...]
> make[5]: Entering directory
> `/home/LTP/ltp-2010-02-01/testcases/kernel/security/selinux-testsuite/ref=
pol
> icy'
> (cd
> "/home/LTP/ltp-2010-02-01/testcases/kernel/security/selinux-testsuite/ref=
pol
> icy/policy_files/generic" && cat test_global.te test_bounds.te
> test_capable_file.te test_capable_net.te test_capable_sys.te
> test_dyntrace.te test_dyntrans.te test_entrypoint.te test_execshare.te
> test_exectrace.te test_execute_no_trans.te test_fdreceive.te test_file.te
> test_inherit.te test_ioctl.te test_ipc.te test_link.te test_mkdir.te
> test_open.te test_ptrace.te test_readlink.te test_relabel.te test_rename.=
te
> test_rxdir.te test_setattr.te test_setnice.te test_sigkill.te test_stat.te
> test_sysctl.te test_task_create.te test_task_getpgid.te
> test_task_getsched.te test_task_getsid.te test_task_setpgid.te
> test_task_setsched.te test_transition.te test_wait.te) > test_policy.te
> cat: /selinux/mls: No such file or directory
> make[6]: Entering directory
> `/home/LTP/ltp-2010-02-01/testcases/kernel/security/selinux-testsuite/ref=
pol
> icy'
> Compiling targeted test_policy module
> test_policy.te:129:ERROR 'syntax error' at token 'typebounds' on line 939=
91:
> # Definition of boundary relationship
> typebounds test_bounds_parent_t test_bounds_child_t;
> /usr/bin/checkmodule: =A0error(s) encountered while parsing configuration
> /usr/bin/checkmodule: =A0loading policy configuration from tmp/test_polic=
y.tmp
> make[6]: *** [tmp/test_policy.mod] Error 1
> make[6]: Leaving directory
> `/home/LTP/ltp-2010-02-01/testcases/kernel/security/selinux-testsuite/ref=
pol
> icy'
> make[5]: *** [test_policy.pp] Error 2
> [...]
> ------------
>
> Similar failure occurred in 2010-01-29 cvs "make".
>
>
> I got "strace" of "make" command. I think that "${LTPROOT}/testcases/
> kernel/security/selinux-testsuite/refpolicy/tmptest_policy.tmp" may be
> related to this failure:
> ------------
> [...]
> 20659 open("tmp/test_policy.tmp", O_RDONLY) =3D 3
> 20659 ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbf972518) =3D -1 ENOTTY
> (Inappropriate ioctl
> =A0for device)
> 20659 fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D2564625, ...}) =3D 0
> 20659 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, =
-1,
> 0) =3D 0xb7f400
> 00
> 20659 read(3, "#line 1 \"/usr/share/selinux/deve"..., 8192) =3D 8192
> 20659 read(3, "\n\n\n\n\n\n\n\n\n#\n# Block device nodes "..., 8192) =3D =
8192
> 20659 read(3, "################################"..., 8192) =3D 8192
> 20659 read(3, "der configuration file.\n## </sum"..., 8192) =3D 8192
> [...]
> 20659 read(3, "1\n#line 52\n \t\n#line 52\n\t\n#line 5"..., 8192) =3D 8192
> 20659 read(3, "\n\tallow testdomain security_t:se"..., 8192) =3D 8192
> 20659 read(3, "optional\n#line 104\n\t\n#line 104\n\n"..., 8192) =3D 8192
> 20659 read(3, "_t testdomain;\n\nallow test_bound"..., 8192) =3D 8192
> 20659 write(2, "test_policy.te:129:", 19) =3D 19
> 20659 write(2, "ERROR 'syntax error' at token 't"..., 149) =3D 149
> 20659 write(2, "/usr/bin/checkmodule: =A0error(s) "..., 72) =3D 72
> [...]
> ------------
>
>
> "${LTPROOT}/testcases/kernel/security/selinux-testsuite/refpolicy/
> test_policy.te" is follows:
> ------------
> [...]
> allow test_bounds_unbound_t test_bounds_file_t : file { rw_file_perms };
>
> # Definition of boundary relationship
> typebounds test_bounds_parent_t test_bounds_child_t; =A0 =A0 =A0 =A0 =A0 =
=A0...Line129
> typebounds test_bounds_file_t test_bounds_file_red_t,
> test_bounds_file_blue_t;
>
> # Allow the test_bounds_parent_t to dyntrans
> allow test_bounds_parent_t test_bounds_child_t =A0 : process { dyntransit=
ion
> };
> allow test_bounds_parent_t test_bounds_unbound_t : process { dyntransition
> };
> [...]
> ------------
>
>
> "${LTPROOT}/testcases/kernel/security/selinux-testsuite/refpolicy/tmp
> test_policy.tmp" is follows:
> ------------
> [...]
> allow test_bounds_unbound_t test_bounds_file_t : file { { getattr read wr=
ite
> append ioctl
> lock } };
> ...Line93988
>
> # Definition of boundary relationship
> typebounds test_bounds_parent_t test_bounds_child_t; =A0 =A0 =A0 =A0 =A0 =
=A0...Line93991
> typebounds test_bounds_file_t test_bounds_file_red_t,
> test_bounds_file_blue_t;
>
> # Allow the test_bounds_parent_t to dyntrans
> allow test_bounds_parent_t test_bounds_child_t =A0 : process { dyntransit=
ion
> };
> allow test_bounds_parent_t test_bounds_unbound_t : process { dyntransition
> };
> [...]
> ------------
>
> In "test_policy.te", Line129's syntax is right, I think.
>
> In "test_policy.tmp", Line93991 is same as "test_policy.te".
> But Line93988 is different.
>
>
> I investigated like above, but I couldn't specify a cause after all.
> Do you have any good idea?

I'll just yank selinux-testsuite from the default build because
apparently the default selinux policies don't work on RHEL.

Please work with Stephen to resolve the issue as I have no idea what
the issue is that these these messages are trying to convey...

Thanks,
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
