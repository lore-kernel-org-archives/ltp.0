Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1URcTm-0000CE-Q1
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 06:01:26 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1URcTl-00010P-Iu
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 06:01:26 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r3F61JvL004319
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Apr 2013 02:01:19 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Mon, 15 Apr 2013 13:59:02 +0800
Message-Id: <cover.1366005109.git.zliu@redhat.com>
Subject: [LTP] [PATCH v3 0/3] mm/thp: add two new case
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

V2 to V3:
added some comments for low memory system.

Wanlong, I included you into 'Tested-by' thread, thanks for
your reviewing and testing the patchset.

Zhouping Liu (3):
  mm/thp: new case thp04.c
  lib/mem: introduce a new function set_global_mempolicy()
  mm/thp: add new case thp05

 runtest/mm                         |   6 ++
 testcases/kernel/mem/include/mem.h |  12 +++
 testcases/kernel/mem/lib/mem.c     | 203 ++++++++++++++++++++++++++++++++++++-
 testcases/kernel/mem/thp/thp04.c   | 136 +++++++++++++++++++++++++
 testcases/kernel/mem/thp/thp05.c   | 152 +++++++++++++++++++++++++++
 5 files changed, 508 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/mem/thp/thp04.c
 create mode 100644 testcases/kernel/mem/thp/thp05.c

-- 
1.7.11.7


------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
