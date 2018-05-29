From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Tue, 29 May 2018 17:53:35 +0200
Subject: [LTP] [PATCH] testcase: kernel: ioctl: Handle ENOENT error
Message-ID: <20180529155335.5224-1-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

In case the folder /dev/net is not available, the error
returned is ENOENT and not ENODEV.
Handle this case to return a TCONF instead of a TFAIL.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
---
 testcases/kernel/syscalls/ioctl/ioctl03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl03.c b/testcases/kernel/s=
yscalls/ioctl/ioctl03.c
index 0ae3cb244..b1b50edb4 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl03.c
@@ -80,7 +80,7 @@ static void verify_features(void)
=20
 	int netfd =3D open("/dev/net/tun", O_RDWR);
 	if (netfd =3D=3D -1) {
-		if (errno =3D=3D ENODEV)
+		if (errno =3D=3D ENODEV || errno =3D=3D ENOENT)
 			tst_brk(TCONF, "TUN support is missing?");
=20
 		tst_brk(TBROK | TERRNO, "opening /dev/net/tun failed");
--=20
2.11.0

