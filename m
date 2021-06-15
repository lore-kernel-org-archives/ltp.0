From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Jun 2021 18:33:04 +0200
Subject: [LTP] [RFC PATCH 0/3] C,
 shell API: Add $LTPROOT/testcases/bin into PATH
Message-ID: <20210615163307.10755-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

although we need to set $LTPROOT/testcases/bin in LTP runner
(i.e. keep it in runltp and runltp-ng), we can add this path when
running from installed LTP (to simplify normal setup).

We could rethink running from git tree (setting TST_DATAROOT),
or adding variable for remote LTP installation location for SSH based
network tests. But that's another step.

Kind regards,
Petr

Petr Vorel (3):
  tst_test.sh: Add $LTPROOT/testcases/bin into PATH
  lib: Add $LTPROOT/testcases/bin into PATH
  doc: Update LTPROOT and PATH environment variables

 README.md                 |  2 +-
 doc/user-guide.txt        |  5 +++--
 lib/tst_test.c            | 22 +++++++++++++++++++---
 testcases/lib/tst_test.sh |  4 ++++
 4 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.32.0

