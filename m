From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 28 Oct 2020 17:10:56 +0000
Subject: [LTP] [PATCH] pty04: Limit the number of packets sent to avoid
 timeout
Message-ID: <20201028171056.2151-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

At the end of the test we transmit many packets while closing the PTY
to check for races in the kernel. However if the process which closes
the PTY is delayed this can result a very large number of packets
being transmitted. The kernel appears to handle this quite slowly
which can cause the test to timeout or even a softlockup.

This is not supposed to be a performance test, so this commit puts an
upper bound on the number of packets transmitted.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

Hopefully will solve: https://github.com/linux-test-project/ltp/issues/674

 testcases/kernel/pty/pty04.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
index 4adf2cbb7..a59de7830 100644
--- a/testcases/kernel/pty/pty04.c
+++ b/testcases/kernel/pty/pty04.c
@@ -136,7 +136,8 @@ static int open_pty(const struct ldisc_info *ldisc)
 static ssize_t try_write(int fd, const char *data,
 			 ssize_t size, ssize_t *written)
 {
-	ssize_t ret = write(fd, data, size);
+	ssize_t off = written ? *written : 0;
+	ssize_t ret = write(fd, data + off, size);
 
 	if (ret < 0)
 		return -(errno != EAGAIN);
@@ -149,6 +150,7 @@ static void write_pty(const struct ldisc_info *ldisc)
 	char *data;
 	ssize_t written, ret;
 	size_t len = 0;
+	int max_writes = 1000;
 
 	switch (ldisc->n) {
 	case N_SLIP:
@@ -190,7 +192,8 @@ static void write_pty(const struct ldisc_info *ldisc)
 
 	tst_res(TPASS, "Wrote PTY %s %d (2)", ldisc->name, ptmx);
 
-	while (try_write(ptmx, data, len, NULL) >= 0)
+	TST_CHECKPOINT_WAIT2(0, 100000);
+	while (max_writes-- && try_write(ptmx, data, len, NULL) >= 0)
 		;
 
 	tst_res(TPASS, "Writing to PTY interrupted by hangup");
@@ -331,7 +334,7 @@ static void read_netdev(const struct ldisc_info *ldisc)
 	check_data(ldisc, data, plen);
 	tst_res(TPASS, "Read netdev %s %d (2)", ldisc->name, sk);
 
-	TST_CHECKPOINT_WAKE(0);
+	TST_CHECKPOINT_WAKE2(0, 2);
 	while ((rlen = read(sk, data, plen)) > 0)
 		check_data(ldisc, data, rlen);
 
-- 
2.28.0

