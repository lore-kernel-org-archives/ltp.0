Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B7FC44500
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 11:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769080724; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=cVGBo+X3lWZWYn2RVHcn1p6ScnJgXEnTL8C90V3N2tU=;
 b=IYsrAdEXxn8R1O92Fxg+b7Qs9WJj+SyeKWos2uXpZ7C6XybMmLgUUPEuKflRjvgtI2BHg
 lmXwJit/ofwPtUTmfaHJt+xDPOqgHrdBK26nxcXicSzQqN+ZVzG2HzyMHruXkIJMM+7Y6eH
 yx9l7Ke5ZC2fvbZD97jBZkix7XKXA78=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E27E73CB36B
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 12:18:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F17D3C1B59
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 12:18:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 08FBE1400BE3
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 12:18:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769080699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=krWnXV/pr51jYQOAf/uLc4RJqOv1WAthFg3Xx6gUyWQ=;
 b=KwRgof2yZbM/8KmxJguHkRrMHc/rtGtuhBIq3lUVe6MCNadfZpVdNqG8bTtXfV9zuZu2ka
 vSUfBh1xISF96m/CbprmRo1yq0dKM3+EgY/NgmFsLb2Gy8mXJQvPUULvloxJBju1KSihSE
 MkAv94YDzyM2g1HQsmQjKYmCH7WvRY0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-WB3XhnF7OaCsmP-oP01gxw-1; Thu,
 22 Jan 2026 06:18:17 -0500
X-MC-Unique: WB3XhnF7OaCsmP-oP01gxw-1
X-Mimecast-MFC-AGG-ID: WB3XhnF7OaCsmP-oP01gxw_1769080697
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF32D193E8F1; Thu, 22 Jan 2026 11:18:16 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.116.167])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59EF21800999; Thu, 22 Jan 2026 11:18:14 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 22 Jan 2026 19:18:10 +0800
Message-ID: <20260122111810.91411-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wvLq_31AgSzkbvntCX5kCfAqXs6-4FLtnPU7zAlSUVw_1769080697
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] vma05: fix the needs_cmds format
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

Fixes: 39a28444272 ("lib: Add support option for .needs_cmds")
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Wei Gao <wegao@suse.com>
---
 testcases/kernel/mem/vma/vma05.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
index 34a82162c..b9654e80c 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -26,7 +26,14 @@
 # {
 #  "needs_root": true,
 #  "needs_tmpdir": true,
-#  "needs_cmds": ["gdb", "uname"],
+#  "needs_cmds": [
+#     {
+#       "cmd": "gdb"
+#     },
+#     {
+#       "cmd": "uname"
+#     }
+#   ],
 #  "save_restore": [
 #   ["/proc/sys/kernel/core_pattern", "core", "TBROK"],
 #   ["/proc/sys/kernel/core_uses_pid", "0", "TBROK"]
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
