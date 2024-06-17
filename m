Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D1FC27C79
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 03:34:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECEFF3D0D09
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 05:34:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49F1D3CB74E
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 05:34:08 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 88E83600BF9
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 05:34:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718595245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cjSAgovHeUFrQpNNcdKBcTW3LJ0pAp43yav2TTmHXW0=;
 b=gX+m6WrVeXuZPVaaIdSw9W0pirH9JSqqkRtak5ss1HejdMpcqEzM6Kj9T84xznNyKGXf8o
 tAlmPv0cZPNTG+TuIVA7g2V/bsy1brb/rrU1rWlM6sxqEYaM75UunZ2VvZzS2ItC9a7Jfe
 YGEMKLwb80efhx5ATengBsePxx4guCc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-9rqEav0GNb-lUgYPlk127Q-1; Sun,
 16 Jun 2024 23:34:04 -0400
X-MC-Unique: 9rqEav0GNb-lUgYPlk127Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F54319560B4
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 03:34:03 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B50019560AE
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 03:34:01 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 17 Jun 2024 11:33:56 +0800
Message-ID: <20240617033356.299491-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] quotactl07: add _GNU_SOURCE define
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

VG8gZ2V0IHJpZCBvZiBlcnJvciBvbiBpbXBsaWNpdCBkZWNsYXJhdGlvbiAoZ2xpYmMtMi4zOSk6
CgogL3Vzci9pbmNsdWRlL3hmcy9saW51eC5oOjE4ODoxNTogZXJyb3I6IGltcGxpY2l0IGRlY2xh
cmF0aW9uIG9mIGZ1bmN0aW9uCiDigJhmYWxsb2NhdGXigJk7IGRpZCB5b3UgbWVhbiDigJhhbGxv
Y2HigJk/IFstV2ltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogMTg4IHwgICAgICAgICBy
ZXQgPSBmYWxsb2NhdGUoZmQsIEZBTExPQ19GTF9aRVJPX1JBTkdFLCBzdGFydCwgbGVuKTsKICAg
ICB8ICAgICAgICAgICAgICAgXn5+fn5+fn5+CiAgICAgfCAgICAgICAgICAgICAgIGFsbG9jYQog
bWFrZTogKioqIFsuLi8uLi8uLi8uLi9pbmNsdWRlL21rL3J1bGVzLm1rOjQ1OiBxdW90YWN0bDA3
XQogRXJyb3IgMQoKU2lnbmVkLW9mZi1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Ci0t
LQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9xdW90YWN0bC9xdW90YWN0bDA3LmMgfCAyICsr
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9xdW90YWN0bC9xdW90YWN0bDA3LmMgYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL3F1b3RhY3RsL3F1b3RhY3RsMDcuYwppbmRleCAzNGZmMjcwNWQuLmQ4YWQzNzYw
YSAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9xdW90YWN0bC9xdW90YWN0
bDA3LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9xdW90YWN0bC9xdW90YWN0bDA3
LmMKQEAgLTEzLDYgKzEzLDggQEAKICAqICgieGZzOiBTYW5pdHkgY2hlY2sgZmxhZ3Mgb2YgUV9Y
UVVPVEFSTSBjYWxsIikuCiAgKi8KIAorI2RlZmluZSBfR05VX1NPVVJDRQorI2luY2x1ZGUgPGZj
bnRsLmg+CiAjaW5jbHVkZSA8ZXJybm8uaD4KICNpbmNsdWRlIDx1bmlzdGQuaD4KICNpbmNsdWRl
IDxzdGRpby5oPgotLSAKMi40NS4yCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
