From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon, 14 May 2018 17:03:54 +0100
Subject: [LTP] [PATCH] lib/tst_device: Fill a file in megabyte sized chunks
Message-ID: <20180514160354.13281-1-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

A zero-filled file is used as backing store when creating a loopback
device. The zero-fill operations is done in 1KB sized chunks for
file-size specified in megabytes. This leads to a large number of
write calls which take long time during test setup phase in certain
environments.

Move to using 1MB sized chunks to reduce the number of write syscalls
by a few order of magnitude.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 lib/tst_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index edfacbdc7..463743443 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -268,7 +268,7 @@ const char *tst_acquire_device__(unsigned int size)
 				ltp_dev_size, acq_dev_size);
 	}
 
-	if (tst_fill_file(DEV_FILE, 0, 1024, 1024 * acq_dev_size)) {
+	if (tst_fill_file(DEV_FILE, 0, 1024 * 1024, acq_dev_size)) {
 		tst_resm(TWARN | TERRNO, "Failed to create " DEV_FILE);
 		return NULL;
 	}
-- 
2.17.0

