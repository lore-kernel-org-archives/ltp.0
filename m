From: Eric Biggers <ebiggers@kernel.org>
Date: Thu,  6 Dec 2018 10:18:11 -0800
Subject: [LTP] [PATCH 0/3] ltp: new test for crypto_user information leak bug
Message-ID: <20181206181814.85583-1-ebiggers@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This series adds a test for an information leak bug in the crypto user
configuration API which was recently fixed.

Eric Biggers (3):
  lapi/cryptouser.h: add more declarations
  tst_netlink: inline functions in header
  crypto/crypto_user01.c: new test for information leak bug

 include/lapi/cryptouser.h               |  73 +++++++++
 include/tst_netlink.h                   |  11 +-
 runtest/crypto                          |   1 +
 runtest/cve                             |   2 +
 testcases/kernel/crypto/.gitignore      |   1 +
 testcases/kernel/crypto/crypto_user01.c | 208 ++++++++++++++++++++++++
 6 files changed, 291 insertions(+), 5 deletions(-)
 create mode 100644 testcases/kernel/crypto/crypto_user01.c

-- 
2.20.0.rc1.387.gf8505762e3-goog

