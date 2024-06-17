Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536DDC27C6E
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 05:35:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8F1F3D0CF9
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 07:35:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA41C3D0988
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 07:34:53 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A727B2009C1
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 07:34:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718602490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aXu3jyEiLan57Ld48iOLo576AlmmRaPvmx5OXdbWBEo=;
 b=f+Gr7nWN5d3pbmcFpZBUcb0v0AMhMwsoyakwrGuGrWcduznGr1sQnYApU4o2hG1DbrGiFt
 kL9iIQ3Urud9T75HjbcgE3Q7RLIz1K8PgdGCUQZh964lvq3cvTuvwSyKJSM5txLqA3yIm1
 k9u2CGtnPx0PZc/2BgVS9kAwKgvHicQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-3r0F9usvNg656HmW0FR8yg-1; Mon,
 17 Jun 2024 01:34:49 -0400
X-MC-Unique: 3r0F9usvNg656HmW0FR8yg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 190C619560BE
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 05:34:48 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC70819560AE
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 05:34:46 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 17 Jun 2024 13:34:36 +0800
Message-ID: <20240617053436.301336-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] configure.ac: Add _GNU_SOURCE for struct
 fs_quota_statv check
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

VGhlc2UgY2hhbmdlcyBoZWxwIGVuc3VyZSB0aGF0IHRoZSBuZWNlc3NhcnkgZmVhdHVyZXMgYW5k
IGRlZmluaXRpb25zCmFyZSBhdmFpbGFibGUgZHVyaW5nIHRoZSBjb25maWd1cmF0aW9uIHByb2Nl
c3MsIHByZXZlbnRpbmcgcG90ZW50aWFsCmlzc3VlcyByZWxhdGVkIHRvIG1pc3Npbmcgb3IgaW5j
b21wYXRpYmxlIGRlZmluaXRpb25zLiBUaGlzIHNob3VsZApyZXNvbHZlIHRoZSBjb21waWxhdGlv
biBlcnJvciByZWxhdGVkIHRvIHN0cnVjdCBmc19xdW90YV9zdGF0djoKCiAvdXNyL2luY2x1ZGUv
eGZzL3hxbS5oOjE2Nzo4OiBlcnJvcjogcmVkZWZpbml0aW9uIG9mIOKAmHN0cnVjdCBmc19xZmls
ZXN0YXR24oCZCgpTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KLS0t
CiBjb25maWd1cmUuYWMgfCA2ICsrKysrLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2NvbmZpZ3VyZS5hYyBiL2NvbmZpZ3VyZS5h
YwppbmRleCA4NWM1NzM5YzQuLjgyOTY5YjhkMyAxMDA2NDQKLS0tIGEvY29uZmlndXJlLmFjCisr
KyBiL2NvbmZpZ3VyZS5hYwpAQCAtMTgxLDcgKzE4MSwxMSBAQCBBQ19DSEVDS19UWVBFUyhbc3Ry
dWN0IGZpbGVfaGFuZGxlXSwsLFsKICNpbmNsdWRlIDxmY250bC5oPgogXSkKIAotQUNfQ0hFQ0tf
VFlQRVMoW3N0cnVjdCBmc19xdW90YV9zdGF0dl0sLCxbI2luY2x1ZGUgPHhmcy94cW0uaD5dKQor
QUNfQ0hFQ0tfVFlQRVMoW3N0cnVjdCBmc19xdW90YV9zdGF0dl0sLCxbCisjZGVmaW5lIF9HTlVf
U09VUkNFCisjaW5jbHVkZSA8eGZzL3hxbS5oPgorXSkKKwogQUNfQ0hFQ0tfVFlQRVMoW3N0cnVj
dCBpZl9uZXh0ZHFibGtdLCwsWyNpbmNsdWRlIDxsaW51eC9xdW90YS5oPl0pCiBBQ19DSEVDS19U
WVBFUyhbc3RydWN0IGlvdmVjXSwsLFsjaW5jbHVkZSA8c3lzL3Vpby5oPl0pCiBBQ19DSEVDS19U
WVBFUyhbc3RydWN0IGlwYzY0X3Blcm1dLCwsWyNpbmNsdWRlIDxzeXMvaXBjYnVmLmg+XSkKLS0g
CjIuNDUuMgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
