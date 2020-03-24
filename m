From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Mar 2020 10:36:20 +0100
Subject: [LTP] [PATCH 0/2] xinetd rewrite
Message-ID: <20200324093622.21091-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

this sounds as a bad joke to rewrite tests for xinetd, which nobody uses
now. I was surprised, that it's still in some distros (e.g. openSUSE,
Debian, Gentoo). I can delete the test if we don't want LTP to be a
museum.

Kind regards,
Petr

Petr Vorel (2):
  xinetd: Rewrite into new API
  xinetd: Fix pattern for NetKit telnet

 testcases/network/xinetd/xinetd_tests.sh | 99 ++++++++----------------
 1 file changed, 33 insertions(+), 66 deletions(-)

-- 
2.25.1

