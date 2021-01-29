From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jan 2021 20:41:38 +0100
Subject: [LTP] [PATCH v2 0/6] 	zram cleanup
Message-ID: <20210129194144.31299-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v1->v2:
* rewritten variable setup in commit
  zram01.sh: Check properly mkfs.* dependencies
  to reflect Cyril's suggestions
* 2 new commits related to timeout:
  tst_test.sh: Run _tst_setup_timer after $TST_SETUP
  zram: Increase timeout according to used devices

Kind regards,
Petr

Petr Vorel (6):
  zram: Calculate dev_num variable
  zram01.sh: Generate test setup variables in setup
  zram: Move zram_compress_alg() to zram02.sh
  zram: Move test specific functions out of zram_lib.sh
  tst_test.sh: Run _tst_setup_timer after $TST_SETUP
  zram: Increase timeout according to used devices

 doc/test-writing-guidelines.txt               |   5 +-
 .../kernel/device-drivers/zram/zram01.sh      | 113 +++++++++++++----
 .../kernel/device-drivers/zram/zram02.sh      |  77 ++++++++++--
 .../kernel/device-drivers/zram/zram_lib.sh    | 116 +++---------------
 testcases/lib/tst_test.sh                     |   4 +-
 5 files changed, 180 insertions(+), 135 deletions(-)

-- 
2.30.0

