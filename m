From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 12 May 2020 15:28:24 +0100
Subject: [LTP] [PATCH 2/2] pty04: Retry reads when short
In-Reply-To: <20200512142824.13063-1-rpalethorpe@suse.com>
References: <20200512142824.13063-1-rpalethorpe@suse.com>
Message-ID: <20200512142824.13063-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Even though reads are blocking and packets are flipped into the netdevice
buffer whole, it seems read may return before a full packet is read into user
land. Retrying read should prevent timeouts and read failures on some
machines.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reported-by: Jan Stancek <jstancek@redhat.com>
Cc: Petr Vorel <pvorel@suse.cz>
---

NOTE: When running this test repeatedly and in parallel; strange things still
happen, see:
https://github.com/linux-test-project/ltp/issues/674#issuecomment-625181783

However this hopefully will fix the timeout issues and read failures reported
by some testers.

 testcases/kernel/pty/pty04.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
index bfda08b2b..9b2911421 100644
--- a/testcases/kernel/pty/pty04.c
+++ b/testcases/kernel/pty/pty04.c
@@ -288,9 +288,20 @@ static void check_data(const struct ldisc_info *ldisc,
 		tst_res(TINFO, "Will continue test without data checking");
 }
 
+static ssize_t try_read(int fd, char *data, ssize_t size, ssize_t *n)
+{
+	ssize_t ret = read(fd, data, size);
+
+	if (ret < 0)
+		return -(errno != EAGAIN);
+
+	return (*n += ret) >= size;
+}
+
 static void read_netdev(const struct ldisc_info *ldisc)
 {
-	int rlen, plen = 0;
+	int ret, rlen, plen = 0;
+	ssize_t n;
 	char *data;
 
 	switch (ldisc->n) {
@@ -305,20 +316,27 @@ static void read_netdev(const struct ldisc_info *ldisc)
 
 	tst_res(TINFO, "Reading from socket %d", sk);
 
-	SAFE_READ(1, sk, data, plen);
+	n = 0;
+	ret = TST_RETRY_FUNC(try_read(sk, data, plen, &n), TST_RETVAL_NOTNULL);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "Read %zd of %d bytes", n, plen);
 	check_data(ldisc, data, plen);
 	tst_res(TPASS, "Read netdev 1");
 
-	SAFE_READ(1, sk, data, plen);
+	n = 0;
+	ret = TST_RETRY_FUNC(try_read(sk, data, plen, &n), TST_RETVAL_NOTNULL);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "Read %zd of %d bytes", n, plen);
 	check_data(ldisc, data, plen);
 	tst_res(TPASS, "Read netdev 2");
 
 	TST_CHECKPOINT_WAKE(0);
-	while((rlen = read(sk, data, plen)) > 0)
+	while ((rlen = read(sk, data, plen)) > 0)
 		check_data(ldisc, data, rlen);
 
 	tst_res(TPASS, "Reading data from netdev interrupted by hangup");
 
+	close(sk);
 	tst_free_all();
 }
 
@@ -357,6 +375,7 @@ static void cleanup(void)
 {
 	ioctl(pts, TIOCVHANGUP);
 	ioctl(ptmx, TIOCVHANGUP);
+	close(sk);
 
 	tst_reap_children();
 }
-- 
2.26.1

