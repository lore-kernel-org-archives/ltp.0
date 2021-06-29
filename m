From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Tue, 29 Jun 2021 14:10:43 +0200
Subject: [LTP] [PATCH v4 0/4] syscalls/msgstress: fixes for small systems
Message-ID: <20210629121047.100391-1-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

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

Krzysztof Kozlowski (4):
  include/tst_pid.h: fix language typo (subtraction)
  tst_pid.c: fix fork failure on small memory systems
  syscalls/msgstress03: fix fork failure on small memory systems
  syscalls/msgstress: tune limit of processes for small machines

 include/tst_pid.h                             |  6 +-
 lib/tst_pid.c                                 | 72 ++++++++++++++++++-
 .../syscalls/ipc/msgstress/msgstress03.c      | 15 +++-
 3 files changed, 89 insertions(+), 4 deletions(-)

-- 
2.27.0

