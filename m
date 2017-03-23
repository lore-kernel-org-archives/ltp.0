From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 23 Mar 2017 16:26:20 +0100
Subject: [LTP] [PATCH 0/4] CVE Exploit tests
Message-ID: <20170323162620.546e7a52@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

These are the first three exploit tests I have completed. I also have a
working, but messy, test for CVE-2014-0196 which will follow sometime soon,
hopefully along with a few others.

Richard Palethorpe (4):
  Test for vulnerability CVE-2016-7117 in recvmmsg error return path
  Test for CVE-2016-4997 on setsockopt
  Test for uname26 exploit CVE-2012-0957
  Add CVE .gitignore, Makefile and runtest files

 runtest/cve                   |   5 ++
 runtest/syscalls              |   2 +
 scenario_groups/default       |   1 +
 testcases/cve/.gitignore      |   3 +
 testcases/cve/Makefile        |  24 ++++++
 testcases/cve/cve-2012-0957.c |  90 ++++++++++++++++++++
 testcases/cve/cve-2016-4997.c |  87 +++++++++++++++++++
 testcases/cve/cve-2016-7117.c | 191 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 403 insertions(+)
 create mode 100644 runtest/cve
 create mode 100644 testcases/cve/.gitignore
 create mode 100644 testcases/cve/Makefile
 create mode 100644 testcases/cve/cve-2012-0957.c
 create mode 100644 testcases/cve/cve-2016-4997.c
 create mode 100644 testcases/cve/cve-2016-7117.c

-- 
2.12.0
