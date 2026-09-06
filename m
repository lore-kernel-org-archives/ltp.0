Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725B4C79F8C
	for <ltp@archiver.kernel.org>; Sun,  6 Sep 2026 13:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788703039; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=JHw58AY/Ii5f49y7jcCQ//tduVhcvl+eVJcqYJB5Vm4=;
 b=AN9NqANrYmPhh+lDACQGuZGZMy9f+NFb4CXgFIxoMK+OfJ0CMeOs5ZL5/RwC1eqIiPYeA
 zRa8k0U/TjREjbw5UbHwPSmWUPU5Z4enIJIyHlg54rg9hxTl2Ycft9/UhF3xDeJbQ2RYJi5
 lHwinsT5hUyJkoW/j8QVndDj9l4IgxA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D84923E9063
	for <ltp@archiver.kernel.org>; Sun,  6 Sep 2026 15:57:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3B853C2C00
 for <ltp@lists.linux.it>; Sun,  6 Sep 2026 15:57:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2F0831400159
 for <ltp@lists.linux.it>; Sun,  6 Sep 2026 15:56:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788703017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uvH65kREBlzJ7t11YQKExNX/4nLe8qqIazsDIWhBdCs=;
 b=KJ+Jx6Kmly4pFJmosibR4xblAeTTDtsWB1YCKDEHV5brhTbvlvSCLNE25yYeIQoeIsnJSB
 S1vgw9rOkxBXmn1kLDTQfaw7lVZs53O5wDhFqL9No5flxzzoxlYqWvZygGhOAxaBSSrLmn
 ui1mJopZTUoZVdhqfkzaF2GjjPyioZE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-lN6kwVBLOXK1QfsGCxHlfg-1; Sun,
 06 Sep 2026 09:56:55 -0400
X-MC-Unique: lN6kwVBLOXK1QfsGCxHlfg-1
X-Mimecast-MFC-AGG-ID: lN6kwVBLOXK1QfsGCxHlfg_1788703014
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D05B195608D
 for <ltp@lists.linux.it>; Sun,  6 Sep 2026 13:56:54 +0000 (UTC)
Received: from mmenashe-thinkpadp16vgen1.remote.csb
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B037F423
 for <ltp@lists.linux.it>; Sun,  6 Sep 2026 13:56:53 +0000 (UTC)
To: ltp@lists.linux.it
Date: Sun,  6 Sep 2026 16:56:50 +0300
Message-ID: <20260906135650.52112-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i7CU-M2pR0j4uUFZB1kT7npQu_ZV9bncQwHyXF5ZZZ4_1788703014
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] read_all: Fix buffer too small for long paths
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

queue_pop() copies each path into popped[BUFFER_SIZE], but BUFFER_SIZE
was 1024 while visit_dir() builds paths up to MAX_PATH (4096). Any path
longer than 1023 bytes aborted the test with TBROK "Buffer is too small
for path".

Set BUFFER_SIZE to 4096 to match MAX_PATH. QUEUE_SIZE (16384) still
holds a full-length path.

Tested on smaller boards and then on local machines with deeply nested
directories under /sys; read_all_sys now passes instead of aborting.

Fixes: 67c95fbbfc3a ("Add read_all file systems test")
Signed-off-by: Michael Menasherov <mmenashe@redhat.com>
---
 testcases/kernel/fs/read_all/read_all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index 5720ffb99..d67fe5712 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -51,7 +51,7 @@
 #include "tst_timer.h"
 
 #define QUEUE_SIZE 16384
-#define BUFFER_SIZE 1024
+#define BUFFER_SIZE 4096
 #define MAX_PATH 4096
 #define MAX_DISPLAY 40
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
