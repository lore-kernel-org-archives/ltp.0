From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed,  3 Mar 2021 10:35:42 +0100
Subject: [LTP] [PATCH] cmdlib: Update exists function to exit with TCONF
Message-ID: <20210303093542.9292-1-kory.maincent@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The exists function which tests the existence of a command was returning
an error.
Update it to return TCONF and exit with the value 32.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

This function is only used by ftp01.sh test.
The real effort should be to rewrite ftp01 test to the new API, but I did
not manage to do it properly and makes it compatible with the other
ftp clients.

 testcases/lib/cmdlib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/cmdlib.sh b/testcases/lib/cmdlib.sh
index e4986c39c..ad93e3cc8 100644
--- a/testcases/lib/cmdlib.sh
+++ b/testcases/lib/cmdlib.sh
@@ -103,8 +103,8 @@ exists()
 {
     for cmd in $*; do
         if ! command -v $cmd >/dev/null 2>&1; then
-            end_testcase "$cmd: command not found"
-            exit 1
+            tst_brkm TCONF NULL "$1: command $2 not found."
+            exit 32
         fi
     done
 }
-- 
2.17.1

