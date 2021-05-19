From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 19 May 2021 16:46:53 +0800
Subject: [LTP] [PATCH 0/2] syscalls/sendfile: Convert sendfile{08,
 09} to the new API
Message-ID: <20210519084655.52780-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xie Ziyao (2):
  syscalls/sendfile: Convert sendfile08 to the new API
  syscalls/sendfile: Convert sendfile09 to the new API

 .../kernel/syscalls/sendfile/sendfile08.c     | 138 ++++-------
 .../kernel/syscalls/sendfile/sendfile09.c     | 234 ++++++------------
 2 files changed, 118 insertions(+), 254 deletions(-)

--
2.17.1

