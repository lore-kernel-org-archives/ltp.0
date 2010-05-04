Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1O9AOZ-0007zV-FM
	for ltp-list@lists.sourceforge.net; Tue, 04 May 2010 05:10:11 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9AOV-0006vr-5G
	for ltp-list@lists.sourceforge.net; Tue, 04 May 2010 05:10:11 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4453g4g009076
	for <ltp-list@lists.sourceforge.net>; Mon, 3 May 2010 23:03:42 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4459vuc148580
	for <ltp-list@lists.sourceforge.net>; Mon, 3 May 2010 23:09:57 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4459uG8013195
	for <ltp-list@lists.sourceforge.net>; Mon, 3 May 2010 23:09:57 -0600
Date: Tue, 4 May 2010 10:39:52 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100504050952.GA3685@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [ANNOUNCEMENT] LTP for APRIL 2010 has been released
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
Cc: CyrilHrubischrubis@suse.cz

Hi All,

Finally after rigorous testing and observing testing on multiple platform and
OS, April month LTP is out now. Good news is that we have also started executing
LTP testsuits on ChromeOS, which will definitely give a good coverage and fixes
of LTP and in future we can expect more and more inclusion.


You can download the tar ball from:
https://sourceforge.net/projects/ltp/files/LTP%20Source/ltp-20100430/ltp-full-20100430.tgz/download

Or you can directly clone git version as:
git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp

After merging to GIT tree we have worked mostly on build stability of LTP for
different architecture. And for that very close reviewed patches has been merged
this month's LTP.

You can find complete ChangeLog with $LTPROOT/ChangeLog as well as with this
mail footer for quick reference.

The latest version of the test-suite contains 3000+ tests for the Linux
OS and can be found at:
http://ltp.sourceforge.net/,
Latest happenings in LTP can also be found at:
http://ltp.sourceforge.net/wiki/,
http://ltp.sourceforge.net/wikiArchives.php

Major contributor:
    - Garret Cooper
    - Serge E Hallyn
    - Cyril Hrubis
    - Bryan Freed
    - Darren Hart

Notes from Maintainer:
=====================
I would like to thanks all the major contributor who is really motivating others
to include more and more patches to LTP and make LTP more better and stable
project.

Secondly in the following month now we need to work on testcase stability and i
request all the contributor to stretch your self as we are really seeing many of
the unstable/old testcases inside LTP. Please send your patch we will review
them closely and will test for any regression then we can merge/remove to LTP.

Here is the file changes:

Garrett Cooper (7):
Rishikesh K Rajak (30):


 ChangeLog                                          |  633 ++++++++++++++++++++
 doc/MaintNotes                                     |  107 ++++
 include/mk/man.mk                                  |    2 +
 result                                             |   96 +++
 runltp                                             |    2 +-
 testcases/commands/ade/ar/ar01                     |   12 +-
 testcases/commands/mail/mail_tests.sh              |    2 +-
 testcases/kernel/containers/mqns/mqns.h            |    2 +
 testcases/kernel/containers/mqns/mqns_01.c         |    8 +-
 testcases/kernel/containers/mqns/mqns_02.c         |   16 +-
 testcases/kernel/containers/mqns/mqns_03.c         |    2 +-
 testcases/kernel/containers/mqns/mqns_04.c         |    2 +-
 testcases/kernel/containers/netns/Makefile         |    2 +-
 testcases/kernel/containers/netns/common.c         |    4 +-
 testcases/kernel/containers/netns/par_chld_ipv6.c  |    6 +-
 testcases/kernel/containers/netns/sysfsview.c      |    2 +-
 .../kernel/containers/netns/two_children_ns.c      |    8 +-
 testcases/kernel/containers/pidns/pidns30.c        |    2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |    3 +-
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat01.c     |    2 +-
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat02.c     |    2 +-
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat03.c     |    2 +-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   |    2 +-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c   |    2 +-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c   |    2 +-
 .../kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c     |    2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget01.c   |    2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c   |    2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c   |    2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget05.c   |    2 +-
 .../security/cap_bound/cap_bset_inh_bounds.c       |    4 +-
 testcases/kernel/syscalls/eventfd/eventfd01.c      |    2 +-
 testcases/kernel/syscalls/ipc/msgctl/msgctl10.c    |    8 +-
 testcases/kernel/syscalls/linkat/linkat01.c        |    2 +-
 .../kernel/syscalls/utimensat/utimensat_tests.sh   |    2 +-
 .../conformance/definitions/aio_h/2-1.c            |    1 +
 .../conformance/definitions/errno_h/3-1.c          |    2 +-
 .../conformance/definitions/pthread_h/2-2.c        |    9 +
 .../conformance/interfaces/aio_cancel/3-1.c        |    2 +-
 .../conformance/interfaces/aio_cancel/4-1.c        |    1 -
 .../conformance/interfaces/aio_cancel/5-1.c        |    1 -
 .../conformance/interfaces/aio_cancel/6-1.c        |    1 -
 .../conformance/interfaces/aio_cancel/7-1.c        |    1 -
 .../conformance/interfaces/aio_error/2-1.c         |    1 -
 .../conformance/interfaces/sched_yield/1-1.c       |   14 +-
 testcases/realtime/func/prio-wake/prio-wake.c      |   11 +-
 testscripts/test_fs_bind.sh                        |    2 +-
 47 files changed, 917 insertions(+), 80 deletions(-)
 create mode 100644 doc/MaintNotes
 create mode 100644 result

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
