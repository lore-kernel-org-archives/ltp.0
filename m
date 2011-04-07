Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <noreply@sourceforge.net>) id 1Q7t8A-0006Qr-FD
	for ltp-list@lists.sourceforge.net; Thu, 07 Apr 2011 17:36:30 +0000
From: "SourceForge.net" <noreply@sourceforge.net>
Mime-Version: 1.0
Message-Id: <E1Q7t8A-00057P-AG@sfs-web-10.v29.ch3.sourceforge.com>
Date: Thu, 07 Apr 2011 17:36:30 +0000
Subject: [LTP] [ ltp-Patches-1942286 ] Port rhel5_ibm_eal4_cert_suite2 for
	SGI RHEL5.1 CC tests
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
To: noreply@sourceforge.net

Patches item #1942286, was opened at 2008-04-14 17:44
Message generated for change (Comment added) made by nobody
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=303382&aid=1942286&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: Testcases
Group: Other
Status: Closed
Resolution: Accepted
Priority: 5
Private: No
Submitted By: Klaus Weidner (kweidner)
Assigned to: Nobody/Anonymous (nobody)
Summary: Port rhel5_ibm_eal4_cert_suite2 for SGI RHEL5.1 CC tests

Initial Comment:
This patch contains the changes to the rhel5_ibm_eal4_cert_suite2 test
suite made for the CC evaluation of RHEL5.1 on SGI hardware.

Thank you to the IBM team for providing the test cases!

Bill O'Donnell <billodo@sgi.com>
Klaus Weidner <klaus@atsec.com>

*** Description of changes **************************************************

New features are:

- add support for the IA64 (Itanium2) platform, including testing of new system
  calls (clone2) and conditionally disabling inapplicable system calls for that
  platform

- add additional sanity checks to the "make verifydeps" step to catch common
  configuration errors in LSPP mode before running the tests

- add DAC manual test (tests/manual/dac.test file) suitable for running in
  tmpfs and other non-ext3 filesystems for additional coverage

The following enhancements were made to the test suite:

- show clearer usage message for the exportvars.sh script, make IPv6 address
  assignment more flexible

- when waiting for audit records to be written to disk, always wait for the
  kernel to indicate that it has cleared the backlog. This helps ensure
  reliable results on slow machines or ones with inconsistent clocks (such as
  testing in VMWare). (Optionally, try removing the "sleep 1" in function
  ltp-full/lib/audit_utils.c:pause_for_auditd() and
  ltp-full/python-lib/framework/audit_interface.py:wait_for_audit_log() for
  faster test execution.)

- remove unnecessary sleep()s in the Python RPC framework to speed up test
  execution

- more informative debugging output in the Python RPC framework, including
  enabling coredumps in case of segmentation faults in test cases

The following bugs were fixed:

- ensure correct permissions for new audit log file in
  ltp-full/lib/audit_utils.c:clear_audit_log()

- increase static string buffers in the ltp-full/lib/audit_parse_verify.c
  routines to avoid overflows and corresponding segmentation faults (this is
  not a security issue since root rights are already needed to execute the
  tests)

- in ltp-full/lib/tst_res.c, increase maximum supported user message size to
  avoid truncation of output

- in ltp-full/lib/tst_sig.c, ignore SIGWINCH signal to avoid test failure when
  the window containing the shell running the tests is resized

*** Diffstat ****************************************************************

 lspp/tests/LTP/Makefile                                                                            |   10 
 lspp/tests/LTP/ltp-full/lib/audit_parse_verify.c                                                   |   15 
 lspp/tests/LTP/ltp-full/lib/audit_utils.c                                                          |   21 
 lspp/tests/LTP/ltp-full/lib/tst_res.c                                                              |  968 ++++++++++
 lspp/tests/LTP/ltp-full/lib/tst_sig.c                                                              |  289 ++
 lspp/tests/LTP/ltp-full/python-lib/framework/audit_interface.py                                    |   27 
 lspp/tests/LTP/ltp-full/python-lib/framework/rexec.py                                              |   68 
 lspp/tests/LTP/ltp-full/python-lib/framework/shared_globals.py                                     |    6 
 lspp/tests/LTP/ltp-full/testcases/audit/audit_tools/ausearch_test                                  |   15 
 lspp/tests/LTP/ltp-full/testcases/audit/filters/multirule_test.c                                   |    2 
 lspp/tests/LTP/ltp-full/testcases/audit/filters/ranges1_test.c                                     |    4 
 lspp/tests/LTP/ltp-full/testcases/audit/filters/ranges2_test.c                                     |    5 
 lspp/tests/LTP/ltp-full/testcases/audit/filters/selinux_context_test.c                             |    1 
 lspp/tests/LTP/ltp-full/testcases/audit/include.mk                                                 |    6 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/accept_test.c                                     |    1 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/bind_test.c                                       |    6 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/chown32_test.c                                    |    4 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/clone2_test.c                                     |  237 ++
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/clone_test.c                                      |   11 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/connect_test.c                                    |    6 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/fchown32_test.c                                   |    4 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/fork_test.c                                       |   10 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/getsockopt_test.c                                 |    6 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/init_module_test.c                                |    2 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/lchown32_test.c                                   |    5 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/mmap2_test.c                                      |    2 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/msgctl_test.c                                     |   10 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/msgget_test.c                                     |   10 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/msgrecv_test.c                                    |   10 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/msgsend_test.c                                    |   10 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/reboot_test.c                                     |    4 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/recvfrom_recvmsg_test.c                           |   14 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/semctl_test.c                                     |   10 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/semget_test.c                                     |   10 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/semop_test.c                                      |   10 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/semtimedop_test.c                                 |    6 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/sendmsg_test.c                                    |    6 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/sendto_test.c                                     |    6 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/setfsgid32_test.c                                 |    3 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/setfsuid32_test.c                                 |    3 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/setgid32_test.c                                   |    3 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/setgroups32_test.c                                |    4 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/setregid32_test.c                                 |    3 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/setresgid32_test.c                                |    4 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/setresuid32_test.c                                |    3 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/setreuid32_test.c                                 |    4 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/setuid32_test.c                                   |    4 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/shmat_test.c                                      |    6 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/shmctl_test.c                                     |    6 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/shmdt_test.c                                      |    6 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/shmget_test.c                                     |    6 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/stime_test.c                                      |    2 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/umount2_test.c                                    |    9 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/utime_test.c                                      |    9 
 lspp/tests/LTP/ltp-full/testcases/audit/syscalls/vfork_test.c                                      |    9 
 lspp/tests/LTP/ltp-full/testcases/audit/trustedpgms/passwd_test.c                                  |    4 
 lspp/tests/LTP/ltp-full/testcases/kernel/security/mls/tests/framework/drivers/_ipc.c               |   36 
 lspp/tests/LTP/ltp-full/testcases/kernel/security/mls/tests/framework/drivers/_syscalls.c          |    6 
 lspp/tests/LTP/ltp-full/testcases/kernel/security/mls/tests/framework/drivers/ipc.py               |    6 
 lspp/tests/LTP/ltp-full/testcases/network/cipso_ipsec/framework/test_drivers/ipsec_v6_sshd_test.py |    3 
 lspp/tests/LTP/ltp-full/testcases/platform.mk                                                      |    5 
 lspp/tests/exportvars.sh                                                                           |   50 
 lspp/tests/manual/dac.test                                                                         |   98 +
 lspp/tests/platform.mk                                                                             |    8 
 lspp/tests/rules.mk                                                                                |   46 
 65 files changed, 1993 insertions(+), 190 deletions(-)



----------------------------------------------------------------------

Comment By: Nobody/Anonymous (nobody)
Date: 2011-04-07 17:36

Message:
YfrcWR  <a href="http://yylwzcqwnqih.com/">yylwzcqwnqih</a>,
[url=http://plqtpudqvvmo.com/]plqtpudqvvmo[/url],
[link=http://brurvyewbnqf.com/]brurvyewbnqf[/link],
http://uxuavwhtluzn.com/

----------------------------------------------------------------------

Comment By: Subrata Modak (subrata_modak)
Date: 2008-04-20 19:21

Message:
Logged In: YES 
user_id=1737361
Originator: NO

Thanks. This has been released now.

Regards--
Subrata

----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=303382&aid=1942286&group_id=3382

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
