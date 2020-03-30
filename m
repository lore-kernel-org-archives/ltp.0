From: Zou Wei <zou_wei@huawei.com>
Date: Mon, 30 Mar 2020 10:44:23 +0800
Subject: [LTP] [PATCH v2] syscalls/statx: Add judgment to the MODE value
Message-ID: <1585536263-23084-1-git-send-email-zou_wei@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v2:
Clear current umask by umask(0) in setup()

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 testcases/kernel/syscalls/statx/statx01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index 4f9d582..b66c2b6 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -147,6 +147,8 @@ static void setup(void)
 {
 	char data_buff[SIZE];
 	int file_fd;
+
+	umask(0);

 	memset(data_buff, '@', sizeof(data_buff));

--
2.6.2

