Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S7JoI-0007lP-Rl
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:10 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S7JoI-0008Uq-05
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:10 +0000
Received: by dado14 with SMTP id o14so271895dad.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Mar 2012 21:58:04 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Tue, 13 Mar 2012 12:56:34 +0800
Message-Id: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH 00/11] hugetlb multiple fixes
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
--------------1.7.8.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This patchset makes the following changes:

01 - 08: set and restore nr_hugepages values automatically in 
         hugeshm* tests.

09,11  : code cleanups, remove unused files and functions

10     : fix a hugeshmget03 bug.

patchset has been tested on my system, both with large free memory 
and tight memory environment.

Caspar Zhang (11):
  hugetlb/hugeshmat: cleanup codes
  hugetlb/hugeshmat: set nr_hugepages in tests
  hugetlb/hugeshmctl: cleanup codes
  hugetlb/hugeshmctl: set nr_hugepages in tests
  hugetlb/hugeshmdt: cleanup codes
  hugetlb/hugeshmdt: set nr_hugepages in tests
  hugetlb/hugeshmget: cleanup codes
  hugetlb/hugeshmget: set nr_hugepages in tests
  hugetlb/lib: cleanup codes
  hugetlb/hugeshmget03: fix broken testcase
  libltp: remove system_specific_hugepages_info

 include/system_specific_hugepages_info.h           |   30 --
 lib/system_specific_hugepages_info.c               |   93 ------
 testcases/kernel/mem/hugetlb/Makefile.inc          |   16 +-
 testcases/kernel/mem/hugetlb/hugemmap/Makefile     |    1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |   19 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |    5 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c |    1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |   24 +-
 testcases/kernel/mem/hugetlb/hugeshmat/Makefile    |    2 +-
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat01.c     |  173 ++++-------
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat02.c     |  167 ++++-------
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat03.c     |  171 ++++-------
 testcases/kernel/mem/hugetlb/hugeshmctl/Makefile   |    2 +-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   |  327 ++++++++------------
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c   |  150 ++++------
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c   |  192 +++++-------
 testcases/kernel/mem/hugetlb/hugeshmdt/Makefile    |    2 +-
 .../kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c     |  169 ++++------
 testcases/kernel/mem/hugetlb/hugeshmget/Makefile   |    2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget01.c   |  124 +++-----
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c   |  164 ++++------
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c   |  160 ++++------
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget05.c   |  165 ++++-------
 testcases/kernel/mem/hugetlb/lib/ipcmsg.h          |   58 ----
 testcases/kernel/mem/hugetlb/lib/ipcsem.h          |   60 ----
 testcases/kernel/mem/hugetlb/lib/ipcshm.h          |   33 ++-
 testcases/kernel/mem/hugetlb/lib/libipc.c          |  143 ++-------
 27 files changed, 823 insertions(+), 1630 deletions(-)
 delete mode 100644 include/system_specific_hugepages_info.h
 delete mode 100644 lib/system_specific_hugepages_info.c
 delete mode 100644 testcases/kernel/mem/hugetlb/lib/ipcmsg.h
 delete mode 100644 testcases/kernel/mem/hugetlb/lib/ipcsem.h

-- 
1.7.8.4



--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.4--
