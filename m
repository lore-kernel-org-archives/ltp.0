From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 10 Feb 2020 13:47:20 +0100
Subject: [LTP] [PATCH] syscalls/setrlimit06: lower RLIMIT_CPU parameters
Message-ID: <87e6761eb699c7912e2064dea222f5ac7fd04a6b.1581338640.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Lower the parameters so that test completes faster where possible.

This also increases alarm timer slightly, which in combination with
lower RLIMIT_CPU aims to avoid false positives in environments with
high steal time, where it can take multiple of wall clock seconds
to spend single second on a cpu.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/setrlimit/setrlimit06.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit06.c b/testcases/kernel/syscalls/setrlimit/setrlimit06.c
index 726b26841583..3e5bf1d4253d 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit06.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit06.c
@@ -59,8 +59,8 @@ static void verify_setrlimit(void)
 	pid = SAFE_FORK();
 	if (!pid) {
 		struct rlimit rlim = {
-			.rlim_cur = 2,
-			.rlim_max = 3,
+			.rlim_cur = 1,
+			.rlim_max = 2,
 		};
 
 		TEST(setrlimit(RLIMIT_CPU, &rlim));
@@ -70,7 +70,7 @@ static void verify_setrlimit(void)
 			exit(1);
 		}
 
-		alarm(10);
+		alarm(20);
 
 		while (1);
 	}
-- 
2.18.1

