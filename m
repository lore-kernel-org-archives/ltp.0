From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 24 May 2017 11:40:26 +0300
Subject: [LTP] [PATCH 0/4] lib/shell: run commands with 'timeout'
Message-ID: <1495615230-29045-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The first three patches remove usage of shell functions with
'ROD' based functions and the last one adds 'timeout' command
to the both shell libraries.

Alexey Kodanev (4):
  lib/test_net: print TPASS/TFAIL inside tst_ping()
  net: remove EXPECT_PASS usage with tst_ping()
  net/virt_lib.sh: don't use ROD_SILENT with shell function
  lib/test: run ROD_BASE() & tst_rod() with 'timeout' cmd

 testcases/lib/test.sh                              |    7 +++++--
 testcases/lib/test_net.sh                          |    4 ++--
 testcases/lib/tst_test.sh                          |   11 +++++++----
 .../network/stress/broken_ip/broken_ip4-checksum   |    2 +-
 .../network/stress/broken_ip/broken_ip4-dstaddr    |    2 +-
 .../network/stress/broken_ip/broken_ip4-fragment   |    2 +-
 testcases/network/stress/broken_ip/broken_ip4-ihl  |    2 +-
 .../network/stress/broken_ip/broken_ip4-protcol    |    2 +-
 .../network/stress/broken_ip/broken_ip4-totlen     |    2 +-
 .../network/stress/broken_ip/broken_ip4-version    |    2 +-
 .../network/stress/broken_ip/broken_ip6-dstaddr    |    2 +-
 .../network/stress/broken_ip/broken_ip6-nexthdr    |    2 +-
 testcases/network/stress/broken_ip/broken_ip6-plen |    2 +-
 .../network/stress/broken_ip/broken_ip6-version    |    2 +-
 testcases/network/stress/icmp/icmp-uni-basic.sh    |    5 -----
 testcases/network/stress/icmp/icmp-uni-vti.sh      |    2 +-
 testcases/network/stress/interface/if-lib.sh       |    7 +------
 testcases/network/stress/interface/if-mtu-change   |    2 +-
 testcases/network/stress/interface/if4-addr-change |    4 ++--
 testcases/network/virt/virt_lib.sh                 |    9 ++++++---
 20 files changed, 36 insertions(+), 37 deletions(-)

