Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SzM2R-0000NX-PJ
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 06:16:07 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SzM2Q-0001QC-SC
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 06:16:07 +0000
Received: by pbcwy7 with SMTP id wy7so334108pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Aug 2012 23:16:00 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Thu,  9 Aug 2012 14:15:36 +0800
Message-Id: <cover.1344492473.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.6"
Subject: [LTP] [PATCH resend 0/6] NUMA and follow-up fix
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Resending the whole patch series (including Jan's 2 patches) for easier 
reviewing.

updates:
   syscalls/numa: check syscall availability
     remove TEST() macro and use syscall() directly.
   numa_helper: move to libkerntest
     merged the library cleaning fix to this one.
   mm: use new numa_helper
     the same as previous V3 version, which already has Jan's reivew.

Caspar Zhang (4):
  syscalls/numa: check syscall availability
  numa_helper: move to libkerntest
  mm: use new numa_helper
  mm: add common Makefile include: libmem.mk

Jan Stancek (2):
  numa_helper: add flag to get_allowed_nodes()
  update testcases to use flag for get_allowed_nodes()

 testcases/kernel/Makefile                          |    4 +
 testcases/kernel/include/lib.mk                    |   37 +++
 testcases/kernel/include/numa_helper.h             |   37 +++
 testcases/kernel/lib/Makefile                      |   29 +++
 testcases/kernel/lib/numa_helper.c                 |  266 ++++++++++++++++++++
 testcases/kernel/mem/cpuset/Makefile               |   22 +--
 testcases/kernel/mem/cpuset/cpuset01.c             |   16 +-
 testcases/kernel/mem/hugetlb/Makefile.inc          |   18 +-
 testcases/kernel/mem/hugetlb/hugemmap/Makefile     |   12 +-
 testcases/kernel/mem/include/libmem.mk             |   40 +++
 testcases/kernel/mem/include/mem.h                 |    2 +-
 testcases/kernel/mem/ksm/Makefile                  |   22 +--
 testcases/kernel/mem/ksm/ksm02.c                   |    9 +-
 testcases/kernel/mem/ksm/ksm04.c                   |    9 +-
 testcases/kernel/mem/lib/Makefile                  |    1 +
 testcases/kernel/mem/lib/mem.c                     |   50 +++--
 testcases/kernel/mem/oom/Makefile                  |   22 +--
 testcases/kernel/mem/oom/oom02.c                   |    4 -
 testcases/kernel/mem/oom/oom04.c                   |    4 -
 testcases/kernel/mem/swapping/Makefile             |   22 +--
 testcases/kernel/mem/thp/Makefile                  |   22 +--
 testcases/kernel/mem/tunable/Makefile              |   22 +--
 testcases/kernel/mem/vma/Makefile                  |    4 +-
 testcases/kernel/mem/vma/vma02.c                   |   19 +-
 testcases/kernel/mem/vma/vma04.c                   |   11 +-
 testcases/kernel/syscalls/get_mempolicy/Makefile   |    2 +-
 .../syscalls/get_mempolicy/get_mempolicy01.c       |   15 +-
 testcases/kernel/syscalls/mbind/Makefile           |    2 +-
 testcases/kernel/syscalls/mbind/mbind01.c          |   14 +-
 testcases/kernel/syscalls/move_pages/Makefile      |    2 +-
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
 testcases/kernel/syscalls/numa/Makefile            |   22 --
 testcases/kernel/syscalls/numa/Makefile.inc        |   27 --
 testcases/kernel/syscalls/numa/lib/Makefile        |   26 --
 testcases/kernel/syscalls/numa/lib/numa_helper.c   |  165 ------------
 testcases/kernel/syscalls/numa/lib/numa_helper.h   |   33 ---
 46 files changed, 562 insertions(+), 508 deletions(-)
 create mode 100644 testcases/kernel/include/lib.mk
 create mode 100644 testcases/kernel/include/numa_helper.h
 create mode 100644 testcases/kernel/lib/Makefile
 create mode 100644 testcases/kernel/lib/numa_helper.c
 create mode 100644 testcases/kernel/mem/include/libmem.mk
 delete mode 100644 testcases/kernel/syscalls/numa/Makefile
 delete mode 100644 testcases/kernel/syscalls/numa/Makefile.inc
 delete mode 100644 testcases/kernel/syscalls/numa/lib/Makefile
 delete mode 100644 testcases/kernel/syscalls/numa/lib/numa_helper.c
 delete mode 100644 testcases/kernel/syscalls/numa/lib/numa_helper.h

-- 
1.7.8.6



--------------1.7.8.6
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
--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.6--
