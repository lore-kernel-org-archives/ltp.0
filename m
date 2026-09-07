Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5A3C79F9E
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 12:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788782618; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=tj7GRHPt3Z5GFUPNbwxR44GaEtey+4ccxbnDN2MbuyI=;
 b=Iu/A2NjJTF9IIcBw7KJA47Mp3qSqDNiCOvEJXC7SaJz2WKcpLCzH4KiL/uVVlc0TdO2F2
 PFCGOg2HurOg4TRtyAuLMsGqMGx3U56WogIkLVsCSIporsGWw7yBLirDWayflaF60/qA0C6
 iRj6sVX7vJszvh3sLbxYSZBV+KzWsag=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 281713E88DA
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 14:03:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D66143C2C00
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 14:03:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 53406200968
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 14:03:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788782596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MDVavgB6/OWntnBQqO2aQbzwFoYhuaLL+HOs9IJIQZg=;
 b=SiespVzlrXaUovoeX1lgizxh7SrmaoU8C5jlFH93slqV9V5tf3q9R2gMfYwyapqTTO6Sw0
 ewoitOhNcuQ9mkEzGv/xCJvQZSXQGugHu03OIAMHNL3CF9aN5vIPojH1y90BbgjLM3mEeo
 2rpNBnVUlLymMs+yyN/vYJETRC3bfks=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-5wvSuf-ZMO6AXLbPVvCtmw-1; Mon,
 07 Sep 2026 08:03:14 -0400
X-MC-Unique: 5wvSuf-ZMO6AXLbPVvCtmw-1
X-Mimecast-MFC-AGG-ID: 5wvSuf-ZMO6AXLbPVvCtmw_1788782594
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A66B719539A7
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 12:03:13 +0000 (UTC)
Received: from mmenashe-thinkpadp16vgen1.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAC2D1956042
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 12:03:12 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon,  7 Sep 2026 15:03:08 +0300
Message-ID: <20260907120308.32898-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2I0k26LhDIj4QQiWW5ykx3RBduzeV9-n1zE74JgBUME_1788782594
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] read_all: Fix buffer too small for long paths
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

Set BUFFER_SIZE and MAX_PATH to PATH_MAX so all path buffers and size
limits use the standard constant consistently.

Tested on smaller boards and then on local machines with deeply nested
directories under /sys; read_all_sys now passes instead of aborting.

Fixes: 67c95fbbfc3a ("Add read_all file systems test")
Signed-off-by: Michael Menasherov <mmenashe@redhat.com>
---
 testcases/kernel/fs/read_all/read_all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index 5720ffb99..bf5f613a3 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -51,8 +51,8 @@
 #include "tst_timer.h"
 
 #define QUEUE_SIZE 16384
-#define BUFFER_SIZE 1024
-#define MAX_PATH 4096
+#define BUFFER_SIZE PATH_MAX
+#define MAX_PATH PATH_MAX
 #define MAX_DISPLAY 40
 
 struct queue {
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
