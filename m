From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  5 Apr 2018 02:06:41 +0200
Subject: [LTP] [RFC PATCH v4 3/6] network.sh: Migrate to new shell API
In-Reply-To: <20180405000644.18815-1-pvorel@suse.cz>
References: <20180405000644.18815-1-pvorel@suse.cz>
Message-ID: <20180405000644.18815-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testscripts/network.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testscripts/network.sh b/testscripts/network.sh
index cc2b2de72..b18f202d5 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -89,7 +89,7 @@ shift $(($OPTIND - 1))
 TST_TOTAL=1
 TCID="network_settings"
 
-TST_USE_LEGACY_API=1
+TST_NO_DEFAULT_RUN=1
 . tst_net.sh
 
 # Reset variables.
-- 
2.16.2

