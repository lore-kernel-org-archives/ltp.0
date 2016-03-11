From: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Date: Fri, 11 Mar 2016 15:01:49 +0300
Subject: [LTP]  [PATCH v2] syscalls/profil: disable these tests for uClibc
Message-ID: <1457697709-11192-1-git-send-email-yuriy.kolerov@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


uClibc doesn't have profiling support. It's necessary to define UCLIBC
environment variable with value 1 to prevent building of this test for
uClibc. This variable may be defined when calling make:

    make UCLIBC=1

Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
---
 testcases/kernel/syscalls/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-syscalls-profil-disable-these-tests-for-uClibc.patch
Type: text/x-patch
Size: 471 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160311/783bf998/attachment.bin>
