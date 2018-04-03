From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  3 Apr 2018 17:47:12 +0200
Subject: [LTP] [RFC PATCH v3 0/5] Rewriting network tests into new shell API
Message-ID: <20180403154717.22491-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v2->v3:
* Place underscore in the end of a function names in tst_test.sh (requested by Alexey).
* Two new commits (second depend on previous):
  tst_test.sh: Introduce TST_NO_DEFAULT_RUN
  network.sh: Migrate to new shell API
* Rename files (test_net.sh => tst_net.sh, test_net_stress.sh => tst_net_stress.sh)

Using TST_NO_DEFAULT_RUN was indeed the easiest solution to migrate
network.sh script. Now it should be possible to migrate the rest of
network tests into new API, they will not be blocker for deleting the
old API. Commits are bisectable (no break introduced).

Although I tested LTP over netns and SSH (RSH not tested as it's
deprecated) on both these few using new API (net_stress.interface and
net_stress.multicast runtests) and some of these using legacy API,
testing and comments are much appreciated.

Kind regards,
Petr

Petr Vorel (5):
  tst_net.sh: Support both old and new shell APIs + rename it
  tst_test.sh: Introduce TST_NO_DEFAULT_RUN
  network.sh: Migrate to new shell API
  network/interface: Cleanup if4-addr-change
  net: Migrate test_net_stress.sh and it's dependencies to new shell API

 testcases/lib/{test_net.sh => tst_net.sh}          | 135 +++++++++++++--------
 testcases/lib/tst_test.sh                          | 101 +++++++--------
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
 testcases/network/stress/interface/if-addr-adddel  |  33 +++--
 .../network/stress/interface/if-addr-addlarge      |  39 +++---
 testcases/network/stress/interface/if-mtu-change   |  26 ++--
 testcases/network/stress/interface/if-route-adddel |  29 ++---
 .../network/stress/interface/if-route-addlarge     |  31 ++---
 testcases/network/stress/interface/if-updown       |  29 ++---
 testcases/network/stress/interface/if4-addr-change |  76 +++++++-----
 testcases/network/stress/ipsec/ipsec_lib.sh        |   3 +-
 .../grp-operation/mcast-group-multiple-socket      |  16 +--
 .../multicast/grp-operation/mcast-group-same-group |  17 ++-
 .../grp-operation/mcast-group-single-socket        |  17 ++-
 .../grp-operation/mcast-group-source-filter        |  17 ++-
 .../stress/multicast/grp-operation/mcast-lib.sh    |  17 +--
 .../{test_net_stress.sh => tst_net_stress.sh}      |  28 ++++-
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
 testscripts/network.sh                             |   6 +-
 86 files changed, 476 insertions(+), 352 deletions(-)
 rename testcases/lib/{test_net.sh => tst_net.sh} (87%)
 rename testcases/network/stress/ns-tools/{test_net_stress.sh => tst_net_stress.sh} (88%)

-- 
2.16.2

