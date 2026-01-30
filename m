Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE72D73EBD
	for <ltp@archiver.kernel.org>; Fri, 30 Jan 2026 05:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769752423; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=oPdlnmE7ToCjgYPoYysIfzPS9wugN7MtRmKS2YO7vLs=;
 b=NuOHN+LwF6jdHXc3NFsxDDUSxgVI1RsOLJCYjcaUpTTQEKOiNVpI63xP0jtGGvVbtWjSE
 giDTys+DUMILSDPzNt+/+QNhJnE0leDmEd+icfrOLEIZpGpCcgPGqgLZTYTn2LUKIofIXFR
 Jp0towxdztNcgAYa8xFWAv4Eoy4q7sU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1535F3CBEDC
	for <ltp@archiver.kernel.org>; Fri, 30 Jan 2026 06:53:43 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90D8B3C5849
 for <ltp@lists.linux.it>; Fri, 30 Jan 2026 06:53:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 31B111400971
 for <ltp@lists.linux.it>; Fri, 30 Jan 2026 06:53:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769752393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eIh7Ve5YOedZoUiPGr044S3WTyoDavCG953OXH3Oju8=;
 b=bKk+GBHWiWECnoBoO4knUo4uvoF1d4ADCA1pweeV6/FQ+y3AY/j/jlURGBLPmHGmZs5Bvm
 VKZtLCKI7f0nijPNNctnXpl++MKD3R/Ss5KPQH+D8IywKdePyYWBXpqISXKNSnkUyWlcyz
 seZGwUzNvRJ1r5KNtp7LIarxhYwvKj4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-6fd3M5-8No2Dbdz6RSsojg-1; Fri,
 30 Jan 2026 00:53:11 -0500
X-MC-Unique: 6fd3M5-8No2Dbdz6RSsojg-1
X-Mimecast-MFC-AGG-ID: 6fd3M5-8No2Dbdz6RSsojg_1769752390
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FA1819560B8; Fri, 30 Jan 2026 05:52:57 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.116.129])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FB241955F1B; Fri, 30 Jan 2026 05:52:54 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri, 30 Jan 2026 13:52:49 +0800
Message-ID: <20260130055249.137401-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g6sDbdAh4d_O7h_hczpZIjPZ6j59vELyLHm9SpV1l-8_1769752390
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls: unlimit the process's virtual memory
 (address space)
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
Cc: Xiubo Li <xiubli@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UmVjZW50bHkgb3VyIHRlc3QgZW52aXJvbm1lbnQgY2hhbmdlcyBSTElNSVRfQVMgYmVmb3JlIExU
UCBydW5zLCBzbwp0aGVzZSB0ZXN0cyBoaXQgdGhlIHBlci1wcm9jZXNzIHZpcnR1YWwtbWVtb3J5
IGNlaWxpbmcgbG9uZyBiZWZvcmUKdGhleSByZWFjaCB0aGUga2VybmVsIGxpbWl0cyB0aGV5IGFy
ZSBpbnRlbmRlZCB0byBleGVyY2lzZS4KCm11bm1hcDA0IGV4aXRzIGFmdGVyIG9ubHkgfjM2ayBW
TUFzIGFuZCB0aGUgcGFydGlhbCBtdW5tYXAoKSBzdWNjZWVkczoKCiAgPT09PSBtdW5tYXAwNCA9
PT09CiAgY29tbWFuZDogbXVubWFwMDQKICB0c3RfdGVzdC5jOjE4NDY6IFRJTkZPOiBPdmVyYWxs
IHRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwNW0gMjRzCiAgbXVubWFwMDQuYzo1OTogVElORk86IE1h
cHBlZCAzNjI4MCByZWdpb25zCiAgbXVubWFwMDQuYzoyNjogVEZBSUw6IG11bm1hcChtYXBzWzJd
ICsgcGFnZV9zeiwgcGFnZV9zeikgc3VjY2VlZGVkCgpjdmUtMjAxNy0xNzA1MuKAmXMgTUFQX1BP
UFVMQVRFIGxvb3AgaGl0cyBFTk9NRU0gYW5kIFRCUk9LczoKCiAgPT09PSBjdmUtMjAxNy0xNzA1
MiA9PT09CiAgY29tbWFuZDogY3ZlLTIwMTctMTcwNTIKICBjdmUtMjAxNy0xNzA1Mi5jOjQ4OiBU
QlJPSzogbW1hcCgobmlsKSwxNjc3NzIxNixQUk9UX1JFQUQoMSksMzI4MDIsLTEsMCkgZmFpbGVk
OiBFTk9NRU0gKDEyKQogIHRzdF90ZXN0LmM6NDc5OiBUSU5GTzogQ2hpbGQgcHJvY2VzcyByZXBv
cnRlZCBUQlJPSyBraWxsaW5nIHRoZSB0ZXN0CiAgdHN0X3Rlc3QuYzoxOTA5OiBUSU5GTzogS2ls
bGVkIHRoZSBsZWZ0b3ZlciBkZXNjZW5kYW50IHByb2Nlc3NlcwoKY3ZlLTIwMTctMTAwMDM2NCAo
c3RhY2tfY2xhc2gpIGZhaWxzIHRvIGFsbG9jYXRlIHRoZSBndWFyZCBnYXAgcmVnaW9uOgoKICA9
PT09IGN2ZS0yMDE3LTEwMDAzNjQgPT09PQogIGNvbW1hbmQ6IHN0YWNrX2NsYXNoCiAgdHN0X2tj
b25maWcuYzo2Mjk6IFRJTkZPOiBzdGFja19ndWFyZF9nYXAgaXMgbm90IGZvdW5kIGluIC9wcm9j
L2NtZGxpbmUKICBzdGFja19jbGFzaC5jOjI5MzogVElORk86IFNUQUNLX0dST1dTRE9XTiA9IDEg
PT0gMHg3ZmZjMjQ1NWQ3YzAgPiAweDdmZmMyNDU1ZDczMAogIHN0YWNrX2NsYXNoLmM6MjQzOiBU
SU5GTzogU3RhY2s6MHg3ZmZjMjQ0NWQwMDArMHgxMDMwMDAgbW1hcDoweDdmZmMyNDM1YzAwMCsw
eDEwMDAKICBzdGFja19jbGFzaC5jOjEyNzogVEJST0s6IG1tYXAoMHgxMzI2MDAwLDE0MDQ0NDQ0
MDU2MzcxMixQUk9UX05PTkUoMCksMTA0ODYxMCwtMSwwKSBmYWlsZWQ6IEVOT01FTSAoMTIpCiAg
dHN0X3Rlc3QuYzo0Nzk6IFRJTkZPOiBDaGlsZCBwcm9jZXNzIHJlcG9ydGVkIFRCUk9LIGtpbGxp
bmcgdGhlIHRlc3QKICB0c3RfdGVzdC5jOjE5MDk6IFRJTkZPOiBLaWxsZWQgdGhlIGxlZnRvdmVy
IGRlc2NlbmRhbnQgcHJvY2Vzc2VzCgpFeHBsaWNpdGx5IHNldCBSTElNSVRfQVM9UkxJTV9JTkZJ
TklUWSBpbnNpZGUgZWFjaCB0ZXN0IHZpYSBzdHJ1Y3QKdHN0X3Rlc3QudWxpbWl0LCBlbnN1cmlu
ZyB0aGV5IGFsd2F5cyBoYXZlIHVubGltaXRlZCB2aXJ0dWFsIGFkZHJlc3MKc3BhY2UgcmVnYXJk
bGVzcyBvZiB0ZXN0IGVudiB1bGltaXQgc2V0dGluZ3MuCgpGb2xsb3ctdXA6IGMwNzVmNmMwNzMg
KCJjdmUtMjAxNy0xNzA1MjogdG9sZXJhdGUgRU5PTUVNIGR1cmluZyB0ZXN0IikKU2lnbmVkLW9m
Zi1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CkNjOiBYaXVibyBMaSA8eGl1YmxpQHJl
ZGhhdC5jb20+Ci0tLQoKTm90ZXM6CiAgICBXaGVuIEkgZGVidWdnaW5nIG11bm1hcDA0IGFuZCBz
dGFja19jbGFzaCB0b2RheSwgSSBzdWRkZW5seSByZWFsaXplZAogICAgdGhhdCB0aGUgY3ZlLTIw
MTctMTcwNTIgZXJyb3Igd2FzIGFsc28gY2xvc2VseSByZWxhdGVkIHRvIHRoZSBybGltaXQKICAg
IGNoYW5nZSwgd2hpY2ggd2FzIGludGVudGlvbmFsbHkgY2hhbmdlZCBieSBYaXVibyAobXkgY29s
bGVhZ3VlKSB0bwogICAgc3RhYmlsaXplIHNvbWUgbWVtb3J5IHByZXNzdXJlIHNjZW5hcmlvcy4K
ICAgIAogICAgSG93ZXZlciwgdGhpcyBjaGFuZ2UgdW5leHBlY3RlZGx5IGV4cG9zZWQgdGhlIG5l
ZWQgdG8gcGF5IGF0dGVudGlvbiB0bwogICAgUkxJTUlUX0FTIGluIHRoZXNlIHRlc3RzLCB3aGlj
aCBhbHNvIHNob3VsZCBiZSBmaXhlZCBpbiBMVFAgdXBzdHJlYW0uCiAgICAKICAgIEkgdGhpbmsg
dGhpcyBwYXRjaCBpcyB2YWx1YWJsZSB0byBiZSBtZXJnZWQgaW50byB0aGUgbmV3IHZlcnNpb24u
CgogdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNy0xNzA1Mi5jICAgICAgICAgICAgICB8IDQgKysrKwog
dGVzdGNhc2VzL2N2ZS9zdGFja19jbGFzaC5jICAgICAgICAgICAgICAgICB8IDQgKysrKwogdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvbXVubWFwMDQuYyB8IDQgKysrKwogMyBmaWxl
cyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2N2ZS9j
dmUtMjAxNy0xNzA1Mi5jIGIvdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNy0xNzA1Mi5jCmluZGV4IGYx
YmZmM2RiMi4uNGQ5NDQ4YzI3IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE3LTE3
MDUyLmMKKysrIGIvdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNy0xNzA1Mi5jCkBAIC0xMzAsNiArMTMw
LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKIAkuY2xlYW51cCA9IGNsZWFu
dXAsCiAJLnNldHVwID0gc2V0dXAsCiAJLnRlc3RfYWxsID0gcnVuLAorCS51bGltaXQgPSAoY29u
c3Qgc3RydWN0IHRzdF91bGltaXRfdmFsW10pIHsKKwkJe1JMSU1JVF9BUywgUkxJTV9JTkZJTklU
WX0sCisJCXt9CisJfSwKIAkudGFncyA9IChjb25zdCBzdHJ1Y3QgdHN0X3RhZ1tdKSB7CiAJCXsi
bGludXgtZ2l0IiwgIjJiN2U4NjY1YjRmZiJ9LAogCQl7IkNWRSIsICIyMDE3LTE3MDUyIn0sCmRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMvY3ZlL3N0YWNrX2NsYXNoLmMgYi90ZXN0Y2FzZXMvY3ZlL3N0
YWNrX2NsYXNoLmMKaW5kZXggMDU4NGIyZjdhLi5lOWRkMDczNmEgMTAwNjQ0Ci0tLSBhL3Rlc3Rj
YXNlcy9jdmUvc3RhY2tfY2xhc2guYworKysgYi90ZXN0Y2FzZXMvY3ZlL3N0YWNrX2NsYXNoLmMK
QEAgLTMzMSw2ICszMzEsMTAgQEAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewogCS5u
ZWVkc19yb290ID0gMSwKIAkuc2V0dXAgPSBzZXR1cCwKIAkudGVzdF9hbGwgPSBzdGFja19jbGFz
aF90ZXN0LAorCS51bGltaXQgPSAoY29uc3Qgc3RydWN0IHRzdF91bGltaXRfdmFsW10pIHsKKwkJ
e1JMSU1JVF9BUywgUkxJTV9JTkZJTklUWX0sCisJCXt9CisJfSwKIAkudGFncyA9IChjb25zdCBz
dHJ1Y3QgdHN0X3RhZ1tdKSB7CiAJCXsiQ1ZFIiwgIjIwMTctMTAwMDM2NCJ9LAogCQl7ImxpbnV4
LWdpdCIsICI1OGM1ZDBkNmQ1MjIifSwKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvbXVubWFwL211bm1hcDA0LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1h
cC9tdW5tYXAwNC5jCmluZGV4IGUxYjY3YWVlZS4uNmNjZjI1YjNiIDEwMDY0NAotLS0gYS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5jCisrKyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvbXVubWFwL211bm1hcDA0LmMKQEAgLTc1LDYgKzc1LDEwIEBAIHN0YXRp
YyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKIAkuY2xlYW51cCA9IGNsZWFudXAsCiAJLm5lZWRz
X3Jvb3QgPSAxLAogCS5taW5fa3ZlciA9ICI0LjE3IiwKKwkudWxpbWl0ID0gKGNvbnN0IHN0cnVj
dCB0c3RfdWxpbWl0X3ZhbFtdKSB7CisJCXtSTElNSVRfQVMsIFJMSU1fSU5GSU5JVFl9LAorCQl7
fQorCX0sCiAJLnNhdmVfcmVzdG9yZSA9IChjb25zdCBzdHJ1Y3QgdHN0X3BhdGhfdmFsW10pewog
CQl7ICIvcHJvYy9zeXMvdm0vbWF4X21hcF9jb3VudCIsIFRTVF9UT19TVFIoTUFQX01BWF9DT1VO
VCksIFRTVF9TUl9TS0lQIH0sCiAJCXt9LAotLSAKMi41Mi4wCgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
