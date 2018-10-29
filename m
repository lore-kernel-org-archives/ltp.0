From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 29 Oct 2018 16:03:16 +0300
Subject: [LTP] [PATCH 0/6] network: new tests for mpls over gre, gre6 and sit
Message-ID: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Before using sit tunnels with MPLS, add stand-alone sit01 test.
It is done by the first two patches.

The rest of the patches add various MPLS tests:
 * mpls01: functional test, creates/removes MPLS routes,
   checks sysctl parameters.
 * mpls02: MPLS over the default test network configuration
 * mpls03/mpls04: MPLS over GRE and SIT.

Alexey Kodanev (6):
  network/virt: add support for sit tunnel
  network/sit01: new test for sit tunnel
  network/mpls01: new test for mpls labels
  network/mpls02: new test with lwtunnel
  network/mpls03: add MPLS over GRE and GREv6
  network/mpls04: new test with mpls over sit tunnel

 runtest/net.features               |   10 ++++
 testcases/network/mpls/Makefile    |   10 ++++
 testcases/network/mpls/mpls01.sh   |   70 ++++++++++++++++++++++++
 testcases/network/mpls/mpls02.sh   |   53 ++++++++++++++++++
 testcases/network/mpls/mpls03.sh   |   24 ++++++++
 testcases/network/mpls/mpls04.sh   |   19 +++++++
 testcases/network/mpls/mpls_lib.sh |  105 ++++++++++++++++++++++++++++++++++++
 testcases/network/virt/sit01.sh    |   23 ++++++++
 testcases/network/virt/virt_lib.sh |    8 +++-
 9 files changed, 321 insertions(+), 1 deletions(-)
 create mode 100644 testcases/network/mpls/Makefile
 create mode 100755 testcases/network/mpls/mpls01.sh
 create mode 100755 testcases/network/mpls/mpls02.sh
 create mode 100755 testcases/network/mpls/mpls03.sh
 create mode 100755 testcases/network/mpls/mpls04.sh
 create mode 100755 testcases/network/mpls/mpls_lib.sh
 create mode 100755 testcases/network/virt/sit01.sh

