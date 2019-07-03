From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Wed,  3 Jul 2019 18:23:00 +0800
Subject: [LTP] [PATCH 0/3] zram/zram_lib.sh: fix zram_compress_alg() test
 for zram01
Message-ID: <20190703102303.32166-1-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The zram_compress_alg() test in zram01 is not working properly, this
patchset will address the following issues:
  1. One-liner local variable assignment with space-separated value does
     not work for DASH, which is symbolically linked to /bin/sh on some
     OS like Ubuntu.
  2. Inconsistent variable name for compression algorithms, and the
     algorithm name needs to be sanitized.
  3. Hard-coded block device numbers to iterate with. If the number of
     the available zram compression algorithms is larger than the
     number of block devices, the test will fail.

Po-Hsu Lin (3):
  zram/zram_lib.sh: fix local variable assignment for DASH
  zram/zram_lib.sh: fix variable name and algorithm retrieval
  zram/zram_lib.sh: iterate through all available compression algorithms
    for all zram block devices

 .../kernel/device-drivers/zram/zram_lib.sh    | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

-- 
2.17.1

