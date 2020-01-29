From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 29 Jan 2020 15:49:11 +0100
Subject: [LTP] [PATCH 1/3] Fix releasing loop devices in shell API
In-Reply-To: <20200129144913.9889-1-mdoucha@suse.cz>
References: <20200129144913.9889-1-mdoucha@suse.cz>
Message-ID: <20200129144913.9889-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_device helper program currently cannot release any loop devices because
tst_release_device() checks whether any loop device was acquired by the same
process. If not, it'll do nothing. And since loop devices for shell test
scripts are always acquired by a different tst_device process, the check always
fails.

Call tst_detach_device() instead to bypass the check.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/old/old_device.h   | 6 ++++++
 testcases/lib/tst_device.c | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/old/old_device.h b/include/old/old_device.h
index 17da57e1f..d2f1ecde5 100644
--- a/include/old/old_device.h
+++ b/include/old/old_device.h
@@ -41,6 +41,7 @@ const char *tst_dev_fs_type(void);
  * Note that you have to call tst_tmpdir() beforehand.
  *
  * Returns path to the device or NULL if it cannot be created.
+ * Call tst_release_device() when you're done.
  */
 const char *tst_acquire_device_(void (cleanup_fn)(void), unsigned int size);
 
@@ -56,6 +57,11 @@ static inline const char *tst_acquire_device(void (cleanup_fn)(void))
  */
 int tst_release_device(const char *dev);
 
+/*
+ * @dev: device path returned by the tst_acquire_device()
+ */
+int tst_detach_device(const char *dev);
+
 /*
  * Just like umount() but retries several times on failure.
  * @path: Path to umount
diff --git a/testcases/lib/tst_device.c b/testcases/lib/tst_device.c
index dc47d6f03..a657db30b 100644
--- a/testcases/lib/tst_device.c
+++ b/testcases/lib/tst_device.c
@@ -60,7 +60,13 @@ static int release_device(int argc, char *argv[])
 	if (argc != 3)
 		return 1;
 
-	return tst_release_device(argv[2]);
+	/*
+	 * tst_acquire_device() was called in a different process.
+	 * tst_release_device() would think that no device was acquired yet
+	 * and do nothing. Call tst_detach_device() directly to bypass
+	 * the check.
+	 */
+	return tst_detach_device(argv[2]);
 }
 
 int main(int argc, char *argv[])
-- 
2.24.1

