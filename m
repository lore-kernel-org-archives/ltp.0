From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 16 Nov 2020 13:46:08 +0100
Subject: [LTP] [PATCH 0/3] Convert network stress tests to tst_net.sh
Message-ID: <20201116124611.16919-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

this patch series converts (all?) remeianing tests in network/stress to
use tst_net.sh

J?rg

 .../stress/multicast/packet-flood/mcast4-pktfld01  | 114 +++----------
 .../stress/multicast/packet-flood/mcast4-pktfld02  | 116 +++----------
 .../stress/multicast/packet-flood/mcast6-pktfld01  | 112 +++----------
 .../stress/multicast/packet-flood/mcast6-pktfld02  | 114 +++----------
 .../stress/multicast/query-flood/mcast4-queryfld01 | 153 +++++------------
 .../stress/multicast/query-flood/mcast4-queryfld02 | 145 ++++-------------
 .../stress/multicast/query-flood/mcast4-queryfld03 | 142 ++++------------
 .../stress/multicast/query-flood/mcast4-queryfld04 | 148 ++++-------------
 .../stress/multicast/query-flood/mcast4-queryfld05 | 181 +++++++--------------
 .../stress/multicast/query-flood/mcast4-queryfld06 | 166 ++++++-------------
 .../stress/multicast/query-flood/mcast6-queryfld01 | 144 ++++------------
 .../stress/multicast/query-flood/mcast6-queryfld02 | 140 ++++------------
 .../stress/multicast/query-flood/mcast6-queryfld03 | 144 +++++-----------
 .../stress/multicast/query-flood/mcast6-queryfld04 | 147 +++++------------
 .../stress/multicast/query-flood/mcast6-queryfld05 | 180 +++++++-------------
 .../stress/multicast/query-flood/mcast6-queryfld06 | 177 ++++++--------------
 testcases/network/stress/route/route4-redirect     | 155 +++++-------------
 testcases/network/stress/route/route6-redirect     | 143 ++++------------
 18 files changed, 662 insertions(+), 1959 deletions(-)

