From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 24 Aug 2020 14:10:11 +0200
Subject: [LTP] [PATCH] syscalls/setsockopt05: associate receiver with
 destination address
Message-ID: <c73f6b2e1232d6a892ecef76370ea2cf6c7dd044.1598270814.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to avoid sporadic ECONNREFUSED errors:
  safe_net.c:202: BROK: setsockopt05.c:70: send(6, 0x3ffcaf7d828, 4000, 32768) failed: ECONNREFUSED (111)

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/setsockopt/setsockopt05.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
index e78ef236e337..469e5a64bf71 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
@@ -37,6 +37,7 @@ static void setup(void)
 	int real_uid = getuid();
 	int real_gid = getgid();
 	int sock;
+	int port = TST_GET_UNUSED_PORT(AF_INET, SOCK_DGRAM);
 	struct ifreq ifr;
 
 	SAFE_UNSHARE(CLONE_NEWUSER);
@@ -45,14 +46,14 @@ static void setup(void)
 	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1", real_uid);
 	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1", real_gid);
 
-	tst_init_sockaddr_inet_bin(&addr, INADDR_LOOPBACK, 12345);
+	tst_init_sockaddr_inet_bin(&addr, INADDR_LOOPBACK, port);
 	sock = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
 	strcpy(ifr.ifr_name, "lo");
 	ifr.ifr_mtu = 1500;
 	SAFE_IOCTL(sock, SIOCSIFMTU, &ifr);
 	ifr.ifr_flags = IFF_UP;
 	SAFE_IOCTL(sock, SIOCSIFFLAGS, &ifr);
-	SAFE_CLOSE(sock);
+	SAFE_BIND(sock, (struct sockaddr *)&addr, sizeof(struct sockaddr));
 }
 
 static void run(void)
-- 
2.18.1

