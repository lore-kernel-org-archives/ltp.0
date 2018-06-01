From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  1 Jun 2018 13:49:49 +0200
Subject: [LTP] [PATCH 0/7] TST_IPVER
Message-ID: <20180601114956.17265-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

this is a better implementation of part of
"tst_net.sh: Simplify ipver settings code" part of patch-set posted in [1]


Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2018-May/008240.html

Petr Vorel (7):
  tst_net.sh: Simplify ipver settings code
  tst_net.sh: Rename ipver to TST_IPVER
  net/dns: Replace $ipver by $TST_IPVER from tst_net.sh
  net/ftp: Replace $ipver by $TST_IPVER from tst_net.sh
  net/http: Replace $ipver by $TST_IPVER from tst_net.sh
  net/ssh: Replace $ipver by $TST_IPVER from tst_net.sh
  net/virt: Replace $ipver by $TST_IPVER from tst_net.sh

 testcases/lib/tst_net.sh                                   |  5 ++---
 testcases/lib/tst_test.sh                                  |  2 +-
 testcases/network/stress/dns/dns-stress                    | 12 +++++-------
 testcases/network/stress/ftp/ftp-download-stress           |  3 +--
 testcases/network/stress/ftp/ftp-upload-stress             |  3 +--
 testcases/network/stress/http/http-stress                  |  3 +--
 testcases/network/stress/interface/if-addr-adddel          |  2 +-
 testcases/network/stress/interface/if-addr-addlarge        |  2 +-
 testcases/network/stress/interface/if-route-addlarge       |  2 +-
 .../multicast/grp-operation/mcast-group-multiple-socket    |  2 +-
 .../stress/multicast/grp-operation/mcast-group-same-group  |  2 +-
 .../multicast/grp-operation/mcast-group-single-socket      |  2 +-
 .../multicast/grp-operation/mcast-group-source-filter      |  2 +-
 .../network/stress/multicast/grp-operation/mcast-lib.sh    |  2 +-
 testcases/network/stress/ns-tools/tst_net_stress.sh        |  2 +-
 testcases/network/stress/ssh/ssh-stress                    | 14 ++++++--------
 testcases/network/virt/virt_lib.sh                         |  6 ++----
 17 files changed, 28 insertions(+), 38 deletions(-)

-- 
2.16.3

