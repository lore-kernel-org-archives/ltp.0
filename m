From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Mar 2018 17:45:34 +0200
Subject: [LTP] [RFC PATCH 0/3] Rewritting network tests into new shell API
Message-ID: <20180329154537.32711-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I'd like to test_net.sh using new shell API, it's useful from several
perspectives, but it's a huge task:

$ git grep -l -e '\. test_net.sh' -e '\. test_net_stress.sh' |wc -l
79

So I decided to extend test_net.sh to support and rewrite into new API
tests which uses test_net_stress.sh (all stress/interface tests and part
of stress/multicast tests).
test_net.sh got cluttered by it, but hope not for long time.

Comments are welcome.

Kind regards,
Petr


Petr Vorel (3):
  test_net.sh: Support both old and new shell APIs
  network/interface: Cleanup if4-addr-change
  net: Migrate test_net_stress.sh and it's dependencies to new shell API

 testcases/lib/test_net.sh                          | 126 +++++++++++++--------
 testcases/lib/tst_test.sh                          |   1 +
 testcases/network/stress/interface/if-addr-adddel  |  31 +++--
 .../network/stress/interface/if-addr-addlarge      |  37 +++---
 testcases/network/stress/interface/if-mtu-change   |  24 ++--
 testcases/network/stress/interface/if-route-adddel |  26 ++---
 .../network/stress/interface/if-route-addlarge     |  28 ++---
 testcases/network/stress/interface/if-updown       |  27 ++---
 testcases/network/stress/interface/if4-addr-change |  75 ++++++------
 .../grp-operation/mcast-group-multiple-socket      |  16 +--
 .../multicast/grp-operation/mcast-group-same-group |  17 ++-
 .../grp-operation/mcast-group-single-socket        |  17 ++-
 .../grp-operation/mcast-group-source-filter        |  17 ++-
 .../stress/multicast/grp-operation/mcast-lib.sh    |  15 +--
 .../network/stress/ns-tools/test_net_stress.sh     |  19 +++-
 15 files changed, 263 insertions(+), 213 deletions(-)

-- 
2.16.2

