Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SMGYv-0005Os-Dj
	for ltp-list@lists.sourceforge.net; Mon, 23 Apr 2012 10:32:05 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SMGYr-00084P-3D
	for ltp-list@lists.sourceforge.net; Mon, 23 Apr 2012 10:32:05 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q3NAVtMs003075
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 23 Apr 2012 06:31:55 -0400
Message-ID: <4F952F99.4010407@redhat.com>
Date: Mon, 23 Apr 2012 12:31:53 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 0/3] add CMA test
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
Cc: Jeffrey Burke <jburke@redhat.com>

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
  configure: check if process_vm_read/write is supported
  add testcases/kernel/syscalls/cma
  syscalls/cma: add errno tests

 configure.ac                                       |    1 +
 m4/ltp-cma.m4                                      |   67 +++
 testcases/kernel/syscalls/cma/Makefile             |   22 +
 testcases/kernel/syscalls/cma/cma01.c              |  434 ++++++++++++++++++++
 .../kernel/syscalls/cma/process_vm_readv/Makefile  |   29 ++
 .../kernel/syscalls/cma/process_vm_writev/Makefile |   29 ++
 6 files changed, 582 insertions(+)
 create mode 100644 m4/ltp-cma.m4
 create mode 100644 testcases/kernel/syscalls/cma/Makefile
 create mode 100644 testcases/kernel/syscalls/cma/cma01.c
 create mode 100644 testcases/kernel/syscalls/cma/process_vm_readv/Makefile
 create mode 100644 testcases/kernel/syscalls/cma/process_vm_writev/Makefile

-- 1.7.9.3 

------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
