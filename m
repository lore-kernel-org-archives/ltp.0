From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Feb 2021 15:47:02 +0100
Subject: [LTP] [PATCH 0/2] netns_netlink: Rewrite into new API
Message-ID: <20210219144704.20433-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

this is cleanup before needed fix of check_iproute().
More at second commit.

Kind regards,
Petr

Petr Vorel (1):
  libclone: Move test.h include to C file

Richard Palethorpe (1):
  netns_netlink: Rewrite into new API

 .../kernel/containers/libclone/libclone.c     |   1 +
 .../kernel/containers/libclone/libclone.h     |   1 -
 .../kernel/containers/mqns/mqns_helper.h      |   2 +-
 .../kernel/containers/netns/netns_helper.h    |  38 ++----
 .../kernel/containers/netns/netns_netlink.c   | 115 +++++++-----------
 5 files changed, 58 insertions(+), 99 deletions(-)

-- 
2.30.1

