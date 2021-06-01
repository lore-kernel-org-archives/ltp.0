From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  1 Jun 2021 11:55:15 +0100
Subject: [LTP] [PATCH v3 0/6] cfs_bandwidth01 and CGroup API
Message-ID: <20210601105521.27459-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

This adds a test scheduler test which uses the cpu controller.

Also included are some additions and fixes to the CGroup API related
to the test.

V3:
* Reverse order of writing cpu.cfs_period_us and cpu.cfs_quota_us to fix V1.
* Add may_have_waiters to indicate we should try waking and cleaning up
  children during cleanup. At worst this can result in timeout warnings if there
  are less than 9 children waiting.
  Which is probably better than failing to cleanup the CGroups.

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
 .../sched/cfs-scheduler/cfs_bandwidth01.c     | 184 ++++++++++++++++++
 6 files changed, 236 insertions(+), 16 deletions(-)
 create mode 100644 testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c

-- 
2.31.1

