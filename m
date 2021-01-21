From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Jan 2021 14:32:30 +0100
Subject: [LTP] [PATCH v4 0/3] Kernel module detection (own implementation)
Message-ID: <20210121133233.29007-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v3->v4:
* fix memory leaks (add missing free())
* optimize handling input string (avoid unnecessary fgets())
* add missing static
* new commit: re-add tst_require_drivers veth in tst_net.sh

I'm for merging this variant which works with text files.
I haven't check the binary format yet, but it'd would most likely
require using libkmod. Do we want that?

Kind regards,
Petr

Petr Vorel (3):
  lib: Fix kernel module detection on BusyBox
  zram: Fix module detection on BusyBox
  tst_net.sh: Require veth for netns (again)

 lib/tst_kernel.c                              | 104 ++++++++++++++++--
 .../kernel/device-drivers/zram/zram_lib.sh    |   6 +-
 testcases/lib/tst_net.sh                      |   1 +
 3 files changed, 95 insertions(+), 16 deletions(-)

-- 
2.30.0

