From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 11 Feb 2019 21:07:43 +0300
Subject: [LTP] [PATCH 0/4] netstress: new option and some enhancements
Message-ID: <1549908467-15609-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Mainly, for UDP protocol.

Alexey Kodanev (4):
  netstress: support SO_REUSEPORT with new 'P' flag
  netstress: allow setting MSG_ZEROCOPY for other protocols
  netstress: handle zero length message for datagram sockets
  netstress: increase timeout errors counter

 testcases/network/netstress/netstress.c |   39 ++++++++++++++++++++++--------
 1 files changed, 28 insertions(+), 11 deletions(-)

