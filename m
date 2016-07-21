From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Jul 2016 15:14:29 +0100
Subject: [LTP] [PATCH] kernel/include/aarch64.in: Fix incorrect numbers for
	kcmp and getrandom
Message-ID: <1469110469-19351-1-git-send-email-peter.maydell@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The syscall numbers listed for kcmp and getrandom for aarch64 seem
to have been incorrectly copied from 32-bit ARM. 64-bit ARM uses
the generic syscall numbers, which are 272 and 278.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Without this patch the getrandom testcases will TCONF rather than passing.

 testcases/kernel/include/aarch64.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/include/aarch64.in b/testcases/kernel/include/aarch64.in
index 28b741d..cb3fe06 100644
--- a/testcases/kernel/include/aarch64.in
+++ b/testcases/kernel/include/aarch64.in
@@ -253,5 +253,5 @@ clock_adjtime 266
 syncfs 267
 setns 268
 sendmmsg 269
-kcmp 378
-getrandom 384
+kcmp 272
+getrandom 278
-- 
1.9.1

