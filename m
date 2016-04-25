From: Hangbin Liu <haliu@redhat.com>
Date: Mon, 25 Apr 2016 10:21:03 +0800
Subject: [LTP] [PATCH v6 0/3] networking/stress/icmp: add ip xfrm ipsec
	support
Message-ID: <1461550866-21003-1-git-send-email-haliu@redhat.com>
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

Change from V5:
1. remove useless description
2. use same command substitution syntax in script
3. set TFAIL in the end

Hangbin Liu (3):
  lib/test_net.sh: add tst_ping() to check icmp connectivity
  network/stress: add ipsec lib
  network/stress/icmp: add icmp-uni-basic to implement all icmp basic
    stress test

 runtest/network_stress.icmp                  |  46 +++++++----
 testcases/lib/test_net.sh                    |  30 ++++++++
 testcases/network/stress/icmp/Makefile       |   3 +
 testcases/network/stress/icmp/icmp-uni-basic |  91 ++++++++++++++++++++++
 testcases/network/stress/ipsec/Makefile      |  28 +++++++
 testcases/network/stress/ipsec/ipsec_lib.sh  | 110 +++++++++++++++++++++++++++
 6 files changed, 294 insertions(+), 14 deletions(-)
 create mode 100755 testcases/network/stress/icmp/icmp-uni-basic
 create mode 100644 testcases/network/stress/ipsec/Makefile
 create mode 100644 testcases/network/stress/ipsec/ipsec_lib.sh

-- 
2.5.0

