From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Jul 2020 19:20:37 +0200
Subject: [LTP] [PATCH v2 0/7] tst_net.sh: Remove rsh,
 update docs add debug & test
Message-ID: <20200710172044.21592-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey, Xiao,

changes v1->v2:
* Add new commit "net: Remove rsh, rcp, rlogin tests"
* Use TST_NET_RHOST_RUN_DEBUG=1 instead of -d in tst_rhost_run

I wonder if we want to drop more TCP tests
(testcases/network/tcp_cmds/). Maybe:

* drop arping and clockdiff (they're legacy + IMHO they should be tested in inputils package)
* drop arp from ipneigh01.sh (keep only ip neigh)
* drop netstat (legacy, from net-tools) should be replaced with ss (iproute2)
* also ftp01.sh has non-trivial setup, but maybe there is a benefit in this smoke test
* how about telnet01.sh and host01.sh?

If we keep them I'd suggest (apart from porting to the new API) also use
different variable than RHOST for tests in testcases/network/tcp_cmds/
(ftp01.sh, host01.sh, telnet01.sh) to avoid having the same variable for
2 purposes, it's already used in two host configuration - now only ssh.

Other thing is the docs, we have setup in INSTALL,
testcases/network/README.md, than specific setup in
testcases/network/tcp_cmds/README, testcases/network/stress/README and
other various places. I'd prefer to have some cleanup, but first we
should decide which tests are worth to keep.

Kind regards,
Petr

Petr Vorel (7):
  tst_net.sh: Remove rsh support
  tst_net.sh: Use ssh in LTP_RSH
  net: Remove rsh, rcp, rlogin tests
  net: Update README.md
  tst_net.sh: Drop 'sh -c' use from ssh in tst_rhost_run
  net/test: Add basic testing for tst_rhost_run
  tst_net.sh/tst_rhost_run: Add debugging

 lib/newlib_tests/shell/net/tst_rhost_run.sh   |  27 ++++
 runtest/net.tcp_cmds                          |   3 -
 testcases/lib/tst_net.sh                      |  33 ++--
 testcases/lib/tst_test.sh                     |   2 +-
 testcases/network/README.md                   |  97 +++++-------
 testcases/network/stress/README               |   9 +-
 testcases/network/tcp_cmds/rcp/Makefile       |  30 ----
 testcases/network/tcp_cmds/rcp/rcp01.sh       | 144 ------------------
 testcases/network/tcp_cmds/rlogin/Makefile    |  31 ----
 testcases/network/tcp_cmds/rlogin/rlogin01.sh |  91 -----------
 testcases/network/tcp_cmds/rsh/Makefile       |  31 ----
 testcases/network/tcp_cmds/rsh/rsh01.sh       | 115 --------------
 12 files changed, 91 insertions(+), 522 deletions(-)
 create mode 100755 lib/newlib_tests/shell/net/tst_rhost_run.sh
 delete mode 100644 testcases/network/tcp_cmds/rcp/Makefile
 delete mode 100755 testcases/network/tcp_cmds/rcp/rcp01.sh
 delete mode 100644 testcases/network/tcp_cmds/rlogin/Makefile
 delete mode 100755 testcases/network/tcp_cmds/rlogin/rlogin01.sh
 delete mode 100644 testcases/network/tcp_cmds/rsh/Makefile
 delete mode 100755 testcases/network/tcp_cmds/rsh/rsh01.sh

-- 
2.27.0

