Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4924C369B1
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 03:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744774376; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=8jW9Hc0zu+hu2PnoY23kYm8M4jq6mvEsUg0LOFP/nLU=;
 b=asw+qLyJSKoVoA/yXyvE8uDYkStzgJc0iea1KXgbrEYUg3jvzKlubpRGVhezaQJJutyE0
 01ILT05gNc3h4B03/HkXJuG6dO8zCEip69eoxTItNY2EpUPEMrjp9kppQ48Sl0zgAZip48F
 noJlnHZvSm9tzE8u50qFIryscDMGTxI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33F7D3CB943
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 05:32:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10EA73CB596
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 05:32:12 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 014FB60073B
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 05:32:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744774330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=puYkwXWXbcuEcRcs8xEYaHUDlYjDL9jwGiJdrjWhYGA=;
 b=ZFXP90NuQYz93bUEQxKKkfuc54rHKLi7eqLy+JodPKQLLtXBJoSixuh9HdrBARO2ol7TnG
 BNEYivJaOJ1RFwMglULfzKexLHllRJlEWkatYE7SLbrXH0B2XVPRY53C9TLiZ0qzp6DJgp
 inyOVw6BBHcfei69T/Vj8cAToN09BfY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-sAZ2EoZiP7imeCwWoEnFOw-1; Tue,
 15 Apr 2025 23:32:09 -0400
X-MC-Unique: sAZ2EoZiP7imeCwWoEnFOw-1
X-Mimecast-MFC-AGG-ID: sAZ2EoZiP7imeCwWoEnFOw_1744774328
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55F20180AF4A
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 03:32:08 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 037DC180B488
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 03:32:06 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed, 16 Apr 2025 11:31:59 +0800
Message-ID: <20250416033200.62867-2-liwang@redhat.com>
In-Reply-To: <20250416033200.62867-1-liwang@redhat.com>
References: <20250416033200.62867-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n-eSeS560j8gTeE5ajhvL8zmAW_kOu3ZPDAIArirC2U_1744774328
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED 2/2] ci: add gawk package
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

To get rid of the error from Fedora42 configuration.

CI: https://github.com/wangli5665/ltp/actions/runs/14484013675

Signed-off-by: Li Wang <liwang@redhat.com>
---
 ci/fedora.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/fedora.sh b/ci/fedora.sh
index 2b0701d08..eeacf476c 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -15,6 +15,7 @@ $yum \
 	automake \
 	make \
 	clang \
+	gawk \
 	gcc \
 	git \
 	findutils \
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
