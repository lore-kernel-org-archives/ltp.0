From: Daniel =?unknown-8bit?q?D=C3=ADaz?= <daniel.diaz@linaro.org>
Date: Mon, 25 Feb 2019 11:12:20 -0600
Subject: [LTP] [PATCH] setregid01: Fix security warning for string formatting
Message-ID: <20190225171220.5827-1-daniel.diaz@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

GCC 8.2.0 complains with the following:
  setregid01.c: In function 'run':
  setregid01.c:47:3: error: format not a string literal and no format argum=
ents [-Werror=3Dformat-security]
     tst_res(TFAIL | TTERRNO, tc->msg);
     ^~~~~~~
because there is no string formatting in the message. This can
be seen with CFLAGS set to:
  -Wformat -Wformat-security -Werror=3Dformat-security
as Yocto Project's Poky does, e.g.:
  http://errors.yoctoproject.org/Errors/Details/230043/

Signed-off-by: Daniel D=C3=ADaz <daniel.diaz@linaro.org>
---
 testcases/kernel/syscalls/setregid/setregid01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/setregid/setregid01.c b/testcases/ke=
rnel/syscalls/setregid/setregid01.c
index f2e41e134..8c9e11918 100644
--- a/testcases/kernel/syscalls/setregid/setregid01.c
+++ b/testcases/kernel/syscalls/setregid/setregid01.c
@@ -44,9 +44,9 @@ static void run(unsigned int n)
 	TEST(SETREGID(*tc->arg1, *tc->arg2));
=20
 	if (TST_RET =3D=3D -1)
-		tst_res(TFAIL | TTERRNO, tc->msg);
+		tst_res(TFAIL | TTERRNO, "%s", tc->msg);
 	else
-		tst_res(TPASS, tc->msg);
+		tst_res(TPASS, "%s", tc->msg);
 }
=20
 static void setup(void)
--=20
2.17.1

