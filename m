From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Aug 2021 11:12:21 +0200
Subject: [LTP] [PATCH 0/3] shell: remove which, use type or command -v
Message-ID: <20210818091224.27578-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Petr Vorel (3):
  tst_test.sh: Simplify tst_cmd_available()
  binfmt_misc02.sh: Use "command -v" instead of "which"
  commands: Drop which01.sh

 runtest/commands                              |   1 -
 testcases/commands/which/Makefile             |  11 --
 testcases/commands/which/which01.sh           | 107 ------------------
 .../kernel/fs/binfmt_misc/binfmt_misc02.sh    |  14 +--
 testcases/lib/tst_test.sh                     |  13 +--
 5 files changed, 8 insertions(+), 138 deletions(-)
 delete mode 100644 testcases/commands/which/Makefile
 delete mode 100755 testcases/commands/which/which01.sh

-- 
2.32.0

