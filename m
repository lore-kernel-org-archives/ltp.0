From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Thu, 29 Apr 2021 15:03:12 +0800
Subject: [LTP] [PATCH] proc01: Close the opened file
Message-ID: <20210429070312.16404-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
---
 testcases/kernel/fs/proc/proc01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index 96441d153..0fae6754f 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -368,6 +368,7 @@ static long readproc(const char *obj)
 		if ((statbuf.st_mode & S_IRUSR) == 0 &&
 		    (statbuf.st_mode & S_IWUSR) != 0) {
 			tst_resm(TINFO, "%s: is write-only.", obj);
+			(void)close(fd);
 			return 0;
 		}

@@ -376,6 +377,7 @@ static long readproc(const char *obj)
 			if (!strcmp(obj, error_nonblock[i])) {
 				tst_resm(TINFO, "%s: does not honor "
 					 "O_NONBLOCK", obj);
+				(void)close(fd);
 				return 0;
 			}
 		}
--
2.20.1



