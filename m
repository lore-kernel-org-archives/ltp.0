From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Oct 2019 13:25:20 +0200
Subject: [LTP] [PATCH 0/2] Add support for a test tags
Message-ID: <20191014112522.24548-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a newest version of the test tags, first patch adds a support
for test tags to a test library, the second one annotates tests with
tags. Not everything is annotated at the moment but fair amount of tests
is included.

These patches are also a stepping stone for the test metadata project
that will allow us to do much more than this. You can have a look at:

https://github.com/metan-ucw/ltp/tree/master/docparse

Also if you run a make in the docparse directory it will generate test
metadata along with a single html page with nice test metadata
description.

While the whole project is work-in-progress, the test tags are finished
and may add a value even without the rest of the changes, see the first
commit for details.

Cyril Hrubis (2):
  lib: Add support for test tags
  testcases/kernel: Add tags

 include/tst_test.h                            | 10 +++
 lib/tst_test.c                                | 77 +++++++++++++++++--
 testcases/cve/cve-2014-0196.c                 |  5 ++
 testcases/cve/cve-2015-3290.c                 |  5 ++
 testcases/cve/cve-2016-10044.c                |  5 ++
 testcases/cve/cve-2016-7042.c                 |  5 ++
 testcases/cve/cve-2016-7117.c                 |  5 ++
 testcases/cve/cve-2017-16939.c                |  5 ++
 testcases/cve/cve-2017-17052.c                |  5 ++
 testcases/cve/cve-2017-17053.c                |  5 ++
 testcases/cve/cve-2017-2618.c                 |  5 ++
 testcases/cve/cve-2017-2671.c                 |  5 ++
 testcases/cve/meltdown.c                      |  6 +-
 testcases/cve/stack_clash.c                   |  4 +
 testcases/kernel/crypto/af_alg01.c            |  5 ++
 testcases/kernel/crypto/af_alg02.c            |  5 ++
 testcases/kernel/crypto/af_alg03.c            |  4 +
 testcases/kernel/crypto/af_alg04.c            |  4 +
 testcases/kernel/crypto/af_alg05.c            |  8 +-
 testcases/kernel/crypto/af_alg06.c            |  4 +
 testcases/kernel/crypto/crypto_user01.c       |  6 ++
 testcases/kernel/crypto/crypto_user02.c       |  4 +
 testcases/kernel/crypto/pcrypt_aead01.c       |  5 ++
 testcases/kernel/sound/snd_timer01.c          |  6 ++
 testcases/kernel/syscalls/accept/accept02.c   |  5 ++
 testcases/kernel/syscalls/acct/acct02.c       |  4 +
 testcases/kernel/syscalls/add_key/add_key02.c |  5 ++
 testcases/kernel/syscalls/bpf/bpf_prog02.c    |  4 +
 .../syscalls/futex/futex_cmp_requeue02.c      |  5 ++
 testcases/kernel/syscalls/keyctl/keyctl02.c   |  4 +
 testcases/kernel/syscalls/keyctl/keyctl04.c   |  5 ++
 testcases/kernel/syscalls/keyctl/keyctl05.c   |  4 +
 .../kernel/syscalls/move_pages/move_pages12.c |  6 ++
 .../kernel/syscalls/realpath/realpath01.c     |  4 +
 .../syscalls/request_key/request_key05.c      |  4 +
 testcases/kernel/syscalls/sbrk/sbrk03.c       |  4 +
 testcases/kernel/syscalls/sendto/sendto02.c   |  4 +
 .../kernel/syscalls/setrlimit/setrlimit06.c   |  4 +
 38 files changed, 251 insertions(+), 9 deletions(-)

-- 
2.21.0

