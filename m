From: bxue@redhat.com <bxue@redhat.com>
Date: Tue,  2 May 2017 11:59:56 +0800
Subject: [LTP] [PATCH v2 0/2] add test case splice04 and splice05
Message-ID: <1493697598-9327-1-git-send-email-bxue@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Boyang Xue <bxue@redhat.com>

Hi,

Please help me review the following test cases. Thanks.

Change from patchset v1:
1) add built test case binary in .gitignore
2) restrict test data size so as to honor /proc/sys/fs/pipe-max-size
3) do splice() in a loop in case not all data are splice-ed in a single operation

Thanks for review comments from Jan.

-Boyang

Boyang Xue (2):
  syscalls/splice04: add test for splice() from pipe to pipe
  syscalls/splice05: add test for splice() between pipe and socket

 .gitignore                                  |   2 +
 runtest/syscalls                            |   2 +
 testcases/kernel/syscalls/splice/splice04.c | 117 ++++++++++++++++++++++++
 testcases/kernel/syscalls/splice/splice05.c | 134 ++++++++++++++++++++++++++++
 4 files changed, 255 insertions(+)
 create mode 100644 testcases/kernel/syscalls/splice/splice04.c
 create mode 100644 testcases/kernel/syscalls/splice/splice05.c

-- 
1.8.3.1

