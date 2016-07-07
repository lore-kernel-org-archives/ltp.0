From: Eryu Guan <eguan@redhat.com>
Date: Thu,  7 Jul 2016 23:05:17 +0800
Subject: [LTP] [PATCH v2 3/3] ltp-aiodio: new dio_sparse tests specifying
	offset
In-Reply-To: <1467903917-16064-1-git-send-email-eguan@redhat.com>
References: <1467903917-16064-1-git-send-email-eguan@redhat.com>
Message-ID: <1467903917-16064-3-git-send-email-eguan@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The first 4 tests are to cover the second issue described in this patch

direct-io: fix direct write stale data exposure from concurrent buffered read
https://patchwork.ozlabs.org/patch/622065/

Other tests are added to test various offsets.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v2:
- no change in v2

 runtest/ltp-aiodio.part2 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/runtest/ltp-aiodio.part2 b/runtest/ltp-aiodio.part2
index 28a84ac..00b9abf 100644
--- a/runtest/ltp-aiodio.part2
+++ b/runtest/ltp-aiodio.part2
@@ -78,3 +78,11 @@ ADSP076 dio_sparse  -a 8k -w 8192k -s 8192k -n 64
 ADSP077 dio_sparse  -a 8k -w 518192k -s 18192k -n 128
 ADSP078 dio_sparse  -a 8k -w 518192k -s 518192k -n 512
 ADSP079 dio_sparse  -a 8k -w 518192k -s 518192k -n 1000
+ADSP080 dio_sparse  -a 4k -w 4k -s 2k -o 2k -n 2
+ADSP081 dio_sparse  -a 2k -w 2k -s 1k -o 1k -n 2
+ADSP082 dio_sparse  -a 1k -w 1k -s 512 -o 512 -n 2
+ADSP083 dio_sparse  -a 4k -w 4k -s 2k -o 3k -n 2
+ADSP084 dio_sparse  -a 4k -w 4k -s 4k -o 4k -n 2
+ADSP085 dio_sparse  -a 4k -w 4k -s 4k -o 6k -n 2
+ADSP086 dio_sparse  -a 4k -w 4k -s 4k -o 8k -n 2
+ADSP087 dio_sparse  -a 4k -w 16k -s 8k -o 8k -n 2
-- 
2.7.4

