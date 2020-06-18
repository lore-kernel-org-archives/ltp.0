From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 18 Jun 2020 15:28:16 +0200
Subject: [LTP] [PATCH] pty03: Add CVE reference and add it to the CVE runfile
Message-ID: <20200618132816.22086-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 runtest/cve                  | 1 +
 testcases/kernel/pty/pty03.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/runtest/cve b/runtest/cve
index bbbe965d4..a3a25dbe1 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -53,3 +53,4 @@ cve-2018-1000204 ioctl_sg01
 cve-2018-18559 bind06
 cve-2018-19854 crypto_user01
 cve-2020-11494 pty04
+cve-2020-14416 pty03
diff --git a/testcases/kernel/pty/pty03.c b/testcases/kernel/pty/pty03.c
index 8e05ad3be..e71739a71 100644
--- a/testcases/kernel/pty/pty03.c
+++ b/testcases/kernel/pty/pty03.c
@@ -2,6 +2,8 @@
 /*
  * Copyright (c) 2020 SUSE
  *
+ * CVE-2020-14416
+ *
  * Test based on Syzkaller reproducer:
  * https://syzkaller.appspot.com/bug?id=680c24ff647dd7241998e19da52e8136d2fd3523
  *
@@ -148,6 +150,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "0ace17d568241"},
+		{"CVE", "2020-14416"},
 		{}
 	}
 };
-- 
2.26.2

