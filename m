Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TOpeU-000442-GW
	for ltp-list@lists.sourceforge.net; Thu, 18 Oct 2012 12:56:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TOpeQ-0002k1-Fu
	for ltp-list@lists.sourceforge.net; Thu, 18 Oct 2012 12:56:42 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9ICuW9j010180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Oct 2012 08:56:32 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id q9ICuVXZ003245
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Oct 2012 08:56:31 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 18 Oct 2012 14:56:21 +0200
Message-Id: <cover.1350564702.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v2 0/3] new syscall testcases: migrate_pages
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
- add parse_opts
- add new testcases to runtest/syscalls
- add parenthesis to else blocks where needed
- replace drop_caches with check for free memory

Jan Stancek (3):
  numa_helper: export get_max_node()
  new syscall test: migrate_pages01
  new syscall test: migrate_pages02

 runtest/syscalls                                   |    3 +
 testcases/kernel/include/numa_helper.h             |    1 +
 testcases/kernel/lib/numa_helper.c                 |    6 +-
 testcases/kernel/syscalls/migrate_pages/Makefile   |   32 ++
 .../syscalls/migrate_pages/migrate_pages01.c       |  280 +++++++++++++++
 .../syscalls/migrate_pages/migrate_pages02.c       |  363 ++++++++++++++++++++
 .../syscalls/migrate_pages/migrate_pages_common.c  |   62 ++++
 .../syscalls/migrate_pages/migrate_pages_common.h  |   33 ++
 8 files changed, 778 insertions(+), 2 deletions(-)
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
