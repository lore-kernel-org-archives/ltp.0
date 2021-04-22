From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 22 Apr 2021 16:16:27 +0300
Subject: [LTP] [PATCH 0/3] network/virt: new FOU and GUE tests
Message-ID: <20210422131630.28565-1-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The first patch adds IPv6 flag '-6' to the library, which
will be used by the two new tests in this patch series too.

The rest are adding two similar tests for UDP tunneling.

Alexey Kodanev (3):
  lib/tst_test.sh: add TST_IPV6_FLAG ('-6')
  network/virt: new test for generic udp encapsulation (gue)
  network/virt: new foo over udp (fou) tunneling test

 runtest/net.features                        |  6 +++
 testcases/lib/tst_net.sh                    |  4 +-
 testcases/lib/tst_test.sh                   |  2 +-
 testcases/network/stress/route/route-lib.sh | 15 +++----
 testcases/network/virt/fou01.sh             | 48 +++++++++++++++++++++
 testcases/network/virt/gue01.sh             | 45 +++++++++++++++++++
 testcases/network/virt/virt_lib.sh          | 24 ++++++++++-
 7 files changed, 132 insertions(+), 12 deletions(-)
 create mode 100755 testcases/network/virt/fou01.sh
 create mode 100755 testcases/network/virt/gue01.sh

-- 
2.25.1

