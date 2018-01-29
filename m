From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 29 Jan 2018 14:41:07 +0300
Subject: [LTP] [PATCH 0/9] network: add new features
Message-ID: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* SO_ZEROCOPY (no auto test-cases yet, can be tried manually with
  netstress 'z' option);

* IP_BIND_ADDRESS_NO_PORT, new bind_noport01 test;

* one more protocol added to netstress - UDPLITE; busy_poll03, dccp01 and
  UDP IPsec tests are updated;

* netstress server now sends data to client using send(), sendto() and
  sendmsg(), if protocol allows.

Alexey Kodanev (9):
  lib: add safe_sendmsg()
  lib: add safe_getsockopt() and tst_getsockport()
  netstress: make socketaddr returned by recvfrom() thread-local
  netstress: server: write to socket with send/sendto/sendmsg
  netstress: support UDPLITE protocol
  netstress: support SO_ZEROCOPY
  netstress: support IP_BIND_ADDRESS_NO_PORT
  network: add new test-cases with UDP LITE protocol
  network: new test-case for IP_BIND_ADDRESS_NO_PORT

 include/lapi/netinet_in.h                     |    8 +
 include/lapi/socket.h                         |   12 ++
 include/lapi/udp.h                            |   30 +++
 include/safe_net_fn.h                         |    8 +
 include/tst_safe_net.h                        |    9 +
 lib/safe_net.c                                |   60 ++++++
 runtest/net.features                          |    3 +
 testcases/network/busy_poll/busy_poll03.sh    |   32 ++--
 testcases/network/dccp/dccp01.sh              |   28 ++-
 testcases/network/netstress/netstress.c       |  239 +++++++++++++++++--------
 testcases/network/sockets/Makefile            |    2 +-
 testcases/network/sockets/bind_noport01.sh    |   50 +++++
 testcases/network/stress/udp/udp_ipsec.sh     |    7 +-
 testcases/network/stress/udp/udp_ipsec_vti.sh |    7 +-
 14 files changed, 394 insertions(+), 101 deletions(-)
 create mode 100644 include/lapi/udp.h
 create mode 100755 testcases/network/sockets/bind_noport01.sh

