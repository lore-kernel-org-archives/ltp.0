From: Hangbin Liu <haliu@redhat.com>
Date: Tue, 15 Mar 2016 17:50:36 +0800
Subject: [LTP]  [PATCHv2 0/3] networking/stress: add ip xfrm ipsec support
Message-ID: <1458035439-9143-1-git-send-email-haliu@redhat.com>
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

 testcases/lib/test_net.sh                          |  21 ++++
 .../stress/icmp/uni-basic/icmp4-uni-basic01        |  96 +++++-----------
 testcases/network/stress/ipsec/Makefile            |  29 +++++
 testcases/network/stress/ipsec/ipsec_lib.sh        | 126 +++++++++++++++++++++
 4 files changed, 207 insertions(+), 65 deletions(-)
 create mode 100644 testcases/network/stress/ipsec/Makefile
 create mode 100644 testcases/network/stress/ipsec/ipsec_lib.sh

-- 
2.5.0

