From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Wed, 15 Feb 2017 09:54:56 -0800
Subject: [LTP] LTP tip busted for x86_64 + glibc !
Message-ID: <60c14b52-eec5-e376-e46e-95b97aa5d39c@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It seems I need the following fixups

------->
diff --git a/testcases/kernel/syscalls/preadv/preadv.h
b/testcases/kernel/syscalls/preadv/preadv.h
index f3ac30db3e02..8c48d3a7c05b 100644
--- a/testcases/kernel/syscalls/preadv/preadv.h
+++ b/testcases/kernel/syscalls/preadv/preadv.h
@@ -22,7 +22,7 @@
 #include "linux_syscall_numbers.h"
 
 #if !defined(HAVE_PREADV)
-int preadv(int fd, const struct iovec *iov, int iovcnt, off_t offset)
+ssize_t preadv(int fd, const struct iovec *iov, int iovcnt, off_t offset)
 {
        return tst_syscall(__NR_preadv, fd, iov, iovcnt, offset);
 }
diff --git a/testcases/kernel/syscalls/pwritev/pwritev.h
b/testcases/kernel/syscalls/pwritev/pwritev.h
index 4970036efec1..9a2a3a8b0c6f 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev.h
+++ b/testcases/kernel/syscalls/pwritev/pwritev.h
@@ -22,7 +22,7 @@
 #include "linux_syscall_numbers.h"
 
 #if !defined(HAVE_PWRITEV)
-int pwritev(int fd, const struct iovec *iov, int iovcnt, off_t offset)
+ssize_t pwritev(int fd, const struct iovec *iov, int iovcnt, off_t offset)
 {
        return tst_syscall(__NR_pwritev, fd, iov, iovcnt, offset);

