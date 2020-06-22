From: Petr Vorel <petr.vorel@suse.com>
Date: Mon, 22 Jun 2020 09:09:06 +0200
Subject: [LTP] [RESENT PATCH 0/5] tst_net.sh: Remove rsh,
 update docs add debug & test
Message-ID: <20200622070911.16123-1-petr.vorel@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <pvorel@suse.cz>

Hi,

It looks this patchset from Friday didn't get to the mailing list, thus
sending it again.

started as removing rsh, then also update docs and backport testing
environment I use for some time (but not sure if needed).

Kind regards,
Petr

Petr Vorel (5):
  tst_net.sh: Remove rsh support
  net: Update README.md
  tst_net.sh: Drop 'sh -c' use from ssh in tst_rhost_run
  net/test: Add basic testing for tst_rhost_run
  st_net.sh: tst_rhost_run: Add -d option (debug)

 lib/newlib_tests/shell/net/tst_rhost_run.sh | 25 +++++++
 testcases/lib/tst_net.sh                    | 37 +++++++----
 testcases/network/README.md                 | 73 ++++++++++-----------
 3 files changed, 85 insertions(+), 50 deletions(-)
 create mode 100755 lib/newlib_tests/shell/net/tst_rhost_run.sh

-- 
2.27.0

