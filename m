From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Fri, 15 Jun 2018 08:18:07 +0200
Subject: [LTP] [PATCH] testcase: gethostid: Check if hostid is available
Message-ID: <20180615061807.15099-1-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On some embedded systems, hostid may not be installed.
Because of that, the test will fail with:

gethostid01    1  TFAIL  :  gethostid01.c:171: fgets failed

The test should return a TCONF instead.
This commit uses tst_get_path function to check if "hostid"
is available in $PATH. Otherwise, it will return a TCONF.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
---
 testcases/kernel/syscalls/gethostid/gethostid01.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/gethostid/gethostid01.c b/testcases/=
kernel/syscalls/gethostid/gethostid01.c
index e6b006759..241335af7 100644
--- a/testcases/kernel/syscalls/gethostid/gethostid01.c
+++ b/testcases/kernel/syscalls/gethostid/gethostid01.c
@@ -239,6 +239,10 @@ int main(int ac, char **av)
=20
 void setup(void)
 {
+	char path[2048];
+
+	if (tst_get_path("hostid", path, sizeof(path)))
+		tst_brkm(TCONF, NULL, "Couldn't find hostid in $PATH");
=20
 	tst_sig(FORK, DEF_HANDLER, cleanup);
=20
--=20
2.11.0

