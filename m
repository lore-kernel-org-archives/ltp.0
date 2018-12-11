From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 10 Dec 2018 22:03:14 -0800
Subject: [LTP] [PATCH v2 0/3] ltp: new test for crypto_user information leak
	bug
Message-ID: <20181211060317.18698-1-ebiggers@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This series adds a test for an information leak bug in the crypto user
configuration API which was recently fixed.

Changed since v1:
  - Check all attributes, not just the first of each type
  - Work around dependency bug in old kernel headers
  - Rename __check_for_leaks() to do_check_for_leaks()
  - Use SPDX license identifier

Eric Biggers (3):
  lapi/cryptouser.h: add more declarations
  tst_netlink: inline functions in header
  crypto/crypto_user01.c: new test for information leak bug

 include/lapi/cryptouser.h               |  73 +++++++++
 include/tst_netlink.h                   |  11 +-
 runtest/crypto                          |   1 +
 runtest/cve                             |   2 +
 testcases/kernel/crypto/.gitignore      |   1 +
 testcases/kernel/crypto/crypto_user01.c | 195 ++++++++++++++++++++++++
 6 files changed, 278 insertions(+), 5 deletions(-)
 create mode 100644 testcases/kernel/crypto/crypto_user01.c

-- 
2.19.2

