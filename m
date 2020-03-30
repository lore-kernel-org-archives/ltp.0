From: Zou Wei <zou_wei@huawei.com>
Date: Mon, 30 Mar 2020 15:27:49 +0800
Subject: [LTP] [PATCH v3 3/3] syscalls/statx01: Fix bug caused by default
 umask
In-Reply-To: <1585553269-119544-1-git-send-email-zou_wei@huawei.com>
References: <1585553269-119544-1-git-send-email-zou_wei@huawei.com>
Message-ID: <1585553269-119544-4-git-send-email-zou_wei@huawei.com>
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
 testcases/kernel/syscalls/statx/statx01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index 4f9d582..2358dd7 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -148,6 +148,8 @@ static void setup(void)
 	char data_buff[SIZE];
 	int file_fd;

+	umask(0);
+
 	memset(data_buff, '@', sizeof(data_buff));

 	file_fd =  SAFE_OPEN(TESTFILE, O_RDWR|O_CREAT, MODE);
--
2.6.2

