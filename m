From: Liam Howlett <liam.howlett@oracle.com>
Date: Tue, 9 Feb 2021 14:37:04 +0000
Subject: [LTP] [PATCH 0/1] Test brk vma code path
Message-ID: <20210209143702.2003038-1-Liam.Howlett@Oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The brk system call uses a slightly different code path through the
kernel to expand/contract across VMAs.  This new test is written to
force the VMA to create a two new entries and shrink back across VMA
boundaries.

Liam R. Howlett (1):
  brk02: Add test for removing more than one VMA

 testcases/kernel/syscalls/brk/brk02.c | 49 +++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 testcases/kernel/syscalls/brk/brk02.c

-- 
2.28.0
