From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Fri, 20 Aug 2021 12:00:25 +0200
Subject: [LTP] [PATCH v5 0/3] syscalls/msgstress: fixes for small systems
Message-ID: <20210820100028.97487-1-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Changes since v4:
1. Drop applied patches.
2. Add patch 1/3 moving code to lib.
3. Change limit 500->50 in patch 3/3.

Changes since v3:
1. Adjust subject of patch 2/4.
2. Don't use TEST() macro in 2/4.
3. Remove debug messages in 2/4.
4. Return unsigned int in get_session_uid() as it cannot fail in 2/4.

Changes since v2:
1. Resend due to messed up previous submission.

Changes since v1:
1. Move the code reading cgroups session limit to lib/tst_pid.c to
   existing tst_get_free_pids_().
2. Allow reading session limits from cgroups v2.
3. Add patch 1/4 - typo fix.
4. Add patch 4/4 with the buffer/reserve of pids.

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  lib/tst_pid: simplify error handling by callers of tst_get_free_pids()
  syscalls/msgstress03: fix fork failure on small memory systems
  syscalls/msgstress: tune limit of processes for small machines

 lib/tst_pid.c                                       | 13 +++++++++----
 .../kernel/syscalls/ipc/msgstress/msgstress03.c     | 10 +++++++++-
 .../kernel/syscalls/ipc/msgstress/msgstress04.c     |  6 ------
 3 files changed, 18 insertions(+), 11 deletions(-)

-- 
2.30.2

