From: Michael Moese <mmoese@suse.de>
Date: Wed, 24 Jan 2018 14:02:59 +0100
Subject: [LTP] [PATCH 06/19] fix old style definition in pidns06.c
In-Reply-To: <20180124130312.7665-1-mmoese@suse.de>
References: <20180124130312.7665-1-mmoese@suse.de>
Message-ID: <20180124130312.7665-7-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/containers/pidns/pidns06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/containers/pidns/pidns06.c b/testcases/kernel/containers/pidns/pidns06.c
index cdb472640..6afcc81ee 100644
--- a/testcases/kernel/containers/pidns/pidns06.c
+++ b/testcases/kernel/containers/pidns/pidns06.c
@@ -112,7 +112,7 @@ static void setup(void)
 	check_newpid();
 }
 
-int main()
+int main(void)
 {
 	int status;
 
-- 
2.13.6

