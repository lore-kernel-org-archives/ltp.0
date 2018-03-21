From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 21 Mar 2018 15:39:24 +0100
Subject: [LTP] [PATCH v2 0/3] Add Netlink and Crypto libraries,
	plus pcrypt_aead01
Message-ID: <20180321143927.12156-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds two new libraries containing the minimum functionality needed for
the test pcrypt_aead01 which I previously posted as CVE-2017-18075.

Richard Palethorpe (3):
  lib: Check received message was not truncated
  lib: Add tst_crypto and tst_netlink libs
  Add pcrypt_aead01 CVE-2017-18075

 include/tst_crypto.h                    | 135 ++++++++++++++++++++++++++++++++
 include/tst_netlink.h                   |  63 +++++++++++++++
 include/tst_netlink_fn.h                |  35 +++++++++
 lib/safe_net.c                          |  13 ++-
 lib/tst_crypto.c                        | 122 +++++++++++++++++++++++++++++
 lib/tst_netlink.c                       |  63 +++++++++++++++
 runtest/crypto                          |   1 +
 runtest/cve                             |   1 +
 testcases/kernel/crypto/.gitignore      |   1 +
 testcases/kernel/crypto/Makefile        |  22 ++++++
 testcases/kernel/crypto/pcrypt_aead01.c |  85 ++++++++++++++++++++
 11 files changed, 540 insertions(+), 1 deletion(-)
 create mode 100644 include/tst_crypto.h
 create mode 100644 include/tst_netlink.h
 create mode 100644 include/tst_netlink_fn.h
 create mode 100644 lib/tst_crypto.c
 create mode 100644 lib/tst_netlink.c
 create mode 100644 runtest/crypto
 create mode 100644 testcases/kernel/crypto/.gitignore
 create mode 100644 testcases/kernel/crypto/Makefile
 create mode 100644 testcases/kernel/crypto/pcrypt_aead01.c

-- 
2.16.2

