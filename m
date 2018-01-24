From: Michael Moese <mmoese@suse.de>
Date: Wed, 24 Jan 2018 14:03:01 +0100
Subject: [LTP] [PATCH 08/19] fix two old style function definitions in
	mem_process.c
In-Reply-To: <20180124130312.7665-1-mmoese@suse.de>
References: <20180124130312.7665-1-mmoese@suse.de>
Message-ID: <20180124130312.7665-9-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/controllers/memcg/control/mem_process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/control/mem_process.c b/testcases/kernel/controllers/memcg/control/mem_process.c
index 9007c2cd3..899467fe3 100644
--- a/testcases/kernel/controllers/memcg/control/mem_process.c
+++ b/testcases/kernel/controllers/memcg/control/mem_process.c
@@ -81,7 +81,7 @@ void touch_memory(char *p)
 		p[i] = 0xef;
 }
 
-void mem_map()
+void mem_map(void)
 {
 	static char *p;
 
@@ -101,7 +101,7 @@ void mem_map()
 /*
  * done: retrieve instructions from the named pipe
  */
-char action()
+char action(void)
 {
 	char ch;
 	int fd;
-- 
2.13.6

