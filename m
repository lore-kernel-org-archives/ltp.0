From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 25 May 2018 23:57:24 +0200
Subject: [LTP] [RFC PATCH v5 4/5] tst_test.sh: s/resm/res/
In-Reply-To: <20180525215725.7218-1-pvorel@suse.cz>
References: <20180525215725.7218-1-pvorel@suse.cz>
Message-ID: <20180525215725.7218-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

resm is for legacy API.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 098ff7bd2..621e3eec0 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -88,7 +88,7 @@ _tst_inc_res()
 	TWARN) TST_WARN=$((TST_WARN+1));;
 	TCONF) TST_CONF=$((TST_CONF+1));;
 	TINFO) ;;
-	*) tst_brk TBROK "Invalid resm type '$1'";;
+	*) tst_brk TBROK "Invalid res type '$1'";;
 	esac
 }
 
-- 
2.16.3

