From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 09 Jun 2021 15:54:54 +0100
Subject: [LTP] [PATCH 0/4] Introduce a concept of test runtime cap
In-Reply-To: <20210609114659.2445-1-chrubis@suse.cz>
References: <20210609114659.2445-1-chrubis@suse.cz>
Message-ID: <87zgvz3x6p.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Cyril,

Cyril Hrubis <chrubis@suse.cz> writes:

> Recently we had a problem with tests that use .all_filesystems and
> tst_timeout_remaining().
>
> The problem is that the tst_timeout_remaining() function wasn't aware of
> the loop over fork_testrun() that executes a testrun for each supported
> filesystem, which caused such test, e.g. writev03, to run for
> unpredictable and long periods.
>
> This is an attempt how to solve this properly by uncoupling timeouts
> from test runtime so that test never runs for longer than its timeout.
>
> Cyril Hrubis (4):
>   lib: tst_supported_fs_types: Add tst_fs_max_types()
>   lib: tst_test: Move timeout scaling out of fork_testrun()
>   lib: Introduce concept of max_test_runtime
>   syscalls/writev03: Adjust test runtime
>
>  include/tst_fs.h                              |  5 ++
>  include/tst_fuzzy_sync.h                      |  4 +-
>  include/tst_test.h                            |  7 +-
>  lib/newlib_tests/.gitignore                   |  3 +-
>  .../{test18.c => test_runtime01.c}            |  7 +-
>  lib/newlib_tests/test_runtime02.c             | 31 +++++++
>  lib/tst_supported_fs_types.c                  |  5 ++
>  lib/tst_test.c                                | 87 ++++++++++++++++---
>  testcases/kernel/crypto/af_alg02.c            |  2 +-
>  testcases/kernel/crypto/pcrypt_aead01.c       |  2 +-
>  testcases/kernel/mem/mtest01/mtest01.c        |  6 +-
>  testcases/kernel/mem/mtest06/mmap1.c          | 13 ++-
>  .../kernel/syscalls/move_pages/move_pages12.c |  4 +-
>  testcases/kernel/syscalls/writev/writev03.c   |  1 +
>  14 files changed, 141 insertions(+), 36 deletions(-)
>  rename lib/newlib_tests/{test18.c => test_runtime01.c} (59%)
>  create mode 100644 lib/newlib_tests/test_runtime02.c
>
> -- 
> 2.31.1

The changes generally look good. I think the new environment variable
needs documenting in the user guide though.

-- 
Thank you,
Richard.
