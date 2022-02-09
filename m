Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFF2C433FE
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 08:52:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A79EA3C9B73
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 09:52:30 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9970F3C23B0
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 09:52:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CEF9B6006F6
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 09:52:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644396738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pEC2VaECBNbTYtHWAQHa9gdUNcx1+bYssInc7mVb3w8=;
 b=YSGMqwKBUjv2hRNQ15CskDh9H3g5v/PvOTKpWnkeGk9kjFTOjIiUGRrrO/Qd8K2fLDr/ra
 R6nQewX6W7jZBNa4jcLirPE5/RTDaaHFrcFevrtprYXd6j4ZS7jusG1Z3EWMG06CbXFedy
 J36fC/Kpm+rT+4w9f91g6M953P3F1RY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-vp_41KR0OhGCsgfgNgMcRA-1; Wed, 09 Feb 2022 03:52:17 -0500
X-MC-Unique: vp_41KR0OhGCsgfgNgMcRA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BE0684DA43
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 08:52:16 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 539A556A86
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 08:52:14 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed,  9 Feb 2022 16:52:13 +0800
Message-Id: <20220209085213.2882229-1-liwang@redhat.com>
In-Reply-To: <20220208132414.2852202-1-liwang@redhat.com>
References: <20220208132414.2852202-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] getrusage03: mlock all address space for process
 calling consume_mb
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

SXQgaXMgdHJ5aW5nIHRvIHRlc3Qgd2l0aG91dCBzd2FwIGhhcHBlbiB0byBndWFyYW50ZWUgbGVz
cyBkaXN0dXJiaW5nCmZvciB0aGUg4oCZLT5ydV9tYXhyc3PigJggY291bnRpbmcuCgpUaGVyZWZv
cmUgYWRkIG1sb2NrYWxsKCkgdG8gcHJldmVudCB0aGF0IG1lbW9yeSBhZGRyZXNzIHNwYWNlCm9m
IHRoZSBjYWxsaW5nIHByb2Nlc3MgZnJvbSBiZWluZyBwYWdlZCB0byB0aGUgc3dhcCBhcmVhLgoK
RHVlIHRvIHRoYXQgbG9jayBuZWVkcyBDQVBfSVBDX0xPQ0sgY2FwYWJpbGl0eSBhbmQgY2hpbGQg
Y2FuIG5vdAppbmhlcml0IG1lbW9yeSBsb2NrcyBmcm9tIHBhcmVudCwgaGVyZSBhZGQgdGhlIGRl
ZmluaXRpb24gYW5kIHB1dAp0aGUgbWxvY2thbGwoKSBpbiBjb25zdW1lX21iLgoKU2lnbmVkLW9m
Zi1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Ci0tLQogaW5jbHVkZS9sYXBpL2NhcGFi
aWxpdHkuaCAgICAgICAgICAgICAgICAgICAgICAgICB8IDQgKysrKwogdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9nZXRydXNhZ2UvZ2V0cnVzYWdlMDMuYyB8IDQgKysrKwogdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9nZXRydXNhZ2UvZ2V0cnVzYWdlMDMuaCB8IDIgKysKIDMgZmlsZXMgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGFwaS9jYXBhYmls
aXR5LmggYi9pbmNsdWRlL2xhcGkvY2FwYWJpbGl0eS5oCmluZGV4IDhjYWJkMGYyOC4uMTdlYzEw
N2IxIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xhcGkvY2FwYWJpbGl0eS5oCisrKyBiL2luY2x1ZGUv
bGFwaS9jYXBhYmlsaXR5LmgKQEAgLTI0LDYgKzI0LDEwIEBACiAjIGRlZmluZSBDQVBfTkVUX1JB
VyAgICAgICAgICAxMwogI2VuZGlmCiAKKyNpZm5kZWYgQ0FQX0lQQ19MT0NLCisjIGRlZmluZSBD
QVBfSVBDX0xPQ0sgICAgICAgICAxNAorI2VuZGlmCisKICNpZm5kZWYgQ0FQX1NZU19DSFJPT1QK
ICMgZGVmaW5lIENBUF9TWVNfQ0hST09UICAgICAgIDE4CiAjZW5kaWYKZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTAzLmMgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2dldHJ1c2FnZS9nZXRydXNhZ2UwMy5jCmluZGV4IDIwMWQyNThm
YS4uNDNmYWIwNjA1IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldHJ1
c2FnZS9nZXRydXNhZ2UwMy5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0cnVz
YWdlL2dldHJ1c2FnZTAzLmMKQEAgLTE5Myw0ICsxOTMsOCBAQCBzdGF0aWMgc3RydWN0IHRzdF90
ZXN0IHRlc3QgPSB7CiAJLnNldHVwID0gc2V0dXAsCiAJLnRlc3QgPSBydW4sCiAJLnRjbnQgPSBB
UlJBWV9TSVpFKHRlc3RmdW5jX2xpc3QpLAorCS5jYXBzID0gKHN0cnVjdCB0c3RfY2FwIFtdKSB7
CisJCVRTVF9DQVAoVFNUX0NBUF9SRVEsIENBUF9JUENfTE9DSyksCisJCXt9CisJfSwKIH07CmRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldHJ1c2FnZS9nZXRydXNhZ2Uw
My5oIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRydXNhZ2UvZ2V0cnVzYWdlMDMuaApp
bmRleCBmMWJiZTliZTUuLmIyOGI5ZDRjMyAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9nZXRydXNhZ2UvZ2V0cnVzYWdlMDMuaAorKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2dldHJ1c2FnZS9nZXRydXNhZ2UwMy5oCkBAIC0xNiw2ICsxNiw4IEBAIHN0YXRpYyB2
b2lkIGNvbnN1bWVfbWIoaW50IGNvbnN1bWVfbnIpCiAJc2l6ZV90IHNpemU7CiAJdW5zaWduZWQg
bG9uZyB2bXN3YXBfc2l6ZTsKIAorCW1sb2NrYWxsKE1DTF9DVVJSRU5UfE1DTF9GVVRVUkUpOwor
CiAJc2l6ZSA9IGNvbnN1bWVfbnIgKiAxMDI0ICogMTAyNDsKIAlwdHIgPSBTQUZFX01BTExPQyhz
aXplKTsKIAltZW1zZXQocHRyLCAwLCBzaXplKTsKLS0gCjIuMzEuMQoKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
