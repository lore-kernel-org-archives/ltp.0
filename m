From: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Date: Wed, 17 Aug 2016 16:27:37 +0300
Subject: [LTP] [PATCH] syscalls/splice02: Reduce size of the input sequence
Message-ID: <1471440457-26985-1-git-send-email-yuriy.kolerov@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


This test may take a lot of time on slow FPGA-based targets. Size of
the generated sequence may be reduced from 1-10000000 to seq 1-20000
and in bytes it is still more than SPLICE_SIZE constant from splice02.c:

    #define SPLICE_SIZE (64*1024)

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
---
 runtest/syscalls | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-syscalls-splice02-Reduce-size-of-the-input-sequence.patch
Type: text/x-patch
Size: 350 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160817/b3421168/attachment.bin>
