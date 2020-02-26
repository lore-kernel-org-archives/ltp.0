From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 26 Feb 2020 11:58:37 +0530
Subject: [LTP] [PATCH V4 1/10] tst_device: Add tst_is_mounted() helper
In-Reply-To: <20200226051407.GP14282@dhcp-12-102.nay.redhat.com>
References: <7c0899c42b8d8434c1cf9ca6b261993a1c09031f.1582612624.git.viresh.kumar@linaro.org>
 <305330ad290ce4802d832e02765b8723a976d4a7.1582627066.git.viresh.kumar@linaro.org>
 <20200226051407.GP14282@dhcp-12-102.nay.redhat.com>
Message-ID: <20200226062837.v3bfggksn62dk2gt@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 26-02-20, 13:14, Zorro Lang wrote:
> For example, if path is "/mnt/test", and we get a line as "/mnt/test/mnt1 ..."
> or "/mnt/mnt/test", Then this function thinks "/mnt/test" is a mountpoint.
> 
> We can refer to util-linux/sys-utils/mountpoint.c a little, but it's complicated,
> or we can call mountpoint command directly?

This is working fine for me, does this looks okay now ?

diff --git a/lib/tst_device.c b/lib/tst_device.c
index d99fb8bc554a..8bf6dacf5973 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -388,25 +388,16 @@ int tst_umount(const char *path)
 
 int tst_is_mounted(const char *path)
 {
-       char line[256];
-       FILE *file;
-       int ret = 0;
-
-       file = SAFE_FOPEN(NULL, "/proc/mounts", "r");
-
-       while (fgets(line, sizeof(line), file)) {
-               if (strstr(line, path) != NULL) {
-                       ret = 1;
-                       break;
-               }
-       }
+       char cmd[PATH_MAX];
+       int ret;
 
-       SAFE_FCLOSE(NULL, file);
+       snprintf(cmd, sizeof(cmd), "mountpoint -q %s", path);
+       ret = tst_system(cmd);
 
-       if (!ret)
+       if (ret)
                tst_resm(TINFO, "No device is mounted at %s", path);
 
-       return ret;
+       return !ret;
 }

-- 
viresh
