From: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Date: Fri,  4 Mar 2016 19:40:55 +0300
Subject: [LTP]  [PATCH] syscalls/profil01: disable this test for uClibc
Message-ID: <1457109655-6170-1-git-send-email-yuriy.kolerov@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


uClibc doesn't have profiling support.

Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
---
 testcases/kernel/syscalls/profil/profil01.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-syscalls-profil01-disable-this-test-for-uClibc.patch
Type: text/x-patch
Size: 583 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160304/8ceac2bb/attachment.bin>
