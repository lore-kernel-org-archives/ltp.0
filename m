From: Michael Moese <mmoese@suse.de>
Date: Wed, 24 Jan 2018 14:03:00 +0100
Subject: [LTP] [PATCH 07/19] fix old style function definition in
	memcg_process_stress.c
In-Reply-To: <20180124130312.7665-1-mmoese@suse.de>
References: <20180124130312.7665-1-mmoese@suse.de>
Message-ID: <20180124130312.7665-8-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/controllers/memcg/stress/memcg_process_stress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c b/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
index 92627fe46..870575c26 100644
--- a/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
+++ b/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
@@ -37,7 +37,7 @@ unsigned long memsize;
 char **pages;
 int nr_page;
 
-void touch_memory()
+void touch_memory(void)
 {
 	int i;
 
-- 
2.13.6

