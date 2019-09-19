From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 19 Sep 2019 16:59:09 +0200
Subject: [LTP] [PATCH 0/2] Increase bind() converage - GH#538
Message-ID: <20190919145911.22278-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patchset updates syscalls/bind02 to new API and adds a test that bind()
opens sockets for incoming connections. The test is split into two programs,
one for stream-oriented sockets and the other for datagram-oriented sockets.

Martin Doucha (2):
  Update syscalls/bind02 to new API
  Add connection tests for bind()

 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/bind/.gitignore |   2 +
 testcases/kernel/syscalls/bind/Makefile   |   5 +
 testcases/kernel/syscalls/bind/bind02.c   | 153 ++++-----------
 testcases/kernel/syscalls/bind/bind04.c   | 206 ++++++++++++++++++++
 testcases/kernel/syscalls/bind/bind05.c   | 219 ++++++++++++++++++++++
 testcases/kernel/syscalls/bind/libbind.c  |  47 +++++
 testcases/kernel/syscalls/bind/libbind.h  |  15 ++
 8 files changed, 537 insertions(+), 112 deletions(-)
 create mode 100644 testcases/kernel/syscalls/bind/bind04.c
 create mode 100644 testcases/kernel/syscalls/bind/bind05.c
 create mode 100644 testcases/kernel/syscalls/bind/libbind.c
 create mode 100644 testcases/kernel/syscalls/bind/libbind.h

-- 
2.22.1

