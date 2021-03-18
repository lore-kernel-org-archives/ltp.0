From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 18 Mar 2021 13:09:31 +0000
Subject: [LTP] [PATCH v2 3/7] fzsync: Correctly print positive lower delay
 range bound
In-Reply-To: <20210318130935.28528-1-rpalethorpe@suse.com>
References: <20210318130935.28528-1-rpalethorpe@suse.com>
Message-ID: <20210318130935.28528-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If the magnitude of delay_bias is large enough then it can turn the
lower bound positive.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_fuzzy_sync.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index b8841d96d..4063e95cb 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -518,9 +518,9 @@ static void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
 			tst_res(TINFO,
 				"Reached deviation ratios < %.2f, introducing randomness",
 				pair->max_dev_ratio);
-			tst_res(TINFO, "Delay range is [-%d, %d]",
-				(int)(pair->diff_sb.avg / per_spin_time) + pair->delay_bias,
-				(int)(pair->diff_sa.avg / per_spin_time) - pair->delay_bias);
+			tst_res(TINFO, "Delay range is [%d, %d]",
+				-(int)(pair->diff_sb.avg / per_spin_time) + pair->delay_bias,
+				(int)(pair->diff_sa.avg / per_spin_time) + pair->delay_bias);
 			tst_fzsync_pair_info(pair);
 			pair->sampling = -1;
 		}
-- 
2.30.1

