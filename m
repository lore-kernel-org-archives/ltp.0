From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Sep 2021 16:37:23 +0200
Subject: [LTP] [PATCH 0/2] Two small fixes for kconfig parser
Message-ID: <20210915143725.13170-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis (2):
  lib: tst_kconfig: Fix typo Constrain -> Constraint
  lib: tst_kconfig: Fix segfaults on variable value mismatch

 lib/newlib_tests/config07 | 5 +++++
 lib/tst_kconfig.c         | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)
 create mode 100644 lib/newlib_tests/config07

-- 
2.32.0

