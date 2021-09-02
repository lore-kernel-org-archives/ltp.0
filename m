From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  2 Sep 2021 12:37:36 +0200
Subject: [LTP] [PATCH 0/4] checkbashisms.pl in make check + fixed docs
Message-ID: <20210902103740.19446-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

checkbashisms.pl has problem with type. Although it's in POSIX [1] even
in old one from 2004 [2] and it's supported by all common shells (i.e.
bash, zsh, dash, busybox sh, mksh; even in ksh; maybe just csh does not
support it) checkbashisms.pl complains about it:

$ make check-tst_test.sh
CHECK testcases/lib/tst_test.sh
possible bashism in tst_test.sh line 33 (type):
		if type $TST_CLEANUP >/dev/null 2>/dev/null; then
possible bashism in tst_test.sh line 694 (type):
		if type $TST_SETUP >/dev/null 2>/dev/null; then
possible bashism in tst_test.sh line 726 (type):
		if type ${TST_TESTFUNC}1 > /dev/null 2>&1; then
make: [../../include/mk/rules.mk:58: check-tst_test.sh] Error 1 (ignored)


Should I report it to Debian (the upstream)? Or at least ask for way to
suppress the warning?

Kind regards,
Petr

[1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/type.html#tag_20_136
[2] https://pubs.opengroup.org/onlinepubs/000095399/utilities/type.html

Petr Vorel (4):
  doc: Mention make check
  Vendor checkbashisms.pl version 2.20.5
  rules.mk: Add checkbashisms to 'make check' for *.sh
  doc: Update for vendored checkbashisms.pl

 doc/c-test-tutorial-simple.txt            |  21 +-
 doc/maintainer-patch-review-checklist.txt |   3 +-
 doc/test-writing-guidelines.txt           |  18 +-
 include/mk/env_post.mk                    |   2 +
 include/mk/generic_leaf_target.inc        |   2 +-
 include/mk/generic_trunk_target.inc       |   2 +-
 include/mk/rules.mk                       |   9 +
 scripts/checkbashisms.pl                  | 816 ++++++++++++++++++++++
 8 files changed, 851 insertions(+), 22 deletions(-)
 create mode 100755 scripts/checkbashisms.pl

-- 
2.33.0

