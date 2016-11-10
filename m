From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 Nov 2016 09:22:59 +0100
Subject: [LTP] [PATCH 3/3] runalltests.sh: update network related scripts
	paths
In-Reply-To: <20161110082259.32348-1-pvorel@suse.cz>
References: <20161110082259.32348-1-pvorel@suse.cz>
Message-ID: <20161110082259.32348-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

networktests.sh and networkstress.sh scripts were removed in fddb4f3.

network tests are running the same tests as it was default in
networktests.sh, networkstress.sh are running all tests (default was to
display help).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runalltests.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/runalltests.sh b/runalltests.sh
index 6e48c38..a899473 100755
--- a/runalltests.sh
+++ b/runalltests.sh
@@ -367,7 +367,7 @@ fi
 ## START => Test Series 12                             ##
 if [ $RUN_LTP_NETWORK_TESTS -eq 1 ]
 then
-	(cd $LTPROOT/testscripts/; ./networktests.sh)
+	(cd $LTPROOT/testscripts/; ./network.sh -m -n -r -t)
 fi
 ## END => Test Series 12                               ##
 
@@ -375,7 +375,7 @@ fi
 ## START => Test Series 13                             ##
 if [ $RUN_LTP_NETWORK_STRESS_TESTS -eq 1 ]
 then
-	(cd $LTPROOT/testscripts/; ./networkstress.sh)
+	(cd $LTPROOT/testscripts/; ./network.sh -w)
 fi
 ## END => Test Series 13                               ##
 
-- 
2.10.2

