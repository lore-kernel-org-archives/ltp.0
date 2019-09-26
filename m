From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 26 Sep 2019 17:13:27 +0200
Subject: [LTP] [PATCH v2 0/4] Increase bind() converage - GH#538
Message-ID: <20190926151331.25070-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patchset updates syscalls/bind02 to new API and adds a test that bind()
opens sockets for incoming connections. The test is split into two programs,
one for stream-oriented sockets and the other for datagram-oriented sockets.

Changes from previous version:
- minor code style fixes in syscalls/bind02
- refactoring of include/tst_net.h (patch #2)
- code from libbind.c and some setup code moved to tst_net.c (patch #3)
- added UDPLITE and SCTP test cases
- common constants and test_case data structure moved to libbind.h

Petr Vorel wrote:
> Both tests also share a lot of code. I understand you don't want to mix TCP
> and UDP tests (I would probably do), but could you at least move setup()
> and constants into libbind.h?

I tried to write a single test file for both at first but the code flow is
slightly different which would result in a huge if/else mess. In SOCK_STREAM
test file, main thread gets a new socket from accept() so it can (and should)
use read()/write() to communicate with peer. On the other hand, SOCK_DGRAM
test file has to do its own handshake and main thread has to use recvfrom()
and sendto() because the main thread never gets a point-to-point connection
to peer.

I've decided not to write test cases for SOCK_SEQPACKET+IPPROTO_SCTP (yet)
because this type of socket doesn't support connect() at all. The call will
succeed but write() will then raise SIGPIPE. So I'd have to write a third
test file with yet another slightly different code flow.


Martin Doucha (4):
  Update syscalls/bind02 to new API
  Create separate .c file for include/tst_net.h
  Add socket address initialization functions to tst_net library
  Add connection tests for bind()

 include/tst_net.h                         | 122 ++-----------
 lib/tst_net.c                             | 205 ++++++++++++++++++++++
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/bind/.gitignore |   2 +
 testcases/kernel/syscalls/bind/Makefile   |   2 +
 testcases/kernel/syscalls/bind/bind02.c   | 154 +++++-----------
 testcases/kernel/syscalls/bind/bind04.c   | 180 +++++++++++++++++++
 testcases/kernel/syscalls/bind/bind05.c   | 192 ++++++++++++++++++++
 testcases/kernel/syscalls/bind/libbind.h  |  29 +++
 9 files changed, 672 insertions(+), 216 deletions(-)
 create mode 100644 lib/tst_net.c
 create mode 100644 testcases/kernel/syscalls/bind/bind04.c
 create mode 100644 testcases/kernel/syscalls/bind/bind05.c
 create mode 100644 testcases/kernel/syscalls/bind/libbind.h

-- 
2.23.0

