From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Wed, 23 Jun 2021 15:55:17 +0200
Subject: [LTP] [PATCH v2 0/4] syscalls/msgstress: fixes for small systems
Message-ID: <20210623135524.80663-1-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Changes since v1:
1. Move the code reading cgroups session limit to lib/tst_pid.c to
   existing tst_get_free_pids_().
2. Allow reading session limits from cgroups v2.
3. Add patch 1/4 - typo fix.
4. Add patch 4/4 with the buffer/reserve of pids.

Best regards,
Krzysztof

Krzysztof Kozlowski (4):
  include/tst_pid.h: fix language typo (subtraction)
  syscalls/msgstress04: fix fork failure on small memory systems
  syscalls/msgstress03: fix fork failure on small memory systems
  syscalls/msgstress: tune limit of processes for small machines

 include/tst_pid.h                             |  6 +-
 lib/tst_pid.c                                 | 81 ++++++++++++++++++-
 .../syscalls/ipc/msgstress/msgstress03.c      | 15 +++-
 3 files changed, 98 insertions(+), 4 deletions(-)

-- 
2.27.0

