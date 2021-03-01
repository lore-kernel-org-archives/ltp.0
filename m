From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  1 Mar 2021 23:02:15 +0100
Subject: [LTP] [PATCH 0/7] zram cleanup, tst_set_timeout(timeout)
Message-ID: <20210301220222.22705-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cc: Cyril Hrubis <chrubis@suse.cz>,
    Li Wang <liwang@redhat.com>,
    Joerg Vehlow <joerg.vehlow@aox-tech.de>,
    Joerg Vehlow <lkml@jv-coder.de>

Petr Vorel (7):
  zram: Calculate dev_num variable
  zram01.sh: Generate test setup variables in setup
  zram: Add zram_compress_alg() to zram02.sh
  zram: Move test specific functions out of zram_lib.sh
  tst_test.sh: Introduce tst_set_timeout(timeout)
  tst_test.sh: Run cleanup also after test timeout
  zram: Increase timeout according to used devices

 doc/test-writing-guidelines.txt               | 16 ++-
 .../kernel/device-drivers/zram/zram01.sh      | 99 +++++++++++++++----
 .../kernel/device-drivers/zram/zram02.sh      | 48 +++++++--
 .../kernel/device-drivers/zram/zram_lib.sh    | 85 ++++------------
 testcases/lib/tst_test.sh                     | 34 +++++--
 5 files changed, 175 insertions(+), 107 deletions(-)

-- 
2.30.1

