From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 16 Apr 2020 15:28:59 +0800
Subject: [LTP] [PATCH v3 0/3] increase pipe2 coverage
In-Reply-To: <1586927503-10827-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1586927503-10827-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1587022142-32122-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes:#625
v2->v3:
Add pipe2_02.c and  pipe2_03.c test.

Noticed that:
Cases use SAFE_PIPE2 macro(it is in review[1]).
[1]https://patchwork.ozlabs.org/project/ltp/patch/20200409211255.1357-2-laniel_francis@privacyrequired.com/
Also, laniel has writed test case for pipe2 O_NONBLOCK flag, so I only
cover O_CLOEXEC and O_DIRECT flag.

Yang Xu (3):
  syscalls/pipe2_01: convert into new API
  syscalls/pipe2_02: Add new test for pipe2 O_CLOEXEC flag
  syscalls/pipe2_03: Add new test for pipe2 O_DIRECT flag

 include/lapi/fcntl.h                          |   4 +
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/pipe2/.gitignore    |   2 +
 testcases/kernel/syscalls/pipe2/pipe2_01.c    | 234 +++++-------------
 testcases/kernel/syscalls/pipe2/pipe2_02.c    | 214 ++++------------
 .../kernel/syscalls/pipe2/pipe2_02_child.c    |  26 ++
 testcases/kernel/syscalls/pipe2/pipe2_03.c    | 157 ++++++++++++
 7 files changed, 305 insertions(+), 333 deletions(-)
 create mode 100644 testcases/kernel/syscalls/pipe2/pipe2_02_child.c
 create mode 100644 testcases/kernel/syscalls/pipe2/pipe2_03.c

-- 
2.23.0



