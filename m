From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 30 Mar 2018 01:31:31 +0200
Subject: [LTP] [RFC PATCH v2 0/3] Rewritting network tests into new shell API
Message-ID: <20180329233134.24151-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v1->v2:
* Make new API default for test_net.sh
* Rename variable TST_USE_NEW_API => TST_USE_LEGACY_API
* Set TST_USE_LEGACY_API=1 in majority of network scripts.

NOTE: still kept the old script names.

I'm not happy with the state of testscripts/network.sh. I kept it using
the legacy API. I tried to migrate it into new API, but that would
require too much changes (and I don't like to have tst_run call in
testscripts/network.sh).

Kind regards,
Petr

Petr Vorel (3):
  test_net.sh: Support both old and new shell APIs
  network/interface: Cleanup if4-addr-change
  net: Migrate test_net_stress.sh and it's dependencies to new shell API

 testcases/lib/test_net.sh                          | 133 +++++++++++++--------
 testcases/lib/tst_test.sh                          |   1 +
 testcases/network/busy_poll/busy_poll01.sh         |   1 +
 testcases/network/busy_poll/busy_poll02.sh         |   1 +
 testcases/network/busy_poll/busy_poll03.sh         |   1 +
 testcases/network/dccp/dccp01.sh                   |   1 +
 testcases/network/dctcp/dctcp01.sh                 |   1 +
 testcases/network/dhcp/dhcpd_tests.sh              |   1 +
 testcases/network/dhcp/dnsmasq_tests.sh            |   1 +
 testcases/network/iproute/ip_tests.sh              |   1 +
 testcases/network/multicast/mc_cmds/mc_cmds        |   1 +
 testcases/network/multicast/mc_commo/mc_commo      |   1 +
 testcases/network/multicast/mc_member/mc_member    |   1 +
 testcases/network/multicast/mc_opts/mc_opts        |   1 +
 testcases/network/nfs/fsx-linux/fsx.sh             |   1 +
 testcases/network/nfs/nfs_stress/nfs01             |   1 +
 testcases/network/nfs/nfs_stress/nfs02             |   1 +
 testcases/network/nfs/nfs_stress/nfs03             |   1 +
 testcases/network/nfs/nfs_stress/nfs04             |   1 +
 testcases/network/nfs/nfs_stress/nfs05             |   1 +
 testcases/network/nfs/nfs_stress/nfs06             |   1 +
 testcases/network/nfs/nfslock01/nfslock01          |   1 +
 testcases/network/nfs/nfsstat01/nfsstat01          |   1 +
 testcases/network/rpc/basic_tests/rpc01/rpc01      |   1 +
 .../network/rpc/basic_tests/rpcinfo/rpcinfo01      |   1 +
 testcases/network/rpc/basic_tests/rup/rup01        |   1 +
 testcases/network/rpc/basic_tests/rusers/rusers01  |   1 +
 testcases/network/rpc/rpc-tirpc/rpc_test.sh        |   1 +
 testcases/network/sctp/sctp01.sh                   |   1 +
 testcases/network/sockets/bind_noport01.sh         |   1 +
 .../network/stress/broken_ip/broken_ip4-checksum   |   1 +
 .../network/stress/broken_ip/broken_ip4-dstaddr    |   1 +
 .../network/stress/broken_ip/broken_ip4-fragment   |   1 +
 testcases/network/stress/broken_ip/broken_ip4-ihl  |   1 +
 .../network/stress/broken_ip/broken_ip4-protcol    |   1 +
 .../network/stress/broken_ip/broken_ip4-totlen     |   1 +
 .../network/stress/broken_ip/broken_ip4-version    |   1 +
 .../network/stress/broken_ip/broken_ip6-dstaddr    |   1 +
 .../network/stress/broken_ip/broken_ip6-nexthdr    |   1 +
 testcases/network/stress/broken_ip/broken_ip6-plen |   1 +
 .../network/stress/broken_ip/broken_ip6-version    |   1 +
 testcases/network/stress/dns/dns-stress            |   1 +
 testcases/network/stress/ftp/ftp-download-stress   |   1 +
 testcases/network/stress/ftp/ftp-upload-stress     |   1 +
 testcases/network/stress/http/http-stress          |   1 +
 testcases/network/stress/interface/if-addr-adddel  |  31 ++---
 .../network/stress/interface/if-addr-addlarge      |  37 +++---
 testcases/network/stress/interface/if-mtu-change   |  24 ++--
 testcases/network/stress/interface/if-route-adddel |  26 ++--
 .../network/stress/interface/if-route-addlarge     |  28 ++---
 testcases/network/stress/interface/if-updown       |  27 ++---
 testcases/network/stress/interface/if4-addr-change |  74 +++++++-----
 testcases/network/stress/ipsec/ipsec_lib.sh        |   1 +
 .../grp-operation/mcast-group-multiple-socket      |  16 +--
 .../multicast/grp-operation/mcast-group-same-group |  17 ++-
 .../grp-operation/mcast-group-single-socket        |  17 ++-
 .../grp-operation/mcast-group-source-filter        |  17 ++-
 .../stress/multicast/grp-operation/mcast-lib.sh    |  15 +--
 .../network/stress/ns-tools/test_net_stress.sh     |  24 +++-
 testcases/network/stress/ssh/ssh-stress            |   1 +
 testcases/network/tcp_cmds/arping/arping01.sh      |   1 +
 .../network/tcp_cmds/clockdiff/clockdiff01.sh      |   1 +
 testcases/network/tcp_cmds/ipneigh/ipneigh01.sh    |   1 +
 testcases/network/tcp_cmds/ping/ping01.sh          |   1 +
 testcases/network/tcp_cmds/ping/ping02.sh          |   1 +
 testcases/network/tcp_cmds/rlogin/rlogin01         |   1 +
 testcases/network/tcp_cmds/sendfile/sendfile01     |   1 +
 testcases/network/tcp_cmds/tcpdump/tcpdump01       |   1 +
 testcases/network/tcp_cmds/telnet/telnet01         |   1 +
 .../network/tcp_cmds/tracepath/tracepath01.sh      |   1 +
 testcases/network/tcp_fastopen/tcp_fastopen_run.sh |   1 +
 testcases/network/traceroute/traceroute01.sh       |   1 +
 testcases/network/virt/geneve01.sh                 |   1 +
 testcases/network/virt/gre01.sh                    |   1 +
 testcases/network/virt/ipvlan01.sh                 |   1 +
 testcases/network/virt/macvlan01.sh                |   1 +
 testcases/network/virt/macvtap01.sh                |   1 +
 testcases/network/virt/vlan01.sh                   |   1 +
 testcases/network/virt/vlan02.sh                   |   1 +
 testcases/network/virt/vlan03.sh                   |   1 +
 testcases/network/virt/vxlan01.sh                  |   1 +
 testcases/network/virt/vxlan02.sh                  |   1 +
 testcases/network/virt/vxlan03.sh                  |   1 +
 testcases/network/xinetd/xinetd_tests.sh           |   1 +
 testscripts/network.sh                             |   4 +-
 85 files changed, 340 insertions(+), 220 deletions(-)

-- 
2.16.3

