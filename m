From: Martin Doucha <mdoucha@suse.cz>
Date: Mon,  4 Nov 2019 13:52:27 +0100
Subject: [LTP] [PATCH 0/1] Fix zram01.sh
Message-ID: <20191104125228.17173-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The compression ratio check in zram01.sh is completely broken:
- It uses `free -m` to *guess* zram memory usage which is distorted by all
  other processes running on the system.
- It calculates memory usage backwards ($before - $after; which should
  produce a negative value if the two values weren't nonsense).
- It mixes bytes with megabytes when calculating the final ratio.

Here's a patch to calculate the compression ratio correctly using sysfs memory
usage statistics for each zram device. I currently calculate it as
$bytes_written / $mm_stat_compr_data_size.

One question for debate is whether I should use a different formula:
- $bytes_written / $mm_stat_mem_used_total
  (mem_used_total includes internal zram memory management overhead)
- $mm_stat_orig_data_size / $mm_stat_compr_data_size
  (zram01.sh fills the zram device with binary zeroes so the data will be
  compacted even before compression; orig_data_size << bytes_written)
- $mm_stat_orig_data_size / $mm_stat_mem_used_total)
  (this could easily produce ratio <100% due to page compacting)
See https://www.kernel.org/doc/Documentation/blockdev/zram.txt

The mm_stat sysfs file is available since kernel 4.1. Unfortunately,
I couldn't test the TCONF branch when mm_stat doesn't exist because there's
no SLE release with kernel version between 3.14 and 4.1.

Verifcation run: https://openqa.suse.de/tests/3552880#step/zram01/6

Martin Doucha (1):
  Fix compression ratio calculation in zram01

 .../kernel/device-drivers/zram/zram01.sh      | 36 +++++++++----------
 1 file changed, 16 insertions(+), 20 deletions(-)

-- 
2.23.0

