From: Daniel =?unknown-8bit?q?D=C3=ADaz?= <daniel.diaz@linaro.org>
Date: Wed, 20 Feb 2019 09:34:11 -0600
Subject: [LTP] [PATCH 2/3] syscalls/sighold02: Include lapi/signal.h for
	__SIGRT{MIN, MAX}
In-Reply-To: <20190220153412.18090-1-daniel.diaz@linaro.org>
References: <20190220153412.18090-1-daniel.diaz@linaro.org>
Message-ID: <20190220153412.18090-2-daniel.diaz@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

MUSL does not include __SIGRTMIN nor __SIGRTMAX. The
compatibility header can help here.

Signed-off-by: Daniel D=C3=ADaz <daniel.diaz@linaro.org>
---
 testcases/kernel/syscalls/sighold/sighold02.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/sighold/sighold02.c b/testcases/kern=
el/syscalls/sighold/sighold02.c
index d1d4b0b06..b763142df 100644
--- a/testcases/kernel/syscalls/sighold/sighold02.c
+++ b/testcases/kernel/syscalls/sighold/sighold02.c
@@ -49,6 +49,7 @@
 #include <sys/wait.h>
 #include "test.h"
 #include "safe_macros.h"
+#include "lapi/signal.h"
=20
 /* _XOPEN_SOURCE disables NSIG */
 #ifndef NSIG
--=20
2.17.1

