From: Li Wang <liwang@redhat.com>
Date: Wed, 27 Jul 2016 17:58:39 +0800
Subject: [LTP] [PATCH] mkswap: make the test device size is aligned to
	pagesize
Message-ID: <1469613519-27167-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We get failures like below because of 'DEVICE_SIZE-10000' makes the
loop device size is not aligned to system PAGE_SIZE any more.

-----
mkswap01 1 TINFO : Found free device '/dev/loop1'
mkswap01 1 TPASS : 'mkswap   /dev/loop1 ' passed.
mkswap01 2 TFAIL : 'mkswap -f  /dev/loop1 92400' failed, not expected.
mkswap01 3 TINFO : Can not do swapon on /dev/loop1.
mkswap01 3 TINFO : Device size specified by 'mkswap' greater than real size.
mkswap01 3 TINFO : Swapon failed expectedly.
mkswap01 3 TPASS : 'mkswap -f  /dev/loop1 112400' passed.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/commands/mkswap/mkswap01.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
index 9727b0f..e89c720 100755
--- a/testcases/commands/mkswap/mkswap01.sh
+++ b/testcases/commands/mkswap/mkswap01.sh
@@ -169,8 +169,8 @@ mkswap_test()
 setup
 
 mkswap_test "" "" "$TST_DEVICE"
-mkswap_test "" "" "$TST_DEVICE" "$((DEVICE_SIZE-10000))"
-mkswap_test "-f" "" "$TST_DEVICE" "$((DEVICE_SIZE+10000))"
+mkswap_test "" "" "$TST_DEVICE" "$((DEVICE_SIZE-PAGE_SIZE/1024))"
+mkswap_test "-f" "" "$TST_DEVICE" "$((DEVICE_SIZE+PAGE_SIZE/1024))"
 mkswap_test "-c" "" "$TST_DEVICE"
 mkswap_test "-p" "2048" "$TST_DEVICE"
 mkswap_test "-L" "ltp_testswap" "-L ltp_testswap" "" "/dev/disk/by-label/ltp_testswap"
-- 
1.8.3.1

