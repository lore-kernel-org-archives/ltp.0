From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  9 Nov 2017 12:39:43 +0100
Subject: [LTP] [RFC PATCH 0/4] Add headers in lapi
Message-ID: <20171109113947.24609-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I posted this originally in "netstress: Add imports for TCP_FASTOPEN definition" [1], got reply from Alexey [2].

Do we want to include system headers which originaly define definitions in lapi
headers? (e.g. include <linux/falloc.h> in include/lapi/fallocate.h as it
defines FALLOC_FL_KEEP_SIZE from linux/falloc.h)?
Some of them do it, some not.

If yes, do we want to check presence of them with autotools?

What is the purpose of lapi anyway? I suppose just to backport missing features
added in recent glibc to older versions or missing in other libc (musl, uclibc,
binder).


Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2017-October/006275.html
[2] http://lists.linux.it/pipermail/ltp/2017-November/006345.html

Petr Vorel (4):
  lapi: Add lapi/tcp.h with definitions moved from netstress.c
  lapi/socket.h: Move definitions from netstress.c
  lapi: Add lapi/in.h with definition moved from netstress.c
  lapi: Add lapi/dccp.h with definition moved from netstress.c

 include/lapi/dccp.h                     | 25 +++++++++++++++++++++++++
 include/lapi/in.h                       | 25 +++++++++++++++++++++++++
 include/lapi/socket.h                   | 18 +++++++++++++++++-
 include/lapi/tcp.h                      | 25 +++++++++++++++++++++++++
 testcases/network/netstress/netstress.c | 33 ++++-----------------------------
 5 files changed, 96 insertions(+), 30 deletions(-)
 create mode 100644 include/lapi/dccp.h
 create mode 100644 include/lapi/in.h
 create mode 100644 include/lapi/tcp.h

-- 
2.15.0

