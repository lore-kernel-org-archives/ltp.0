Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6333C433EF
	for <ltp@archiver.kernel.org>; Sun, 13 Feb 2022 03:20:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D04843C9ED2
	for <ltp@archiver.kernel.org>; Sun, 13 Feb 2022 04:20:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9F593C9528
 for <ltp@lists.linux.it>; Sun, 13 Feb 2022 04:19:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BE6DA1400518
 for <ltp@lists.linux.it>; Sun, 13 Feb 2022 04:19:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644722397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=O9cT7jnSRgaDHCNxozIa+WrClzAfMucPdonbGmreDTE=;
 b=GPtK1iJ/8xtH/Qsa3/8omIYTBRq0R5UA3JE55mZaxa+g1STu6Xwt94yea53lYNb7PW2Jr8
 fKO8TiGwTnyMcq5yke4Br37G/6ZgnrQADHZQ71YjA2H52WBM1w9S+QM6Xa3BgaFx49kZ5q
 9iNFwM7FaEqKRCrP3cGtds9C4B7W0rQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-MjYdIna5O5CyIbTqtxIhGw-1; Sat, 12 Feb 2022 22:19:55 -0500
X-MC-Unique: MjYdIna5O5CyIbTqtxIhGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77CE52F26
 for <ltp@lists.linux.it>; Sun, 13 Feb 2022 03:19:53 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0B744CECF
 for <ltp@lists.linux.it>; Sun, 13 Feb 2022 03:19:51 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sun, 13 Feb 2022 11:19:50 +0800
Message-Id: <20220213031950.3026176-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED] test_children_cleanup: fix redirection issue in
 shell
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/newlib_tests/test_children_cleanup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/newlib_tests/test_children_cleanup.sh b/lib/newlib_tests/test_children_cleanup.sh
index 2a84c3d85..4b4e8b2f0 100755
--- a/lib/newlib_tests/test_children_cleanup.sh
+++ b/lib/newlib_tests/test_children_cleanup.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2022 SUSE LLC <mdoucha@suse.cz>
 
 TMPFILE="/tmp/ltp_children_cleanup_$$.log"
-./test_children_cleanup &>"$TMPFILE"
+./test_children_cleanup 1>$TMPFILE 2>&1
 CHILD_PID=`sed -n 's/^.*Forked child \([0-9]*\)$/\1/p' "$TMPFILE"`
 rm "$TMPFILE"
 
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
