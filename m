From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 16 Aug 2021 12:16:51 +0100
Subject: [LTP] [PATCH v4 2/2] setsockopt08: Avoid confusion by removing TCONF
In-Reply-To: <20210816111651.29860-1-rpalethorpe@suse.com>
References: <20210812064741.4246-1-rpalethorpe@suse.com>
 <20210816111651.29860-1-rpalethorpe@suse.com>
Message-ID: <20210816111651.29860-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When not in compat mode this only tests that bad offsets result in
EINVAL. When in compat mode, we also test for the vulnerability.

Therefor I view this as two tests. The TCONF was supposed to indicate
the configuration didn't allow one of these tests. However it just
caused confusion with multiple people asking me to change it to
tst_brk.

So change it to TINFO.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/setsockopt/setsockopt08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
index 20abe85b4..1ffc69178 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
@@ -91,7 +91,7 @@ static void *buffer;
 void setup(void)
 {
 	if (tst_kernel_bits() == 32 || sizeof(long) > 4) {
-		tst_res(TCONF,
+		tst_res(TINFO,
 			"The vulnerability was only present in 32-bit compat mode");
 	}
 
-- 
2.31.1

