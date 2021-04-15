From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 15 Apr 2021 14:35:16 +0800
Subject: [LTP] [PATCH v2 0/2] syscalls/chown: rewrite chown/chown{01,
 03} with the new api
Message-ID: <20210415063518.174631-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xie Ziyao (2):
  syscalls/chown: rewrite chown/chown01.c with the new api
  syscalls/chown: rewrite chown/chown03.c with the new api

 testcases/kernel/syscalls/chown/chown01.c | 187 +++--------------
 testcases/kernel/syscalls/chown/chown03.c | 240 +++++++---------------
 2 files changed, 106 insertions(+), 321 deletions(-)

--
2.17.1

