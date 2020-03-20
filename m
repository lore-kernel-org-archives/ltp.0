From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 20 Mar 2020 10:22:44 +0530
Subject: [LTP] [PATCH] syscalls/fspick: Call fsconfig with
 FSCONFIG_CMD_RECONFIGURE
Message-ID: <b392569b582f264927f2fea65bf14a89c03faaa5.1584679961.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Make sure mountpoint is reconfigured after all the recent changes by
calling fsconfig() with FSCONFIG_CMD_RECONFIGURE.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/fspick/fspick01.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/fspick/fspick01.c b/testcases/kernel/syscalls/fspick/fspick01.c
index 3b3635b20195..b5a35bf61e2c 100644
--- a/testcases/kernel/syscalls/fspick/fspick01.c
+++ b/testcases/kernel/syscalls/fspick/fspick01.c
@@ -43,6 +43,12 @@ static void run(unsigned int n)
 		goto out;
 	}
 
+	TEST(fsconfig(fspick_fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
+		goto out;
+	}
+
 	tst_res(TPASS, "%s: fspick() passed", tc->name);
 
 out:
-- 
2.21.0.rc0.269.g1a574e7a288b

