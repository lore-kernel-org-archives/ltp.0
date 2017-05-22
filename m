From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 22 May 2017 14:13:31 +0200
Subject: [LTP] [PATCH v2 00/10] CVE Tests
Message-ID: <20170522121341.4663-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Version 2:
* Remove unresolved merge conflict from two commits
* Use _GNU_SOURCE instead of __USE_GNU

P.s. Sorry for spamming the mailing list.

Richard Palethorpe (10):
  Add fuzzy synchronisation library for triggering races
  Test for vulnerability CVE-2016-7117 in recvmmsg error return path
  Test for CVE-2016-4997 on setsockopt
  Test for uname26 exploit CVE-2012-0957
  Add CVE .gitignore, Makefile and runtest files
  Test for CVE-2014-0196 PTY echo race
  Test for CVE-2017-5669 in shmat
  Test for CVE-2017-6951 in request_key
  Test for CVE-2017-7277 SOF_TIMESTAMPING_OPT_STATS
  Test for CVE-2017-2671 on ping sockets

 configure.ac                  |   1 +
 include/tst_fuzzy_sync.h      | 189 ++++++++++++++++++
 m4/ltp-mmsghdr.m4             |  22 +++
 runtest/cve                   |  10 +
 runtest/syscalls              |   4 +
 scenario_groups/default       |   1 +
 testcases/cve/.gitignore      |   8 +
 testcases/cve/Makefile        |  26 +++
 testcases/cve/cve-2012-0957.c |  90 +++++++++
 testcases/cve/cve-2014-0196.c | 163 +++++++++++++++
 testcases/cve/cve-2016-4997.c |  93 +++++++++
 testcases/cve/cve-2016-7117.c | 165 ++++++++++++++++
 testcases/cve/cve-2017-2671.c | 123 ++++++++++++
 testcases/cve/cve-2017-5669.c |  90 +++++++++
 testcases/cve/cve-2017-6951.c |  47 +++++
 testcases/cve/cve-2017-7277.c | 449 ++++++++++++++++++++++++++++++++++++++++++
 16 files changed, 1481 insertions(+)
 create mode 100644 include/tst_fuzzy_sync.h
 create mode 100644 m4/ltp-mmsghdr.m4
 create mode 100644 runtest/cve
 create mode 100644 testcases/cve/.gitignore
 create mode 100644 testcases/cve/Makefile
 create mode 100644 testcases/cve/cve-2012-0957.c
 create mode 100644 testcases/cve/cve-2014-0196.c
 create mode 100644 testcases/cve/cve-2016-4997.c
 create mode 100644 testcases/cve/cve-2016-7117.c
 create mode 100644 testcases/cve/cve-2017-2671.c
 create mode 100644 testcases/cve/cve-2017-5669.c
 create mode 100644 testcases/cve/cve-2017-6951.c
 create mode 100644 testcases/cve/cve-2017-7277.c

-- 
2.12.2

