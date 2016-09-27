From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Sep 2016 15:49:19 +0200
Subject: [LTP] [PATCH v6] lib: make the loop device size can be increased
In-Reply-To: <1474959083-26677-1-git-send-email-liwang@redhat.com>
References: <1474959083-26677-1-git-send-email-liwang@redhat.com>
Message-ID: <20160927134918.GF12308@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a few changes, thanks.

* I've changed the parameter passed to the ioctl() it has to be 64 bit
  unsigned integer otherwise the stack would get corrupted since the
  kernel writes 64 bit value to the pointer.

* Tweaked the documentation. Added documentation for the
  .device_min_size and cleared up the tst_acquire_device one.

The full diff is:

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index a27f24f..384ff09 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -904,6 +904,10 @@ If '.needs_device' flag in the 'struct tst_test' is set the the 'tst_device'
 structure is initialized with a path to a test device and default filesystem
 to be used.
 
+You can also request minimal device size in megabytes by setting
+'.device_min_size' in the 'struct tst_test' structure. The device is
+guaranteed to have at least the requested size then.
+
 [source,c]
 -------------------------------------------------------------------------------
 #include "tst_test.h"
@@ -919,8 +923,10 @@ int tst_umount(const char *path);
 -------------------------------------------------------------------------------
 
 In case that 'LTP_DEV' is passed to the test in an environment, the library
-checks that the file exists and that it's a block device. Otherwise a
-temporary file is created and attached to a free loop device.
+checks that the file exists and that it's a block device, if
+'.device_min_size' is set the device size is checked as well. If 'LTP_DEV'
+wasn't set or if size requirements were not met a temporary file is created
+and attached to a free loop device.
 
 If there is no usable device and loop device couldn't be initialized the test
 exits with 'TCONF'.
@@ -1330,14 +1336,24 @@ Following functions similar to the LTP C interface are available.
 * tst_mkfs()
 * tst_release_device()
 
-One more function called 'tst_check_cmds()' that gets unspecified number
-of parameters and asserts that each parameter is a name of an executable
-in '$PATH' and exits the test with 'TCONF' on first missing.
+tst_check_cmds
+++++++++++++++
+
+The 'tst_check_cmds()' function that gets unspecified number of parameters and
+asserts that each parameter is a name of an executable in '$PATH' and exits
+the test with 'TCONF' on first missing.
+
+tst_acquire_device
+++++++++++++++++++
+
+The 'tst_acquire_device()' can be used to obtain a block device for testing,
+the function takes optional parameter which can be used to request device
+minimal size in megabytes.
 
-Another one is 'tst_acquire_device()' that looks for LTP_DEV env variable
-first (which may be passed by the test driver or by a user) and returns while
-it's value greater than 150MB. It also does clear first sectors of $LTP_DEV
-and makes the block device size can be increased according to real need.
+The function returns device passed in 'LTP_DEV' environment variable if it's
+set, points to a block device, and if size requirements are met. If 'LTP_DEV'
+is not set or found suitable a temporary file is created and attached to a
+free loop device.
 
 tst_sleep
 +++++++++
diff --git a/lib/newlib_tests/tst_device.c b/lib/newlib_tests/tst_device.c
index d656904..72c2033 100644
--- a/lib/newlib_tests/tst_device.c
+++ b/lib/newlib_tests/tst_device.c
@@ -17,6 +17,7 @@
 
 #include <stdlib.h>
 #include <sys/mount.h>
+#include <stdint.h>
 
 #include "tst_test.h"
 
@@ -24,7 +25,7 @@ static void do_test(void)
 {
 	int fd;
 	const char *dev;
-	unsigned int ltp_dev_size;
+	uint64_t ltp_dev_size;
 
 	dev = tst_device->dev;
 	if (!dev)
@@ -37,7 +38,9 @@ static void do_test(void)
 	SAFE_CLOSE(fd);
 
 	if (ltp_dev_size/1024/1024 == 160)
-		tst_res(TPASS, "PASSED LTP Device Test");
+		tst_res(TPASS, "Got expected device size");
+	else
+		tst_res(TFAIL, "Got unexpected device size");
 }
 
 static struct tst_test test = {
diff --git a/lib/tst_device.c b/lib/tst_device.c
index f02d1c6..3c62df0 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -29,6 +29,8 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <linux/loop.h>
+#include <stdint.h>
+#include <inttypes.h>
 #include "test.h"
 #include "safe_macros.h"
 
@@ -188,7 +190,7 @@ const char *tst_acquire_device_(void (cleanup_fn)(void), unsigned int size)
 	char *dev;
 	struct stat st;
 	unsigned int acq_dev_size;
-	unsigned int ltp_dev_size;
+	uint64_t ltp_dev_size;
 
 	acq_dev_size = size > 150 ? size : 150;
 
@@ -226,7 +228,7 @@ const char *tst_acquire_device_(void (cleanup_fn)(void), unsigned int size)
 			return dev;
 		}
 
-		tst_resm(TINFO, "Skipping $LTP_DEV size %luMB, requested size %luMB",
+		tst_resm(TINFO, "Skipping $LTP_DEV size %"PRIu64"MB, requested size %uMB",
 				ltp_dev_size, acq_dev_size);
 	}
 

-- 
Cyril Hrubis
chrubis@suse.cz
