From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 13 May 2021 16:21:19 +0100
Subject: [LTP] [PATCH 0/6] cfs_bandwidth01 and CGroup API
Message-ID: <20210513152125.25766-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

This adds a test scheduler test which uses the cpu controller.

Also included are some additions and fixes to the CGroup API related
to the test.

Richard Palethorpe (6):
  API/cgroups: Allow fetching of CGroup name
  API/cgroups: Remove obsolete function in API
  API/cgroups: Check for unknown controller name
  API/cgroups: Add cpu controller
  API/cgroups: Auto add controllers to subtree_control in new subgroup
  sched/cgroup: Add cfs_bandwidth01

 include/tst_cgroup.h                          |   4 +
 lib/tst_cgroup.c                              |  94 ++++++----
 runtest/sched                                 |   1 +
 .../kernel/sched/cfs-scheduler/.gitignore     |   1 +
 testcases/kernel/sched/cfs-scheduler/Makefile |   4 +-
 .../sched/cfs-scheduler/cfs_bandwidth01.c     | 175 ++++++++++++++++++
 6 files changed, 245 insertions(+), 34 deletions(-)
 create mode 100644 testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c

-- 
2.31.1

