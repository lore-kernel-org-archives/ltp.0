From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Jul 2021 16:07:14 +0200
Subject: [LTP] [PATCH 0/2] Add TST_NET_IPV{4,6}_ONLY and use on broken_ip
Message-ID: <20210714140716.1568-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

https://github.com/linux-test-project/ltp/issues/843

does it make sense to run it on IPv4 and broken_ip-totlen on IPv6?
Both don't break but not in runtest file.

Kind regards,
Petr

Petr Vorel (2):
  tst_net.sh: Add variable for supported protocol
  broken_ip: TCONF when test run on unsupported protocol

 testcases/lib/tst_net.sh                              | 8 ++++++++
 testcases/lib/tst_test.sh                             | 2 +-
 testcases/network/stress/broken_ip/broken_ip-checksum | 3 ++-
 testcases/network/stress/broken_ip/broken_ip-fragment | 3 ++-
 testcases/network/stress/broken_ip/broken_ip-ihl      | 3 ++-
 testcases/network/stress/broken_ip/broken_ip-nexthdr  | 3 ++-
 testcases/network/stress/broken_ip/broken_ip-protcol  | 3 ++-
 7 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.32.0

