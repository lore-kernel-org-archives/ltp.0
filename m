From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 May 2018 17:21:28 +0200
Subject: [LTP] [RFC PATCH v4 3/4] lib/tst_test.sh: Warn about using
	"private" variable or function
In-Reply-To: <20180524152129.1067-1-pvorel@suse.cz>
References: <20180524152129.1067-1-pvorel@suse.cz>
Message-ID: <20180524152129.1067-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index a5f0ab288..cdcd33ced 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -259,6 +259,10 @@ tst_run()
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
+
+		for _tst_i in $(grep _tst_ "$TST_TEST_PATH" | sed 's/.*_tst_//; s/[="} \t\/:`].*//'); do
+			tst_res TWARN "Private variable or function _tst_$_tst_i used!"
+		done
 	fi
 
 	local _tst_name
-- 
2.16.3

