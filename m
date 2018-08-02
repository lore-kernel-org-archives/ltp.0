From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Thu,  2 Aug 2018 16:12:50 +0200
Subject: [LTP] [PATCH 1/2] testcases: netns: Check TUN support enabled
Message-ID: <20180802141251.1571-1-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

In case TUN support is not enabled, the test will fail while
performing the "ip" command with following error:
   open: No such file or directory
   netns_netlink    1  TBROK  :  netns_netlink.c:143: system() failed

As the system() call is not setting errno, we are not able to know
if the error is produced by a mis-configuration or not.

Because of that, this commit adds a check during the setup function to see
if the device "/dev/net/tun" is available or not. It is the file
that "ip tuntap add mode tap" command is looking for (and fails with
the "open" error).

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
---
 testcases/kernel/containers/netns/netns_netlink.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testcases/=
kernel/containers/netns/netns_netlink.c
index 47e8235d6..077ec5dab 100644
--- a/testcases/kernel/containers/netns/netns_netlink.c
+++ b/testcases/kernel/containers/netns/netns_netlink.c
@@ -57,6 +57,15 @@ static void cleanup(void)
=20
 static void setup(void)
 {
+	/* Check that the TUN support is available */
+	int netfd =3D open("/dev/net/tun", O_RDWR);
+	if (netfd =3D=3D -1) {
+		if (errno =3D=3D ENODEV || errno =3D=3D ENOENT)
+			tst_brkm(TCONF, NULL, "TUN support is missing?");
+
+		tst_brkm(TBROK | TERRNO, NULL, "opening /dev/net/tun failed");
+	}
+
 	tst_require_root();
 	check_iproute(IP_TUNTAP_MIN_VER);
 	check_netns();
--=20
2.11.0

