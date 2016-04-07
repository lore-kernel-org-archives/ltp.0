From: TAKAHASHI Tetsuya <takahashi.tetsuya.cis@canon-is.co.jp>
Date: Thu, 7 Apr 2016 12:08:40 +0000
Subject: [LTP] [PATCH] runtest/scsi_debug.part1: gf701 test does not work.
Message-ID: <330BE2030BD7834286495D8B7FCF1FB71DC52EBF@mbx01.itr.canon-is.co.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello.

I think that a line feed code is necessary between gf701 test and gf702 test.
In this case, the gf701 test does not work.

------
--- a/runtest/scsi_debug.part1  2016-03-22 18:01:02.000000000 +0900
+++ b/runtest/scsi_debug.part1  2016-03-31 18:23:35.877219900 +0900
@@ -73,7 +73,8 @@
 rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:mm-sync-$$ 500b:/test/growfiles/ext2/rwtest14%f
 rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:/test/growfiles/ext2/rwtest15%f
 # Check the EXT3 filesystem
-gf701 growfiles -W gf701 -d /test/growfiles/ext3 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glseek20.2gf702 growfiles -W gf702 -d /test/growfiles/ext3 -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
+gf701 growfiles -W gf701 -d /test/growfiles/ext3 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glseek20.2
+gf702 growfiles -W gf702 -d /test/growfiles/ext3 -b -e 1 -L 10 -i 100 -I p -S 2 -u -f gf03_
 gf703 growfiles -W gf703 -d /test/growfiles/ext3 -b -e 1 -g 1 -i 1 -S 150 -u -f gf05_
 gf704 growfiles -W gf704 -d /test/growfiles/ext3 -b -e 1 -g 4090 -i 500 -t 39000 -u -f gf06_
 gf705 growfiles -W gf705 -d /test/growfiles/ext3 -b -e 1 -g 5000 -i 500 -t 49900 -T10 -c9 -I p -u -f gf07_
------

Best regards.


