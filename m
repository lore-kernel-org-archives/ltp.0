From: Sandeep Patil <sspatil@android.com>
Date: Mon, 25 Mar 2019 16:20:08 -0700
Subject: [LTP] [PATCH 0/4] Convert tests to use new library
Message-ID: <20190325232012.67123-1-sspatil@android.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The series of patches convert 4 tests to use the new library. I
went through the kernel/syscalls directory alphabetically and
found the tests that haven't been converted yet.

The tests I changed here are, abort01, accept01, accept4 and acct1.

I've only tested these with glibc + x86 vm. I removed some of the
UCLINUX specific ifdefs in the process that I am not so sure about.
Is there a way for me to test these on other systems?

For now, I marked the patch where I removed these as RFC.

Sandeep Patil (4):
  syscalls/abort01: convert to new library
  syscalls/accept01: convert to new library.
  syscalls/accept4: convert to new library
  syscalls/acct01: convert to new library

 testcases/kernel/syscalls/abort/abort01.c     | 171 ++++---------
 testcases/kernel/syscalls/accept/accept01.c   | 236 ++++++++---------
 .../kernel/syscalls/accept4/accept4_01.c      | 241 ++++++------------
 testcases/kernel/syscalls/acct/acct01.c       | 207 +++++----------
 4 files changed, 294 insertions(+), 561 deletions(-)

-- 
2.21.0.392.gf8f6787159e-goog

