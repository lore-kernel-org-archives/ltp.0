From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 13 May 2020 13:39:44 +0100
Subject: [LTP] [PATCH v3] pty04: Retry reads when short and wait longer
Message-ID: <20200513123944.31411-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Even though reads are blocking and packets are flipped into the netdevice
buffer whole, it seems read may return before a full packet is read into user
land. Retrying read should prevent timeouts and read failures on some
machines.

Also this increases the timeout to wait for the checkpoint to a large value
because sometimes the kernel stalls, possibly while trying to (re)claim
memory, and this causes the checkpoint wait to timeout and everything to be
cleaned up. If the kernel is left in a stalled state, this can result in a
stack trace which is more useful.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reported-by: Jan Stancek <jstancek@redhat.com>
Cc: Petr Vorel <pvorel@suse.cz>
---

V3:
* Increase the timeout on the wait for the reason described above
* Add some more info to read and write results

 testcases/kernel/pty/pty04.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
index 4e16707e3..68a84ea87 100644
--- a/testcases/kernel/pty/pty04.c
+++ b/testcases/kernel/pty/pty04.c
@@ -177,7 +177,7 @@ static void write_pty(const struct ldisc_info *ldisc)
 			     TST_RETVAL_NOTNULL);
 	if (ret < 0)
 		tst_brk(TBROK | TERRNO, "Failed 1st write to PTY");
-	tst_res(TPASS, "Wrote PTY 1");
+	tst_res(TPASS, "Wrote PTY %s %d (1)", ldisc->name, ptmx);
 
 	written = 0;
 	ret = TST_RETRY_FUNC(try_write(ptmx, data, len, &written),
@@ -188,7 +188,7 @@ static void write_pty(const struct ldisc_info *ldisc)
 	if (tcflush(ptmx, TCIFLUSH))
 		tst_brk(TBROK | TERRNO, "tcflush(ptmx, TCIFLUSH)");
 
-	tst_res(TPASS, "Wrote PTY 2");
+	tst_res(TPASS, "Wrote PTY %s %d (2)", ldisc->name, ptmx);
 
 	while (try_write(ptmx, data, len, NULL) >= 0)
 		;
@@ -288,6 +288,24 @@ static void check_data(const struct ldisc_info *ldisc,
 		tst_res(TINFO, "Will continue test without data checking");
 }
 
+static void try_read(int fd, char *data, ssize_t size)
+{
+	ssize_t ret, n = 0;
+	int retry = mtu;
+
+	while (retry--) {
+		ret = read(fd, data, size - n);
+
+		if (ret < 0)
+			break;
+
+		if ((n += ret) >= size)
+			return;
+	}
+
+	tst_brk(TBROK | TERRNO, "Read %zd of %zd bytes", n, size);
+}
+
 static void read_netdev(const struct ldisc_info *ldisc)
 {
 	int rlen, plen = 0;
@@ -305,13 +323,13 @@ static void read_netdev(const struct ldisc_info *ldisc)
 
 	tst_res(TINFO, "Reading from socket %d", sk);
 
-	SAFE_READ(1, sk, data, plen);
+	try_read(sk, data, plen);
 	check_data(ldisc, data, plen);
-	tst_res(TPASS, "Read netdev 1");
+	tst_res(TPASS, "Read netdev %s %d (1)", ldisc->name, sk);
 
-	SAFE_READ(1, sk, data, plen);
+	try_read(sk, data, plen);
 	check_data(ldisc, data, plen);
-	tst_res(TPASS, "Read netdev 2");
+	tst_res(TPASS, "Read netdev %s %d (2)", ldisc->name, sk);
 
 	TST_CHECKPOINT_WAKE(0);
 	while ((rlen = read(sk, data, plen)) > 0)
@@ -319,6 +337,7 @@ static void read_netdev(const struct ldisc_info *ldisc)
 
 	tst_res(TPASS, "Reading data from netdev interrupted by hangup");
 
+	close(sk);
 	tst_free_all();
 }
 
@@ -342,7 +361,7 @@ static void do_test(unsigned int n)
 	}
 
 	if (!SAFE_FORK()) {
-		TST_CHECKPOINT_WAIT(0);
+		TST_CHECKPOINT_WAIT2(0, 100000);
 		SAFE_IOCTL(pts, TIOCVHANGUP);
 		tst_res(TINFO, "Sent hangup ioctl to PTS");
 		SAFE_IOCTL(ptmx, TIOCVHANGUP);
@@ -357,6 +376,7 @@ static void cleanup(void)
 {
 	ioctl(pts, TIOCVHANGUP);
 	ioctl(ptmx, TIOCVHANGUP);
+	close(sk);
 
 	tst_reap_children();
 }
-- 
2.26.1

