From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Mar 2019 19:27:47 +0100
Subject: [LTP] [PATCH v2 0/6] ltp: AF_ALG test helpers and a few
 regression tests
In-Reply-To: <20190318171327.237014-1-ebiggers@kernel.org>
References: <20190318171327.237014-1-ebiggers@kernel.org>
Message-ID: <20190318182747.GA5924@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Eric,

> This series adds helper functions for testing AF_ALG (the userspace
> interface to algorithms in the Linux kernel's crypto API) to the
> Linux Test Project.  It then adds a few sample regression tests.

> I've had these patches sitting around for a while with the goal of also
> writing some "real" tests that test for more than these specific bugs,
> but haven't gotten around to it yet.  And I now consider further
> improving the in-kernel crypto self-tests to be a higher priority.  But
> I figured I'd send this out as-is in case people are interested in
> having this merged, e.g. maybe other people want to add AF_ALG tests to
> LTP too and the 'tst_af_alg' lib would be a good starting point.

> Changed since v1:

>     - Define 'AF_ALG' in include/lapi/socket.h if undefined.
>       Also move 'SOL_ALG' definition to there.
The only minor issue is with missing SOL_ALG on older distros.

Going to push it with this fix including lapi/socket.h on lib/tst_af_alg.c and
testcases/kernel/crypto/af_alg01.c.


Kind regards,
Petr

diff --git lib/tst_af_alg.c lib/tst_af_alg.c
index 5cae85721..9ce1ca471 100644
--- lib/tst_af_alg.c
+++ lib/tst_af_alg.c
@@ -9,6 +9,7 @@
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_af_alg.h"
+#include "lapi/socket.h"
 
 int tst_alg_create(void)
 {
diff --git testcases/kernel/crypto/af_alg01.c testcases/kernel/crypto/af_alg01.c
index 1ce0e2508..bb6e01738 100644
--- testcases/kernel/crypto/af_alg01.c
+++ testcases/kernel/crypto/af_alg01.c
@@ -14,6 +14,7 @@
 
 #include "tst_test.h"
 #include "tst_af_alg.h"
+#include "lapi/socket.h"
 
 static void test_with_hash_alg(const char *hash_algname)
 {
