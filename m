From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  3 Apr 2017 09:14:25 +0200
Subject: [LTP] [RFC PATCH v2 0/3] Simplify network setup
Message-ID: <20170403071428.11754-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <petr.vorel@gmail.com>

Hi Cyril,

thanks for detailed review. I fixed all but this comment:

> Also in LKML conding style mixed-case is frowned upon.
I know that camel-case naming is forbidden. I've taken it from ipcalc project.
But I understand that we need to keep *our* chosen style (i.e. LKML) so If you
want, I'll fix variable names as well.

Kind regards,
Petr

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

