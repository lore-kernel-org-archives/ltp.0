From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Fri, 20 Jan 2017 14:54:16 +0800
Subject: [LTP] [PATCH] commands/insmod: Add ltp_insmod01.ko to .gitignore
	and cleanup
Message-ID: <1484895256-29665-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

commands/size have been removed in:

commit 1ce062f321280daf540c666b068def7d137359b6
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Tue Oct 25 17:22:23 2016 +0200

commands: objdump01, size01: Remove.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/commands/.gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/.gitignore b/testcases/commands/.gitignore
index 4a5a719..9aa1caf 100644
--- a/testcases/commands/.gitignore
+++ b/testcases/commands/.gitignore
@@ -1,5 +1,5 @@
 /ldd/datafiles/lddfile.out
 /ldd/datafiles/*.obj.so
-/size/test
 /cron/cron_dirs_check
 /eject/eject_check_tray
+/insmod/ltp_insmod01.ko
-- 
1.8.4.2



