From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 13 May 2020 10:04:53 +0100
Subject: [LTP] [PATCH v2] pty04: Retry reads when short
Message-ID: <20200513090453.6071-1-rpalethorpe@suse.com>
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

V2:
* Remove while style fix
* Use plain while loop instead of exp backoff

testcases/kernel/pty/pty04.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
index 4e16707e3..8f17aba55 100644
--- a/testcases/kernel/pty/pty04.c
+++ b/testcases/kernel/pty/pty04.c
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
@@ -305,11 +323,11 @@ static void read_netdev(const struct ldisc_info *ldisc)
 
 	tst_res(TINFO, "Reading from socket %d", sk);
 
-	SAFE_READ(1, sk, data, plen);
+	try_read(sk, data, plen);
 	check_data(ldisc, data, plen);
 	tst_res(TPASS, "Read netdev 1");
 
-	SAFE_READ(1, sk, data, plen);
+	try_read(sk, data, plen);
 	check_data(ldisc, data, plen);
 	tst_res(TPASS, "Read netdev 2");
 
@@ -319,6 +337,7 @@ static void read_netdev(const struct ldisc_info *ldisc)
 
 	tst_res(TPASS, "Reading data from netdev interrupted by hangup");
 
+	close(sk);
 	tst_free_all();
 }
 
@@ -357,6 +376,7 @@ static void cleanup(void)
 {
 	ioctl(pts, TIOCVHANGUP);
 	ioctl(ptmx, TIOCVHANGUP);
+	close(sk);
 
 	tst_reap_children();
 }
-- 
2.26.1

