From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  7 May 2018 21:32:33 +0200
Subject: [LTP] [RFC PATCH 0/1] Yet another fixes for network
Message-ID: <20180507193234.6810-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

My commit 89a83d8a0 ("net/ipsec_lib.sh: Process getopts parameters with
TST_OPTS and TST_PARSE_ARGS") broke parsing -s parameter ("array"
separated by space).

This patch fixes it by changing separator to ':'.
Other solution is just to revert it, not to block the release.

The same problem is with runtest/net.nfs, that's why we shouldn't
apply Xiao's patch [1] until we solve this.

To allow properly parse quoted parameters in the new API we'd have to
avoid shifting parameters before tst_run, but I haven't found a
solution.  I suppose, we are not going to change the way how getopts are
handled in the new API anyway, so we should document this feature in
doc/test-writing-guidelines.txt.

I apologize for complicating release by "last minute changes".


Kind regards,
Petr

[1] https://lists.linux.it/pipermail/ltp/2018-May/008021.html

Petr Vorel (1):
  net/ipsec: Fix getopts parsing -s parameter

 runtest/net_stress.ipsec_dccp               | 212 ++++++++++++++--------------
 runtest/net_stress.ipsec_icmp               | 168 +++++++++++-----------
 runtest/net_stress.ipsec_sctp               | 212 ++++++++++++++--------------
 runtest/net_stress.ipsec_tcp                | 212 ++++++++++++++--------------
 runtest/net_stress.ipsec_udp                | 208 +++++++++++++--------------
 testcases/network/stress/ipsec/ipsec_lib.sh |  12 +-
 6 files changed, 516 insertions(+), 508 deletions(-)

-- 
2.16.3

