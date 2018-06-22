From: Alistair Strachan <astrachan@google.com>
Date: Fri, 22 Jun 2018 14:57:07 -0700
Subject: [LTP] [PATCH] pathconf01: Use TMPDIR instead of "/tmp" if set
Message-ID: <20180622215710.126661-1-astrachan@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Enable this test to work in environments without a /tmp directory.

Signed-off-by: Alistair Strachan <astrachan@google.com>
---
 testcases/kernel/syscalls/pathconf/pathconf01.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/pathconf/pathconf01.c b/testcases/kernel/syscalls/pathconf/pathconf01.c
index ddbe87f7a..362bae94f 100644
--- a/testcases/kernel/syscalls/pathconf/pathconf01.c
+++ b/testcases/kernel/syscalls/pathconf/pathconf01.c
@@ -154,7 +154,8 @@ int main(int ac, char **av)
 	tst_parse_opts(ac, av, options, &help);
 
 	if (!lflag) {
-		path = strdup("/tmp");
+		tst_tmpdir();
+		path = tst_get_tmpdir();
 	}
     /***************************************************************
      * perform global setup for test
@@ -221,7 +222,10 @@ void setup(void)
  ***************************************************************/
 void cleanup(void)
 {
-
+	if (!lflag) {
+		tst_rmdir();
+		free(path);
+	}
 }
 
 /***************************************************************
