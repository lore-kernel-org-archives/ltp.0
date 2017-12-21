From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Dec 2017 20:27:35 +0100
Subject: [LTP] [RFC PATCH v2 0/4] Add headers in lapi
Message-ID: <20171221192739.4868-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

any comments on this cleanup patch-set?
I haven't figured how to rename include/lapi/in.h.
The rest should be ok.

As Alexey updates testcases/network/netstress/netstress.c quite often,
I'd like to get rid of rebasing patch :-).

Kind regards,
Petr

Petr Vorel (4):
  lapi: Add lapi/tcp.h with definitions moved from netstress.c
  lapi/socket.h: Move definitions from netstress.c
  lapi: Add lapi/in.h with definition moved from netstress.c
  lapi: Add lapi/dccp.h with definition moved from netstress.c

 include/lapi/dccp.h                     | 27 ++++++++++++++++++++++++
 include/lapi/in.h                       | 27 ++++++++++++++++++++++++
 include/lapi/socket.h                   | 18 ++++++++++++++++
 include/lapi/tcp.h                      | 31 +++++++++++++++++++++++++++
 testcases/network/netstress/netstress.c | 37 ++++++---------------------------
 5 files changed, 109 insertions(+), 31 deletions(-)
 create mode 100644 include/lapi/dccp.h
 create mode 100644 include/lapi/in.h
 create mode 100644 include/lapi/tcp.h

-- 
2.15.1

