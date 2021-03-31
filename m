From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 31 Mar 2021 09:58:33 +0200
Subject: [LTP] [PATCH 1/1] tst_mkfs: Add -I option to mkfs.vfat
In-Reply-To: <87a6qkom1p.fsf@suse.de>
References: <20210329145738.986-1-pvorel@suse.cz> <87czvhneqb.fsf@suse.de>
 <YGMYpaeR7Mp7rATD@pevik> <87a6qkom1p.fsf@suse.de>
Message-ID: <YGQrqdryrb+4f5UO@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

instead of using -I I tried Martin Doucha's suggestion to rescan partition table
with ioctl BLKRRPART. But I get EINVAL. Not sure if O_RDONLY is a proper flag,
but I also tried to open with args used for manipulating loop (open(path,
O_CREAT|O_WRONLY|O_TRUNC, S_IRUSR|S_IWUSR)) and a same issue. Happens on recent
kernel and very old kernel 3.16.

I wonder if I have wrong flags or BLKRRPART is just not supported on loop
devices. Looking into kernel sources it's this part blkdev_reread_part():

	if (!disk_part_scan_enabled(bdev->bd_disk) || bdev_is_partition(bdev))
		return -EINVAL;
Kind regards,
Petr

diff --git lib/tst_mkfs.c lib/tst_mkfs.c
index 736324f04..06fafcd18 100644
--- lib/tst_mkfs.c
+++ lib/tst_mkfs.c
@@ -15,6 +15,10 @@
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <fcntl.h>
+
 #include "test.h"
 #include "ltp_priv.h"
 #include "tst_mkfs.h"
@@ -26,7 +30,7 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 	       const char *dev, const char *fs_type,
 	       const char *const fs_opts[], const char *const extra_opts[])
 {
-	int i, pos = 1, ret;
+	int fd, i, pos = 1, ret;
 	char mkfs[64];
 	const char *argv[OPTS_MAX] = {mkfs};
 	char fs_opts_str[1024] = "";
@@ -93,6 +97,13 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 			"tst_clear_device() failed");
 	}
 
+	/* force kernel to reread partition table */
+	fd = open(dev, O_RDONLY);
+	tst_resm_(file, lineno, TINFO, "dev: %s, fd: %d", dev, fd);
+	ret = ioctl(fd, BLKRRPART);
+	tst_resm_(file, lineno, TINFO, "rc: %d", ret);
+	close(fd);
+
 	tst_resm_(file, lineno, TINFO,
 		"Formatting %s with %s opts='%s' extra opts='%s'",
 		dev, fs_type, fs_opts_str, extra_opts_str);
