From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 7 Jul 2017 14:29:34 +0200
Subject: [LTP] [PATCH v4] syscalls/shmat0*: cleanup && convert to new API
In-Reply-To: <1499051354-10926-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20170630145418.GE18305@rei.lan>
 <1499051354-10926-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170707122933.GA28534@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor change, thanks.

diff --git a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
index ac50fdd27..a9771519d 100644
--- a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
+++ b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
@@ -88,10 +88,9 @@ void *probe_free_addr(const char *file, const int lineno)
        int shm_id = -1;
        key_t probe_key = 0;
 
-       if (!probe_key)
-               probe_key = GETIPCKEY();
+       probe_key = GETIPCKEY();

  We initialized the probe_key to zero 0 here so there is no need for the if ().


-- 
Cyril Hrubis
chrubis@suse.cz
