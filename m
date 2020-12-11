From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Fri, 11 Dec 2020 11:44:16 +0200
Subject: [LTP] [PATCH v1] openposix/fork/7-1.c: A bug fix
Message-ID: <20201211094416.26616-1-bogdan.lezhepekov@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The function output interferes with the variable errno, that leads to
the false positive result on limited test setups. The issue fixed.

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 .../open_posix_testsuite/conformance/interfaces/fork/7-1.c    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
index c3db90c00..4249d713d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
@@ -53,12 +53,14 @@ static void read_catalog(nl_catd cat, char *who)
 {
 	char *msg = NULL;
 	int i, j;
-	errno = 0;
 
 #if VERBOSE > 0
 	output("Reading the message catalog from %s...\n", who);
 #endif
 
+	/* the output function interferes with errno */ 
+	errno = 0;
+
 	for (i = 1; i <= 2; i++) {
 		for (j = 1; j <= 2; j++) {
 
-- 
2.26.2

