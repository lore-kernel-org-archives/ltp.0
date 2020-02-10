From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 Feb 2020 13:40:42 +0100
Subject: [LTP] [PATCH v2 1/3] tst_umount: Fail immediately when errno !=
 EBUSY
Message-ID: <20200210124043.14425-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Only on EBUSY makes sense to keep trying in a loop.
This helps to use tst_umount() in safe_umount() (next commit).

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Reported-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 89b9c96de..6cad9bd4d 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -363,6 +363,13 @@ int tst_umount(const char *path)
 		if (!ret)
 			return 0;
 
+		if (err != EBUSY) {
+			tst_resm(TWARN, "umount('%s') failed with %s",
+		         path, tst_strerrno(err));
+			errno = err;
+			return ret;
+		}
+
 		tst_resm(TINFO, "umount('%s') failed with %s, try %2i...",
 		         path, tst_strerrno(err), i+1);
 
-- 
2.24.1

