From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Sep 2021 15:08:13 +0200
Subject: [LTP] [PATCH v2 0/7] Cleanup sched/process.c
Message-ID: <20210910130820.21141-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v1->v2:
* split 1 commit into 2, use freopen() as suggested by Li
* 4 more commits for further cleanup

Petr Vorel (7):
  sched/process.c: Replace errfp with stderr
  sched/process.c: Open debugfp with freopen()
  ci/alpine: Enable process.c
  sched/process.c: Log into cwd, add *.log suffix
  sched/.gitignore: Ignore logs
  sched/process.c: Remove non-Linux code
  sched/process.c: Remove useless TRUE FALSE definitions

 ci/alpine.sh                                  |   1 -
 .../kernel/sched/process_stress/.gitignore    |   1 +
 .../kernel/sched/process_stress/Makefile      |   2 -
 .../kernel/sched/process_stress/process.c     | 118 ++++--------------
 4 files changed, 23 insertions(+), 99 deletions(-)

-- 
2.33.0

