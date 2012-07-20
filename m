Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SsAJI-0006YW-Ae
	for ltp-list@lists.sourceforge.net; Fri, 20 Jul 2012 10:19:48 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SsAJC-0001Y2-Or
	for ltp-list@lists.sourceforge.net; Fri, 20 Jul 2012 10:19:48 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q6KAJaC5020610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 20 Jul 2012 06:19:36 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id q6KAJZ06009330
	for <ltp-list@lists.sourceforge.net>; Fri, 20 Jul 2012 06:19:36 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 20 Jul 2012 12:19:30 +0200
Message-Id: <cover.1342777340.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH 0/2] numa_helper: get nodes with mem/cpu/both
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit

numa_helper has been used for syscalls testcases, which
care about nodes with memory. Based on discussion here:
http://article.gmane.org/gmane.linux.ltp/16325
it was deemed, that 'flag' extension would be useful,
to allow tests to ask for nodes with memory/cpu/both.

This patch series is introducing flag to get_allowed_nodes().

For example, a config like this one:
  # numactl -H
  available: 3 nodes (2,4-5)
  node 2 cpus: 0
  node 2 size: 511 MB
  node 2 free: 88 MB
  node 4 cpus:
  node 4 size: 256 MB
  node 4 free: 34 MB
  node 5 cpus:
  node 5 size: 255 MB
  node 5 free: 59 MB

would return:
  nodes (flag=0): 2 4 5 (any)
  nodes (flag=1): 2 4 5 (mem)
  nodes (flag=2): 2     (cpus)
  nodes (flag=3): 2     (mem and cpus)

Tested with:
numactl-devel-0.9.8-7.el5
numactl-devel-2.0.3-9.el6
numactl-devel-2.0.7-6.el7

numa_node_to_cpus() is broken in older libnuma < 1, so cpumap
is used instead.

Next step (not part of this series) is to move it outside
syscalls area, so it can be used by other testcases.

Jan Stancek (2):
  numa_helper: add flag to get_allowed_nodes()
  update testcases to use flag for get_allowed_nodes()

 .../syscalls/get_mempolicy/get_mempolicy01.c       |    5 +-
 testcases/kernel/syscalls/mbind/mbind01.c          |    5 +-
 .../kernel/syscalls/move_pages/move_pages02.c      |    5 +-
 .../kernel/syscalls/move_pages/move_pages03.c      |    5 +-
 .../kernel/syscalls/move_pages/move_pages04.c      |    5 +-
 .../kernel/syscalls/move_pages/move_pages05.c      |    5 +-
 .../kernel/syscalls/move_pages/move_pages06.c      |    5 +-
 .../kernel/syscalls/move_pages/move_pages07.c      |    5 +-
 .../kernel/syscalls/move_pages/move_pages08.c      |    5 +-
 .../kernel/syscalls/move_pages/move_pages09.c      |    5 +-
 .../kernel/syscalls/move_pages/move_pages10.c      |    5 +-
 .../kernel/syscalls/move_pages/move_pages11.c      |    5 +-
 .../syscalls/move_pages/move_pages_support.c       |    8 +-
 testcases/kernel/syscalls/numa/lib/numa_helper.c   |  211 +++++++++++++++-----
 testcases/kernel/syscalls/numa/lib/numa_helper.h   |    8 +-
 15 files changed, 203 insertions(+), 84 deletions(-)

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--

