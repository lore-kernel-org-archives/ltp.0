Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Se5If-0005Lb-I2
	for ltp-list@lists.sourceforge.net; Mon, 11 Jun 2012 14:08:57 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Se5IZ-0002KF-NC
	for ltp-list@lists.sourceforge.net; Mon, 11 Jun 2012 14:08:57 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q5BE8jbg027714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jun 2012 10:08:45 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id q5BE8ism015080
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jun 2012 10:08:44 -0400
Message-ID: <4FD5FBEB.9030702@redhat.com>
Date: Mon, 11 Jun 2012 16:08:43 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 0/3] add CMA test
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

changes in v3:
- add forgotten void in the cma_test_errnos() parameters
- change branching based on program parameter
- make return right in place instead of setting ret variable
  and returning at the end of the function
- dont pass TEST_ERRNO, use TTERNNO in tst_*()
- no need to pass tst_exit as cleanup fn to SAFE_*() macros
- remove useless initialization of variables
- avoid indirection when copying parameters
- use /proc/sys/kernel/pid_max + 1 as invalid pid
- add missing munmap

changes in v2:
- dropped configure check as glibc wrapper calls syscall directly,
  and using syscall(2) we can test also when glibc wrappers are missing
- added simplified process_vm.h

CMA (cross memory attach) feature introduced 2 new syscalls:
process_vm_readv
process_vm_writev

commit fcf634098c00dd9cd247447368495f0b79be12d1
Author: Christopher Yeoh <cyeoh@au1.ibm.com>
Date: Mon Oct 31 17:06:39 2011 -0700
Cross Memory Attach

"The basic idea behind cross memory attach is to allow MPI programs doing
intra-node communication to do a single copy of the message rather than
a double copy of the message via shared memory." [1]

This patch series is introducing the initial structure under syscalls/cma
and first test to check various errno codes as described in proposed man
page [2].

[1] http://lwn.net/Articles/451188/
[2] http://ozlabs.org/~cyeoh/cma/process_vm_readv.txt


Jan Stancek (3):
  add testcases/kernel/syscalls/cma
  cma: add process_vm.h
  syscalls/cma: add errno tests

 runtest/syscalls                                   |    3 +
 testcases/kernel/syscalls/cma/Makefile             |   22 +
 testcases/kernel/syscalls/cma/process_vm.h         |   58 +++
 testcases/kernel/syscalls/cma/process_vm01.c       |  431 ++++++++++++++++++++
 .../kernel/syscalls/cma/process_vm_readv/Makefile  |   22 +
 .../kernel/syscalls/cma/process_vm_writev/Makefile |   22 +
 6 files changed, 558 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/cma/Makefile
 create mode 100644 testcases/kernel/syscalls/cma/process_vm.h
 create mode 100644 testcases/kernel/syscalls/cma/process_vm01.c
 create mode 100644 testcases/kernel/syscalls/cma/process_vm_readv/Makefile
 create mode 100644 testcases/kernel/syscalls/cma/process_vm_writev/Makefile

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
