From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  3 May 2017 18:07:48 +0200
Subject: [LTP] [RFC PATCH v5 0/3] Simplify network setup
Message-ID: <20170503160751.1634-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

another version of tst_net_vars network setup helper.
v4->v5:
* Clenup unneded variables (reverse IP related).
* Don't require to have mask in IP address. Use netlink to detect prefix when
  address is presented on some of the NIC on the system or fallback to default
  ones (24 for IPv4, 64 for IPv6).
* Fix detecting wrong subnet with network not round up by 8 (IPv4 resp 16
  (IPv6). E.g.: problem IP addressed like 10.2.0.1/22 10.2.1.1/22.
* Add more environment variables (e.g. prefix, whole IP address)
* Rewritten (again) unused network generation to fix overlap with used IP addresses.
* Simplify tst_ipaddr() (in testcases/lib/test_net.sh).
* Use tst_brk() to exit on error.
* Cleanup warnings and formatting.

There is still requirement network prefix to be < 8 (IPv4) resp. 16 (IPv6) as
then IPV{4,6}_NETWORK variables would be empty, which is not expected by tests
(they join it with address separators with {L,R}HOST_IPV{4,6}_HOST. Even we got
rid of reverse related variables we still need IPV{4,6}_NETWORK variables for
some tests.

BTW: I probably have source lines > 80 chars. My Vim doesn't highlight
anything, but checkpatch.pl complain. I might have wrong vim configuration.

Petr Vorel (3):
  gitignore: Prefixing filenames
  network: Add tool for setup IP variables
  network: Use tst_net_vars to set up IPv4 and IPv6 related variables

 testcases/lib/.gitignore     |  13 +-
 testcases/lib/Makefile       |   2 +-
 testcases/lib/test_net.sh    |  43 +--
 testcases/lib/tst_net_vars.c | 760 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 781 insertions(+), 37 deletions(-)
 create mode 100644 testcases/lib/tst_net_vars.c

-- 
2.12.2

