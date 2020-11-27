From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 27 Nov 2020 17:31:48 +0100
Subject: [LTP] [PATCH 0/2] First step in formalizing the test library
Message-ID: <20201127163150.22903-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is partly motivated by the issue #462 where we ended up with a
loose corer cases that are not well defined.

So as a first step this patches:

- Do fix old problem with TBROK propagation

- Start a library description that hopefully captures
  so-far unwritten desing decisions and rules

Cyril Hrubis (2):
  lib: tst_test.c: Add TBROK counter.
  lib: Add test library design document

 lib/README.md               | 130 ++++++++++++++++++++++++++++++++++++
 lib/newlib_tests/.gitignore |   1 +
 lib/newlib_tests/test22.c   |  34 ++++++++++
 lib/tst_test.c              |  13 +++-
 4 files changed, 176 insertions(+), 2 deletions(-)
 create mode 100644 lib/README.md
 create mode 100644 lib/newlib_tests/test22.c

-- 
2.26.2

