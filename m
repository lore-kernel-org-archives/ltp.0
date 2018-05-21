From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 21 May 2018 14:48:24 +0300
Subject: [LTP] [PATCH 0/6] network/tcp_cc: add new tests bbr01 and bbr02
Message-ID: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The patches are adding two new tests for BBR congestion control
algorithm.

* bbr01 test is a simple one and similar to dctcp01 but not using
  ECN when emulating packet loss.

* bbr02 test, in addition to packet loss emulation with ECN, is using
  delay, reorder and corrupt features of 'tc'. And also iterates the
  different queueing disciplines.

The last test, I guess, should use TST_TEST_DATA for passing queueing
disciplines.

Alexey Kodanev (6):
  network: rename dcctp dir to tcp_cc
  dctcp01: convert to new API and move common code to a library
  network/tcp_cc/dctcp01: increase packet loss for dctcp
  network/tcp_cc/lib: add a function to set qdisc and txqueuelen
  network/tcp_cc: add new test bbr01
  network/tcp_cc: add new test bbr02

 runtest/net.features                   |    5 ++
 testcases/network/dctcp/Makefile       |   22 --------
 testcases/network/dctcp/dctcp01.sh     |   91 --------------------------------
 testcases/network/tcp_cc/Makefile      |   22 ++++++++
 testcases/network/tcp_cc/bbr01.sh      |   32 +++++++++++
 testcases/network/tcp_cc/bbr02.sh      |   45 ++++++++++++++++
 testcases/network/tcp_cc/dctcp01.sh    |   38 +++++++++++++
 testcases/network/tcp_cc/tcp_cc_lib.sh |   91 ++++++++++++++++++++++++++++++++
 8 files changed, 233 insertions(+), 113 deletions(-)
 delete mode 100644 testcases/network/dctcp/Makefile
 delete mode 100755 testcases/network/dctcp/dctcp01.sh
 create mode 100644 testcases/network/tcp_cc/Makefile
 create mode 100755 testcases/network/tcp_cc/bbr01.sh
 create mode 100755 testcases/network/tcp_cc/bbr02.sh
 create mode 100755 testcases/network/tcp_cc/dctcp01.sh
 create mode 100755 testcases/network/tcp_cc/tcp_cc_lib.sh

