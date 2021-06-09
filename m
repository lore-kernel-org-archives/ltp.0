From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 9 Jun 2021 17:49:22 +0800
Subject: [LTP] [PATCH 0/2] syscalls/chown: Format output and add testcases
 for chown05
Message-ID: <20210609094924.145262-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Format output and add testcases for chown05.
2. Delete duplicate header files.

Xie Ziyao (2):
  syscalls/chown: format output and add testcases for chown05
  syscalls/chown: format output and delete duplicate header files

 testcases/kernel/syscalls/chown/chown01.c |  8 +-------
 testcases/kernel/syscalls/chown/chown02.c |  9 +++------
 testcases/kernel/syscalls/chown/chown03.c |  9 ---------
 testcases/kernel/syscalls/chown/chown04.c | 20 +++++++++++---------
 testcases/kernel/syscalls/chown/chown05.c | 22 +++++++++++++++-------
 5 files changed, 30 insertions(+), 38 deletions(-)

--
2.17.1

