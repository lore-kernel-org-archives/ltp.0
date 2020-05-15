From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 15 May 2020 11:39:10 +0100
Subject: [LTP] [PATCH] pty04: Avoid receiving packets from all interfaces
Message-ID: <20200515103910.8703-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Raw sockets receive all packets from all interfaces as soon as they are
created. They don't need to be bound to one or more interfaces like I thought.

This creates the socket with a NULL packet type which appears to be unused in
the Linux kernel and receives no packets. The protocol is then changed to
ETH_P_ALL when binding to the netdevice we are interested in.

I assume it is impossible for a packet to have zero for its packet type. Most
likely using ETH_P_LOOP would have been OK too, but I suppose that is really
used by some hardware.

This also fixes various other problems that have been observed with this
test. Such as memory allocation failures.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Jan Stancek <jstancek@redhat.com>
---

Another day, another patch for pty04.

 testcases/kernel/pty/pty04.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
index d574d8b2c..4adf2cbb7 100644
--- a/testcases/kernel/pty/pty04.c
+++ b/testcases/kernel/pty/pty04.c
@@ -206,7 +206,7 @@ static void open_netdev(const struct ldisc_info *ldisc)
 	SAFE_IOCTL(pts, SIOCGIFNAME, ifreq.ifr_name);
 	tst_res(TINFO, "Netdev is %s", ifreq.ifr_name);
 
-	sk = SAFE_SOCKET(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+	sk = SAFE_SOCKET(PF_PACKET, SOCK_RAW, 0);
 
 	ifreq.ifr_mtu = ldisc->mtu;
 	if (ioctl(sk, SIOCSIFMTU, &ifreq))
-- 
2.26.1

