From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 31 May 2021 19:25:20 +0800
Subject: [LTP] [PATCH 0/2] syscalls/fchown: Convert fchown{04,
 05} to the new API
Message-ID: <20210531112522.9082-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Cleanup and convert fchown{04, 05} to the new API.
2. Remove duplicate test points for fchown05.

Xie Ziyao (2):
  syscalls/fchown: Convert fchown04 to the new API
  syscalls/fchown: Convert fchown05 to the new API

 testcases/kernel/syscalls/fchown/fchown04.c | 179 +++++---------------
 testcases/kernel/syscalls/fchown/fchown05.c | 147 +++++-----------
 2 files changed, 87 insertions(+), 239 deletions(-)

--
2.17.1

