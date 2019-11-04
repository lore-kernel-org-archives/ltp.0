From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  4 Nov 2019 18:09:08 +0100
Subject: [LTP] [PATCH 2/2] read_all_sys: skip debugfs
In-Reply-To: <2086f9d5a3ce152780833993e6e21d3fbd074441.1572887015.git.jstancek@redhat.com>
References: <2086f9d5a3ce152780833993e6e21d3fbd074441.1572887015.git.jstancek@redhat.com>
Message-ID: <ca8367553e721a5ef39491dc37d606877d51cfa7.1572887015.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

debugfs is meant for debugging, it exposes also device registers
and can pretty much do anything:
  https://lore.kernel.org/linux-arm-kernel/1507592549.3785589.1570404050459.JavaMail.zimbra@redhat.com/
  https://lore.kernel.org/stable/2029139028.10333037.1572874551626.JavaMail.zimbra@redhat.com/

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/fs/read_all/read_all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index cef55e20d671..8e83009a5d4d 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -83,6 +83,7 @@ static char *drop_privs;
 
 static char *blacklist[] = {
 	"/sys/power/wakeup_count",
+	"/sys/kernel/debug/*",
 };
 static unsigned int blacklist_sz = ARRAY_SIZE(blacklist);
 
-- 
1.8.3.1

