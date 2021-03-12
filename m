From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Mar 2021 18:31:58 +0100
Subject: [LTP] [PATCH 0/3] shell test timeout handling
Message-ID: <20210312173201.27708-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes before previous attempt [1]
* _tst_kill_test() (Cyril)
* added test timeout03.sh
* update trap message (Joerg)

NOTE: we have no way to print summary from _tst_do_exit if cleanup get
stuck, but IMHO there is no simple way how to solve it (we'd have to use
mapped memory to increment counter also in shell API as Cyril suggested)

[1] https://patchwork.ozlabs.org/project/ltp/patch/20210301220222.22705-7-pvorel@suse.cz/

Petr Vorel (3):
  tst_test.sh: Run cleanup also after test timeout
  test: Adding timeout03.sh for testing _tst_kill_test()
  zram: Increase timeout according to used devices

 lib/newlib_tests/shell/timeout03.sh           | 47 +++++++++++++++++++
 .../kernel/device-drivers/zram/zram_lib.sh    |  2 +
 testcases/lib/tst_test.sh                     | 25 ++++++++--
 3 files changed, 71 insertions(+), 3 deletions(-)
 create mode 100755 lib/newlib_tests/shell/timeout03.sh

-- 
2.30.1

