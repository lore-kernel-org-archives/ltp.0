From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 Feb 2020 09:46:19 +0100
Subject: [LTP] [PATCH v7 1/4] tst_umount: Fail immediately when errno !=
 EBUSY
In-Reply-To: <20200217084622.11199-1-pvorel@suse.cz>
References: <20200217084622.11199-1-pvorel@suse.cz>
Message-ID: <20200217084622.11199-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Only on EBUSY makes sense to keep trying in a loop.
This helps to use tst_umount() in safe_umount() (next commit).

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Reported-by: Jan Stancek <jstancek@redhat.com>
Acked-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_device.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 89b9c96de..8b5459def 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -363,10 +363,17 @@ int tst_umount(const char *path)
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
 
-		if (i == 0 && err == EBUSY) {
+		if (i == 0) {
 			tst_resm(TINFO, "Likely gvfsd-trash is probing newly "
 			         "mounted fs, kill it to speed up tests.");
 		}
-- 
2.25.0

