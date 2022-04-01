Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05813C433EF
	for <ltp@archiver.kernel.org>; Fri,  1 Apr 2022 08:41:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 039C43CA1C0
	for <ltp@archiver.kernel.org>; Fri,  1 Apr 2022 10:41:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAE0A3C9E3B
 for <ltp@lists.linux.it>; Fri,  1 Apr 2022 10:41:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AEB6F200906
 for <ltp@lists.linux.it>; Fri,  1 Apr 2022 10:41:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648802490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dOo9g59k3nHT2lY9bPvMrNveh5aF97BHBuwRVZFTMMo=;
 b=GDEPRLAqf2dFHwYPXjJOoKlQVKhe/yndLxOgPh9lXS2udgMk3ZE0e5wq/qVZ1ELFAsirdo
 QQkFGuMb389s0aBWisFei7Y160w9qIcGnDbzq7tserzaFW7kczdjbLak4K07rg+oxNsbEL
 ryNK5KBQulnPEnuU7IRQxDTkePlMnj8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-ugkxosPKOz-pqChpj7bElA-1; Fri, 01 Apr 2022 04:41:27 -0400
X-MC-Unique: ugkxosPKOz-pqChpj7bElA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FBCE1C0E342;
 Fri,  1 Apr 2022 08:41:27 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA534400E551;
 Fri,  1 Apr 2022 08:41:25 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri,  1 Apr 2022 16:41:24 +0800
Message-Id: <20220401084124.801586-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ci: resolve some no match arguments problem
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

Make this installation can succeed on all RHEL related platforms.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 ci/fedora.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/fedora.sh b/ci/fedora.sh
index dc1293aa5..a603bcbe3 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -2,7 +2,7 @@
 # Copyright (c) 2018-2021 Petr Vorel <pvorel@suse.cz>
 set -ex
 
-yum="yum -y install"
+yum="yum -y install --skip-broken"
 
 $yum \
 	asciidoc \
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
