From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 Jan 2021 17:03:14 +0100
Subject: [LTP] [PATCH v3 0/2] kernel module detection (own implementation)
Message-ID: <20210119160316.4776-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v2->v3:
* treat '-' and '_' as the same (follow kmod implementation)
* drop unused MODULES_DIR definition
* code readability (more use of SAFE_ASPRINTF())

It'd deserve a test.

Kind regards,
Petr


Petr Vorel (2):
  lib: Fix kernel module detection on BusyBox
  zram: Fix module detection on BusyBox

 lib/tst_kernel.c                              | 99 ++++++++++++++++---
 .../kernel/device-drivers/zram/zram_lib.sh    |  6 +-
 2 files changed, 89 insertions(+), 16 deletions(-)

-- 
2.30.0

