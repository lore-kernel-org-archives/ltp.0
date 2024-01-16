Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0943EC47077
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 03:17:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C0C53CE376
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 04:17:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 119683C1D32
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 04:17:39 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 99AC8600829
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 04:17:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705375057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Hh0+svzdAxHeMr8XqQcXJ259mDXZm3alNqd2Z4YohSA=;
 b=DL/JKSyv2Rsmke0A/zT++Anuq7plJI9nPJxFBtRaodlihzFSTQBUdzw0v43VUNZNJnkj+T
 Pt5a/A5JEb+1I/n3s7QiCcY2bXgRHQq6oogj37aGxYI610NL+C+6gVQ3Xx8qpswYbZdDT3
 OsbfTtK0PnSPCivhvqE8BZpP7x2dkZ4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-H_3y9LBXOXug87N6NKAvWg-1; Mon,
 15 Jan 2024 22:17:33 -0500
X-MC-Unique: H_3y9LBXOXug87N6NKAvWg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2A7728EA6F2;
 Tue, 16 Jan 2024 03:17:32 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63E5F1C060B3;
 Tue, 16 Jan 2024 03:17:31 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 16 Jan 2024 11:17:28 +0800
Message-Id: <20240116031728.2500892-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tcindex01: fix compilation errors due to missing
 TCA_TCINDEX_ constants
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
Cc: jhs@mojatatu.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGhlIGNoYW5nZSBhZGRyZXNzZXMgY29tcGlsYXRpb24gZXJyb3JzIGVuY291bnRlcmVkIGluIHRo
ZSB0Y2luZGV4MDEuYwp0ZXN0IHdoZW4gY29tcGlsZWQgYWdhaW5zdCBrZXJuZWwtNi43IGFuZCBh
Ym92ZS4KCiAgdGNpbmRleDAxLmM6Njc6NDogZXJyb3I6IOKAmFRDQV9UQ0lOREVYX01BU0vigJkg
dW5kZWNsYXJlZCBoZXJlIChub3QgaW4gYSBmdW5jdGlvbik7CiAgICAgZGlkIHlvdSBtZWFuIOKA
mFRDQV9DT0RFTF9NQVjigJk/CiAgICAge1RDQV9UQ0lOREVYX01BU0ssICZtYXNrLCBzaXplb2Yo
bWFzayksIE5VTEx9LAogICAgICBefn5+fn5+fn5+fn5+fn5+CiAgICAgIFRDQV9DT0RFTF9NQVgK
ICB0Y2luZGV4MDEuYzo2ODo0OiBlcnJvcjog4oCYVENBX1RDSU5ERVhfU0hJRlTigJkgdW5kZWNs
YXJlZCBoZXJlIChub3QgaW4gYSBmdW5jdGlvbik7CiAgICAgZGlkIHlvdSBtZWFuIOKAmFRDQV9G
TE9XX1JTSElGVOKAmT8KICAgICB7VENBX1RDSU5ERVhfU0hJRlQsICZzaGlmdCwgc2l6ZW9mKHNo
aWZ0KSwgTlVMTH0sCiAgICAgIF5+fn5+fn5+fn5+fn5+fn5+CiAgICAgIFRDQV9GTE9XX1JTSElG
VAogIENDIHRlc3RjYXNlcy9jdmUvY3ZlLTIwMTYtNzExNwogIENDIHV0aWxzL3NjdHAvZnVuY190
ZXN0cy90ZXN0X2dldG5hbWVfdjYubwogIHRjaW5kZXgwMS5jOjY5OjQ6IGVycm9yOiDigJhUQ0Ff
VENJTkRFWF9DTEFTU0lE4oCZIHVuZGVjbGFyZWQgaGVyZSAobm90IGluIGEgZnVuY3Rpb24pOwog
ICAgIGRpZCB5b3UgbWVhbiDigJhUQ0FfRkxPV0VSX0NMQVNTSUTigJk/CiAgICAge1RDQV9UQ0lO
REVYX0NMQVNTSUQsICZjbHNpZCwgc2l6ZW9mKGNsc2lkKSwgTlVMTH0sCiAgICAgIF5+fn5+fn5+
fn5+fn5+fn5+fn4KICAgICAgVENBX0ZMT1dFUl9DTEFTU0lECgpUaGUgZXJyb3JzIHdlcmUgZHVl
IHRvIHRoZSByZW1vdmFsIG9mIGNlcnRhaW4gVENBX1RDSU5ERVhfIGNvbnN0YW50cwpmcm9tIHRo
ZSBrZXJuZWwncyB1c2VyIEFQSSAodWFwaSksIGFzIGluZGljYXRlZCBieSB0aGUga2VybmVsIGNv
bW1pdC4KCiAgY29tbWl0IDgyYjI1NDVlZDlhIChuZXQvc2NoZWQ6IFJlbW92ZSB1YXBpIHN1cHBv
cnQgZm9yIHRjaW5kZXggY2xhc3NpZmllcikKClRoZSByZWFzb24gd2h5IEkgZGlkbid0IGFkZCB0
aGlzIGludG8gTFRQIGxpYnJhcnkgaXMgdGhhdCB0aGUgZGVmaW5lcwpoYXZlIGJlZW4gZHJvcHBl
ZCB3ZSBqdXN0IG5lZWQgdG8gc2F0aXNmeSB0aGlzIG9uZSBjYXNlLgotLS0KCk5vdGVzOgogICAg
V2UgbmVlZCB0byBtZXJnZSB0aGlzIHBhdGNoIGJlZm9yZSB0aGUgbmV3IHJlbGVhc2UuCgogdGVz
dGNhc2VzL2N2ZS90Y2luZGV4MDEuYyB8IDE3ICsrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hh
bmdlZCwgMTcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9jdmUvdGNpbmRl
eDAxLmMgYi90ZXN0Y2FzZXMvY3ZlL3RjaW5kZXgwMS5jCmluZGV4IGI0ZjJiYjAxYS4uNzBlNTYz
OWYxIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMvY3ZlL3RjaW5kZXgwMS5jCisrKyBiL3Rlc3RjYXNl
cy9jdmUvdGNpbmRleDAxLmMKQEAgLTMyLDYgKzMyLDIzIEBACiAKICNkZWZpbmUgREVWTkFNRSAi
bHRwX2R1bW15MSIKIAorI2lmbmRlZiBUQ0FfVENJTkRFWF9NQVgKK2VudW0geworICAgICAgIFRD
QV9UQ0lOREVYX1VOU1BFQywKKyAgICAgICBUQ0FfVENJTkRFWF9IQVNILAorICAgICAgIFRDQV9U
Q0lOREVYX01BU0ssCisgICAgICAgVENBX1RDSU5ERVhfU0hJRlQsCisgICAgICAgVENBX1RDSU5E
RVhfRkFMTF9USFJPVUdILAorICAgICAgIFRDQV9UQ0lOREVYX0NMQVNTSUQsCisgICAgICAgVENB
X1RDSU5ERVhfUE9MSUNFLAorICAgICAgIFRDQV9UQ0lOREVYX0FDVCwKKyAgICAgICBfX1RDQV9U
Q0lOREVYX01BWAorfTsKKworI2RlZmluZSBUQ0FfVENJTkRFWF9NQVggICAgIChfX1RDQV9UQ0lO
REVYX01BWCAtIDEpCisjZW5kaWYKKworCiBzdGF0aWMgY29uc3QgdWludDMyX3QgcWRfaGFuZGxl
ID0gVENfSF9NQUtFKDEgPDwgMTYsIDApOwogc3RhdGljIGNvbnN0IHVpbnQzMl90IGNsc2lkID0g
VENfSF9NQUtFKDEgPDwgMTYsIDEpOwogc3RhdGljIGNvbnN0IHVpbnQzMl90IHNoaWZ0ID0gMTA7
Ci0tIAoyLjQwLjEKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
