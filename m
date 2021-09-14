From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Tue, 14 Sep 2021 20:08:49 +0300
Subject: [LTP] [PATCH v1 4/6] rt:pi-tests:test-skeleton: fix wrong return
 value
In-Reply-To: <20210914170851.22931-1-bogdan.lezhepekov@suse.com>
References: <20210914170851.22931-1-bogdan.lezhepekov@suse.com>
Message-ID: <20210914170851.22931-4-bogdan.lezhepekov@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/realtime/func/pi-tests/test-skeleton.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/realtime/func/pi-tests/test-skeleton.c b/testcases/realtime/func/pi-tests/test-skeleton.c
index 7816cf877..4a923cd2d 100644
--- a/testcases/realtime/func/pi-tests/test-skeleton.c
+++ b/testcases/realtime/func/pi-tests/test-skeleton.c
@@ -88,7 +88,7 @@ static void timeout_handler(int sig)
 		exit(1);
 	}
 	printf("\nResult:PASS\n");
-	exit(1);
+	exit(0);
 }
 
 int main(int argc, char **argv)
-- 
2.32.0

