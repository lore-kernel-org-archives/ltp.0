From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  3 Apr 2017 14:45:00 +0200
Subject: [LTP] [RFC PATCH v3 0/3] Simplify network setup
Message-ID: <20170403124503.24054-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <petr.vorel@gmail.com>

Changes v2->v3:
Fixed most of issues reported by Alexey.

Petr Vorel (3):
  gitignore: Prefixing filenames
  network: Add tool for setup IP variables
  network: Use tst_net_vars to set up variables

 testcases/lib/.gitignore     |  13 +-
 testcases/lib/Makefile       |   2 +-
 testcases/lib/test_net.sh    |  33 +--
 testcases/lib/tst_net_vars.c | 597 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 613 insertions(+), 32 deletions(-)
 create mode 100644 testcases/lib/tst_net_vars.c

-- 
2.11.0

