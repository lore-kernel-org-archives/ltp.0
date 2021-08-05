From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Thu,  5 Aug 2021 17:08:06 +0300
Subject: [LTP] [PATCH v1] connectors/cn_pec: improve reliability
Message-ID: <20210805140806.3884-1-bogdan.lezhepekov@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sometimes pec_listener has not enough time to handle all
the generated events.

This patch only returns back the delay that was removed
in a recent patch.

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/kernel/connectors/pec/cn_pec.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/connectors/pec/cn_pec.sh b/testcases/kernel/connectors/pec/cn_pec.sh
index 9b85a5c81..24b1db761 100755
--- a/testcases/kernel/connectors/pec/cn_pec.sh
+++ b/testcases/kernel/connectors/pec/cn_pec.sh
@@ -77,6 +77,8 @@ test()
 	tst_sleep 100ms
 
 	ROD event_generator -n $num_events -e $event \>gen_$event.log 2\>gen_$event.err
+    # sleep until pec_listener has seen and handled all of the generated events
+    tst_sleep 100ms
 
 	kill -s INT $pid 2> /dev/null
 	wait $pid
-- 
2.32.0

