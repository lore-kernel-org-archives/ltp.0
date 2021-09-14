From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Tue, 14 Sep 2021 20:08:48 +0300
Subject: [LTP] [PATCH v1 3/6] rt:pi-tests:testpi-0: return actual exit code
In-Reply-To: <20210914170851.22931-1-bogdan.lezhepekov@suse.com>
References: <20210914170851.22931-1-bogdan.lezhepekov@suse.com>
Message-ID: <20210914170851.22931-3-bogdan.lezhepekov@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The original version always returned 0.

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/realtime/func/pi-tests/testpi-0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-0.c b/testcases/realtime/func/pi-tests/testpi-0.c
index fd8ad0717..64797c899 100644
--- a/testcases/realtime/func/pi-tests/testpi-0.c
+++ b/testcases/realtime/func/pi-tests/testpi-0.c
@@ -94,8 +94,10 @@ int main(int argc, char *argv[])
 	printf("LIBPTHREAD_VERSION: %s\n", pathbuf);
 	free(pathbuf);
 
-	if (sysconf(_SC_THREAD_PRIO_INHERIT) == -1)
+	if (sysconf(_SC_THREAD_PRIO_INHERIT) == -1) {
 		printf("No Prio inheritance support\n");
+		exit(1);
+	}
 
 	printf("Prio inheritance support present\n");
 
-- 
2.32.0

