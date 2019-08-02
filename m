From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  2 Aug 2019 17:04:41 +0200
Subject: [LTP] [PATCH v2 0/4] Move -Werror-implicit-function-declaration to
Message-ID: <20190802150445.10984-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

please see description in patches.

Travis build: https://travis-ci.org/pevik/ltp/builds/566982062

Kind regards,
Petr

Petr Vorel (4):
  make: Remove C++ related flags
  utils/ffsb: Add missing fhstat() signature + includes
  build.sh: Respect user defined CFLAGS and LDFLAGS
  make,travis: Remove -Werror-implicit-function-declaration

 .travis.yml                  |  3 ++-
 INSTALL                      |  4 +---
 build.sh                     |  5 +++--
 doc/build-system-guide.txt   | 10 ----------
 include/mk/config.mk.default |  4 ----
 include/mk/config.mk.in      |  4 ----
 include/mk/env_post.mk       |  4 ----
 utils/ffsb-6.0-rc2/fh.h      |  2 ++
 utils/ffsb-6.0-rc2/fileops.c |  1 +
 9 files changed, 9 insertions(+), 28 deletions(-)

-- 
2.22.0

