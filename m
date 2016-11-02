From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Wed,  2 Nov 2016 12:57:01 +0100
Subject: [LTP]  [PATCH 0/3] Additional checks for sched_xxx, socketcall01,
	inotify06
Message-ID: <1478087824-31577-1-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This series adds checks in setup() to determine if the tests are
run as super user in case of sched_xxx and socketcall01 or to determine
if the test is run with the appropriate kernel version, in case of the
inotify06 test.

Dejan Jovicevic (3):
  sched_xxx: TCONF instead of TFAIL if user is not root
  socketcall: TCONF instead of TFAIL when user is not root
  inotify06: kernel version check

 testcases/kernel/syscalls/inotify/inotify06.c                          | 3 +++
 .../kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c    | 1 +
 .../kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c    | 1 +
 .../kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c    | 1 +
 testcases/kernel/syscalls/sched_setparam/sched_setparam02.c            | 1 +
 testcases/kernel/syscalls/sched_setparam/sched_setparam03.c            | 2 ++
 testcases/kernel/syscalls/socketcall/socketcall01.c                    | 1 +
 7 files changed, 10 insertions(+)

-- 
1.9.1

