Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387B6C3064D
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 09:48:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 891273D3EB6
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 11:48:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DDBB3D0FA2
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 11:48:03 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E288060042F
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 11:48:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719913681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0UGJZ50cdkXDaoYqEiKeCHdsk/Ht37HOVKxrGBw4MdY=;
 b=BDOSO0gJ4qr2uv9M+x6GrtuK/jEjF5dwCraKPkaFUmwKA36IkUV+LUnwNwNngW4CpS4Wzf
 EaAGcBl1eA2+rVF1yiYBiEH3NjdoyQLA59KCyENKs+Od669z6eBHTOM1CxDodEbEHbBC8L
 2r4mRyOdte4856/ujIGE/z+2LHNveZA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-ItAB6do9Pu2rG8MPKevbpw-1; Tue,
 02 Jul 2024 05:47:57 -0400
X-MC-Unique: ItAB6do9Pu2rG8MPKevbpw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 741CD1979204; Tue,  2 Jul 2024 09:47:55 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A347219560A3; Tue,  2 Jul 2024 09:47:50 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com
Date: Tue,  2 Jul 2024 17:47:45 +0800
Message-ID: <20240702094745.96521-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH] landlock: fix minimal required size for
 landlock_ruleset_attr copying
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
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
 linux-kernel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

QXMga2VybmVsIGNvbW1pdCBmZmY2OWZiMDNkZGUgKCJsYW5kbG9jazogU3VwcG9ydCBuZXR3b3Jr
IHJ1bGVzIHdpdGggVENQIGJpbmQgYW5kIGNvbm5lY3QiKQppbnRyb2R1Y2luZyBhIG5ldyBmaWVs
ZCAnaGFuZGxlZF9hY2Nlc3NfbmV0JyBpbiB0aGUgc3RydWN0dXJlIGxhbmRsb2NrX3J1bGVzZXRf
YXR0ciwKYnV0IGluIHRoZSBsYW5kbG9ja19jcmVhdGVfcnVsZXNldCgpIGl0IHN0aWxsIHVzZXMg
dGhlIGZpcnN0IGZpZWxkICdoYW5kbGVkX2FjY2Vzc19mcycKdG8gY2FsY3VsYXRlIG1pbmltYWwg
c2l6ZSwgc28gdGhhdCBtYWRlIGRlY3JlYXNlIDEgaXMgdXNlbGVzcyBpbiBMVFAgbGFuZGxvY2sw
MS5jIHRvCnRlc3QgdGhlIHRvby1zbWFsbC1zaXplLgoKVGVzdCBjb2RlOgogICBydWxlX3NtYWxs
X3NpemUgPSBzaXplb2Yoc3RydWN0IGxhbmRsb2NrX3J1bGVzZXRfYXR0cikgLSAxOwogICB0c3Rf
c3lzY2FsbChfX05SX2xhbmRsb2NrX2NyZWF0ZV9ydWxlc2V0LCAuLi4sIHJ1bGVfc21hbGxfc2l6
ZSwgMCkKClJlc3VsdDoKICBsYW5kbG9jazAxLmM6NDk6IFRGQUlMOiBTaXplIGlzIHRvbyBzbWFs
bCBleHBlY3RlZCBFSU5WQUw6IEVOT01TRyAoNDIpCgpTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxs
aXdhbmdAcmVkaGF0LmNvbT4KQ2M6IE1pY2thw6tsIFNhbGHDvG4gPG1pY0BkaWdpa29kLm5ldD4K
Q2M6IEtvbnN0YW50aW4gTWVza2hpZHplIDxrb25zdGFudGluLm1lc2toaWR6ZUBodWF3ZWkuY29t
PgpDYzogUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4KLS0tCgpOb3RlczoKICAgIEhp
IE1pY2thZWwsCiAgICAgICBJJ20gbm90IHF1aXRlIHN1cmUgaWYgdGhhdCBpcyBvbiBwdXJwb3Nl
IHRvIHVzZSB0aGUgZmlyc3QgZmllbGQgb3Iga2VybmVsCiAgICAgICBidWcsIGNhbiB5b3UgdGFr
ZSBhIGxvb2s/Cgogc2VjdXJpdHkvbGFuZGxvY2svc3lzY2FsbHMuYyB8IDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NlY3Vy
aXR5L2xhbmRsb2NrL3N5c2NhbGxzLmMgYi9zZWN1cml0eS9sYW5kbG9jay9zeXNjYWxscy5jCmlu
ZGV4IDAzYjQ3MGY1YTg1YS4uZjNjZDdkZWY3NjI0IDEwMDY0NAotLS0gYS9zZWN1cml0eS9sYW5k
bG9jay9zeXNjYWxscy5jCisrKyBiL3NlY3VyaXR5L2xhbmRsb2NrL3N5c2NhbGxzLmMKQEAgLTE5
OCw3ICsxOTgsNyBAQCBTWVNDQUxMX0RFRklORTMobGFuZGxvY2tfY3JlYXRlX3J1bGVzZXQsCiAJ
LyogQ29waWVzIHJhdyB1c2VyIHNwYWNlIGJ1ZmZlci4gKi8KIAllcnIgPSBjb3B5X21pbl9zdHJ1
Y3RfZnJvbV91c2VyKCZydWxlc2V0X2F0dHIsIHNpemVvZihydWxlc2V0X2F0dHIpLAogCQkJCQlv
ZmZzZXRvZmVuZCh0eXBlb2YocnVsZXNldF9hdHRyKSwKLQkJCQkJCSAgICBoYW5kbGVkX2FjY2Vz
c19mcyksCisJCQkJCQkgICAgaGFuZGxlZF9hY2Nlc3NfbmV0KSwKIAkJCQkJYXR0ciwgc2l6ZSk7
CiAJaWYgKGVycikKIAkJcmV0dXJuIGVycjsKLS0gCjIuNDUuMgoKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
