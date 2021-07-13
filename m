From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Tue, 13 Jul 2021 11:22:05 +0200
Subject: [LTP] [PATCH v4 0/5] controllers/memcg: fixes for newer kernels
Message-ID: <20210713092210.17141-1-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Changes since v3:
1. Patch 4/5: Include per-CPU memory as well in group limits.

Changes since v2:
1. Patch 1/5: Define MEM_USAGE_RANGE and explain it.
2. Patch 3/5: Use PAGESIZES to explain it is the batch accounting.
3. Patch 4/5: Add to this patchset (previously sent separately, no
   dependencies on others).
4. Patch 5/5: New patch, fixes additional difference, usually of 2-3
   pages coming from the kernel.

See also reply from Michal Hocko:
https://lore.kernel.org/linux-mm/85b8a4f9-b9e9-a6ca-5d0c-c1ecb8c11ef3@canonical.com/T/#m6459b3be3a86f5eaf2cfc48dd586b6faf949e440

v2: https://lists.linux.it/pipermail/ltp/2021-June/023259.html

Best regards,
Krzysztof

Krzysztof Kozlowski (5):
  controllers/memcg: accept range of max_usage_in_bytes
  controllers/memcg: accept range of usage_in_bytes
  controllers/memcg: accept non-zero max_usage_in_bytes after reset
  controllers/memcg: increase memory limit in subgroup charge
  controllers/memcg: offset kernel memory

 .../controllers/memcg/functional/memcg_lib.sh | 41 ++++++++++++++++---
 .../memcg_max_usage_in_bytes_test.sh          | 18 +++++++-
 .../memcg/functional/memcg_stat_rss.sh        | 20 ++++-----
 .../memcg/functional/memcg_stat_test.sh       |  8 ++--
 .../memcg/functional/memcg_subgroup_charge.sh | 33 +++++++++++----
 .../functional/memcg_usage_in_bytes_test.sh   |  7 +++-
 6 files changed, 96 insertions(+), 31 deletions(-)

-- 
2.27.0

