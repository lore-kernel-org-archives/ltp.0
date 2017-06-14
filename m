From: Li Wang <liwang@redhat.com>
Date: Wed, 14 Jun 2017 11:38:30 +0800
Subject: [LTP] [PATCH] dio: reduce the number of cycles
Message-ID: <20170614033830.12736-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These two cases (dio29/30) takes a bit long time in dio test, but they're not stress
test, so I suggest reducing the number of cycles.

On my RHEL-7.3 (23G RAM, 24 CPU(s), x86_64) box, it takes almost 9 mins.

  diotest06    1  TPASS  :  Read with Direct IO, Write without
  diotest06    2  TPASS  :  Write with Direct IO, Read without
  diotest06    3  TPASS  :  Read, Write with Direct IO
  diotest06    0  TINFO  :  3 testblocks 1000 iterations with 100 children completed

  real	8m4.805s
  user	71m36.722s
  sys	8m51.649s

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runtest/dio | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/runtest/dio b/runtest/dio
index a26e001..185cd57 100644
--- a/runtest/dio
+++ b/runtest/dio
@@ -40,8 +40,8 @@ dio27 diotest6 -b 8192 -o 1024000 -i 1000 -v 100
 dio28 diotest6 -b 8192 -o 1024000 -i 1000 -v 200
 
 ### Run the tests with more children
-dio29 diotest3 -b 65536 -n 100 -i 1000 -o 1024000
-dio30 diotest6 -b 65536 -n 100 -i 1000 -o 1024000
+dio29 diotest3 -b 65536 -n 100 -i 100 -o 1024000
+dio30 diotest6 -b 65536 -n 100 -i 100 -o 1024000
 #
 # RAW DEVICE TEST SECTION
 #   DEV1 and DEV2 should be exported prior to execution or
-- 
2.9.3

