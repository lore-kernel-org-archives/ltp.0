Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF4EC27C77
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 03:24:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBD903D0D1D
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 05:24:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80A223CD7F4
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 05:24:11 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9CAFB1400777
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 05:24:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718594649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ojp5xG4CBBYPhNMh3QF2Rev4cZirGt1Tdt7L9O03qJU=;
 b=Iah6VWoU0ruRCqTW72nBEM4wMYjZxRulYstusvhh6XBruC/zlJzRPGdLSIQf4IPGHh46CF
 X3ClJgkZoe+gvaxe8/M0/rR+6S0wMkO8aA/VQQ511LH1vaSl2TzzLMFTYG74bWVD5qIQ3P
 y/057/38Qv/A3g3l/qCKFKEqUTtPavo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-J4CCv6lWPU2qfCN1nOOwlw-1; Sun,
 16 Jun 2024 23:24:07 -0400
X-MC-Unique: J4CCv6lWPU2qfCN1nOOwlw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A563B1956080
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 03:24:06 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EE801955E83
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 03:24:04 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 17 Jun 2024 11:24:00 +0800
Message-ID: <20240617032400.298906-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] rpc_svc_1: Fix incompatible pointer type error
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VG8gZ2V0IHJpZCBvZiB0aGUgY29tcGlsZSBlcnJvciB3aXRoIEdDQy0xNDoKCnJwY19zdmNfMS5j
OjEwOToxMjogZXJyb3I6IGFzc2lnbm1lbnQgdG8g4oCYc3RydWN0IHNvY2thZGRyX2luICrigJkg
ZnJvbQppbmNvbXBhdGlibGUgcG9pbnRlciB0eXBlIOKAmHN0cnVjdCBzb2NrYWRkcl9pbjYgKuKA
mQpbLVdpbmNvbXBhdGlibGUtcG9pbnRlci10eXBlc10KICAxMDkgfCAgICAgICAgIHNhID0gc3Zj
X2dldGNhbGxlcih0cmFuc3ApOwogICAgICAgIHwgICAgICAgICAgICBeCgpTaWduZWQtb2ZmLWJ5
OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KLS0tCiAuLi4vbmV0d29yay9ycGMvcnBjLXRp
cnBjL3Rlc3RzX3BhY2svcnBjX3N2Y18xL3JwY19zdmNfMS5jICAgICAgfCAyICstCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90ZXN0
Y2FzZXMvbmV0d29yay9ycGMvcnBjLXRpcnBjL3Rlc3RzX3BhY2svcnBjX3N2Y18xL3JwY19zdmNf
MS5jIGIvdGVzdGNhc2VzL25ldHdvcmsvcnBjL3JwYy10aXJwYy90ZXN0c19wYWNrL3JwY19zdmNf
MS9ycGNfc3ZjXzEuYwppbmRleCBkMWM0ZGY5N2YuLmQzNjc2OTFjNCAxMDA2NDQKLS0tIGEvdGVz
dGNhc2VzL25ldHdvcmsvcnBjL3JwYy10aXJwYy90ZXN0c19wYWNrL3JwY19zdmNfMS9ycGNfc3Zj
XzEuYworKysgYi90ZXN0Y2FzZXMvbmV0d29yay9ycGMvcnBjLXRpcnBjL3Rlc3RzX3BhY2svcnBj
X3N2Y18xL3JwY19zdmNfMS5jCkBAIC0xMDYsNyArMTA2LDcgQEAgY2hhciAqc3ZjX2dldGNhbGxl
cl90ZXN0KHVuaW9uIHVfYXJndW1lbnQgKmluVmFyLCBTVkNYUFJUICogdHJhbnNwKQogCXN0cnVj
dCBzb2NrYWRkcl9pbiAqc2EgPSBOVUxMOwogCXN0YXRpYyBpbnQgcmVzdWx0OwogCi0Jc2EgPSBz
dmNfZ2V0Y2FsbGVyKHRyYW5zcCk7CisJc2EgPSAoc3RydWN0IHNvY2thZGRyX2luICopIHN2Y19n
ZXRjYWxsZXIodHJhbnNwKTsKIAkvL0lmIHRoZSByZXN1bHQgaXMgbm90IE5VTEwgd2UgY29uc2lk
ZXIgdGhhdCBmdW5jdGlvbiBjYWxsIHN1Y2NlZWRzCiAJLy9zbyByZXR1cm5zIDAgKFBBU1MpCiAJ
cmVzdWx0ID0gKHNhICE9IE5VTEwpID8gMCA6IDE7Ci0tIAoyLjQ1LjIKCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
