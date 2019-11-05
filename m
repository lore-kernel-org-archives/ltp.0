From: Martin Doucha <mdoucha@suse.cz>
Date: Tue,  5 Nov 2019 10:03:38 +0100
Subject: [LTP] [PATCH v2 0/1] Fix compression ratio calculation in zram01
In-Reply-To: <20191105082322.GA16218@dell5510>
References: <20191105082322.GA16218@dell5510>
Message-ID: <20191105090339.6522-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Changes from v1:
- TINFO about amount of data written to zram device changed to TPASS

Shortened patch description from v1:
The compression ratio check in zram01.sh is completely broken. Here's a patch
to calculate the compression ratio correctly using sysfs memory usage
statistics for each zram device. I currently calculate it as
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

Martin Doucha (1):
  Fix compression ratio calculation in zram01

 .../kernel/device-drivers/zram/zram01.sh      | 38 +++++++++----------
 1 file changed, 17 insertions(+), 21 deletions(-)

-- 
2.23.0

