From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  3 Oct 2018 17:37:51 +0200
Subject: [LTP] [PATCH 0/5] Fixes for DHCP tests
Message-ID: <20181003153756.3825-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

while debugging a failure of DHCP tests on SUSE Linux Enterprise I did
some fixes and enhancements of these tests. I tested patchset on various
versions of Debian, SUSE and CentOS, using NetworkManager and Wicked.

Due different approach of using dhclient in these two network managers
and specific /sbin/dhclient-script for each distro it's quite pain to
have these tests working on all distros, so there might be more patches.

Kind regards,
Petr

Petr Vorel (5):
  net/dhcp: Add support for wicked
  net/dhcp: Disable DNS for dnsmasq
  net/dhcp: Print client and server versions
  net/dhcp: Pass lease file location to dhcpd via -lf
  net/dhcp: TBROK when dnsmasq does not start

 testcases/network/dhcp/dhcp_lib.sh      | 21 +++++++++++++++++++++
 testcases/network/dhcp/dhcpd_tests.sh   | 13 +++++++------
 testcases/network/dhcp/dnsmasq_tests.sh |  7 ++++++-
 3 files changed, 34 insertions(+), 7 deletions(-)

-- 
2.19.0

