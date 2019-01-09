From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed,  9 Jan 2019 14:32:05 +0100
Subject: [LTP] [PATCH] Check recvmmsg exists before entering fuzzy loop
In-Reply-To: <20190109120129.GA19502@rei>
Message-ID: <20190109133205.31061-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Avoid thread B entering infinite loop if recvmmsg doesn't exist causing
tst_brk to be called and thread A to make an ungraceful exit.

A more general fix can be added to tst_fuzzy_sync as well, but will take
longer to develop.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reported-by: Li Wang <liwang@redhat.com>
---
 testcases/cve/cve-2016-7117.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index 6290af077..effab083d 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -99,6 +99,10 @@ static void setup(void)
 {
 	fzsync_pair.min_samples = 10000;
 
+	tst_syscall(__NR_recvmmsg);
+	if (errno == ENOSYS)
+		tst_brk(TCONF, "recvmmsg not supported");
+
 	tst_fzsync_pair_init(&fzsync_pair);
 }
 
-- 
2.19.1

