Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EE8C77B61
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 03:41:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFC253CCA76
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 05:41:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A8983C30A8
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 05:40:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1736F2009E5
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 05:40:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682566846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VwP+btHNRunNJwD4MOXR43ruNI0B6mM+TFXwpCgVqQI=;
 b=DNxYRX3v7pRzf3X/eAXRDQbN6stycwS7wHyodUEz/9r88ILLRznzBqT5oNZJLI7LtYxUe+
 uRlavOXrykrO74NIDrPXKtMBM6klcVrFbtZLs6tjQej88bZw+bpeGUN8XChafhE3k5PhvA
 QN4fPKz+OtVSkwSMCSF2woYsyZwLtFI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-OrsNzxdWNTCFrwLCp6yZUw-1; Wed, 26 Apr 2023 23:40:45 -0400
X-MC-Unique: OrsNzxdWNTCFrwLCp6yZUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3B85185A78B;
 Thu, 27 Apr 2023 03:40:44 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF287C15BA0;
 Thu, 27 Apr 2023 03:40:40 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 27 Apr 2023 11:40:39 +0800
Message-Id: <20230427034039.46512-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugemmap24: increase the baseline of slice_boundary
 according to hpage size
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
Cc: Fanhui Meng <mengfanhui@kylinos.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGhpcyBpcyB0byBhdm9pZCBlcnJvciBoYXBwZW5zIG9uIHN5c3RlbSAoYWFyY2g2NDogNTEyTUIp
IHdpdGggbGFyZ2UgaHVnZSBwYWdlOgoKICAjIC4vaHVnZW1tYXAyNAogIHRzdF9odWdlcGFnZS5j
OjgzOiBUSU5GTzogNyBodWdlcGFnZShzKSByZXNlcnZlZAogIHRzdF90ZXN0LmM6MTU2MDogVElO
Rk86IFRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwMG0gMzBzCiAgaHVnZW1tYXAyNC5jOjU3OiBUSU5G
TzogY2FuJ3QgdXNlIHNsaWNlX2JvdW5kYXJ5OiAweDEwMDAwMDAwOiBFSU5WQUwgKDIyKQogIGh1
Z2VtbWFwMjQuYzo1NzogVElORk86IGNhbid0IHVzZSBzbGljZV9ib3VuZGFyeTogMHgyMDAwMDAw
MDogRU5PTUVNICgxMikKICBodWdlbW1hcDI0LmM6NTc6IFRJTkZPOiBjYW4ndCB1c2Ugc2xpY2Vf
Ym91bmRhcnk6IDB4MzAwMDAwMDA6IEVJTlZBTCAoMjIpCiAgdHN0X3Rlc3QuYzoxNjE4OiBUQlJP
SzogVGVzdCBraWxsZWQgYnkgU0lHU0VHViEKCiAgIyBzdHJhY2UgLWYgLi9odWdlbW1hcDI077ya
CiAgLi4uCiAgW3BpZCA4NjU4MF0gbW1hcCgweGZmZmZmZmZmZjAwMDAwMDAsIDIxNDc0ODM2NDgs
IFBST1RfUkVBRCwgTUFQX1NIQVJFRHxNQVBfRklYRUQsIDMsIDApID0gLTEgRUlOVkFMCiAgW3Bp
ZCA4NjU4MF0gd3JpdGUoMiwgImh1Z2VtbWFwMjQuYzo1NzogXDMzWzE7MzRtVElORk86IFwzMyIu
Li4sIDg1aHVnZW1tYXAyNC5jOjU3OiBUSU5GTzogY2FuJ3QgdXNlIHNsaWNlX2JvdW5kYXJ5OiAw
eDMwMDAwMDAwOiBFSU5WQUwgKDIyKSkgPSA4NQogIFtwaWQgODY1ODBdIG1tYXAoTlVMTCwgMjE0
NzQ4MzY0OCwgUFJPVF9SRUFELCBNQVBfU0hBUkVEfE1BUF9GSVhFRCwgMywgMCkgPSAwCiAgW3Bp
ZCA4NjU4MF0gLS0tIFNJR1NFR1Yge3NpX3NpZ25vPVNJR1NFR1YsIHNpX2NvZGU9U0VHVl9BQ0NF
UlIsIHNpX2FkZHI9MHg0MDQzMzh9IC0tLQogIFtwaWQgODY1ODBdICsrKyBraWxsZWQgYnkgU0lH
U0VHViAoY29yZSBkdW1wZWQpICsrKwoKICAjIGNhdCAvcHJvYy9tZW1pbmZvCiAgSHVnZXBhZ2Vz
aXplOiA1MjQyODgga0IKCk5vdGU6CiAgVGhpcyBpcyBiYXNpY2FsbHkgYW4gaW1wcm92ZWQgcGF0
Y2ggYmFzZWQgb24gSmFuJ3Mgd29yaywgdGhlIG9ubHkKICBkaWZmZXJlbmNlIGlzIHRoYXQgdG8g
YnlwYXNzIHRoZSBoZWFwIGFuZCBhdm9pZCBzb21lIHBvdGVudGlhbAogIG1tYXAgY29sbGlzaW9u
cy4KCiAgUGF0Y2ggZ2V0IHBhc3NlZCBvbiBSSEVMLTcvOC85IGFjcm9zcyBtYW55IGFyY2hlcy4K
ICAoeDg2XzY0LCBwcGM2NGxlLCBwcGM2NCwgYWFyY2g2NCwgczM5MHgpCgpDbG9zZXM6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2lzc3Vlcy8xMDIyCkRpc2N1c3M6
IGh0dHBzOi8vbGlzdHMubGludXguaXQvcGlwZXJtYWlsL2x0cC8yMDIzLU1hcmNoLzAzMzExNy5o
dG1sCgpTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KQ2M6IEphbiBT
dGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgpDYzogVGFydW4gU2FodSA8dHNhaHVAbGludXgu
aWJtLmNvbT4KQ2M6IEZhbmh1aSBNZW5nIDxtZW5nZmFuaHVpQGt5bGlub3MuY24+Ci0tLQogdGVz
dGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDI0LmMgfCA5ICsrKysr
KysrLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAy
NC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDI0LmMK
aW5kZXggYTQ2NWFhZGVjLi4xNThhMDMwMTAgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwv
bWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAyNC5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwv
bWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAyNC5jCkBAIC0yMyw3ICsyMyw3IEBACiAKIHN0
YXRpYyBpbnQgIGZkID0gLTE7CiBzdGF0aWMgdW5zaWduZWQgbG9uZyBzbGljZV9ib3VuZGFyeTsK
LXN0YXRpYyBsb25nIGhwYWdlX3NpemUsIHBhZ2Vfc2l6ZTsKK3N0YXRpYyB1bnNpZ25lZCBsb25n
IGhwYWdlX3NpemUsIHBhZ2Vfc2l6ZTsKIAogc3RhdGljIGludCBpbml0X3NsaWNlX2JvdW5kYXJ5
KGludCBmZCkKIHsKQEAgLTQ0LDYgKzQ0LDEzIEBAIHN0YXRpYyBpbnQgaW5pdF9zbGljZV9ib3Vu
ZGFyeShpbnQgZmQpCiAJaGVhcCA9IG1hbGxvYygxKTsKIAlmcmVlKGhlYXApOwogCisJIC8qIEF2
b2lkIHVuZGVyZmxvdyBvbiBzeXN0ZW1zIHdpdGggbGFyZ2UgaHVnZSBwYWdlcy4KKwkgICogVGhl
IGFkZGl0aW9uYWxseSBwbHVzIGhlYXAgYWRkcmVzcyBpcyB0byByZWR1Y2UgdGhlIHBvc3NpYmls
aXR5CisJICAqIG9mIE1BUF9GSVhFRCBzdG9tcCBvdmVyIGV4aXN0aW5nIG1hcHBpbmdzLgorCSAg
Ki8KKwl3aGlsZSAoc2xpY2VfYm91bmRhcnkgKyBzbGljZV9zaXplIDwgKHVuc2lnbmVkIGxvbmcp
aGVhcCArIDIqaHBhZ2Vfc2l6ZSkKKwkJc2xpY2VfYm91bmRhcnkgKz0gc2xpY2Vfc2l6ZTsKKwog
CS8qIEZpbmQgMiBuZWlnaGJvdXIgc2xpY2VzIHdpdGggY291cGxlIGh1Z2UgcGFnZXMgZnJlZQog
CSAqIGFyb3VuZCBzbGljZSBib3VuZGFyeS4KIAkgKiAxNiBpcyB0aGUgbWF4aW11bSBudW1iZXIg
b2Ygc2xpY2VzIChsb3cvaGlnaCkKLS0gCjIuNDAuMAoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
