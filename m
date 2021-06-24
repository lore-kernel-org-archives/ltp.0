From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Thu, 24 Jun 2021 11:15:00 +0300
Subject: [LTP] [PATCH 2/2] fcntl38: check required kernel config option for
 dnotify
In-Reply-To: <20210624081500.11715-1-aleksei.kodanev@bell-sw.com>
References: <20210624081500.11715-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210624081500.11715-2-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 testcases/kernel/syscalls/fcntl/fcntl38.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl38.c b/testcases/kernel/syscalls/fcntl/fcntl38.c
index 6185d3209..fae2ab4f7 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl38.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl38.c
@@ -93,4 +93,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_dnotify,
+	.needs_kconfigs = (const char *[]) { "CONFIG_DNOTIFY=y", NULL },
 };
-- 
2.25.1

