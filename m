From: Li Wang <liwang@redhat.com>
Date: Mon, 28 May 2018 18:39:36 +0800
Subject: [LTP] [PATCH] pty: using tcgetattr() to get attributes before
	re-setting it
Message-ID: <20180528103936.22538-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To fix this error:
  tst_test.c:1015: INFO: Timeout per run is 0h 50m 00s
  pty02.c:42: BROK: tcsetattr() failed: EINVAL

POSIX.1 General description:
  Changes the attributes associated with a terminal. New attributes are
  specified with a termios control structure. Programs should always
  issue a tcgetattr() first, modify the desired fields, and then issue
  a tcsetattr(). tcsetattr() should never be issued using a termios
  structure that was not obtained using tcgetattr(). tcsetattr() should
  use only a termios structure that was obtained by tcgetattr().

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/pty/pty02.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/pty/pty02.c b/testcases/kernel/pty/pty02.c
index fd3d26b..0cedca8 100644
--- a/testcases/kernel/pty/pty02.c
+++ b/testcases/kernel/pty/pty02.c
@@ -31,13 +31,18 @@
 
 static void do_test(void)
 {
-	struct termios io = { .c_lflag = EXTPROC | ICANON };
+	struct termios io;
 	int ptmx, pts;
 	char c = 'A';
 	int nbytes;
 
 	ptmx = SAFE_OPEN("/dev/ptmx", O_WRONLY);
 
+	if (tcgetattr(ptmx, &io) != 0)
+		tst_brk(TBROK | TERRNO, "tcgetattr() failed");
+
+	io.c_lflag = EXTPROC | ICANON;
+
 	if (tcsetattr(ptmx, TCSANOW, &io) != 0)
 		tst_brk(TBROK | TERRNO, "tcsetattr() failed");
 
-- 
2.9.5

