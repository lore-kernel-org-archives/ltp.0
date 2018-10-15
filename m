From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 15 Oct 2018 22:18:17 +0200
Subject: [LTP] [RFC PATCH 0/2] Cleanup runtests containing duplicate
	definitions
Message-ID: <20181015201819.10868-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

anyone using these? Objections?
IMHO there is no point trying to keep them sync.

Kind regards,
Petr

Petr Vorel (2):
  Remove LTP stress tests
  Remove ltplite and runltplite.sh

 Makefile                 |    2 +-
 doc/ltp-run-files.txt    |    3 -
 runltplite.sh            |  392 --------------
 runtest/ltplite          | 1113 --------------------------------------
 runtest/stress.part1     |  209 -------
 runtest/stress.part2     |   53 --
 runtest/stress.part3     |  893 ------------------------------
 testscripts/ltpstress.sh |  349 ------------
 8 files changed, 1 insertion(+), 3013 deletions(-)
 delete mode 100755 runltplite.sh
 delete mode 100644 runtest/ltplite
 delete mode 100644 runtest/stress.part1
 delete mode 100644 runtest/stress.part2
 delete mode 100644 runtest/stress.part3
 delete mode 100755 testscripts/ltpstress.sh

-- 
2.19.0

