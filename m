From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 21 May 2021 11:25:22 +0100
Subject: [LTP] [PATCH v2 0/6] cfs_bandwidth01 and CGroup API
Message-ID: <20210521102528.21102-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

This adds a test scheduler test which uses the cpu controller.

Also included are some additions and fixes to the CGroup API related
to the test.

V2:
* Simpler check for unrecognised controller name
* Dropped whitespace patch which was already merged
* Moved subgroup creation to setup. Otherwise it leaks memory between iterations.
  Although the test still worked because it doesn't error if the group already
  exists.

Richard Palethorpe (6):
  API/cgroups: Allow fetching of CGroup name
  API/cgroups: Remove obsolete function in API
  API/cgroups: Add cpu controller
  API/cgroups: Auto add controllers to subtree_control in new subgroup
  API/cgroups: tst_require fail gracefully with unknown controller
  sched/cgroup: Add cfs_bandwidth01

 include/tst_cgroup.h                          |   4 +
 lib/tst_cgroup.c                              |  58 ++++--
 runtest/sched                                 |   1 +
 .../kernel/sched/cfs-scheduler/.gitignore     |   1 +
 testcases/kernel/sched/cfs-scheduler/Makefile |   4 +-
 .../sched/cfs-scheduler/cfs_bandwidth01.c     | 175 ++++++++++++++++++
 6 files changed, 227 insertions(+), 16 deletions(-)
 create mode 100644 testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c

-- 
2.31.1

