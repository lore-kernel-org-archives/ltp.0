From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 16 Jun 2017 03:56:50 +0200
Subject: [LTP] [RFC PATCH v6 0/2] *** Rmmod causes failures of netns based
	tests ***
Message-ID: <20170616015652.11169-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

this patch tries to fix problems with dhcp based tests when they call TCONF:
/opt/ltp/testscripts/network.sh -6
dhcpd 1 TCONF: 'dhcpd' not found
...
cat: /sys/class/net/ltp_ns_veth2/address: No such file or directory

With this patchset:
/opt/ltp/testscripts/network.sh -6
dhcpd 1 TCONF: 'dhcpd' not found
...
ns_exec     0  TINFO  :  no namespace entries in /proc/2699/ns/

It doesn't help to kill also ns_exec. reset_ltp_netspace() is obviously wrong.
IMHO without trying to manually call reset_ltp_netspace() we should have better
detection of netns problems in init_ltp_netspace().


Kind regards,
Petr


Petr Vorel (2):
  lib/test_net.sh: reset_ltp_netspace()
  network/dhcp: Fix netns after removing kernel module

 testcases/lib/test_net.sh          | 10 +++++++++-
 testcases/network/dhcp/dhcp_lib.sh |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.12.2

