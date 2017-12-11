From: Wang Long <wanglong19@meituan.com>
Date: Mon, 11 Dec 2017 12:23:34 -0500
Subject: [LTP] [PATCH 0/2] Adjust io-throttle testcases
Message-ID: <1513013016-22819-1-git-send-email-wanglong19@meituan.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These two patches update io-throttle thestcases to use the new
blkio cgroup interface.

Wang Long (2):
  adjust io-throttle testcases
  Fix the way to check if the kernel has blkio cgroup enabled

 .../io-throttle/io_throttle_testplan.txt           | 11 ++----
 .../controllers/io-throttle/myfunctions-io.sh      | 43 +++++++++++++---------
 .../io-throttle/run_io_throttle_test.sh            | 41 ++++++++-------------
 testcases/kernel/controllers/test_controllers.sh   |  6 +--
 4 files changed, 48 insertions(+), 53 deletions(-)

-- 
1.8.3.1

