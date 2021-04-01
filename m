From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Thu, 1 Apr 2021 21:56:38 +0800
Subject: [LTP] [PATCH] security/prot_hsymlinks: Set umask before mkdir
Message-ID: <20210401135638.4111-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When uid is nobody, umask is 0077, the test process might has
not permmission to access the file which created by SAFE_MKDIR
with mode 0755.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
index ecb393297..d883ab508 100644
--- a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
+++ b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
@@ -227,6 +227,8 @@ static void setup(int argc, char *argv[])

 	tst_tmpdir();

+	umask(0);
+
 	init_base_dirs();

 	init_files_dirs();
--
2.17.1

