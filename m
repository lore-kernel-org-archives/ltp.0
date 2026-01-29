Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36067D358EE
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 10:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769680851; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=buGhIpmsuhCYOQGFcIJM9Jyxtr4aGkUdqyFECDgFw4Y=;
 b=PW+eNxuT1+zbQhsOKPZP1idXEwhitHhAC84W/yqs3Z9oiUkD7z/JHP+VsLzwigEhrnI8j
 t35KRoAvKfIQqIV4VKzBV+hLH8PFMRvgt1/0DiwghTBjG3qqOsK0y8XrLkbOTJtK8R4kxX5
 qpRjxeMGdyupXT6GkGDHLbYjiDiqVI0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACAB33CBE7F
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 11:00:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F13D3C20D7
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 11:00:27 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1C112600A3D
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 11:00:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769680821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8U3179B4b8OgmDi4BZ9LWHTyNL6Is+Vh+hIdcla7zxE=;
 b=HX8/j4l0RLHp156GPwlGKfmYqdp8n7jlrvpZEJR8wumsj3nHxJdHEvYxmCNquSVFk+ocp8
 Z4O8b+tPRG2w0KSt8bDfmh0IrSHPPuWQ9/kuCmh5IAz1/WGtcnG8kCAZ9No2i73xWswbna
 T5ERvL3ERtPJhEIaQXXbNUX+X42KRoI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-iwdFMPr1NnirI7Hb_gR3Lw-1; Thu,
 29 Jan 2026 05:00:20 -0500
X-MC-Unique: iwdFMPr1NnirI7Hb_gR3Lw-1
X-Mimecast-MFC-AGG-ID: iwdFMPr1NnirI7Hb_gR3Lw_1769680819
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E264A1956067
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 10:00:18 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.116.181])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7ECB19560A2
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 10:00:16 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 29 Jan 2026 18:00:11 +0800
Message-ID: <20260129100011.72437-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cxNreGv854NRFqsoZn-kI8k5JgemHnftWb93Gvm9crA_1769680819
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cve-2017-17052: tolerate ENOMEM during test
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

QXMgZWFjaCBpdGVyYXRpb24gb2YgbW1hcF90aHJlYWQoKSBncmFicyBhIGZyZXNoIDE24oCvTWlC
IE1BUF9QT1BVTEFURQpyZWdpb24gYW5kIG5ldmVyIHJlbGVhc2VzIGl0LiBBcyB0aGUgbG9vcCBy
dW5zLCB0aG9zZSByZWdpb25zCmFjY3VtdWxhdGUgY29uc3VtaW5nIGJvdGggdmlydHVhbCBhZGRy
ZXNzIHNwYWNlIGFuZCBjb21taXR0ZWQgcGh5c2ljYWwKbWVtb3J5IHJpZ2h0IGF3YXkgaW5zdGVh
ZCBvZiBsYXppbHkuCgpFYXNpbHkgbW1hcCgpIGZhaWxzIHdpdGggRU5PTUVNIG9uIHNtYWxsZXIv
bGltaXQgUkFNIHJlc291cmNlIHN5c3RlbS4KCkVycm9yIExvZzoKCiAgY3ZlLTIwMTctMTcwNTIu
Yzo0ODogVEJST0s6IG1tYXAoKG5pbCksMTY3NzcyMTYsUFJPVF9SRUFEKDEpLDMyODAyLC0xLDAp
IGZhaWxlZDogRU5PTUVNICgxMikKICB0c3RfdGVzdC5jOjQ3OTogVElORk86IENoaWxkIHByb2Nl
c3MgcmVwb3J0ZWQgVEJST0sga2lsbGluZyB0aGUgdGVzdAogIHRzdF90ZXN0LmM6MTkwOTogVElO
Rk86IEtpbGxlZCB0aGUgbGVmdG92ZXIgZGVzY2VuZGFudCBwcm9jZXNzZXMKCkNvbnNpZGVyIHRo
ZXJlIGlzIG5vIHByYWN0aWNhbCB1cHBlciBib3VuZCBvbiB0aGlzIGFsbG9jYXRpb24gcGF0dGVy
biwKc28gc2V0dGluZyAudGVzdC5taW5fbWVtX2F2YWlsIG1heSBub3QgaGVscHMuIEhlcmUgd2Ug
anVzdCB0b2xlcmF0ZQpFTk9NRU0gZHVyaW5nIHRoZSBtbWFwX3RocmVhZCgpIGxvb3BpbmcuCgpT
aWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KLS0tCiB0ZXN0Y2FzZXMv
Y3ZlL2N2ZS0yMDE3LTE3MDUyLmMgfCA5ICsrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9jdmUvY3Zl
LTIwMTctMTcwNTIuYyBiL3Rlc3RjYXNlcy9jdmUvY3ZlLTIwMTctMTcwNTIuYwppbmRleCA3MDBl
Yjc4MmUuLjYxMDMyYzE5NyAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNy0xNzA1
Mi5jCisrKyBiL3Rlc3RjYXNlcy9jdmUvY3ZlLTIwMTctMTcwNTIuYwpAQCAtNDQsOSArNDQsMTYg
QEAgc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQogCiBzdGF0aWMgdm9pZCAqbW1hcF90aHJlYWQo
dm9pZCAqYXJnKQogeworCXZvaWQgKnB0cjsKKwogCWZvciAoOzspIHsKLQkJU0FGRV9NTUFQKE5V
TEwsIDB4MTAwMDAwMCwgUFJPVF9SRUFELAorCQlwdHIgPSBtbWFwKE5VTEwsIDB4MTAwMDAwMCwg
UFJPVF9SRUFELAogCQkJCU1BUF9QT1BVTEFURXxNQVBfQU5PTllNT1VTfE1BUF9QUklWQVRFLCAt
MSwgMCk7CisKKwkJaWYgKChwdHIgPT0gTUFQX0ZBSUxFRCkgJiYgKGVycm5vID09IEVOT01FTSkp
IHsKKwkJCXVzbGVlcCgxMDAwKTsKKwkJCWNvbnRpbnVlOworCQl9CiAJfQogCiAJcmV0dXJuIGFy
ZzsKLS0gCjIuNTIuMAoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
