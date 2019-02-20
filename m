From: Daniel =?unknown-8bit?q?D=C3=ADaz?= <daniel.diaz@linaro.org>
Date: Wed, 20 Feb 2019 09:34:12 -0600
Subject: [LTP] [PATCH 3/3] syscalls/ptrace05: Include lapi/signal.h for
	__SIGRT{MIN, MAX}
In-Reply-To: <20190220153412.18090-1-daniel.diaz@linaro.org>
References: <20190220153412.18090-1-daniel.diaz@linaro.org>
Message-ID: <20190220153412.18090-3-daniel.diaz@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

MUSL does not include __SIGRTMIN nor __SIGRTMAX. The
compatibility header can help here.

Signed-off-by: Daniel D=C3=ADaz <daniel.diaz@linaro.org>
---
 testcases/kernel/syscalls/ptrace/ptrace05.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel=
/syscalls/ptrace/ptrace05.c
index 420330029..54cfa4d7b 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace05.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
@@ -38,6 +38,7 @@
 #include "ptrace.h"
=20
 #include "test.h"
+#include "lapi/signal.h"
=20
 char *TCID =3D "ptrace05";
 int TST_TOTAL =3D 0;
--=20
2.17.1

