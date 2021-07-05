From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 5 Jul 2021 15:59:01 +0800
Subject: [LTP] [PATCH 0/2 v2] syscalls/fork: Rewrite fork{07,
 08} to a proper synchronization
Message-ID: <20210705075903.98692-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v1->v2:
1. Write a new test for fork07, which checks that all children inherit parent's file descriptor.
* Parent writes N bytes (for example 'a') to a file in setup()
* Parent opens a file descriptor for reading pointing to that file
* Parent forks N children
  - each child reads a byte from the file checks that the byte is 'a' then exits
* Parent waits the all the children
* Parent checks that the end of file is reached
2. Same changes are applied to fork08, and use file descriptors instead of the FILE.

Xie Ziyao (2):
  fork07: Rewrite the test to a proper synchronization
  fork08: Rewrite the test to a proper synchronization

 testcases/kernel/syscalls/fork/fork07.c | 236 +++++-------------------
 testcases/kernel/syscalls/fork/fork08.c | 200 +++++---------------
 2 files changed, 94 insertions(+), 342 deletions(-)

--
2.17.1

