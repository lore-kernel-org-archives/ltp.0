Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64F5D1CA19
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 04:13:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 227973D1B11
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 05:13:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEF273D1A54
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 05:13:39 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B38FE102098E
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 05:13:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730780016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6x80RNR2cUdD1DeCco9DSgmLiQ/1n3aWGz08ludJAhA=;
 b=Lxqo0kYcFmBFq0jj+OUDqBHzli0CM0qjncieQ4Snc2IY1exQJacFTefZnh3V+bzGMc+ZbA
 oUgPLVv3y3QQnNHeetykGlsRMXCXRmBDFIT0/bCfEKxNIaXjcoG1TBpTiARYBTn+rY9c/G
 V+2XDBMp4ujRaP7JsPo7+CNIra/ZcUQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-MPmBrUF3M9yTjcNr9WnHgw-1; Mon,
 04 Nov 2024 23:13:34 -0500
X-MC-Unique: MPmBrUF3M9yTjcNr9WnHgw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72D691955F10
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 04:13:33 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2950519560A3
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 04:13:31 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue,  5 Nov 2024 12:13:24 +0800
Message-ID: <20241105041326.18531-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lapi: Add new field socket scoping to
 landlock_ruleset_attr
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

Mainline kernel commit 21d52e295 ("landlock: Add abstract UNIX socket scoping")
introduces a new "scoped" member to the struct landlock_ruleset_attr.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/lapi/landlock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/lapi/landlock.h b/include/lapi/landlock.h
index 211d171eb..5fb6d3755 100644
--- a/include/lapi/landlock.h
+++ b/include/lapi/landlock.h
@@ -19,6 +19,7 @@ struct landlock_ruleset_attr
 {
 	uint64_t handled_access_fs;
 	uint64_t handled_access_net;
+	uint64_t scoped;
 };
 #endif
 
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
