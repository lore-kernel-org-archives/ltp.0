From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Aug 2017 16:33:55 +0200
Subject: [LTP] [RFC PATCH 0/2] Simplify network setup: Add unused IP address
	helper functions + test_net_stress.sh
Message-ID: <20170817143357.17241-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

these are first two commits from v8 patch I prepare. I'd like just to discuss
things we've been discussing (hopefully to help smoother inclusion of v8 into
upstream).
Please see comments in commits.

Thanks for your time spent on reviewing!

Kind regards,
Petr


Petr Vorel (2):
  lib/test_net.sh: Add unused IP address helper functions
  network/stress: Add library test_net_stress.sh

 testcases/lib/test_net.sh                          |  78 +++++++++-
 testcases/network/stress/interface/if-addr-adddel  |  15 +-
 .../network/stress/interface/if-addr-addlarge      |  16 +-
 testcases/network/stress/interface/if-lib.sh       |  73 ---------
 testcases/network/stress/interface/if-mtu-change   |  23 +--
 testcases/network/stress/interface/if-route-adddel |  19 +--
 .../network/stress/interface/if-route-addlarge     |  15 +-
 testcases/network/stress/interface/if-updown       |   9 +-
 testcases/network/stress/interface/if4-addr-change |   4 +-
 testcases/network/stress/ns-tools/Makefile         |   2 +-
 .../network/stress/ns-tools/test_net_stress.sh     | 168 +++++++++++++++++++++
 11 files changed, 283 insertions(+), 139 deletions(-)
 delete mode 100644 testcases/network/stress/interface/if-lib.sh
 create mode 100644 testcases/network/stress/ns-tools/test_net_stress.sh

-- 
2.13.2

