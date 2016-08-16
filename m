From: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Date: Tue, 16 Aug 2016 15:49:01 +0300
Subject: [LTP]  [PATCH v2] syscalls/fcntl34: Use flock64 instead of flock
Message-ID: <1471351741-20639-1-git-send-email-yuriy.kolerov@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


This test uses OFD locks which are supported only by 64-bit ABI.
Thus OFD locks must be used with flock64 structure for sure in this
test. It is necessary because on some 32-bit targets (e.g. 32-bit
uClibc) flock is not mapped to flock64 when _FILE_OFFSET_BITS is not
set to 64.

Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
---
 testcases/kernel/syscalls/fcntl/fcntl34.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-syscalls-fcntl34-Use-flock64-instead-of-flock.patch
Type: text/x-patch
Size: 428 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160816/d962680c/attachment.bin>
