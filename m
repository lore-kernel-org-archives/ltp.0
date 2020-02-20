From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 20 Feb 2020 12:13:49 +0100
Subject: [LTP] [PATCH] pty: Test data transmission with SLIP line discipline
Message-ID: <20200220111349.9901-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Basic transmission test and try to trigger a possible race between receiving
and hangup (it appears there is none from my testing).

This only includes SLIP for now, but more disciplines can be added. Probably
at least CAN. However the packet generation will be different for each.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

FYI, I considered patching the kernel so that SLIP sends unthrottle after each
read, but on some physical serial lines this will cause one of the pins to
change state which some crappy device was abusing for non-flow control
purposes. Also it may interfer with flow control implemented somewhere else in
the stack. I doubt this will really cause any problems, but OTOH I don't care
about making SLIP work nicely with blocking PTYs enough to risk any change to
the kernel. AFAICT there is no reason to use SLIP with a PTY except for
virtual testing of SLIP.

 runtest/pty                     |   1 +
 testcases/kernel/pty/.gitignore |   1 +
 testcases/kernel/pty/pty04.c    | 250 ++++++++++++++++++++++++++++++++
 3 files changed, 252 insertions(+)
 create mode 100644 testcases/kernel/pty/pty04.c

diff --git a/runtest/pty b/runtest/pty
index e484da0ff..5587312d3 100644
--- a/runtest/pty
+++ b/runtest/pty
@@ -2,6 +2,7 @@
 pty01 pty01
 pty02 pty02
 pty03 pty03
+pty04 pty04
 ptem01 ptem01
 hangup01 hangup01
 
diff --git a/testcases/kernel/pty/.gitignore b/testcases/kernel/pty/.gitignore
index 5b4f6a8c9..c67d723d2 100644
--- a/testcases/kernel/pty/.gitignore
+++ b/testcases/kernel/pty/.gitignore
@@ -3,3 +3,4 @@
 /pty01
 /pty02
 /pty03
+/pty04
diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
new file mode 100644
index 000000000..65d1d51d4
--- /dev/null
+++ b/testcases/kernel/pty/pty04.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 SUSE
+ *
+ * Test transmitting data over a PTY/TTY line discipline and reading from the
+ * virtual netdev created by the line discipline. Also hangup the PTY while
+ * data is in flight to try to cause a race between the netdev being deleted
+ * and the discipline receive function writing to the netdev.
+ *
+ * Test flow:
+ * 1. Create PTY with ldisc X which creates netdev Y
+ * 2. Open raw packet socket and bind to netdev Y
+ * 3. Send data on ptmx and read packets from socket
+ * 4. Hangup while transmission in progress
+ *
+ * Note that not all line disciplines call unthrottle when they are ready to
+ * read more bytes. So it is possible to fill all the write buffers causing
+ * write to block forever (because once write sleeps it needs unthrottle to
+ * wake it). So we write with O_NONBLOCK.
+ *
+ * Also the max buffer size for PTYs is 8192, so even if the protocol MTU is
+ * greater everything may still be processed in 8129 byte chunks. At least
+ * until we are in the netdev code which can have a bigger buffer. Of course
+ * the MTU still decides exactly where the packet delimiter goes, this just
+ * concerns choosing the best packet size to cause a race.
+ */
+
+#define _GNU_SOURCE
+#include "tst_test.h"
+#include "config.h"
+
+#if defined(HAVE_LINUX_IF_PACKET_H) && defined(HAVE_LINUX_IF_ETHER_H)
+
+#include <linux/if_packet.h>
+#include <linux/if_ether.h>
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <termios.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <net/if.h>
+#include "lapi/ioctl.h"
+
+#include "tst_safe_stdio.h"
+
+struct ldisc_info {
+	int n;
+	char *name;
+	int max_mtu;
+};
+
+static struct ldisc_info ldiscs[] = {
+	{0, "TTY", 0},
+	{1, "SLIP", 8192},
+};
+
+static volatile int ptmx, pts, sk, mtu;
+
+static int set_ldisc(int tty, struct ldisc_info *ldisc)
+{
+	TEST(ioctl(tty, TIOCSETD, &ldisc->n));
+
+	if (!TST_RET)
+		return 0;
+
+	if (TST_ERR == EINVAL) {
+		tst_res(TCONF | TTERRNO,
+			"You don't appear to have the %s TTY line discipline",
+			ldisc->name);
+	} else {
+		tst_res(TBROK | TTERRNO,
+			"Failed to set the %s line discipline", ldisc->name);
+	}
+
+	return 1;
+}
+
+static void open_pty(struct ldisc_info *ldisc)
+{
+	char pts_path[PATH_MAX];
+
+	ptmx = SAFE_OPEN("/dev/ptmx", O_RDWR);
+	if (grantpt(ptmx))
+		tst_brk(TBROK | TERRNO, "grantpt(ptmx)");
+	if (unlockpt(ptmx))
+		tst_brk(TBROK | TERRNO, "unlockpt(ptmx)");
+	if (ptsname_r(ptmx, pts_path, sizeof(pts_path)))
+		tst_brk(TBROK | TERRNO, "ptsname_r(ptmx, ...)");
+
+	SAFE_FCNTL(ptmx, F_SETFL, O_NONBLOCK);
+
+	tst_res(TINFO, "PTS path is %s", pts_path);
+	pts = SAFE_OPEN(pts_path, O_RDWR);
+
+	set_ldisc(pts, ldisc);
+}
+
+static ssize_t try_write(int fd, char *data, ssize_t size, ssize_t *written)
+{
+	ssize_t ret = write(fd, data, size);
+
+	if (ret < 0)
+		return -(errno != EAGAIN);
+
+	return !written || (*written += ret) >= size;
+}
+
+static void write_pty(void)
+{
+	char *data = SAFE_MALLOC(mtu);
+	ssize_t written, ret;
+
+	memset(data, '_', mtu - 1);
+	data[mtu - 1] = 0300;
+
+	written = 0;
+	ret = TST_RETRY_FUNC(try_write(ptmx, data, mtu, &written), TST_RETVAL_NOTNULL);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "Failed 1st write to PTY");
+	tst_res(TPASS, "Wrote PTY 1");
+
+	written = 0;
+	ret = TST_RETRY_FUNC(try_write(ptmx, data, mtu, &written), TST_RETVAL_NOTNULL);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "Failed 2nd write to PTY");
+
+	if (tcflush(ptmx, TCIFLUSH))
+		tst_brk(TBROK | TERRNO, "tcflush(ptmx, TCIFLUSH)");
+
+	tst_res(TPASS, "Wrote PTY 2");
+
+	while (try_write(ptmx, data, mtu, NULL) >= 0)
+		;
+
+	tst_res(TPASS, "Writing to PTY interrupted by hangup");
+
+	free(data);
+}
+
+static void open_netdev(struct ldisc_info *ldisc)
+{
+	struct ifreq ifreq = { 0 };
+	struct sockaddr_ll lla = { 0 };
+
+	SAFE_IOCTL(pts, SIOCGIFNAME, ifreq.ifr_name);
+	tst_res(TINFO, "Netdev is %s", ifreq.ifr_name);
+
+	sk = SAFE_SOCKET(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+
+	ifreq.ifr_mtu = ldisc->max_mtu;
+	if (ioctl(sk, SIOCSIFMTU, &ifreq))
+		tst_res(TWARN | TERRNO, "Failed to set netdev MTU to maximum");
+	SAFE_IOCTL(sk, SIOCGIFMTU, &ifreq);
+	mtu = ifreq.ifr_mtu;
+	tst_res(TINFO, "Netdev MTU is %d (we set %d)", mtu, ldisc->max_mtu);
+
+	SAFE_IOCTL(sk, SIOCGIFFLAGS, &ifreq);
+	ifreq.ifr_flags |= IFF_UP | IFF_RUNNING;
+	SAFE_IOCTL(sk, SIOCSIFFLAGS, &ifreq);
+	SAFE_IOCTL(sk, SIOCGIFFLAGS, &ifreq);
+
+	if (!(ifreq.ifr_flags & IFF_UP))
+		tst_brk(TBROK, "Netdev did not come up");
+
+	SAFE_IOCTL(sk, SIOCGIFINDEX, &ifreq);
+
+	lla.sll_family = PF_PACKET;
+	lla.sll_protocol = htons(ETH_P_ALL);
+	lla.sll_ifindex = ifreq.ifr_ifindex;
+	SAFE_BIND(sk, (struct sockaddr *)&lla, sizeof(struct sockaddr_ll));
+
+	tst_res(TINFO, "Bound netdev %d to socket %d", ifreq.ifr_ifindex, sk);
+}
+
+static void read_netdev(void)
+{
+	char *data = SAFE_MALLOC(mtu - 1);
+
+	tst_res(TINFO, "Reading from socket %d", sk);
+
+	SAFE_READ(1, sk, data, mtu - 1);
+	tst_res(TPASS, "Read netdev 1");
+	SAFE_READ(1, sk, data, mtu - 1);
+
+	tst_res(TPASS, "Read netdev 2");
+
+	TST_CHECKPOINT_WAKE(0);
+	while(read(sk, data, mtu - 1) > 0)
+		;
+
+	tst_res(TPASS, "Reading data from netdev interrupted by hangup");
+
+	free(data);
+}
+
+static void do_test(unsigned int n)
+{
+	struct ldisc_info *ldisc = &ldiscs[n+1];
+
+	open_pty(ldisc);
+	open_netdev(ldisc);
+
+	if (!SAFE_FORK()) {
+		read_netdev();
+		return;
+	}
+
+	if (!SAFE_FORK()) {
+		write_pty();
+		return;
+	}
+
+	if (!SAFE_FORK()) {
+		TST_CHECKPOINT_WAIT(0);
+		SAFE_IOCTL(pts, TIOCVHANGUP);
+		tst_res(TINFO, "Sent hangup ioctl to PTS");
+		SAFE_IOCTL(ptmx, TIOCVHANGUP);
+		tst_res(TINFO, "Sent hangup ioctl to PTM");
+		return;
+	}
+
+	tst_reap_children();
+}
+
+static void cleanup(void)
+{
+	ioctl(pts, TIOCVHANGUP);
+	ioctl(ptmx, TIOCVHANGUP);
+
+	tst_reap_children();
+}
+
+static struct tst_test test = {
+	.test = do_test,
+	.cleanup = cleanup,
+	.tcnt = 1,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.needs_root = 1,
+	.min_kver = "4.10"
+};
+
+#else
+
+TST_TEST_TCONF("Need <linux/if_packet.h> and <linux/if_ether.h>");
+
+#endif
-- 
2.24.0

