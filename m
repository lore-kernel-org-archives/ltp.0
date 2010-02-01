Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NbrLX-0005LB-H6
	for ltp-list@lists.sourceforge.net; Mon, 01 Feb 2010 08:09:23 +0000
Received: from out01.sjc.mx.trendmicro.com ([216.99.131.5])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NbrLV-0002Jw-SH
	for ltp-list@lists.sourceforge.net; Mon, 01 Feb 2010 08:09:23 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.5])
	by out01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 8B52B239E2F
	for <ltp-list@lists.sourceforge.net>;
	Mon,  1 Feb 2010 08:09:14 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 7C20E114B83B
	for <ltp-list@lists.sourceforge.net>;
	Mon,  1 Feb 2010 08:09:08 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Feb 2010 17:09:06 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Mon, 1 Feb 2010 17:09:06 +0900
Message-ID: <001201caa315$d351baf0$79f530d0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] 2010-02-01 cvs make problem
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
To: ltp-list@lists.sourceforge.net

Hi,

I tried to build 2010-02-01 cvs in RHEL5.4 system.
(Archecture : x86 and x86_64)


"make" failed with following message:
------------
[...]
make[5]: Entering directory
`/home/LTP/ltp-2010-02-01/testcases/kernel/security/selinux-testsuite/refpol
icy'
(cd
"/home/LTP/ltp-2010-02-01/testcases/kernel/security/selinux-testsuite/refpol
icy/policy_files/generic" && cat test_global.te test_bounds.te
test_capable_file.te test_capable_net.te test_capable_sys.te
test_dyntrace.te test_dyntrans.te test_entrypoint.te test_execshare.te
test_exectrace.te test_execute_no_trans.te test_fdreceive.te test_file.te
test_inherit.te test_ioctl.te test_ipc.te test_link.te test_mkdir.te
test_open.te test_ptrace.te test_readlink.te test_relabel.te test_rename.te
test_rxdir.te test_setattr.te test_setnice.te test_sigkill.te test_stat.te
test_sysctl.te test_task_create.te test_task_getpgid.te
test_task_getsched.te test_task_getsid.te test_task_setpgid.te
test_task_setsched.te test_transition.te test_wait.te) > test_policy.te
cat: /selinux/mls: No such file or directory
make[6]: Entering directory
`/home/LTP/ltp-2010-02-01/testcases/kernel/security/selinux-testsuite/refpol
icy'
Compiling targeted test_policy module
test_policy.te:129:ERROR 'syntax error' at token 'typebounds' on line 93991:
# Definition of boundary relationship
typebounds test_bounds_parent_t test_bounds_child_t;
/usr/bin/checkmodule:  error(s) encountered while parsing configuration
/usr/bin/checkmodule:  loading policy configuration from tmp/test_policy.tmp
make[6]: *** [tmp/test_policy.mod] Error 1
make[6]: Leaving directory
`/home/LTP/ltp-2010-02-01/testcases/kernel/security/selinux-testsuite/refpol
icy'
make[5]: *** [test_policy.pp] Error 2
[...]
------------

Similar failure occurred in 2010-01-29 cvs "make".


I got "strace" of "make" command. I think that "${LTPROOT}/testcases/
kernel/security/selinux-testsuite/refpolicy/tmptest_policy.tmp" may be
related to this failure:
------------
[...]
20659 open("tmp/test_policy.tmp", O_RDONLY) = 3
20659 ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbf972518) = -1 ENOTTY
(Inappropriate ioctl
 for device)
20659 fstat64(3, {st_mode=S_IFREG|0644, st_size=2564625, ...}) = 0
20659 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7f400
00
20659 read(3, "#line 1 \"/usr/share/selinux/deve"..., 8192) = 8192
20659 read(3, "\n\n\n\n\n\n\n\n\n#\n# Block device nodes "..., 8192) = 8192
20659 read(3, "################################"..., 8192) = 8192
20659 read(3, "der configuration file.\n## </sum"..., 8192) = 8192
[...]
20659 read(3, "1\n#line 52\n \t\n#line 52\n\t\n#line 5"..., 8192) = 8192
20659 read(3, "\n\tallow testdomain security_t:se"..., 8192) = 8192
20659 read(3, "optional\n#line 104\n\t\n#line 104\n\n"..., 8192) = 8192
20659 read(3, "_t testdomain;\n\nallow test_bound"..., 8192) = 8192
20659 write(2, "test_policy.te:129:", 19) = 19
20659 write(2, "ERROR 'syntax error' at token 't"..., 149) = 149
20659 write(2, "/usr/bin/checkmodule:  error(s) "..., 72) = 72
[...]
------------


"${LTPROOT}/testcases/kernel/security/selinux-testsuite/refpolicy/
test_policy.te" is follows:
------------
[...]
allow test_bounds_unbound_t test_bounds_file_t : file { rw_file_perms };

# Definition of boundary relationship
typebounds test_bounds_parent_t test_bounds_child_t;		...Line129
typebounds test_bounds_file_t test_bounds_file_red_t,
test_bounds_file_blue_t;

# Allow the test_bounds_parent_t to dyntrans
allow test_bounds_parent_t test_bounds_child_t   : process { dyntransition
};
allow test_bounds_parent_t test_bounds_unbound_t : process { dyntransition
};
[...]
------------


"${LTPROOT}/testcases/kernel/security/selinux-testsuite/refpolicy/tmp
test_policy.tmp" is follows:
------------
[...]
allow test_bounds_unbound_t test_bounds_file_t : file { { getattr read write
append ioctl
lock } };
...Line93988

# Definition of boundary relationship
typebounds test_bounds_parent_t test_bounds_child_t;		...Line93991
typebounds test_bounds_file_t test_bounds_file_red_t,
test_bounds_file_blue_t;

# Allow the test_bounds_parent_t to dyntrans
allow test_bounds_parent_t test_bounds_child_t   : process { dyntransition
};
allow test_bounds_parent_t test_bounds_unbound_t : process { dyntransition
};
[...]
------------

In "test_policy.te", Line129's syntax is right, I think.

In "test_policy.tmp", Line93991 is same as "test_policy.te".
But Line93988 is different.


I investigated like above, but I couldn't specify a cause after all.
Do you have any good idea?


Thank you--


-Tomonori Mitani



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
