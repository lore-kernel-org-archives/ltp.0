From: Li Wang <liwang@redhat.com>
Date: Tue, 16 Aug 2016 11:35:15 +0800
Subject: [LTP] [PATCH V2] mkswap: make the test device size is aligned to
	pagesize
Message-ID: <1471318515-29836-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We get failures like below because of 'DEVICE_SIZE-10000' makes the
test device size is not aligned to system PAGE_SIZE any more.

   mkswap01 1 TINFO : Found free device '/dev/loop1'
   mkswap01 1 TPASS : 'mkswap   /dev/loop1 ' passed.
   mkswap01 2 TFAIL : 'mkswap -f  /dev/loop1 92400' failed, not expected.
   mkswap01 3 TINFO : Can not do swapon on /dev/loop1.
   mkswap01 3 TINFO : Device size specified by 'mkswap' greater than real size.
   mkswap01 3 TINFO : Swapon failed expectedly.
   mkswap01 3 TPASS : 'mkswap -f  /dev/loop1 112400' passed.

But the way, the orignal test-device(LTP_DEV) size is also not aligned with
PAGE_SIZE on all arches. Here fix it as well.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runltp                                | 2 +-
 testcases/commands/mkswap/mkswap01.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/runltp b/runltp
index 3a46765..bb2e5d8 100755
--- a/runltp
+++ b/runltp
@@ -978,7 +978,7 @@ main()
 create_block()
 {
     #create a block device
-    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=153600 >/dev/null 2>&1
+    dd if=/dev/zero of=${TMP}/test.img bs=1024 count=153600 >/dev/null 2>&1
     if [ $? -ne 0 ]; then
         echo "Failed to create loopback device image, please check disk space and re-run"
         return 1
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

