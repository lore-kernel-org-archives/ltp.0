From: Liam Howlett <liam.howlett@oracle.com>
Date: Wed, 24 Feb 2021 21:31:23 +0000
Subject: [LTP] [PATCH v2 0/1] Test brk VMA code path
Message-ID: <20210224213114.2976705-1-Liam.Howlett@Oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The brk system call uses a slightly different code path through the
kernel to expand/contract across VMAs.  This new test is written to
force the VMA to create at least two new entries and shrink back across
VMA boundaries.

V2 changes:
- White space fixes.
- Removed unnecessary include
- Added tst_res in failure paths

Liam R. Howlett (1):
  brk02: Add test for removing more than one VMA

 testcases/kernel/syscalls/brk/brk02.c | 54 +++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 testcases/kernel/syscalls/brk/brk02.c

-- 
2.30.0
