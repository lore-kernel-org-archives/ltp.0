From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Sep 2019 11:47:21 +0200
Subject: [LTP] [PATCH] syscalls/acct02: Check read size.
Message-ID: <20190925094721.18932-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is just a minor adjustements that checks that we get correct size
from read before we attempt to validate the data we read in order to
print more meaningful failure message.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/acct/acct02.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
index 110d99359..bdb7c1194 100644
--- a/testcases/kernel/syscalls/acct/acct02.c
+++ b/testcases/kernel/syscalls/acct/acct02.c
@@ -171,10 +171,21 @@ static void run(void)
 	acct(NULL);
 
 	do {
-		tst_res(TINFO, "== entry %d ==", ++i);
-
 		read_bytes = SAFE_READ(0, fd, &acct_struct, acct_size);
 
+		if (i == 0 && read_bytes == 0) {
+			tst_res(TFAIL, "acct file is empty");
+			goto exit;
+		}
+
+		if (read_bytes != acct_size) {
+			tst_res(TFAIL, "incomplete read %i bytes, expected %i",
+			        read_bytes, acct_size);
+			goto exit;
+		}
+
+		tst_res(TINFO, "== entry %d ==", ++i);
+
 		if (v3)
 			ret = verify_acct(&acct_struct.v3, acct_struct.v3.ac_etime);
 		else
@@ -192,6 +203,7 @@ static void run(void)
 	else
 		tst_res(TPASS, "acct() wrote correct file contents!");
 
+exit:
 	SAFE_CLOSE(fd);
 }
 
-- 
2.21.0

