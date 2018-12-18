From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 Dec 2018 02:02:14 +0100
Subject: [LTP] [PATCH v3 0/6] DHCP tests and AppArmor/SELinux improvements
Message-ID: <20181218010220.2446-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

another version of DHCP tests and AppArmor/SELinux improvements.
Changes v2->v3:
* Remove TST_SECURITY_WARN and try to detect affected test
automatically via grepping current policy with $TST_NEEDS_CMDS. There is
still printed warning on enforced AppArmor/SELinux even no policy is
found. Suggested by Alexey Kodanev.
* Warning is printed only on TFAIL. Suggested by Alexey Kodanev.
* Root check in tst_test.sh is moved to _tst_require_root()
* Add dhcpd and dhclient path fixes.

Petr Vorel (6):
  net/dhcp: Rename setup & cleanup functions
  shell: Add tst_security.sh helper
  net/dhcp: Use for allowed by AppArmor and SELinux
  net/dhcp: Check also default dhclient lease file path
  net/dhcp: Move print_dhcp_log() into dhcp library
  ver_linux: Print AppArmor and SELinux status

 testcases/lib/tst_security.sh           | 124 ++++++++++++++++++++++++
 testcases/lib/tst_test.sh               |  17 +++-
 testcases/network/dhcp/dhcp_lib.sh      |  24 ++++-
 testcases/network/dhcp/dhcpd_tests.sh   |  19 ++--
 testcases/network/dhcp/dnsmasq_tests.sh |  17 ++--
 ver_linux                               |  46 ++++++++-
 6 files changed, 219 insertions(+), 28 deletions(-)
 create mode 100644 testcases/lib/tst_security.sh

-- 
2.19.2

