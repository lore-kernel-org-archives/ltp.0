From: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Date: Fri, 12 Aug 2016 20:11:52 +0300
Subject: [LTP] [PATCH] syscalls/fcntl34: Use -D_FILE_OFFSET_BITS=64 for all
	cases
Message-ID: <1471021912-29886-1-git-send-email-yuriy.kolerov@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


This test uses OFD locks which are supported only by 64-bit ABI.
Thus OFD locks must be used with flock64 structure for sure in this
test. It is necessary because on some 32-bit targets (e.g. 32-bit
uClibc) flock is not mapped to flock64 when _FILE_OFFSET_BITS is not
set to 64. Thus fcntl34 and fcntl34_64 must be identical. It is an
ugly but the easiest solution.

Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
---
 testcases/kernel/syscalls/fcntl/Makefile | 1 +
 1 file changed, 1 insertion(+)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-syscalls-fcntl34-Use-D_FILE_OFFSET_BITS-64-for-all-c.patch
Type: text/x-patch
Size: 446 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160812/373b6df2/attachment.bin>
