Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TRk0d-0003Dd-LP
	for ltp-list@lists.sourceforge.net; Fri, 26 Oct 2012 13:31:35 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TRk0Z-0002FA-Ts
	for ltp-list@lists.sourceforge.net; Fri, 26 Oct 2012 13:31:35 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9QDVPqX017912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Oct 2012 09:31:26 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id q9QDVOfL016952
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Oct 2012 09:31:25 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 26 Oct 2012 15:31:14 +0200
Message-Id: <cover.1351256774.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v3 0/3] new syscall tests for migrate_pages
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

Changes in v3:
- changed "expected ret success -" to "expected ret success:"
- add comment about "minimum free mem on node"
- check that "minimum free mem on node" can be allocated with numa_alloc_onnode()
- add comment about Bug 870326 - migrate_pages() reports success, but pages are not moved to desired node
  Larry Woodman is looking into it, this testcase should not hit it with check above
- change 'pid' parameter from int to pid_t in migrate_to_node()
- if migrate_pages() fails, print:
  1. /proc/$pid/status
  2. free space on node where it failed to migrate to
- small style cleanups
- add new syscall binaries to ../.gitignore

Jan Stancek (3):
  numa_helper: export get_max_node()
  new syscall test: migrate_pages01
  new syscall test: migrate_pages02

 runtest/syscalls                                   |    3 +
 testcases/kernel/include/numa_helper.h             |    1 +
 testcases/kernel/lib/numa_helper.c                 |    6 +-
 testcases/kernel/syscalls/.gitignore               |    2 +
 testcases/kernel/syscalls/migrate_pages/Makefile   |   32 ++
 .../syscalls/migrate_pages/migrate_pages01.c       |  280 +++++++++++++
 .../syscalls/migrate_pages/migrate_pages02.c       |  419 ++++++++++++++++++++
 .../syscalls/migrate_pages/migrate_pages_common.c  |   62 +++
 .../syscalls/migrate_pages/migrate_pages_common.h  |   33 ++
 9 files changed, 836 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/migrate_pages/Makefile
 create mode 100644 testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
 create mode 100644 testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
 create mode 100644 testcases/kernel/syscalls/migrate_pages/migrate_pages_common.c
 create mode 100644 testcases/kernel/syscalls/migrate_pages/migrate_pages_common.h


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
