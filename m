From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Jun 2021 23:48:04 +0200
Subject: [LTP] [PATCH v3 1/5] tst_device: Require root
In-Reply-To: <20210629214808.18760-1-pvorel@suse.cz>
References: <20210629214808.18760-1-pvorel@suse.cz>
Message-ID: <20210629214808.18760-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

as it's actually required for successful run:
tst_device.c:100: TINFO: Not allowed to open /dev/loop-control. Are you root?: EACCES (13)
tst_device.c:139: TINFO: No free devices found
tst_device.c:335: TBROK: Failed to acquire device

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/tst_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/newlib_tests/tst_device.c b/lib/newlib_tests/tst_device.c
index ad077affd..0bee0a939 100644
--- a/lib/newlib_tests/tst_device.c
+++ b/lib/newlib_tests/tst_device.c
@@ -40,6 +40,7 @@ static void do_test(void)
 }
 
 static struct tst_test test = {
+	.needs_root = 1,
 	.needs_device = 1,
 	.dev_min_size = 300,
 	.test_all = do_test,
-- 
2.32.0

