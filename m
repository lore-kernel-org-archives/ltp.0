From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 25 Sep 2020 23:09:49 +0800
Subject: [LTP] [PATCH] pty/pty03.c: Add another linux git tag
Message-ID: <20200925150949.127675-1-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Running pty03 can trigger the following error on the kernel which
applys commit 0ace17d568241 but doesn't apply commit dd42bf1197144:
----------------------------------------------------------
pty03.c:103: TINFO: Creating PTY with HDLC line discipline
pty03.c:91: TFAIL: Failed to set the HDLC line discipline: EEXIST (17)
----------------------------------------------------------

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/pty/pty03.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/pty/pty03.c b/testcases/kernel/pty/pty03.c
index e71739a71..71bcb2eb6 100644
--- a/testcases/kernel/pty/pty03.c
+++ b/testcases/kernel/pty/pty03.c
@@ -24,6 +24,9 @@
  *
  * Fixed by commit 0ace17d568241:
  * "can, slip: Protect tty->disc_data in write_wakeup and close with RCU"
+ *
+ * This is also regression test for commit:
+ * dd42bf1197144 ("tty: Prevent ldisc drivers from re-using stale tty fields")
  */
 
 #define _GNU_SOURCE
@@ -151,6 +154,7 @@ static struct tst_test test = {
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "0ace17d568241"},
 		{"CVE", "2020-14416"},
+		{"linux-git", "dd42bf1197144"},
 		{}
 	}
 };
-- 
2.25.1



