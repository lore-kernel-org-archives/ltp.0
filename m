From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 31 Mar 2021 15:09:11 +0800
Subject: [LTP] [PATCH 0/3] syscalls/close: Convert close{01, 02,
 08} to the new API
Message-ID: <20210331070914.4401-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

convert syscalls/close/close{01, 02, 08} to the new API

Xie Ziyao (3):
  Convert close01 to the new API
  Convert close02 to the new API
  Convert close08 to the new API

 testcases/kernel/syscalls/close/close01.c | 122 +++++----------
 testcases/kernel/syscalls/close/close02.c | 136 +++++------------
 testcases/kernel/syscalls/close/close08.c | 178 ++++------------------
 3 files changed, 101 insertions(+), 335 deletions(-)

--
2.17.1

