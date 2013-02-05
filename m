Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1U2ku7-00059S-Op
	for ltp-list@lists.sourceforge.net; Tue, 05 Feb 2013 15:57:51 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1U2ku6-0002HK-8U
	for ltp-list@lists.sourceforge.net; Tue, 05 Feb 2013 15:57:51 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r15FviBS002353
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Feb 2013 10:57:44 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  5 Feb 2013 16:57:28 +0100
Message-Id: <cover.1360079418.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 0/3] add new syscall test for setns(2)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This patchset adds 2 new syscall tests for setns(2).
Sample output:

setns01     1  TPASS  :  invalid fd exp_errno=9
setns01     2  TPASS  :  regular file fd exp_errno=22
setns01     3  TPASS  :  invalid ns_type exp_errno=22
setns01     4  TPASS  :  mismatch ns_type/fd exp_errno=22
setns01     5  TPASS  :  without CAP_SYS_ADMIN exp_errno=1

setns02     0  TINFO  :  test_newuts
setns02     0  TINFO  :  creating child with clone_flag=0x4000000, ns_flag=0x4000000
setns02     0  TINFO  :  (child) hostnane (inherited from parent): dhcp-27-145.brq.redhat.com
setns02     0  TINFO  :  (child) hostname changed to: setns_dummy_uts
setns02     1  TPASS  :  (child) hostname is different in parent/child
setns02     0  TINFO  :  (child) attemping to switch ns back to parent ns
setns02     0  TINFO  :  (child) hostname: dhcp-27-145.brq.redhat.com
setns02     2  TPASS  :  (child) hostname now as expected
setns02     1  TPASS  :  child finished succesfully
setns02     0  TINFO  :  creating child with clone_flag=0x4000000, ns_flag=0x0
setns02     0  TINFO  :  (child) hostnane (inherited from parent): dhcp-27-145.brq.redhat.com
setns02     0  TINFO  :  (child) hostname changed to: setns_dummy_uts
setns02     2  TPASS  :  (child) hostname is different in parent/child
setns02     0  TINFO  :  (child) attemping to switch ns back to parent ns
setns02     0  TINFO  :  (child) hostname: dhcp-27-145.brq.redhat.com
setns02     3  TPASS  :  (child) hostname now as expected
setns02     2  TPASS  :  child finished succesfully
setns02     0  TINFO  :  test_newipc
setns02     0  TINFO  :  creating child with clone_flag=0x8000000, ns_flag=0x8000000
setns02     3  TPASS  :  (child) shmat failed as expected: errno=EINVAL(22): Invalid argument
setns02     0  TINFO  :  (child) attemping to switch ns back to parent ns
setns02     4  TPASS  :  (child) shmat suceeded
setns02     3  TPASS  :  child finished succesfully
setns02     0  TINFO  :  creating child with clone_flag=0x8000000, ns_flag=0x0
setns02     4  TPASS  :  (child) shmat failed as expected: errno=EINVAL(22): Invalid argument
setns02     0  TINFO  :  (child) attemping to switch ns back to parent ns
setns02     5  TPASS  :  (child) shmat suceeded
setns02     4  TPASS  :  child finished succesfully

Jan Stancek (3):
  setns: setup directory at kernel/syscalls/setns
  setns: add new syscall test setns01
  setns: add new syscall test setns02

 runtest/syscalls                          |    3 +
 testcases/kernel/syscalls/.gitignore      |    2 +
 testcases/kernel/syscalls/setns/Makefile  |   22 +++
 testcases/kernel/syscalls/setns/setns.h   |   41 +++++
 testcases/kernel/syscalls/setns/setns01.c |  245 +++++++++++++++++++++++++++++
 testcases/kernel/syscalls/setns/setns02.c |  231 +++++++++++++++++++++++++++
 6 files changed, 544 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/setns/Makefile
 create mode 100644 testcases/kernel/syscalls/setns/setns.h
 create mode 100644 testcases/kernel/syscalls/setns/setns01.c
 create mode 100644 testcases/kernel/syscalls/setns/setns02.c


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
