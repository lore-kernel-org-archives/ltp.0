Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1U33b2-0006Ir-Fz
	for ltp-list@lists.sourceforge.net; Wed, 06 Feb 2013 11:55:24 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1U33b0-0004ZJ-LF
	for ltp-list@lists.sourceforge.net; Wed, 06 Feb 2013 11:55:24 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r16BtGnn001053
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Feb 2013 06:55:16 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Wed,  6 Feb 2013 12:55:09 +0100
Message-Id: <cover.1360149841.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v2 0/3] add new syscall test for setns(2)
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

Changes in v2:
- fixed setns01 to work with commit 142e1d1d5f088e7a38659daca6e84a730967774a
- revamped setns01 to use namespace any fd/types available,
  at the moment any from: ipc, mnt, net, pid, uts
- setns01 now runs each test for each namespace type
- fixed typo errors in setns02
- tested with 3.7 and 3.8.0-rc6

Sample output from 3.8.0-rc6+:
setns01     0  TINFO  :  ns_fds[0]=3, ns_types[0]=0x8000000
setns01     0  TINFO  :  ns_fds[1]=4, ns_types[1]=0x20000
setns01     0  TINFO  :  ns_fds[2]=5, ns_types[2]=0x40000000
setns01     0  TINFO  :  ns_fds[3]=6, ns_types[3]=0x20000000
setns01     0  TINFO  :  ns_fds[4]=7, ns_types[4]=0x4000000
setns01     0  TINFO  :  setns(-1, 0x8000000)
setns01     1  TPASS  :  invalid fd exp_errno=9
setns01     0  TINFO  :  setns(-1, 0x20000)
setns01     2  TPASS  :  invalid fd exp_errno=9
setns01     0  TINFO  :  setns(-1, 0x40000000)
setns01     3  TPASS  :  invalid fd exp_errno=9
setns01     0  TINFO  :  setns(-1, 0x20000000)
setns01     4  TPASS  :  invalid fd exp_errno=9
setns01     0  TINFO  :  setns(-1, 0x4000000)
setns01     5  TPASS  :  invalid fd exp_errno=9
setns01     0  TINFO  :  setns(8, 0x8000000)
setns01     6  TPASS  :  regular file fd exp_errno=22
setns01     0  TINFO  :  setns(8, 0x20000)
setns01     7  TPASS  :  regular file fd exp_errno=22
setns01     0  TINFO  :  setns(8, 0x40000000)
setns01     8  TPASS  :  regular file fd exp_errno=22
setns01     0  TINFO  :  setns(8, 0x20000000)
setns01     9  TPASS  :  regular file fd exp_errno=22
setns01     0  TINFO  :  setns(8, 0x4000000)
setns01    10  TPASS  :  regular file fd exp_errno=22
setns01     0  TINFO  :  setns(3, 0xffffffff)
setns01    11  TPASS  :  invalid ns_type exp_errno=22
setns01     0  TINFO  :  setns(4, 0xffffffff)
setns01    12  TPASS  :  invalid ns_type exp_errno=22
setns01     0  TINFO  :  setns(5, 0xffffffff)
setns01    13  TPASS  :  invalid ns_type exp_errno=22
setns01     0  TINFO  :  setns(6, 0xffffffff)
setns01    14  TPASS  :  invalid ns_type exp_errno=22
setns01     0  TINFO  :  setns(7, 0xffffffff)
setns01    15  TPASS  :  invalid ns_type exp_errno=22
setns01     0  TINFO  :  setns(3, 0x20000)
setns01    16  TPASS  :  mismatch ns_type/fd exp_errno=22
setns01     0  TINFO  :  setns(4, 0x40000000)
setns01    17  TPASS  :  mismatch ns_type/fd exp_errno=22
setns01     0  TINFO  :  setns(5, 0x20000000)
setns01    18  TPASS  :  mismatch ns_type/fd exp_errno=22
setns01     0  TINFO  :  setns(6, 0x4000000)
setns01    19  TPASS  :  mismatch ns_type/fd exp_errno=22
setns01     0  TINFO  :  setns(7, 0x8000000)
setns01    20  TPASS  :  mismatch ns_type/fd exp_errno=22
setns01     0  TINFO  :  setns(3, 0x8000000)
setns01    21  TPASS  :  without CAP_SYS_ADMIN exp_errno=1
setns01     0  TINFO  :  setns(4, 0x20000)
setns01    22  TPASS  :  without CAP_SYS_ADMIN exp_errno=1
setns01     0  TINFO  :  setns(5, 0x40000000)
setns01    23  TPASS  :  without CAP_SYS_ADMIN exp_errno=1
setns01     0  TINFO  :  setns(6, 0x20000000)
setns01    24  TPASS  :  without CAP_SYS_ADMIN exp_errno=1
setns01     0  TINFO  :  setns(7, 0x4000000)
setns01    25  TPASS  :  without CAP_SYS_ADMIN exp_errno=1

setns02     0  TINFO  :  test_newuts
setns02     0  TINFO  :  creating child with clone_flag=0x4000000, ns_flag=0x4000000
setns02     0  TINFO  :  (child) hostname (inherited from parent): dell-pe1950-05.lab.bos.redhat.com
setns02     0  TINFO  :  (child) hostname changed to: setns_dummy_uts
setns02     1  TPASS  :  (child) hostname is different in parent/child
setns02     0  TINFO  :  (child) attempting to switch ns back to parent ns
setns02     0  TINFO  :  (child) hostname: dell-pe1950-05.lab.bos.redhat.com
setns02     2  TPASS  :  (child) hostname now as expected
setns02     1  TPASS  :  child finished succesfully
setns02     0  TINFO  :  creating child with clone_flag=0x4000000, ns_flag=0x0
setns02     0  TINFO  :  (child) hostname (inherited from parent): dell-pe1950-05.lab.bos.redhat.com
setns02     0  TINFO  :  (child) hostname changed to: setns_dummy_uts
setns02     2  TPASS  :  (child) hostname is different in parent/child
setns02     0  TINFO  :  (child) attempting to switch ns back to parent ns
setns02     0  TINFO  :  (child) hostname: dell-pe1950-05.lab.bos.redhat.com
setns02     3  TPASS  :  (child) hostname now as expected
setns02     2  TPASS  :  child finished succesfully
setns02     0  TINFO  :  test_newipc
setns02     0  TINFO  :  creating child with clone_flag=0x8000000, ns_flag=0x8000000
setns02     3  TPASS  :  (child) shmat failed as expected: errno=EINVAL(22): Invalid argument
setns02     0  TINFO  :  (child) attempting to switch ns back to parent ns
setns02     4  TPASS  :  (child) shmat suceeded
setns02     3  TPASS  :  child finished succesfully
setns02     0  TINFO  :  creating child with clone_flag=0x8000000, ns_flag=0x0
setns02     4  TPASS  :  (child) shmat failed as expected: errno=EINVAL(22): Invalid argument
setns02     0  TINFO  :  (child) attempting to switch ns back to parent ns
setns02     5  TPASS  :  (child) shmat suceeded
setns02     4  TPASS  :  child finished succesfully

Jan Stancek (3):
  setns: setup directory at kernel/syscalls/setns
  setns: add new syscall test setns01
  setns: add new syscall test setns02

 runtest/syscalls                          |    3 +
 testcases/kernel/syscalls/.gitignore      |    2 +
 testcases/kernel/syscalls/setns/Makefile  |   23 +++
 testcases/kernel/syscalls/setns/setns.h   |   89 +++++++++++
 testcases/kernel/syscalls/setns/setns01.c |  240 +++++++++++++++++++++++++++++
 testcases/kernel/syscalls/setns/setns02.c |  231 +++++++++++++++++++++++++++
 6 files changed, 588 insertions(+), 0 deletions(-)
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
