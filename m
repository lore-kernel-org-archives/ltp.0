From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 23 Jun 2017 14:22:02 +0200
Subject: [LTP] [PATCH v3 0/9] CVE Tests
Message-ID: <20170623122211.29575-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Version 3:
* Move .gitignore and runtest additions to correct commits
* Replace tst_fzsync_init() with static declaration
* Remove packet time stamping test cve-2017-7277
* Remove explicit tid struct members
* Use new SAFE_SHM* macros
* Add Xiao Yang/Fujitsu to copyright notice for CVE-2017-5669

Version 2:
* Remove unresolved merge conflict from two commits
* Use _GNU_SOURCE instead of __USE_GNU

Richard Palethorpe (9):
  Add fuzzy synchronisation library for triggering races
  Test for vulnerability CVE-2016-7117 in recvmmsg error return path
  Test for CVE-2016-4997 on setsockopt
  Test for uname26 exploit CVE-2012-0957
  Add CVE .gitignore, Makefile and runtest files
  Test for CVE-2014-0196 PTY echo race
  Test for CVE-2017-5669 in shmat
  Test for CVE-2017-6951 in request_key
  Test for CVE-2017-2671 on ping sockets

 configure.ac                  |   2 +
 include/tst_fuzzy_sync.h      | 184 ++++++++++++++++++++++++++++++++++++++++++
 m4/ltp-mmsghdr.m4             |  22 +++++
 m4/ltp-uname.m4               |  20 +++++
 runtest/cve                   |   9 +++
 runtest/syscalls              |   4 +
 scenario_groups/default       |   1 +
 testcases/cve/.gitignore      |   7 ++
 testcases/cve/Makefile        |  26 ++++++
 testcases/cve/cve-2012-0957.c |  89 ++++++++++++++++++++
 testcases/cve/cve-2014-0196.c | 161 ++++++++++++++++++++++++++++++++++++
 testcases/cve/cve-2016-4997.c |  92 +++++++++++++++++++++
 testcases/cve/cve-2016-7117.c | 158 ++++++++++++++++++++++++++++++++++++
 testcases/cve/cve-2017-2671.c | 120 +++++++++++++++++++++++++++
 testcases/cve/cve-2017-5669.c |  88 ++++++++++++++++++++
 testcases/cve/cve-2017-6951.c |  46 +++++++++++
 16 files changed, 1029 insertions(+)
 create mode 100644 include/tst_fuzzy_sync.h
 create mode 100644 m4/ltp-mmsghdr.m4
 create mode 100644 m4/ltp-uname.m4
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

-- 
2.12.2

