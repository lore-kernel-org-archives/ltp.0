Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82E2C433EF
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 12:58:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C1113CA197
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 14:58:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F9F83C2DD2
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 14:58:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C38C41000F65
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 14:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657198717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MFNmwYRDzIivwYm/hcg5+P2DNe9jpwuJygX1R499nSU=;
 b=GlHnPUeSHpoCuASYP05g2/+Why3CdIvJbsA30se11jpx9EdNyVt97XVbjlfd7qG5D8tm+e
 NwJOtFIowESobmOak+TlJACVbiYzuEkEYHINlC0CgfA0R+QntJn2Ku73WXEmlek/jjfGO1
 SSH/rmWvkl70l9w/Yy+3EzFobXBaatI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-10FFlZ3UOnG0eYMu5WWiWg-1; Thu, 07 Jul 2022 08:58:36 -0400
X-MC-Unique: 10FFlZ3UOnG0eYMu5WWiWg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C4843C11E7B
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 12:58:36 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A353A1121315
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 12:58:35 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  7 Jul 2022 14:58:30 +0200
Message-Id: <f710f7cc103a61c20d5ee907d9717fa384810553.1657198689.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] commands/df01.sh: print more logs when test fails
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

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/commands/df/df01.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index f74032c962e5..6b20f21d0d74 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -103,6 +103,11 @@ df_check()
 
 	grep ${TST_DEVICE} output | grep -q "${total}.*${used}"
 	if [ $? -ne 0 ]; then
+		echo "total: ${total}, used: ${used}"
+		echo "df saved output:"
+		cat output
+		echo "df output:"
+		$@
 		return 1
 	fi
 }
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
