From: Michael Moese <mmoese@suse.de>
Date: Thu, 25 Jan 2018 16:22:54 +0100
Subject: [LTP] [PATCH 00/10] Trivial fixes for a bunch of compiler warnings
Message-ID: <20180125152304.32747-1-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi again,
I was able to remove some trivial compiler warnings again.
Local build-testing succeeded.

Michael Moese (10):
  fix old-style-definition in written.c
  fix old-style-definition in readline.c
  fix old-style-definition and unused parameter in pthcli.c
  fix old-style-definition and unused parameter in pthserv.c
  fix old-style-definition in hackbench.c
  fix old-style-definition in ht_utils.c
  fix old-style-definition in ht_utils.c
  fix old-style-definition in ht_utils.c
  fix old-style-definition and unused parameter in ht_affinity.c
  fix unused-parameter and old-style-definition in ht_interrupt.c

 testcases/kernel/sched/cfs-scheduler/hackbench.c               |  2 +-
 testcases/kernel/sched/clisrv/pthcli.c                         |  5 ++---
 testcases/kernel/sched/clisrv/pthserv.c                        |  4 ++--
 testcases/kernel/sched/clisrv/readline.c                       |  5 +----
 testcases/kernel/sched/clisrv/writen.c                         |  5 +----
 .../kernel/sched/hyperthreading/ht_affinity/ht_affinity.c      |  8 ++++----
 testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.c   |  6 +++---
 testcases/kernel/sched/hyperthreading/ht_enabled/ht_utils.c    |  6 +++---
 .../kernel/sched/hyperthreading/ht_interrupt/ht_interrupt.c    |  4 ++--
 testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c  | 10 +++++-----
 10 files changed, 24 insertions(+), 31 deletions(-)

-- 
2.13.6

