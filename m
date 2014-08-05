Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <asavkov@redhat.com>) id 1XEgn4-0000V5-QC
	for ltp-list@lists.sourceforge.net; Tue, 05 Aug 2014 15:36:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XEgn2-0007ek-P3
	for ltp-list@lists.sourceforge.net; Tue, 05 Aug 2014 15:36:42 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s75FaXfG017007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Aug 2014 11:36:34 -0400
From: Artem Savkov <asavkov@redhat.com>
Date: Tue,  5 Aug 2014 17:36:17 +0200
Message-Id: <1407252982-27023-1-git-send-email-asavkov@redhat.com>
Subject: [LTP] [PATCH 0/5] testcases/kernel/containers cleanup
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

Artem Savkov (5):
  mqns tests: runmqnsstest.sh -> runtest/containers
  netns tests: runnetnstest.sh -> runtest/containers
  ipcns tests: runipcnstest.sh -> runtest/containers
  uts tests: runutstest.sh -> runtest/containers
  check_for_unshare test removed from containers tests

 runtest/containers                                 |  42 ++++++-
 testcases/kernel/containers/check_for_unshare.c    |  57 ---------
 testcases/kernel/containers/container_test.sh      |  64 ----------
 .../kernel/containers/mqns/check_mqns_enabled.c    |  57 ---------
 testcases/kernel/containers/mqns/mqns_01.c         |  11 ++
 testcases/kernel/containers/mqns/mqns_02.c         |  11 ++
 testcases/kernel/containers/mqns/mqns_03.c         |  11 ++
 testcases/kernel/containers/mqns/mqns_04.c         |  11 ++
 testcases/kernel/containers/mqns/mqns_helper.h     |  54 +++++++++
 testcases/kernel/containers/mqns/runmqnstest.sh    |  40 -------
 testcases/kernel/containers/netns/Makefile         |   4 +-
 testcases/kernel/containers/netns/check_iproute.sh |  52 ++++++++
 .../kernel/containers/netns/check_netns_enabled.c  |  56 ---------
 testcases/kernel/containers/netns/childns.sh       |   2 +
 testcases/kernel/containers/netns/crtchild.c       |  14 +++
 .../kernel/containers/netns/crtchild_delchild.c    |  13 ++
 testcases/kernel/containers/netns/initialize.sh    |   7 +-
 testcases/kernel/containers/netns/netns_helper.h   |  71 +++++++++++
 testcases/kernel/containers/netns/par_chld_ftp.c   |  15 +++
 testcases/kernel/containers/netns/par_chld_ftp.sh  |  52 ++++++++
 testcases/kernel/containers/netns/par_chld_ipv6.c  |  11 ++
 testcases/kernel/containers/netns/runnetnstest.sh  | 133 ---------------------
 .../kernel/containers/netns/two_children_ns.c      |  12 ++
 .../containers/sysvipc/check_ipcns_enabled.c       |  42 -------
 testcases/kernel/containers/sysvipc/ipcns_helper.h |  40 +++++++
 testcases/kernel/containers/sysvipc/mesgq_nstest.c |  13 +-
 .../kernel/containers/sysvipc/runipcnstest.sh      |  62 ----------
 testcases/kernel/containers/sysvipc/sem_nstest.c   |  11 ++
 testcases/kernel/containers/sysvipc/semtest_2ns.c  |  13 ++
 .../kernel/containers/sysvipc/shmem_2nstest.c      |  15 +++
 testcases/kernel/containers/sysvipc/shmnstest.c    |  11 ++
 testcases/kernel/containers/utsname/README         |  53 --------
 .../containers/utsname/check_utsns_enabled.c       |  50 --------
 testcases/kernel/containers/utsname/runutstest.sh  |  33 -----
 testcases/kernel/containers/utsname/utstest.c      |  49 ++++++--
 35 files changed, 527 insertions(+), 665 deletions(-)
 delete mode 100644 testcases/kernel/containers/check_for_unshare.c
 delete mode 100755 testcases/kernel/containers/container_test.sh
 delete mode 100644 testcases/kernel/containers/mqns/check_mqns_enabled.c
 create mode 100644 testcases/kernel/containers/mqns/mqns_helper.h
 delete mode 100755 testcases/kernel/containers/mqns/runmqnstest.sh
 create mode 100755 testcases/kernel/containers/netns/check_iproute.sh
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
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
