From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Jan 2018 14:11:32 +0100
Subject: [LTP] [RFC PATCH 0/2] CVE-2018-1000001 (glibc)
Message-ID: <20180118131134.11945-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

sending simple test of CVE-2018-1000001 (vulnerability in glibc), based
on test in glibc [1] contributed by Dmitry V. Levin.

[1] https://sourceware.org/git/gitweb.cgi?p=glibc.git;a=commitdiff;h=52a713fdd0a30e1bd79818e2e3c4ab44ddca1a94;hp=249a5895f120b13290a372a49bb4b499e749806f

Petr Vorel (2):
  lib: Add SAFE_CHROOT(path) macro
  cve/cve-2018-1000001: Add Realpath Buffer Underflow test

 include/safe_macros_fn.h         |  3 ++
 include/tst_safe_macros.h        |  5 ++-
 lib/safe_macros.c                | 15 +++++++++
 testcases/cve/cve-2018-1000001.c | 66 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 testcases/cve/cve-2018-1000001.c

-- 
2.15.1

