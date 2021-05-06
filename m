From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 6 May 2021 21:09:47 +0800
Subject: [LTP] [PATCH 0/3] syscalls/fchown: Convert fchown{01, 02,
 03} to the new API
Message-ID: <20210506130950.110267-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xie Ziyao (3):
  syscalls/fchown: Convert fchown01 to the new API
  syscalls/fchown: Convert fchown02 to the new API
  syscalls/fchown: Convert fchown03 to the new API

 testcases/kernel/syscalls/fchown/fchown01.c | 110 ++++--------
 testcases/kernel/syscalls/fchown/fchown02.c | 175 ++++++-------------
 testcases/kernel/syscalls/fchown/fchown03.c | 177 ++++++++------------
 3 files changed, 149 insertions(+), 313 deletions(-)

--
2.17.1

