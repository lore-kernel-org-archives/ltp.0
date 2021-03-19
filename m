From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 19 Mar 2021 09:18:32 +0000
Subject: [LTP] [PATCH v3 2/7] fzsync: Reset delay bias
In-Reply-To: <20210319091837.27319-1-rpalethorpe@suse.com>
References: <20210319091837.27319-1-rpalethorpe@suse.com>
Message-ID: <20210319091837.27319-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If the delay bias a preserved then it breaks tests which have multiple
scenarios and/or use -i. The test author could reset it manually in
this case, but it's likely to be error prone.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_fuzzy_sync.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 4141f5c64..b8841d96d 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -289,6 +289,7 @@ static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
 	tst_init_stat(&pair->diff_ab);
 	tst_init_stat(&pair->spins_avg);
 	pair->delay = 0;
+	pair->delay_bias = 0;
 	pair->sampling = pair->min_samples;
 
 	pair->exec_loop = 0;
-- 
2.30.1

