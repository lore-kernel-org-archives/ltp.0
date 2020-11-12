From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Nov 2020 16:47:46 +0100
Subject: [LTP] [PATCH v2 0/2] Add support for kconfig strings
Message-ID: <20201112154748.17857-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We add a support for strings into the boolean tokenizer and also
validator for kconfig variables into the kconfig parser so that we find
most of the typos even before we attempt to evaluate the expressions.

Cyril Hrubis (2):
  lib: tst_bool_expr: Add support for strings
  lib/tst_kconfig: Validate variables

 lib/newlib_tests/.gitignore       |   1 +
 lib/newlib_tests/config01         |   1 +
 lib/newlib_tests/config02         |   1 +
 lib/newlib_tests/config03         |   1 +
 lib/newlib_tests/config04         |   1 +
 lib/newlib_tests/config05         |   1 +
 lib/newlib_tests/test_kconfig.c   |   1 +
 lib/newlib_tests/test_kconfig02.c |  29 +++++++++
 lib/newlib_tests/tst_bool_expr.c  |   3 +
 lib/tst_bool_expr.c               |   7 ++
 lib/tst_kconfig.c                 | 102 ++++++++++++++++++++++++++++++
 11 files changed, 148 insertions(+)
 create mode 100644 lib/newlib_tests/test_kconfig02.c

-- 
2.26.2

