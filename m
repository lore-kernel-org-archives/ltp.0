Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <asavkov@redhat.com>) id 1XHaj9-0004yK-73
	for ltp-list@lists.sourceforge.net; Wed, 13 Aug 2014 15:44:39 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XHaj7-0002Kx-1j
	for ltp-list@lists.sourceforge.net; Wed, 13 Aug 2014 15:44:39 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7DFiTpq030689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Aug 2014 11:44:30 -0400
From: Artem Savkov <asavkov@redhat.com>
Date: Wed, 13 Aug 2014 17:44:20 +0200
Message-Id: <1407944666-32659-1-git-send-email-asavkov@redhat.com>
Subject: [LTP] [PATCH v2 0/6] testcases/kernel/containers cleanup
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
Cc: Artem Savkov <asavkov@redhat.com>

Container tests are currently clumped together in a single script, this
patchset separates them so that they are listed one by on in runtest/containers

v2 set contains a bunch of changes for better compliance with LTP codestyle and
an additional patch doing the same for old code in netns testcases.

Artem Savkov (6):
  mqns tests: runmqnsstest.sh -> runtest/containers
  netns tests: runnetnstest.sh -> runtest/containers
  ipcns tests: runipcnstest.sh -> runtest/containers
  uts tests: runutstest.sh -> runtest/containers
  check_for_unshare test removed from containers tests
  kernel/containers/netns cleanup

 runtest/containers                                 |  42 ++++++-
 testcases/kernel/containers/check_for_unshare.c    |  57 ---------
 testcases/kernel/containers/container_test.sh      |  64 ----------
 .../kernel/containers/mqns/check_mqns_enabled.c    |  57 ---------
 testcases/kernel/containers/mqns/mqns_01.c         |  11 ++
 testcases/kernel/containers/mqns/mqns_02.c         |  11 ++
 testcases/kernel/containers/mqns/mqns_03.c         |  11 ++
 testcases/kernel/containers/mqns/mqns_04.c         |  11 ++
 testcases/kernel/containers/mqns/mqns_helper.h     |  55 +++++++++
 testcases/kernel/containers/mqns/runmqnstest.sh    |  40 -------
 testcases/kernel/containers/netns/Makefile         |   4 +-
 .../kernel/containers/netns/check_netns_enabled.c  |  56 ---------
 testcases/kernel/containers/netns/childns.sh       |   2 +
 testcases/kernel/containers/netns/common.c         |  49 ++------
 testcases/kernel/containers/netns/crtchild.c       |  16 ++-
 .../kernel/containers/netns/crtchild_delchild.c    |  15 ++-
 testcases/kernel/containers/netns/initialize.sh    |   7 +-
 testcases/kernel/containers/netns/netns_helper.h   |  72 +++++++++++
 testcases/kernel/containers/netns/par_chld_ftp.c   |  17 ++-
 testcases/kernel/containers/netns/par_chld_ftp.sh  |  54 +++++++++
 testcases/kernel/containers/netns/par_chld_ipv6.c  |  52 ++++----
 testcases/kernel/containers/netns/runnetnstest.sh  | 133 ---------------------
 .../kernel/containers/netns/two_children_ns.c      |  56 ++++-----
 .../containers/sysvipc/check_ipcns_enabled.c       |  42 -------
 testcases/kernel/containers/sysvipc/ipcns_helper.h |  41 +++++++
 testcases/kernel/containers/sysvipc/mesgq_nstest.c |  13 +-
 .../kernel/containers/sysvipc/runipcnstest.sh      |  62 ----------
 testcases/kernel/containers/sysvipc/sem_nstest.c   |  11 ++
 testcases/kernel/containers/sysvipc/semtest_2ns.c  |  13 ++
 .../kernel/containers/sysvipc/shmem_2nstest.c      |  15 +++
 testcases/kernel/containers/sysvipc/shmnstest.c    |  11 ++
 testcases/kernel/containers/utsname/README         |  53 --------
 .../containers/utsname/check_utsns_enabled.c       |  50 --------
 testcases/kernel/containers/utsname/runutstest.sh  |  33 -----
 testcases/kernel/containers/utsname/utstest.c      |  51 ++++++--
 35 files changed, 522 insertions(+), 765 deletions(-)
 delete mode 100644 testcases/kernel/containers/check_for_unshare.c
 delete mode 100755 testcases/kernel/containers/container_test.sh
 delete mode 100644 testcases/kernel/containers/mqns/check_mqns_enabled.c
 create mode 100644 testcases/kernel/containers/mqns/mqns_helper.h
 delete mode 100755 testcases/kernel/containers/mqns/runmqnstest.sh
 delete mode 100644 testcases/kernel/containers/netns/check_netns_enabled.c
 create mode 100644 testcases/kernel/containers/netns/netns_helper.h
 create mode 100755 testcases/kernel/containers/netns/par_chld_ftp.sh
 delete mode 100755 testcases/kernel/containers/netns/runnetnstest.sh
 delete mode 100644 testcases/kernel/containers/sysvipc/check_ipcns_enabled.c
 create mode 100644 testcases/kernel/containers/sysvipc/ipcns_helper.h
 delete mode 100644 testcases/kernel/containers/sysvipc/runipcnstest.sh
 delete mode 100644 testcases/kernel/containers/utsname/README
 delete mode 100644 testcases/kernel/containers/utsname/check_utsns_enabled.c
 delete mode 100755 testcases/kernel/containers/utsname/runutstest.sh

-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
