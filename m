From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Wed, 10 Jul 2019 15:23:02 +0800
Subject: [LTP] [PATCHv2 0/3] zram/zram_lib.sh: fix zram_compress_alg() test
 for zram01
Message-ID: <20190710072305.25806-1-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The zram_compress_alg() test in zram01 is not working properly, this
patchset will address the following issues:
  1. Inconsistent variable name for compression algorithms, and the
     algorithm name needs to be sanitized before use.
  2. Hard-coded block device numbers to iterate with. If the number of
     the available zram compression algorithms is larger than the
     number of block devices, the test will fail.
  3. Restore the compression algorithm back to the default one.

Po-Hsu Lin (3):
  zram/zram_lib.sh: fix variable name and algorithm retrieval
  zram/zram_lib.sh: iterate through all available compression algorithms
    for all zram block devices
  zram/zram_lib.sh: set the compression algorithms back to default after
    test

 .../kernel/device-drivers/zram/zram_lib.sh    | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

-- 
2.17.1

