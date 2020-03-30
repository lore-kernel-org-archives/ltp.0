From: Zou Wei <zou_wei@huawei.com>
Date: Mon, 30 Mar 2020 15:27:48 +0800
Subject: [LTP] [PATCH v3 2/3] syscalls/fstat: Fix bug caused by default umask
In-Reply-To: <1585553269-119544-1-git-send-email-zou_wei@huawei.com>
References: <1585553269-119544-1-git-send-email-zou_wei@huawei.com>
Message-ID: <1585553269-119544-3-git-send-email-zou_wei@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v3:
The case is only successful when system default umask is 0022.
When default umask is 0077 or other values, should clear current umask by umask(0) in setup().

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 testcases/kernel/syscalls/fstat/fstat02.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/fstat/fstat02.c b/testcases/kernel/syscalls/fstat/fstat02.c
index 4744560..c0229de 100644
--- a/testcases/kernel/syscalls/fstat/fstat02.c
+++ b/testcases/kernel/syscalls/fstat/fstat02.c
@@ -72,6 +72,8 @@ static void setup(void)
 	user_id  = getuid();
 	group_id = getgid();

+	umask(0);
+
 	fildes = SAFE_OPEN(TESTFILE, O_WRONLY | O_CREAT, FILE_MODE);

 	if (tst_fill_file(TESTFILE, 'a', FILE_SIZE, 1))
--
2.6.2

