From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  5 Apr 2017 22:44:15 +0200
Subject: [LTP] [RFC PATCH v4 0/3] Simplify network setup
Message-ID: <20170405204418.3240-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

hopefully last version.
v3->v4:
* Rewritten unused network generation. It uses 10.23 resp. fd00:23 as default,
  in case of collision it's 10.x resp. fdxx:23, x is random value. BTW code in
  previous version was wrong as it had the same size as network.
* Forbidden prefixes are only 0 and 32 resp. 128, but they're rounded up by 8 resp. 16 anyway.

Comments are highly appreciated.

Kind regards,
Petr

Petr Vorel (3):
  gitignore: Prefixing filenames
  network: Add tool for setup IP variables
  network: Use tst_net_vars to set up IPv4 and IPv6 related variables

 testcases/lib/.gitignore     |  13 +-
 testcases/lib/Makefile       |   2 +-
 testcases/lib/test_net.sh    |  33 +--
 testcases/lib/tst_net_vars.c | 616 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 632 insertions(+), 32 deletions(-)
 create mode 100644 testcases/lib/tst_net_vars.c

-- 
2.12.0

