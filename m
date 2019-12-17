From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 17 Dec 2019 18:12:47 +0800
Subject: [LTP] [PATCH v1 0/4] cleanup capset testcase
Message-ID: <1576577571-3668-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I cleanup capset testcase as below:

capset01: test on three versions
capset02: add various EPERM error cases
capset03: add EPERM error test without CAP_SETPCAP
capset04: add new EPERM error test with vfs cap support

I have tested them with root/nobody user and debug EPERM error in kernel code
(security/commoncap.c cap_capset function ).  They are ok.

Yang Xu (4):
  syscalls/capset01: Cleanup & convert to new library
  syscalls/capset02: Cleanup & convert to new library
  syscalls/capset03: add new EPERM error test without CAP_SETPCAP
  syscalls/capset04: add new EPERM error test with vfs cap support

 runtest/syscalls                            |   2 +
 testcases/kernel/syscalls/capset/.gitignore |   2 +
 testcases/kernel/syscalls/capset/capset01.c | 150 ++------
 testcases/kernel/syscalls/capset/capset02.c | 364 ++++++++------------
 testcases/kernel/syscalls/capset/capset03.c |  65 ++++
 testcases/kernel/syscalls/capset/capset04.c |  86 +++++
 6 files changed, 319 insertions(+), 350 deletions(-)
 create mode 100644 testcases/kernel/syscalls/capset/capset03.c
 create mode 100644 testcases/kernel/syscalls/capset/capset04.c

-- 
2.18.0



