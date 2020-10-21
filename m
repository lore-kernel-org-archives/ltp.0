From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 21 Oct 2020 20:57:54 +0800
Subject: [LTP] [PATCH v3 4/4] lipipc: Remove useless get_max_msgqueues api
In-Reply-To: <1603285074-28392-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200722154558.GB2714@yuki.lan>
 <1603285074-28392-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1603285074-28392-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Only old msgstress cases use this api and we have used
SAFE_FILE_SCANF("/proc/sys/kernel/msgmni", "%d", &nr_msgqs) to get the max msgqueues.
So remove this uesless api.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 include/ipcmsg.h        |  1 -
 libs/libltpipc/libipc.c | 23 -----------------------
 2 files changed, 24 deletions(-)

diff --git a/include/ipcmsg.h b/include/ipcmsg.h
index d89894b72..21eb81b6b 100644
--- a/include/ipcmsg.h
+++ b/include/ipcmsg.h
@@ -62,7 +62,6 @@ void rm_queue(int);
 key_t getipckey();
 int getuserid(char *);
 
-int get_max_msgqueues(void);
 int get_used_msgqueues(void);
 
 #endif /* ipcmsg.h */
diff --git a/libs/libltpipc/libipc.c b/libs/libltpipc/libipc.c
index d94880f54..9c2da11b0 100644
--- a/libs/libltpipc/libipc.c
+++ b/libs/libltpipc/libipc.c
@@ -195,26 +195,3 @@ int get_used_msgqueues(void)
 	}
 	return used_queues;
 }
-
-/*
- * Get the max number of message queues allowed on system
- */
-int get_max_msgqueues(void)
-{
-	FILE *f;
-	char buff[BUFSIZE];
-
-	/* Get the max number of message queues allowed on system */
-	f = fopen("/proc/sys/kernel/msgmni", "r");
-	if (!f) {
-		tst_resm(TBROK, "Could not open /proc/sys/kernel/msgmni");
-		return -1;
-	}
-	if (!fgets(buff, BUFSIZE, f)) {
-		fclose(f);
-		tst_resm(TBROK, "Could not read /proc/sys/kernel/msgmni");
-		return -1;
-	}
-	fclose(f);
-	return atoi(buff);
-}
-- 
2.23.0



