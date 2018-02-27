From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Feb 2018 19:00:42 +0100
Subject: [LTP] [RFC PATCH 0/2] netstress,
	lib: TCONF on "not supported" in SAFE_SOCKET()
Message-ID: <20180227180044.21867-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

these patches on the top of your patch netstress: set port dynamically
on the server-side [1] can detect problems when some feature is missing
(e.g. dccp module not compiled).

The only problem is whether we are ok that SAFE_*() macros can exit with
TCONF or we expect it always to exit with TBROK.

[1] http://lists.linux.it/pipermail/ltp/2018-February/007173.html

Petr Vorel (2):
  lib: TCONF on ESOCKTNOSUPPORT and EPROTONOSUPPORT in SAFE_SOCKET()
  tst_netload: Exit with TCONF when netstress exit with CONF

 lib/safe_net.c            | 9 ++++-----
 testcases/lib/test_net.sh | 4 +++-
 2 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.16.2

