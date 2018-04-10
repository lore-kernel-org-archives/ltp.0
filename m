From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 10 Apr 2018 14:21:49 +0300
Subject: [LTP] [RFC PATCH v6 0/7] Rewriting network tests into new shell
	API
In-Reply-To: <20180406123118.21309-1-pvorel@suse.cz>
References: <20180406123118.21309-1-pvorel@suse.cz>
Message-ID: <f7a1ec8a-471e-1dcd-83d7-e3df59d6c201@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 04/06/2018 03:31 PM, Petr Vorel wrote:
> Hi,
> 
> Hopefully last version.
> 
> I migrated only 10 scripts out of many (at least 89) using tst_net.sh or libraries using
> it (at least ipsec_lib.sh, tst_net_stress.sh), but the rest should be quite easy.
>> I spent some time with fixing dependencies for interface stress tests.
> I also fighted with getopts being passed to tst_net.sh and for other scripts
> I needed keep -6 for tst_net.sh, the rest is for scripts using
> tst_net.sh - tests themselves, "libraries" being called by scripts -
> tcp_fastopen_run.sh, vxlan03.sh and testscripts/network.sh).
> Sometimes tst_net.sh is loaded 3 times.

Hi Petr,

three times... does it happen after these patches?

It's sourced by the helper to export the environment variables and export
the variables that are not yet set, so once here.

And each of the tests sources it once as well...


> 
> For further development I'd like to move network setup from
> testscripts/network.sh to tst_net.sh to function tst_net_run(). This
> would allow to run tests with runltp (and keep our
> testscripts/network.sh helper). That would reduce one user of
> tst_net.sh.
> Another benefit I see to have unique way to run script (one day there
> might be runltp replaced by better implementation and I don't want
> network scripts to be missing it).
> 

This helper is really optional, I'm not quite follow you here, what
is the purpose of moving it's setup to tst_net_run()? The tests run
fine without the helper, and with runltp as well.

For netns and runltp, each test-case flushes interfaces and waits for
completion of DAD process, I think we could remove this latency by:

* checking that interface already has the needed configuration, no need
  to flush and re-add anything, check that there is no xfrm policy, etc.
* may be save temp configuration in a file on the first test-case run and
  source it for the next test-cases
* pass nodad when setting IPv6 addresses

Thanks,
Alexey

> You can test it with testscripts/network.sh, testing with netns doesn't require
> any additional setup. Examples:
> /opt/ltp/testscripts/network.sh -e
> /opt/ltp/testscripts/network.sh -6
> 
> Help:
> /opt/ltp/testscripts/network.sh -h
> 
> Changelog v5->v6:
> * Fix bashism in v5 when passing parameters to tst_net.sh.
>   https://lists.linux.it/pipermail/ltp/2018-April/007619.html
> * Fixed missing $ipver in multicast tests.
> * Fixed broken creating tmpdir on rhost in new API.
> 
> Changelog v4->v5:
> * Fix handling getopts parameters in scripts which are using legacy API
>   with getopts (ipsec_lib.sh, tcp_fastopen_run.sh, rpc_test.sh) by
>   shifting args after getopts and moving sourcing tst_net.sh after that.
>   Also -6 param for IPv6 must be passed to tst_net.sh (ipsec_lib.sh,
>   tcp_fastopen_run.sh).
> * Fixed iver for legacy scripts (caused some bugs at least in interfaces
>   tests).
> 
> Changes v3->v4:
> * Fixed bugs with setting TST_IPV6 and ipver variables. Now added into
>   setup function (for new API they must not be used in test scripts
>   outside setup/run/cleanup functions as they're not set).
> * New commit: 6/6 "network/interface: Split tests to test only one command per test"
>   A bit complicated than I thought (adding tst_test_cmds and using it
>   would be simpler), but I guess separation is better (as Cyril noted).
>   I needed to pass -c as getopts parameter.
> * Renamed functions in tst_net.sh (Alexey).
> * Fixed script name in Makefile, changed output of usage (Alexey).
> * Export TST_ID, LTPROOT and TST_DATAROOT also for TST_NO_DEFAULT_RUN
>   (Cyril).
> 
> Petr Vorel (7):
>   tst_net.sh: Support both new and legacy APIs + rename
>   tst_test.sh: Introduce TST_NO_DEFAULT_RUN
>   network.sh: Migrate to new shell API
>   network/interface: Cleanup if4-addr-change
>   network/if-updown: Restore IP in cleanup function
>   tst_net_stress.sh: Migrate with dependencies to new API + rename
>   network/interface: Split tests to test only one command per test
> 
>  runtest/net_stress.interface                       |  38 +++--
>  testcases/lib/{test_net.sh => tst_net.sh}          | 165 ++++++++++++++-------
>  testcases/lib/tst_test.sh                          |  91 ++++++------
>  testcases/network/README.md                        |   4 +-
>  testcases/network/busy_poll/busy_poll01.sh         |   3 +-
>  testcases/network/busy_poll/busy_poll02.sh         |   3 +-
>  testcases/network/busy_poll/busy_poll03.sh         |   3 +-
>  testcases/network/dccp/dccp01.sh                   |   3 +-
>  testcases/network/dctcp/dctcp01.sh                 |   3 +-
>  testcases/network/dhcp/dhcpd_tests.sh              |   3 +-
>  testcases/network/dhcp/dnsmasq_tests.sh            |   3 +-
>  testcases/network/iproute/ip_tests.sh              |   3 +-
>  testcases/network/multicast/mc_cmds/mc_cmds        |   3 +-
>  testcases/network/multicast/mc_commo/mc_commo      |   3 +-
>  testcases/network/multicast/mc_member/mc_member    |   3 +-
>  testcases/network/multicast/mc_opts/mc_opts        |   3 +-
>  testcases/network/nfs/fsx-linux/fsx.sh             |   3 +-
>  testcases/network/nfs/nfs_stress/nfs01             |   3 +-
>  testcases/network/nfs/nfs_stress/nfs02             |   3 +-
>  testcases/network/nfs/nfs_stress/nfs03             |   3 +-
>  testcases/network/nfs/nfs_stress/nfs04             |   3 +-
>  testcases/network/nfs/nfs_stress/nfs05             |   3 +-
>  testcases/network/nfs/nfs_stress/nfs06             |   3 +-
>  testcases/network/nfs/nfslock01/nfslock01          |   3 +-
>  testcases/network/nfs/nfsstat01/nfsstat01          |   3 +-
>  testcases/network/rpc/basic_tests/rpc01/rpc01      |   3 +-
>  .../network/rpc/basic_tests/rpcinfo/rpcinfo01      |   3 +-
>  testcases/network/rpc/basic_tests/rup/rup01        |   3 +-
>  testcases/network/rpc/basic_tests/rusers/rusers01  |   3 +-
>  testcases/network/rpc/rpc-tirpc/rpc_test.sh        |   4 +-
>  testcases/network/sctp/sctp01.sh                   |   3 +-
>  testcases/network/sockets/bind_noport01.sh         |   3 +-
>  .../network/stress/broken_ip/broken_ip4-checksum   |   3 +-
>  .../network/stress/broken_ip/broken_ip4-dstaddr    |   3 +-
>  .../network/stress/broken_ip/broken_ip4-fragment   |   3 +-
>  testcases/network/stress/broken_ip/broken_ip4-ihl  |   3 +-
>  .../network/stress/broken_ip/broken_ip4-protcol    |   3 +-
>  .../network/stress/broken_ip/broken_ip4-totlen     |   3 +-
>  .../network/stress/broken_ip/broken_ip4-version    |   3 +-
>  .../network/stress/broken_ip/broken_ip6-dstaddr    |   3 +-
>  .../network/stress/broken_ip/broken_ip6-nexthdr    |   3 +-
>  testcases/network/stress/broken_ip/broken_ip6-plen |   3 +-
>  .../network/stress/broken_ip/broken_ip6-version    |   3 +-
>  testcases/network/stress/dns/dns-stress            |   3 +-
>  testcases/network/stress/ftp/ftp-download-stress   |   3 +-
>  testcases/network/stress/ftp/ftp-upload-stress     |   3 +-
>  testcases/network/stress/http/http-stress          |   3 +-
>  testcases/network/stress/interface/if-addr-adddel  |  52 +++----
>  .../network/stress/interface/if-addr-addlarge      |  57 +++----
>  testcases/network/stress/interface/if-lib.sh       |  58 ++++++++
>  testcases/network/stress/interface/if-mtu-change   |  52 +++----
>  testcases/network/stress/interface/if-route-adddel |  55 +++----
>  .../network/stress/interface/if-route-addlarge     |  51 ++-----
>  testcases/network/stress/interface/if-updown       |  49 +++---
>  testcases/network/stress/interface/if4-addr-change |  71 ++++-----
>  testcases/network/stress/ipsec/ipsec_lib.sh        |   9 +-
>  .../grp-operation/mcast-group-multiple-socket      |  16 +-
>  .../multicast/grp-operation/mcast-group-same-group |  17 ++-
>  .../grp-operation/mcast-group-single-socket        |  17 ++-
>  .../grp-operation/mcast-group-source-filter        |  17 ++-
>  .../stress/multicast/grp-operation/mcast-lib.sh    |  29 ++--
>  testcases/network/stress/ns-tools/Makefile         |   2 +-
>  .../{test_net_stress.sh => tst_net_stress.sh}      |  32 ++--
>  testcases/network/stress/ssh/ssh-stress            |   3 +-
>  testcases/network/tcp_cmds/arping/arping01.sh      |   3 +-
>  .../network/tcp_cmds/clockdiff/clockdiff01.sh      |   3 +-
>  testcases/network/tcp_cmds/ipneigh/ipneigh01.sh    |   3 +-
>  testcases/network/tcp_cmds/ping/ping01.sh          |   3 +-
>  testcases/network/tcp_cmds/ping/ping02.sh          |   3 +-
>  testcases/network/tcp_cmds/rlogin/rlogin01         |   3 +-
>  testcases/network/tcp_cmds/sendfile/sendfile01     |   3 +-
>  testcases/network/tcp_cmds/tcpdump/tcpdump01       |   3 +-
>  testcases/network/tcp_cmds/telnet/telnet01         |   3 +-
>  .../network/tcp_cmds/tracepath/tracepath01.sh      |   3 +-
>  testcases/network/tcp_fastopen/tcp_fastopen_run.sh |  16 +-
>  testcases/network/traceroute/traceroute01.sh       |   3 +-
>  testcases/network/virt/geneve01.sh                 |   3 +-
>  testcases/network/virt/gre01.sh                    |   3 +-
>  testcases/network/virt/ipvlan01.sh                 |   3 +-
>  testcases/network/virt/macvlan01.sh                |   3 +-
>  testcases/network/virt/macvtap01.sh                |   3 +-
>  testcases/network/virt/vlan01.sh                   |   3 +-
>  testcases/network/virt/vlan02.sh                   |   3 +-
>  testcases/network/virt/vlan03.sh                   |   3 +-
>  testcases/network/virt/vxlan01.sh                  |   3 +-
>  testcases/network/virt/vxlan02.sh                  |   3 +-
>  testcases/network/virt/vxlan03.sh                  |   3 +-
>  testcases/network/xinetd/xinetd_tests.sh           |   3 +-
>  testscripts/network.sh                             |   7 +-
>  89 files changed, 627 insertions(+), 480 deletions(-)
>  rename testcases/lib/{test_net.sh => tst_net.sh} (85%)
>  create mode 100644 testcases/network/stress/interface/if-lib.sh
>  rename testcases/network/stress/ns-tools/{test_net_stress.sh => tst_net_stress.sh} (88%)
> 

