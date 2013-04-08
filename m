Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UP87i-0006p8-51
	for ltp-list@lists.sourceforge.net; Mon, 08 Apr 2013 09:12:22 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UP87e-0008Tp-Oq
	for ltp-list@lists.sourceforge.net; Mon, 08 Apr 2013 09:12:22 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r389CChL022163
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Apr 2013 05:12:12 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Mon,  8 Apr 2013 17:10:06 +0800
Message-Id: <cover.1365411883.git.zliu@redhat.com>
Subject: [LTP] [PATCH v2 0/3] mm/thp: add two new case
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
To: LTP List <ltp-list@lists.sourceforge.net>

The patchset is desinged to test THP functionality.
    
when one process allocate hugepage aligned anonymouse pages,
kernel thread 'khugepaged' controlled by sysfs knobs
/sys/kernel/mm/transparent_hugepage/* will scan them, and make
them as transparent hugepage if they are suited, you can find out
how many transparent hugepages are there in one process from
/proc/<pid>/smaps, among the file contents, 'AnonHugePages' entry
stand for transparent hugepage.

V1 to V2:
accepted Wanlong's suggestion, added some comment for '10s'
added 'static' key word for single-file-only variant.

Zhouping Liu (3):
  mm/thp: new case thp04.c
  lib/mem: introduce a new function set_global_mempolicy()
  mm/thp: add new case thp05

 runtest/mm                         |   6 ++
 testcases/kernel/mem/include/mem.h |  12 +++
 testcases/kernel/mem/lib/mem.c     | 197 ++++++++++++++++++++++++++++++++++++-
 testcases/kernel/mem/thp/thp04.c   | 136 +++++++++++++++++++++++++
 testcases/kernel/mem/thp/thp05.c   | 152 ++++++++++++++++++++++++++++
 5 files changed, 502 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/mem/thp/thp04.c
 create mode 100644 testcases/kernel/mem/thp/thp05.c

-- 
1.7.11.7


------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
