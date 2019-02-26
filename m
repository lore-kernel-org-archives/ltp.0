From: Matthias Maennich <maennich@google.com>
Date: Tue, 26 Feb 2019 17:02:40 +0000
Subject: [LTP] [PATCH v4 0/3] aio_tio: fixes and conversion to new lib
In-Reply-To: <20190111085326.171826-1-maennich@google.com>
References: <20190111085326.171826-1-maennich@google.com>
Message-ID: <20190226170243.134366-1-maennich@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch series fixes aio_tio and migrates the test to the new lib
along with some cleanup.

v3->v4: - address review comments
        - add directory cleanup patch

Matthias Maennich (3):
  aio_tio: determine alignment based on target block device
  aio_tio: convert to new lib
  io/aio: cleanup test directory

 runtest/io                                  |   2 +-
 testcases/kernel/io/aio/.gitignore          |   4 +-
 testcases/kernel/io/aio/Makefile            |  22 +-
 testcases/kernel/io/aio/{aio01 => }/aio01.c |   0
 testcases/kernel/io/aio/aio01/Makefile      |  30 ---
 testcases/kernel/io/aio/aio02.c             | 246 ++++++++++++++++++++
 testcases/kernel/io/aio/aio02/Makefile      |  36 ---
 testcases/kernel/io/aio/aio02/README        |  12 -
 testcases/kernel/io/aio/aio02/aio_tio.c     | 240 -------------------
 testcases/kernel/io/aio/aio02/common.h      |  28 ---
 testcases/kernel/io/aio/aio02/main.c        |  37 ---
 11 files changed, 256 insertions(+), 401 deletions(-)
 rename testcases/kernel/io/aio/{aio01 => }/aio01.c (100%)
 delete mode 100644 testcases/kernel/io/aio/aio01/Makefile
 create mode 100644 testcases/kernel/io/aio/aio02.c
 delete mode 100644 testcases/kernel/io/aio/aio02/Makefile
 delete mode 100644 testcases/kernel/io/aio/aio02/README
 delete mode 100644 testcases/kernel/io/aio/aio02/aio_tio.c
 delete mode 100644 testcases/kernel/io/aio/aio02/common.h
 delete mode 100644 testcases/kernel/io/aio/aio02/main.c

-- 
2.21.0.rc2.261.ga7da99ff1b-goog

