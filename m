From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:20:07 +0200
Subject: [LTP] [COMMITTED] [PATCH 34/40] Make use of SAFE_SETRLIMIT()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-34-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/llseek/llseek01.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/llseek/llseek01.c b/testcases/kernel/syscalls/llseek/llseek01.c
index 6c98a4441..9ae821899 100644
--- a/testcases/kernel/syscalls/llseek/llseek01.c
+++ b/testcases/kernel/syscalls/llseek/llseek01.c
@@ -191,9 +191,7 @@ void setup(void)
 	/* Set limit low, argument is # bytes */
 	rlp.rlim_cur = rlp.rlim_max = 2 * BUFSIZ;
 
-	if (setrlimit(RLIMIT_FSIZE, &rlp) == -1)
-		tst_brkm(TBROK, cleanup,
-			 "Cannot set max. file size using setrlimit");
+	SAFE_SETRLIMIT(cleanup, RLIMIT_FSIZE, &rlp);
 
 	/* Creat/open a temporary file under above directory */
 	if ((fildes = open(TEMP_FILE, O_RDWR | O_CREAT, FILE_MODE)) == -1) {
-- 
2.13.5

