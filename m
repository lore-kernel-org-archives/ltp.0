From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  5 Apr 2018 02:06:38 +0200
Subject: [LTP] [RFC PATCH v4 0/6] Rewrite tests into new API + fixes
Message-ID: <20180405000644.18815-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Changes v3->v4:
* Fixed bugs with setting TST_IPV6 and ipver variables. Now added into
  setup function (for new API they must not be used in test scripts
  outside setup/run/cleanup functions as they're not set).
* New commit: 6/6 "network/interface: Split tests to test only one command per test"
  A bit complicated than I thought (adding tst_test_cmds and using it
  would be simpler), but I guess separation is better (as Cyril noted).
  I needed to pass -c as getopts parameter.
* Renamed functions in tst_net.sh (Alexey).
* Fixed script name in Makefile, changed output of usage (Alexey).
* Export TST_ID, LTPROOT and TST_DATAROOT also for TST_NO_DEFAULT_RUN
  (Cyril).

Kind regards,
Petr

Petr Vorel (6):
  tst_net.sh: Support both new and legacy APIs + rename
  tst_test.sh: Introduce TST_NO_DEFAULT_RUN
  network.sh: Migrate to new shell API
  network/interface: Cleanup if4-addr-change
  tst_net_stress.sh: Migrate with dependencies to new API + rename
  network/interface: Split tests to test only one command per test

 runtest/net_stress.interface                       |  38 ++++--
 testcases/lib/{test_net.sh => tst_net.sh}          | 147 ++++++++++++++-------
 testcases/lib/tst_test.sh                          |  91 +++++++------
 testcases/network/README.md                        |   4 +-
 testcases/network/busy_poll/busy_poll01.sh         |   3 +-
 testcases/network/busy_poll/busy_poll02.sh         |   3 +-
 testcases/network/busy_poll/busy_poll03.sh         |   3 +-
 testcases/network/dccp/dccp01.sh                   |   3 +-
 testcases/network/dctcp/dctcp01.sh                 |   3 +-
 testcases/network/dhcp/dhcpd_tests.sh              |   3 +-
 testcases/network/dhcp/dnsmasq_tests.sh            |   3 +-
 testcases/network/iproute/ip_tests.sh              |   3 +-
 testcases/network/multicast/mc_cmds/mc_cmds        |   3 +-
 testcases/network/multicast/mc_commo/mc_commo      |   3 +-
 testcases/network/multicast/mc_member/mc_member    |   3 +-
 testcases/network/multicast/mc_opts/mc_opts        |   3 +-
 testcases/network/nfs/fsx-linux/fsx.sh             |   3 +-
 testcases/network/nfs/nfs_stress/nfs01             |   3 +-
 testcases/network/nfs/nfs_stress/nfs02             |   3 +-
 testcases/network/nfs/nfs_stress/nfs03             |   3 +-
 testcases/network/nfs/nfs_stress/nfs04             |   3 +-
 testcases/network/nfs/nfs_stress/nfs05             |   3 +-
 testcases/network/nfs/nfs_stress/nfs06             |   3 +-
 testcases/network/nfs/nfslock01/nfslock01          |   3 +-
 testcases/network/nfs/nfsstat01/nfsstat01          |   3 +-
 testcases/network/rpc/basic_tests/rpc01/rpc01      |   3 +-
 .../network/rpc/basic_tests/rpcinfo/rpcinfo01      |   3 +-
 testcases/network/rpc/basic_tests/rup/rup01        |   3 +-
 testcases/network/rpc/basic_tests/rusers/rusers01  |   3 +-
 testcases/network/rpc/rpc-tirpc/rpc_test.sh        |   3 +-
 testcases/network/sctp/sctp01.sh                   |   3 +-
 testcases/network/sockets/bind_noport01.sh         |   3 +-
 .../network/stress/broken_ip/broken_ip4-checksum   |   3 +-
 .../network/stress/broken_ip/broken_ip4-dstaddr    |   3 +-
 .../network/stress/broken_ip/broken_ip4-fragment   |   3 +-
 testcases/network/stress/broken_ip/broken_ip4-ihl  |   3 +-
 .../network/stress/broken_ip/broken_ip4-protcol    |   3 +-
 .../network/stress/broken_ip/broken_ip4-totlen     |   3 +-
 .../network/stress/broken_ip/broken_ip4-version    |   3 +-
 .../network/stress/broken_ip/broken_ip6-dstaddr    |   3 +-
 .../network/stress/broken_ip/broken_ip6-nexthdr    |   3 +-
 testcases/network/stress/broken_ip/broken_ip6-plen |   3 +-
 .../network/stress/broken_ip/broken_ip6-version    |   3 +-
 testcases/network/stress/dns/dns-stress            |   3 +-
 testcases/network/stress/ftp/ftp-download-stress   |   3 +-
 testcases/network/stress/ftp/ftp-upload-stress     |   3 +-
 testcases/network/stress/http/http-stress          |   3 +-
 testcases/network/stress/interface/if-addr-adddel  |  53 +++-----
 .../network/stress/interface/if-addr-addlarge      |  58 +++-----
 testcases/network/stress/interface/if-lib.sh       |  50 +++++++
 testcases/network/stress/interface/if-mtu-change   |  49 +++----
 testcases/network/stress/interface/if-route-adddel |  56 +++-----
 .../network/stress/interface/if-route-addlarge     |  52 +++-----
 testcases/network/stress/interface/if-updown       |  49 +++----
 testcases/network/stress/interface/if4-addr-change |  71 +++++-----
 testcases/network/stress/ipsec/ipsec_lib.sh        |   3 +-
 .../grp-operation/mcast-group-multiple-socket      |  16 ++-
 .../multicast/grp-operation/mcast-group-same-group |  17 ++-
 .../grp-operation/mcast-group-single-socket        |  17 ++-
 .../grp-operation/mcast-group-source-filter        |  17 ++-
 .../stress/multicast/grp-operation/mcast-lib.sh    |  17 +--
 testcases/network/stress/ns-tools/Makefile         |   2 +-
 .../{test_net_stress.sh => tst_net_stress.sh}      |  32 +++--
 testcases/network/stress/ssh/ssh-stress            |   3 +-
 testcases/network/tcp_cmds/arping/arping01.sh      |   3 +-
 .../network/tcp_cmds/clockdiff/clockdiff01.sh      |   3 +-
 testcases/network/tcp_cmds/ipneigh/ipneigh01.sh    |   3 +-
 testcases/network/tcp_cmds/ping/ping01.sh          |   3 +-
 testcases/network/tcp_cmds/ping/ping02.sh          |   3 +-
 testcases/network/tcp_cmds/rlogin/rlogin01         |   3 +-
 testcases/network/tcp_cmds/sendfile/sendfile01     |   3 +-
 testcases/network/tcp_cmds/tcpdump/tcpdump01       |   3 +-
 testcases/network/tcp_cmds/telnet/telnet01         |   3 +-
 .../network/tcp_cmds/tracepath/tracepath01.sh      |   3 +-
 testcases/network/tcp_fastopen/tcp_fastopen_run.sh |   3 +-
 testcases/network/traceroute/traceroute01.sh       |   3 +-
 testcases/network/virt/geneve01.sh                 |   3 +-
 testcases/network/virt/gre01.sh                    |   3 +-
 testcases/network/virt/ipvlan01.sh                 |   3 +-
 testcases/network/virt/macvlan01.sh                |   3 +-
 testcases/network/virt/macvtap01.sh                |   3 +-
 testcases/network/virt/vlan01.sh                   |   3 +-
 testcases/network/virt/vlan02.sh                   |   3 +-
 testcases/network/virt/vlan03.sh                   |   3 +-
 testcases/network/virt/vxlan01.sh                  |   3 +-
 testcases/network/virt/vxlan02.sh                  |   3 +-
 testcases/network/virt/vxlan03.sh                  |   3 +-
 testcases/network/xinetd/xinetd_tests.sh           |   3 +-
 testscripts/network.sh                             |   7 +-
 89 files changed, 593 insertions(+), 457 deletions(-)
 rename testcases/lib/{test_net.sh => tst_net.sh} (86%)
 create mode 100644 testcases/network/stress/interface/if-lib.sh
 rename testcases/network/stress/ns-tools/{test_net_stress.sh => tst_net_stress.sh} (88%)

-- 
2.16.2

