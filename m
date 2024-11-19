Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7068DD591D4
	for <ltp@archiver.kernel.org>; Tue, 19 Nov 2024 07:28:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 047923D86F0
	for <ltp@archiver.kernel.org>; Tue, 19 Nov 2024 08:28:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B7843D86C7
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 08:28:29 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=chuhu@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 39F086320D5
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 08:28:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732001306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XSATaRRkVfYIDS2ot/Dv+GK2Xqo5d+yBF4IGm5KJ1Os=;
 b=XhVJv7TXP2AGHSVia1UB5v+W8xQjYv0S4ffGpBG2kOkPiJ8yiJZ1BiJ2WQ6WFuB7isLFm7
 CEC5tn39Hak9nUh67Gb/0u/nVkMjmX4UL/kki6u5p2Z2PaODuu2ESGC7ZJ0nwSrwMmtySv
 tT2EkkjBJMPVkSlF3Mf6FPoGAdio0e4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-qDbLrzV4NUG6XL4BZG6Z9g-1; Tue,
 19 Nov 2024 02:28:24 -0500
X-MC-Unique: qDbLrzV4NUG6XL4BZG6Z9g-1
X-Mimecast-MFC-AGG-ID: qDbLrzV4NUG6XL4BZG6Z9g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04C511955F69
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 07:28:24 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8D2F1956056
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 07:28:22 +0000 (UTC)
From: Chunyu Hu <chuhu@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 19 Nov 2024 15:28:17 +0800
Message-ID: <20241119072817.415810-1-chuhu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vmLoCBMDitthMEpaxePGoX2-MfGF2bqJoeXy-sC5qPw_1732001304
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cve-2015-3290: build with O0
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

SGl0IGEgY29tcGlsZSBicm9rZW4gZm9yIHRoaXMgdGVzdCBpbiByaGVsMTAgZ2NjLTE0LjIuMS02
LmVsMTAueDg2XzY0CmFuZCBmaW5kIG9ubHkgd2l0aCBPMCBpdCBjb3VsZCBiZSBjb21waWxlZCBw
YXNzLgoKQ0MgdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNC0wMTk2CmN2ZS0yMDE1LTMyOTAuYzogSW4g
ZnVuY3Rpb24g4oCYY2hpbGRfdGhyZWFk4oCZOgpjdmUtMjAxNS0zMjkwLmM6NDM3OjE6IGVycm9y
OiBicCBjYW5ub3QgYmUgdXNlZCBpbiDigJhhc23igJkgaGVyZQogIDQzNyB8IH0KICAgICAgfCBe
Cm1ha2U6ICoqKiBbLi4vLi4vaW5jbHVkZS9tay9ydWxlcy5tazo0NTogY3ZlLTIwMTUtMzI5MF0g
RXJyb3IgMQoKU2lnbmVkLW9mZi1ieTogQ2h1bnl1IEh1IDxjaHVodUByZWRoYXQuY29tPgotLS0K
IHRlc3RjYXNlcy9jdmUvTWFrZWZpbGUgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMvY3ZlL01ha2VmaWxl
IGIvdGVzdGNhc2VzL2N2ZS9NYWtlZmlsZQppbmRleCAwMWI5YjljY2IuLjJhNzY5ZGVhOCAxMDA2
NDQKLS0tIGEvdGVzdGNhc2VzL2N2ZS9NYWtlZmlsZQorKysgYi90ZXN0Y2FzZXMvY3ZlL01ha2Vm
aWxlCkBAIC0yMiw2ICsyMiw2IEBAIGlmbmVxICgsJChmaWx0ZXIgJChIT1NUX0NQVSkseDg2IHg4
Nl82NCkpCiBtZWx0ZG93bjogQ0ZMQUdTICs9IC1tc3NlMgogZW5kaWYKIAotY3ZlLTIwMTUtMzI5
MDoJQ0ZMQUdTICs9IC1wdGhyZWFkIC1mb21pdC1mcmFtZS1wb2ludGVyCitjdmUtMjAxNS0zMjkw
OglDRkxBR1MgKz0gLXB0aHJlYWQgLWZvbWl0LWZyYW1lLXBvaW50ZXIgLU8wCiAKIGluY2x1ZGUg
JCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21rL2dlbmVyaWNfbGVhZl90YXJnZXQubWsKLS0gCjIuNDcu
MAoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
