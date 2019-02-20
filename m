From: Matthias Maennich <maennich@google.com>
Date: Wed, 20 Feb 2019 15:20:22 +0000
Subject: [LTP] [PATCH v3 0/3] aio_tio: fixes and conversion to new lib
In-Reply-To: <20190111085326.171826-1-maennich@google.com>
References: <20190111085326.171826-1-maennich@google.com>
Message-ID: <20190220152025.261625-1-maennich@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch series is a resend of an earlier series for two bug fixes. In
addition, it now contains a patch to migrate the test to the new lib
along with some cleanup.

Cheers,
Matthias

Matthias Maennich (3):
  aio_tio: fix error diagnosis for byte transfers
  aio_tio: determine alignment based on target filesystem
  aio_tio: convert to new lib

 testcases/kernel/io/aio/aio02/Makefile  |  24 +--
 testcases/kernel/io/aio/aio02/aio_tio.c | 207 +++++++++++++-----------
 testcases/kernel/io/aio/aio02/common.h  |  28 ----
 testcases/kernel/io/aio/aio02/main.c    |  37 -----
 4 files changed, 112 insertions(+), 184 deletions(-)
 delete mode 100644 testcases/kernel/io/aio/aio02/common.h
 delete mode 100644 testcases/kernel/io/aio/aio02/main.c

-- 
2.21.0.rc0.258.g878e2cd30e-goog

