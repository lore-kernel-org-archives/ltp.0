Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9002FC71135
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 10:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750069635; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=MZfGtHHawFaAvw+E7u/37zUPZGmjJ8Mu3QY5sA2qcq0=;
 b=JKFEAGK9Q70X6rR/pQ24TEhLAd83Z0xDoxKqTTT+EZX9XFxy8pN6RG+6ACh0xs0N+hJTs
 o/Cm4Yd9TijcyjbLZnacL18oaZDwc6f775nTvtjH3Vi6YzWpwz+77i9+RSZnNn9emL2s0lO
 0oB3MueJkzZuBkoFyzcSayB1cMhnaQc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D8F83CC01F
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 12:27:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F9623CC01F
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 12:26:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B18ED200AF7
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 12:26:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750069592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gpliy1tNayD88QYBScau4I81e1O6Na0IKZeH8Imdzjo=;
 b=cduP5eJAf+AOTVOlqO95YZJDCjjHM5qiaS7j0O98F4tuws9vLozaSud8nCvf0FclDnmBVW
 1ei2Eui+/qADHSnp34sebCZloAyVbqggpQxzl5c1jf5WVFMNgte9zjp49x7jF1tePU2Taa
 n0eLnRVDcBe3CDawrOeshJpk5hDbIjU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-a4NjaanKPfK6-epjcs5H2Q-1; Mon,
 16 Jun 2025 06:26:29 -0400
X-MC-Unique: a4NjaanKPfK6-epjcs5H2Q-1
X-Mimecast-MFC-AGG-ID: a4NjaanKPfK6-epjcs5H2Q_1750069588
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4282019560AE; Mon, 16 Jun 2025 10:26:28 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.224])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5699B195608F; Mon, 16 Jun 2025 10:26:25 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 16 Jun 2025 18:26:18 +0800
Message-ID: <20250616102619.54254-3-liwang@redhat.com>
In-Reply-To: <20250616102619.54254-1-liwang@redhat.com>
References: <20250616102619.54254-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5vav7VIs9xe2_2Jh7nl0zxSOsPfQAXyrg8KbajBPHMk_1750069588
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] kernel/pec: switch to new checkpoint wait/wake
 interface
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some PEC tests were failing due to incorrect checkpoint reinitialization.
This issue was introduced by commit bf9589d5bd ("lib: moves test infrastructure
states into a shared context structure"), where the new tst_reinit() added
magic validation and can no longer be used in a standalone process.

For example:

  cn_pec 1 TINFO: Test process events connector
  cn_pec 1 TINFO: Testing fork event (nevents=10)
  tst_test.c:203: TBROK: Invalid shared memory region (bad magic)
  cn_pec 1 TBROK: tst_checkpoint wait 10000 0 failed

This patch updates the PEC test components to use the new futex-based
checkpoint mechanism via `tst_checkpoint.h`, which supports inter-process
synchronization across exec() boundaries.

Changes:

 - Replace legacy `tst_reinit()` with `TST_CHECKPOINT_WAIT(id)` and
   `TST_CHECKPOINT_WAKE(0)`
 - Remove unnecessary braces
 - Add `#include "tst_checkpoint.h"`

This improves robustness and aligns with the refactored checkpoint
infrastructure based on shared futex memory.

Follow-up: bf9589d5bd ("lib: moves test infrastructure states into a shared context structure")
Reported-by: Avinesh Kumar <akumar@suse.de>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/connectors/pec/event_generator.c | 3 ++-
 testcases/kernel/connectors/pec/pec_listener.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/connectors/pec/event_generator.c b/testcases/kernel/connectors/pec/event_generator.c
index 4945058ff..3110512ca 100644
--- a/testcases/kernel/connectors/pec/event_generator.c
+++ b/testcases/kernel/connectors/pec/event_generator.c
@@ -18,6 +18,7 @@
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
+#include "tst_checkpoint.h"
 
 extern struct tst_test *tst_test;
 static struct tst_test test = {
@@ -186,7 +187,7 @@ int main(int argc, char **argv)
 
 	/* ready to generate events */
 	if (checkpoint_id != -1) {
-		tst_reinit();
+		tst_checkpoint_reinit(__FILE__, __LINE__, NULL);
 		TST_CHECKPOINT_WAIT(checkpoint_id);
 	}
 
diff --git a/testcases/kernel/connectors/pec/pec_listener.c b/testcases/kernel/connectors/pec/pec_listener.c
index 01ee91d43..2d04b2842 100644
--- a/testcases/kernel/connectors/pec/pec_listener.c
+++ b/testcases/kernel/connectors/pec/pec_listener.c
@@ -19,6 +19,7 @@
 #include <signal.h>
 #include <linux/types.h>
 #include <linux/netlink.h>
+
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_checkpoint.h"
@@ -307,7 +308,7 @@ int main(int argc, char * const argv[])
 
 	/* ready to receive events */
 	if (checkpoint_id != -1) {
-		tst_reinit();
+		tst_checkpoint_reinit(__FILE__, __LINE__, NULL);
 		TST_CHECKPOINT_WAKE(0);
 	}
 
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
