From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu,  1 Jul 2021 07:03:12 +0200
Subject: [LTP] [PATCH 0/2] API tests cleanup
Message-ID: <20210701050314.1005067-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <pvorel@suse.cz>

Hi,

preparation for v4 test API cleanup.

Kind regards,
Petr

Petr Vorel (2):
  lib/tests: Rename test tst_print_result.c
  lib/tests: Rename test to tst_fuzzy_sync03.c

 lib/newlib_tests/.gitignore                       |  4 ++--
 lib/newlib_tests/Makefile                         |  4 ++--
 lib/newlib_tests/{test16.c => tst_fuzzy_sync03.c} |  0
 lib/newlib_tests/{test17.c => tst_print_result.c} | 10 ++++------
 4 files changed, 8 insertions(+), 10 deletions(-)
 rename lib/newlib_tests/{test16.c => tst_fuzzy_sync03.c} (100%)
 rename lib/newlib_tests/{test17.c => tst_print_result.c} (80%)

-- 
2.32.0.rc0

