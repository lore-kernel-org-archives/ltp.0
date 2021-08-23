From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Aug 2021 17:05:17 +0200
Subject: [LTP] [PATCH 0/3] TST_EXP_*() macros fixes
Message-ID: <20210823150520.25614-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis (3):
  tst_test_macros: Fix TST_EXP_*() default message
  tst_test_macros: Stringify early
  tst_test_macros: Add test_macros05 tests

 include/tst_test_macros.h        | 40 ++++++++++++++-------------
 lib/newlib_tests/.gitignore      |  1 +
 lib/newlib_tests/test_macros05.c | 46 ++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 19 deletions(-)
 create mode 100644 lib/newlib_tests/test_macros05.c

-- 
2.31.1

