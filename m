From: Hangbin Liu <haliu@redhat.com>
Date: Thu, 17 Mar 2016 18:04:13 +0800
Subject: [LTP]  [PATCHv3 0/3] networking/stress: add ip xfrm ipsec support
Message-ID: <1458209056-18829-1-git-send-email-haliu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

As we know, most of the network stress tests have IPsec testing, and we use
setkey for configuration. But setkey[1] hasn't updated for a long time. And
some distros, RHEL7 for example, even don't have ipset-tools package. On
other hand, iproute2 is recommend for network configuration. And ip xfrm is
more powerful than setkey. So let's use ip xfrm for ipsec testing.

[1] http://ipsec-tools.sourceforge.net/

Change from V2:
1. remove c2x and use hexdump directly.
2. remove indent after "case".
3. remove useless export and old scripts like check_env.
4. remove tst_init_iface.
5. remove return value check after setup ipsec env.
6. remove addr config as Alexey said, we assume the address already added.

Change from V1:
1. update tst_ping() to use default iface and addr. make ping from local side.
2. remove unused variables. add -s option when use tst_rhost_run. Use ROD
   before normal commands.
3. change all "tst_resm TBROK && exit" to "tst_brkm TBROK"
3. still keep tst_init_iface in test icmp4-uni-basic01 because we will
   set_ipv4/6addr each time.

Hangbin Liu (3):
  lib/test_net.sh: add tst_ping() to check icmp connectivity
  network/stress: add ipsec lib
  network/stress/icmp: use ip xfrm for icmp4-uni-basic01 ipsec testing

 testcases/lib/test_net.sh                          |  19 +++
 .../stress/icmp/uni-basic/icmp4-uni-basic01        | 160 ++++-----------------
 testcases/network/stress/ipsec/Makefile            |  29 ++++
 testcases/network/stress/ipsec/ipsec_lib.sh        | 111 ++++++++++++++
 4 files changed, 183 insertions(+), 136 deletions(-)
 create mode 100644 testcases/network/stress/ipsec/Makefile
 create mode 100644 testcases/network/stress/ipsec/ipsec_lib.sh

-- 
2.5.0

