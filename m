From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Wed, 11 Aug 2021 12:10:54 +0200
Subject: [LTP] [RESEND PATCH 0/4] controllers/memcg: fixes for CPU nodes on
 newer kernels
Message-ID: <20210811101058.36695-1-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

This is continuation of my work fixing controllers/memcg.

Rebased on top of latest master - no other dependencies.

The problem is that since v5.9 kernel, not only per-CPU but also
per-node kernel memory is accounted to group.  Creating a subgroup on
v5.11 kernel on a two-node machine eats ~440 kB by itself in kernel
memory.

The patchset tries to take it into account and adjust the memory limits.
Have in mind however that kernel might change such accounting in the
future.

Best regards,
Krzysztof


Krzysztof Kozlowski (4):
  controllers/memcg: account per-node kernel memory
  controllers/memcg: fix memcg_stat_test on two node machines
  controllers/memcg: fail early to avoid possible false-positives
  controllers/memcg: check status of commands using interface

 .../memcg/functional/memcg_failcnt.sh         |  4 +-
 .../controllers/memcg/functional/memcg_lib.sh | 46 ++++++++++++++++++-
 .../memcg_max_usage_in_bytes_test.sh          | 10 ++--
 .../memcg_memsw_limit_in_bytes_test.sh        |  8 ++--
 .../memcg_move_charge_at_immigrate_test.sh    |  4 +-
 .../memcg/functional/memcg_stat_test.sh       | 39 ++++++++--------
 .../memcg/functional/memcg_subgroup_charge.sh | 14 ++----
 .../functional/memcg_usage_in_bytes_test.sh   |  4 +-
 .../functional/memcg_use_hierarchy_test.sh    | 16 ++++---
 9 files changed, 96 insertions(+), 49 deletions(-)

-- 
2.30.2

