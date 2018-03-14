From: yang xu <xuyang.jy@cn.fujitsu.com>
Date: Wed, 14 Mar 2018 19:07:24 +0800
Subject: [LTP] [PATCH] fs/read_all: Filter /dev/watchdog*
Message-ID: <1521025644-18312-1-git-send-email-xuyang.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On some distros with Magic Close feature or built-in CONFIG_WATCHDOG_NOWAYOUT,
just closing /dev/watchdog* enabled by open leads to system reboot as expected.

If Magic Close feature is supported, just writing a specific magic character 'V'
into /dev/watchdog* before closing it can disable the watchdog.

If CONFIG_WATCHDOG_NOWAYOUT is built-in, there is no way to disable the watchdog.

Magic Close feature is introduced by:
commit 017cf080("watchDog Timer Driver Core - Add Magic Close feature")

Please see the following url for detailed watchdog info:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/watchdog/watchdog-api.txt

Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/fs/read_all/read_all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index 81806e7..a841b88 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -393,6 +393,9 @@ static void visit_dir(const char *path)
 		snprintf(dent_path, MAX_PATH,
 			 "%s/%s", path, dent->d_name);
 
+		if (!strncmp(dent_path, "/dev/watchdog", 13))
+			continue;
+
 		if (act == DA_UNKNOWN) {
 			if (lstat(dent_path, &dent_st))
 				tst_res(TINFO | TERRNO, "lstat(%s)", path);
-- 
1.8.3.1



