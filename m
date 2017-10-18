From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Oct 2017 15:49:54 +0200
Subject: [LTP] [RFC PATCH 0/7] Remove network test for ancient software
Message-ID: <20171018135001.30382-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I'm proposing to remove tests for ancient software.
I don't think we should be maintaining tests for something which hardly anyone use.

Kind regards,
Petr

Petr Vorel (7):
  net/tcp_cmds: Remove rwho test
  net/tcp_cmds: Remove rdist test
  net/tcp_cmds: Remove rlogin test
  net/tcp_cmds: Remove rsh test
  net/tcp_cmds: Remove rcp test
  net/tcp_cmds: Remove finger test
  net/tcp_cmds: Remove echo test

 runtest/net.tcp_cmds                         |   7 -
 testcases/network/tcp_cmds/echo/Makefile     |  38 ---
 testcases/network/tcp_cmds/echo/createfile.c |  52 ----
 testcases/network/tcp_cmds/echo/echo01       | 127 ---------
 testcases/network/tcp_cmds/echo/echoes.c     | 375 ---------------------------
 testcases/network/tcp_cmds/finger/Makefile   |  31 ---
 testcases/network/tcp_cmds/finger/finger01   | 203 ---------------
 testcases/network/tcp_cmds/rcp/Makefile      |  30 ---
 testcases/network/tcp_cmds/rcp/rcp01         | 144 ----------
 testcases/network/tcp_cmds/rdist/Makefile    |  30 ---
 testcases/network/tcp_cmds/rdist/rdist01     | 187 -------------
 testcases/network/tcp_cmds/rlogin/Makefile   |  31 ---
 testcases/network/tcp_cmds/rlogin/rlogin01   |  90 -------
 testcases/network/tcp_cmds/rsh/Makefile      |  31 ---
 testcases/network/tcp_cmds/rsh/rsh01         | 115 --------
 testcases/network/tcp_cmds/rwho/Makefile     |  31 ---
 testcases/network/tcp_cmds/rwho/rwho01       |  91 -------
 17 files changed, 1613 deletions(-)
 delete mode 100644 testcases/network/tcp_cmds/echo/Makefile
 delete mode 100644 testcases/network/tcp_cmds/echo/createfile.c
 delete mode 100755 testcases/network/tcp_cmds/echo/echo01
 delete mode 100644 testcases/network/tcp_cmds/echo/echoes.c
 delete mode 100644 testcases/network/tcp_cmds/finger/Makefile
 delete mode 100755 testcases/network/tcp_cmds/finger/finger01
 delete mode 100644 testcases/network/tcp_cmds/rcp/Makefile
 delete mode 100755 testcases/network/tcp_cmds/rcp/rcp01
 delete mode 100644 testcases/network/tcp_cmds/rdist/Makefile
 delete mode 100755 testcases/network/tcp_cmds/rdist/rdist01
 delete mode 100644 testcases/network/tcp_cmds/rlogin/Makefile
 delete mode 100755 testcases/network/tcp_cmds/rlogin/rlogin01
 delete mode 100644 testcases/network/tcp_cmds/rsh/Makefile
 delete mode 100755 testcases/network/tcp_cmds/rsh/rsh01
 delete mode 100644 testcases/network/tcp_cmds/rwho/Makefile
 delete mode 100755 testcases/network/tcp_cmds/rwho/rwho01

-- 
2.14.2

