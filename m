From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Mar 2017 11:37:11 +0200
Subject: [LTP] [RFC PATCH 0/2] Simplify network setup
Message-ID: <20170329093713.28361-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

this patch simplifies network related setup a lot as with input of 2 IPv4 and 2 IPv6 addresses defines these variables:
IPV4_NETWORK
LHOST_IPV4_HOST
RHOST_IPV4_HOST
IPV4_NET_REV
IPV6_NETWORK
LHOST_IPV6_HOST
RHOST_IPV6_HOST
IPV6_NET_REV
LHOST_IPV6_REV
RHOST_IPV6_REV
IPV4_NET16_UNUSED
IPV6_NET32_UNUSED

Tool, written in C is not perfect, probably needs cleanup.
Part of the code is borrowed from ipcalc [1], inet_ntop6_impl is based on
inet_ntop() musl implementation [2], that's why I put their copyright.

Any comments are highly appreciated.

Kind regards,
Petr

[1] https://github.com/nmav/ipcalc/blob/master/ipcalc.c
[2] https://github.com/bpowers/musl/blob/master/src/network/inet_ntop.c

Petr Vorel (2):
  network: Add tool for setup IP variables
  network: Use setup_network_variables to set up variables

 testcases/lib/.gitignore                |  13 +-
 testcases/lib/Makefile                  |   4 +-
 testcases/lib/setup_network_variables.c | 602 ++++++++++++++++++++++++++++++++
 testcases/lib/test_net.sh               |  33 +-
 4 files changed, 619 insertions(+), 33 deletions(-)
 create mode 100644 testcases/lib/setup_network_variables.c

-- 
2.12.0

