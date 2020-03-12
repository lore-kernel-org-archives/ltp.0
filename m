From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 12 Mar 2020 13:55:42 +0100
Subject: [LTP] [PATCH v3 0/3] Increase bind() coverage - GH#538
Message-ID: <20200312125545.3976-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patchset adds a test that bind() opens sockets for incoming connections.
The test is split into two programs, one for stream-oriented sockets and
the other for datagram-oriented sockets.

This is a v3 resubmission of a patchset from last year. I had more important
patches to write for a while but I've dusted this code off now because I'll
need some of the helper functions in an upcoming CVE test.

Martin Doucha (3):
  Create separate .c file for include/tst_net.h
  Add socket address initialization functions to tst_net library
  Add connection tests for bind()

 include/tst_net.h                         | 136 ++------------
 lib/tst_net.c                             | 217 ++++++++++++++++++++++
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/bind/.gitignore |   2 +
 testcases/kernel/syscalls/bind/Makefile   |   2 +
 testcases/kernel/syscalls/bind/bind04.c   | 172 +++++++++++++++++
 testcases/kernel/syscalls/bind/bind05.c   | 186 +++++++++++++++++++
 testcases/kernel/syscalls/bind/libbind.h  |  29 +++
 testcases/lib/tst_net_iface_prefix.c      |   9 +-
 testcases/lib/tst_net_ip_prefix.c         |  10 +-
 testcases/lib/tst_net_vars.c              |  64 +++----
 11 files changed, 671 insertions(+), 158 deletions(-)
 create mode 100644 lib/tst_net.c
 create mode 100644 testcases/kernel/syscalls/bind/bind04.c
 create mode 100644 testcases/kernel/syscalls/bind/bind05.c
 create mode 100644 testcases/kernel/syscalls/bind/libbind.h

-- 
2.25.1

