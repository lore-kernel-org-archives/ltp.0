From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 18 Mar 2021 15:11:26 +0200
Subject: [LTP] [PATCH 0/8] fanotify tests for v5.13
Message-ID: <20210318131134.3562203-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Following tests were used for development of the two features
queued for v5.13 (in linux-next):
- Performance improvements for events merge [1]
- Unprivileged fanotify listener [2]

All test cases of fanotify05 pass on upstream, but their runtime
on linux-next is reduced by more than half.

Only the first test case of fanotify17 pass on upstream.
The rest of the test cases as well as fanotify18 and fanotify19
tests exit with TCONF on upstream. They all pass on linux-next.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20210304104826.3993892-1-amir73il@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20210304112921.3996419-1-amir73il@gmail.com/

Amir Goldstein (8):
  syscalls/fanotify05: Fix test output when not getting overflow
  syscalls/fanotify05: Verify events are received by queue order
  syscalls/fanotify05: Verify getting a single overflow event
  syscalls/fanotify05: Add a test case for unlimited queue
  syscalls/fanotify05: adjust test to tunable max_queued_events
  syscalls/fanotify: New test for fanotify user limits
  syscalls/fanotify: New test to validate unprivileged user permissions
  syscalls/fanotify: New test to validate unprivileged listener events

 runtest/syscalls                              |   3 +
 testcases/kernel/syscalls/fanotify/.gitignore |   3 +
 testcases/kernel/syscalls/fanotify/fanotify.h |   3 +
 .../kernel/syscalls/fanotify/fanotify05.c     | 147 ++++++++--
 .../kernel/syscalls/fanotify/fanotify17.c     | 266 ++++++++++++++++++
 .../kernel/syscalls/fanotify/fanotify18.c     | 198 +++++++++++++
 .../kernel/syscalls/fanotify/fanotify19.c     | 253 +++++++++++++++++
 7 files changed, 845 insertions(+), 28 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify17.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify18.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify19.c

-- 
2.25.1

