From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu,  8 Aug 2019 17:38:24 +0200
Subject: [LTP] [RFC PATCH 0/1] tst API for dropping or requiring capabilities
Message-ID: <20190808153825.18363-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

This API allows one to drop or require particular capabilities after setup.

It can be used like this:

	.caps = (struct tst_cap []) {
		TST_CAP(TST_DROP, CAP_SYS_ADMIN),
		{0, 0, 0},
	},

or

	.caps = (struct tst_cap []) {
	        TST_CAP(TST_DROP, CAP_SYS_ADMIN)
		TST_CAP(TST_REQUIRE, CAP_SOMETHING),
		{0, 0, 0},
	},

It uses capget and capset directly so that we do not need to link to libcap.

Richard Palethorpe (1):
  capability: Introduce capability API

 include/tst_capability.h | 56 +++++++++++++++++++++++++++++
 include/tst_test.h       |  6 ++++
 lib/tst_capability.c     | 78 ++++++++++++++++++++++++++++++++++++++++
 lib/tst_test.c           |  3 ++
 4 files changed, 143 insertions(+)
 create mode 100644 include/tst_capability.h
 create mode 100644 lib/tst_capability.c

-- 
2.22.0

