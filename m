From: Li Wang <liwang@redhat.com>
Date: Thu,  3 Dec 2020 11:06:16 +0000
Subject: [LTP] [PATCH 3/3] af_alg07: add dynamic bias for ARM
In-Reply-To: <20201203110616.28302-1-liwang@redhat.com>
References: <20201203110616.28302-1-liwang@redhat.com>
Message-ID: <20201203110616.28302-3-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We observed that af_alg07 sporadically failed on hpe-moonshot(aarch64) with
fixed kernel, but after trying manually we can NOT reproduce it again, one
possibility is that the FAIL is caused by an unaligned race window between
two threads, so here add dynamic bias adjustment to see if it helps.

Point of view from Martin Doucha:
1) fchownat() returns 0 => fchownat() was called too early or the kernel is vulnerable
2) fchwonat() fails with ENOENT => kernel is fixed, print TPASS and exit
3) fchownat() fails with EBADF => fchownat() was called too late

Signed-off-by: Li Wang <liwang@redhat.com>
CC: Richard Palethorpe <rpalethorpe@suse.com>
CC: Martin Doucha <mdoucha@suse.cz>
CC: Joerg Vehlow <lkml@jv-coder.de>
CC: Chunyu Hu <chuhu@redhat.com>
CC: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/crypto/af_alg07.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/testcases/kernel/crypto/af_alg07.c b/testcases/kernel/crypto/af_alg07.c
index 539ebee11..ee48c2edb 100644
--- a/testcases/kernel/crypto/af_alg07.c
+++ b/testcases/kernel/crypto/af_alg07.c
@@ -76,6 +76,16 @@ static void run(void)
 			return;
 		}
 
+		if (TST_RET == 0) {
+			tst_fzsync_pair_add_bias(&fzsync_pair, -1);
+			continue;
+		}
+
+		if (TST_RET == -1 && TST_ERR == EBADF) {
+			tst_fzsync_pair_add_bias(&fzsync_pair, 1);
+			continue;
+		}
+
 		if (TST_RET == -1 && TST_ERR == ENOENT) {
 			tst_res(TPASS | TTERRNO,
 				"fchownat() failed successfully");
-- 
2.21.3

