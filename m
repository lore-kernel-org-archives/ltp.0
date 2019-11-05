From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  5 Nov 2019 13:23:43 +0100
Subject: [LTP] [PATCH v2 2/2] read_all_sys: skip debugfs
In-Reply-To: <4647b3bced96c66c040078a32c13dab65558816d.1572956488.git.jstancek@redhat.com>
References: <4647b3bced96c66c040078a32c13dab65558816d.1572956488.git.jstancek@redhat.com>
Message-ID: <2796ab4f800aefe17dda60ccc8d2cc5b06c6341e.1572956488.git.jstancek@redhat.com>
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
index 46f88af2270c..68fc7d031f80 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -83,6 +83,7 @@ static char *drop_privs;
 static char *blacklist[] = {
 	NULL, /* reserved for -e parameter */
 	"/sys/power/wakeup_count",
+	"/sys/kernel/debug/*",
 };
 
 static struct tst_option options[] = {
-- 
1.8.3.1

