From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 19 Feb 2019 17:47:49 +0300
Subject: [LTP] [PATCH 0/4] network: new random message size test-cases
Message-ID: <1550587673-7995-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

New tests in the series with random message sizes: geneve02, gre02,
macsec03, vxlan04.

This patch-set also introduces "TST_NET_MAX_PKT" environment variable
to control the upper limit of the message payload size. By default it
is set to 1.1 * MTU (of the test interface).

Alexey Kodanev (4):
  network/gre01: move setup to library
  lib/tst_net.sh: add new TST_NET_MAX_PKT env variable
  network: use TST_NET_MAX_PKT
  network: add new test-cases with randomized message length

 runtest/net.features                            |    9 +
 runtest/net_stress.ipsec_dccp                   |  208 +++++++++++-----------
 runtest/net_stress.ipsec_sctp                   |  208 +++++++++++-----------
 runtest/net_stress.ipsec_tcp                    |  208 +++++++++++-----------
 runtest/net_stress.ipsec_udp                    |  212 +++++++++++-----------
 testcases/lib/tst_net.sh                        |   10 +-
 testcases/lib/tst_test.sh                       |    1 +
 testcases/network/mpls/mpls02.sh                |    2 +-
 testcases/network/mpls/mpls_lib.sh              |    2 +-
 testcases/network/sockets/bind_noport01.sh      |   15 ++-
 testcases/network/stress/dccp/dccp_ipsec.sh     |    6 +-
 testcases/network/stress/dccp/dccp_ipsec_vti.sh |    6 +-
 testcases/network/stress/sctp/sctp_ipsec.sh     |    6 +-
 testcases/network/stress/sctp/sctp_ipsec_vti.sh |    6 +-
 testcases/network/stress/tcp/tcp_ipsec.sh       |    6 +-
 testcases/network/stress/tcp/tcp_ipsec_vti.sh   |    6 +-
 testcases/network/stress/udp/udp_ipsec.sh       |    7 +-
 testcases/network/stress/udp/udp_ipsec_vti.sh   |    7 +-
 testcases/network/tcp_cc/tcp_cc_lib.sh          |    4 +-
 testcases/network/virt/geneve02.sh              |   38 ++++
 testcases/network/virt/gre01.sh                 |   19 +--
 testcases/network/virt/gre02.sh                 |   11 ++
 testcases/network/virt/macsec03.sh              |   13 ++
 testcases/network/virt/virt_lib.sh              |   27 +++-
 testcases/network/virt/vxlan04.sh               |   39 ++++
 25 files changed, 624 insertions(+), 452 deletions(-)
 create mode 100755 testcases/network/virt/geneve02.sh
 create mode 100755 testcases/network/virt/gre02.sh
 create mode 100755 testcases/network/virt/macsec03.sh
 create mode 100755 testcases/network/virt/vxlan04.sh

