Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9D0C02192
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 10:33:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2798E3C91EF
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 11:33:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 471C23C91B1
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 11:33:28 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E75591A0434E
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 11:33:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738751605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5fY2lb6JbUOVSHtAz38u3ea2Q/kVKdAalx7uePsw4J4=;
 b=M59f9uao8h1s87lLtP4TYT4HwgdCRaUDt9rNBCtXztuiJjqXqgQsqBOKKThEKOiQc2kUP4
 ZkWserKz91QIEnQbwJvVjp/JVJ2AI5GNa2FROU43nJRjS3pgnwpZeE5+vkpifYBneHFgrI
 Y/GbE4SdbRxiY2xRaoKPM6aBkv+wHEs=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-n4cnZt4zMsKK-wVWXFqXNg-1; Wed, 05 Feb 2025 05:33:24 -0500
X-MC-Unique: n4cnZt4zMsKK-wVWXFqXNg-1
X-Mimecast-MFC-AGG-ID: n4cnZt4zMsKK-wVWXFqXNg
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3eba9474a46so1901869b6e.0
 for <ltp@lists.linux.it>; Wed, 05 Feb 2025 02:33:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738751604; x=1739356404;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fY2lb6JbUOVSHtAz38u3ea2Q/kVKdAalx7uePsw4J4=;
 b=eLhWM8ylH6P9D7D/A0j+s9z27eZUyjzt6EPN16RGCDTCWu7tDZBnKBN1JT0B20hGim
 AnfQTzAUypjf59GOURJzt+jvR5bDMYD2xE/JuMTjBZumPvbUUOchvC6II/Zj6StuQgNj
 yaGx9afuA9Lg7r0blRBUZUVLlPpXkCj41g9Dm1aFb+cTlH2UT5mbeCz4JE7adLb9Lglz
 p8vFeWBPSTSxKPh4r+VfmypqTiA8guzQ0LVxuIJFUpu132asp3e6sH0JcnA3K2azIcKf
 WoW2DOvz/4Leaq7u/xo0TrSm64jVk5LMee6dKyXg1xrCB+e7qhEUQnElT7DSA4S+VOwx
 /Gjg==
X-Gm-Message-State: AOJu0YzejIw5IWVvqZf1bJC4I5JEVpLvtqzXlyN+FTec1VUKzwDW1Gn8
 +Orfv14MC1VQTNWc1JlniRZ8ont5cVHL0QUFLuLrpIKMgSFQSiN/YqE2vRUPDm5jhHTwaXKpGHe
 U2DIwsyVjfpiio0z4tr7xVXFTL2DDu/0GqseIL6Tk+JPV0dOhO6W+CJZDuz1fquUS8m5USQGteQ
 bno4ReYWeVYCOGIYJMty6l9/A=
X-Gm-Gg: ASbGncuzPgnzkiHcnMxYMvUM0MPj4UgBkq07A4cJenfNK1ndGKN0BQ1jQBMdVZiqQQ0
 cYPpySJk22s8vb7iyHbT6HAIe9USBOO9AQFmbrcdtPGvKhX0fxjSNgdUi8HLA
X-Received: by 2002:a05:6808:17a5:b0:3eb:4a36:8744 with SMTP id
 5614622812f47-3f37c13bf07mr1392267b6e.17.1738751603902; 
 Wed, 05 Feb 2025 02:33:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEn6N130Wk8/2xbkJrFFGoSOP+OsstDjE2UDrdYs3HnSzMj+NyMWOBm2nVBhqkEo4yOvYXusrOpCW4togE7Z8E=
X-Received: by 2002:a05:6808:17a5:b0:3eb:4a36:8744 with SMTP id
 5614622812f47-3f37c13bf07mr1392253b6e.17.1738751603387; Wed, 05 Feb 2025
 02:33:23 -0800 (PST)
MIME-Version: 1.0
References: <Z6LS8SfWeWnd5A3C@wegao>
In-Reply-To: <Z6LS8SfWeWnd5A3C@wegao>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 5 Feb 2025 11:33:08 +0100
X-Gm-Features: AWEUYZknCtej5mlG7NfpjyB-yW5TbXoqMiBrN2vmacectMXWpdQ47J1J5GrmiHM
Message-ID: <CAASaF6zAqMoT6J1nAG2uwo1pyQnHAEFvcZPinv4w=5F0=TKnqQ@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4ZTEhf6vbpECEa2ioE43ftocXrjOFcTcRuu-mPl_ybc_1738751604
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap34 trigger oom if compile with
 CFLAGS='-fstack-clash-protection'
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBGZWIgNSwgMjAyNSBhdCAzOjU04oCvQU0gV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+
IHdyb3RlOgo+Cj4gSGkgSmFuCj4KPiBDb21waWxpbmcgaHVnZW1tYXAzNCB3aXRoIENGTEFHUz0n
LWZzdGFjay1jbGFzaC1wcm90ZWN0aW9uJyBjYXVzZXMgZ2NjIHRvIGluc2VydCBhZGRpdGlvbmFs
IHN0YWNrIGFkZHJlc3MgdmFsaWRhdGlvbiBjaGVja3MgZHVyaW5nIGFsbG9jYSBjYWxscy4gIFRo
aXMgcmVzdWx0cyBpbiBrZXJuZWwgc3RhcnQgYWxsb2NhdGUgbWVtb3J5IHJlYWxseSAsIGV2ZW50
dWFsbHkgdHJpZ2dlcmluZyBhbiBPT00uCj4KPiBJbiBvdXIgbm9ybWFsIG9wZW5xYSBlbnYgd2Ug
ZG8gbm90IGhhdmUgc3VjaCBiaWcgbWVtb3J5KDEwMjRHQikgdG8gc3VwcG9ydCB0aGlzIHRlc3Qu
IFNvIHdlCj4gIGhhdmUgdG8gZGlzYWJsZSBDRkxBR1M9Jy1mc3RhY2stY2xhc2gtcHJvdGVjdGlv
bicgaWYgd2Ugc3RpbGwgbmVlZCB0aGlzIGNhc2UgcnVubmluZyBpbiBvdXIgZW52LgoKSGksCgpJ
dCBzb3VuZHMgbGlrZSB5b3UgYWxyZWFkeSBmb3VuZCB0aGUgY2F1c2UuIFdlIHNlZW0gdG8gaGF2
ZSBjb3VwbGUgY2hvaWNlczoKCjEpIHN0cmlwIHRoZSBvcHRpb24gZnJvbSB0aGUgQ0ZMQUdTIGZv
ciB0aGlzIHRlc3RjYXNlCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxi
L2h1Z2VtbWFwL01ha2VmaWxlCmIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1h
cC9NYWtlZmlsZQppbmRleCAyZDY1MWI0YWEuLjExNTRhYjNkZSAxMDA2NDQKLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9NYWtlZmlsZQorKysgYi90ZXN0Y2FzZXMv
a2VybmVsL21lbS9odWdldGxiL2h1Z2VtbWFwL01ha2VmaWxlCkBAIC04LDQgKzgsNyBAQCBpbmNs
dWRlICQodG9wX3NyY2RpcikvaW5jbHVkZS9tay90ZXN0Y2FzZXMubWsKIGluY2x1ZGUgJChhYnNf
c3JjZGlyKS8uLi9NYWtlZmlsZS5pbmMKIGluY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21r
L2dlbmVyaWNfbGVhZl90YXJnZXQubWsKCitDRkxBR1Nfbm9fc3RhY2tfcHJvdCA6PSAkKGZpbHRl
ci1vdXQgLWZzdGFjay1jbGFzaC1wcm90ZWN0aW9uLCAkKENGTEFHUykpCisKK2h1Z2VtbWFwMzQ6
IENGTEFHUz0kKENGTEFHU19ub19zdGFja19wcm90KQoKMikgaW5jcmVhc2UgdGhlIG1lbW9yeSBy
ZXF1aXJlbWVudHMgZm9yIHRoZSB0ZXN0LgoKSSdkIHByb2JhYmx5IGdvIHdpdGggMSkgc2luY2Ug
d2Ugd2FudCBrZXJuZWwgdG8gY2F0Y2ggYW55IGlzc3VlcyBhbnl3YXkuIEFuZCBpdAphbGxvd3Mg
dGVzdCB0byBydW4gb24gbGFyZ2VyIHBvb2wgb2Ygc3lzdGVtcy4KCj4KPiA9PT1sb2cgd2l0aCBD
RkxBR1M9Jy1mc3RhY2stY2xhc2gtcHJvdGVjdGlvbic9PT0KPiBbNzEwNzMuNTYyMDk0XSBbVDEz
NTQ2XSBvb20ta2lsbDpjb25zdHJhaW50PUNPTlNUUkFJTlRfTk9ORSxub2RlbWFzaz0obnVsbCks
Y3B1c2V0PS8sbWVtc19hbGxvd2VkPTAtMSxnbG9iYWxfb29tLHRhc2tfbWVtY2c9Lyx0YXNrPWh1
Z2VtbWFwMzQscGlkPTEzNTQyLHVpZD0wCj4gWzcxMDczLjU2MjEwOV0gW1QxMzU0Nl0gT3V0IG9m
IG1lbW9yeTogS2lsbGVkIHByb2Nlc3MgMTM1NDIgKGh1Z2VtbWFwMzQpIHRvdGFsLXZtOjQ3NjQ4
NjRrQiwgYW5vbi1yc3M6MjgxNjAwMGtCLCBmaWxlLXJzczowa0IsIHNobWVtLXJzczowa0IsIFVJ
RDowIHBndGFibGVzOjYzNmtCIG9vbV9zY29yZV9hZGo6MAo+Cj4gdHN0X2h1Z2VwYWdlLmM6ODQ6
IFRJTkZPOiAxIGh1Z2VwYWdlKHMpIHJlc2VydmVkCj4gdHN0X3RtcGRpci5jOjMxNzogVElORk86
IFVzaW5nIC90bXAvTFRQX2h1ZzJ2eGZoMSBhcyB0bXBkaXIgKGJ0cmZzIGZpbGVzeXN0ZW0pCj4g
dHN0X3Rlc3QuYzoxMDk3OiBUSU5GTzogTW91bnRpbmcgbm9uZSB0byAvdG1wL0xUUF9odWcydnhm
aDEvaHVnZXRsYmZzIGZzdHlwPWh1Z2V0bGJmcyBmbGFncz0wCj4gdHN0X3Rlc3QuYzoxOTAwOiBU
SU5GTzogTFRQIHZlcnNpb246IDIwMjQwOTMwCj4gdHN0X3Rlc3QuYzoxOTA0OiBUSU5GTzogVGVz
dGVkIGtlcm5lbDogNi40LjAtMTUwNzAwLjQwLWRlZmF1bHQgIzEgU01QIFRodSBKYW4gOSAxMjo0
MzozMSBVVEMgMjAyNSAoZjc4ZmQ1ZSkgcHBjNjRsZQo+IHRzdF9rY29uZmlnLmM6ODg6IFRJTkZP
OiBQYXJzaW5nIGtlcm5lbCBjb25maWcgJy9wcm9jL2NvbmZpZy5neicKPiB0c3Rfa2NvbmZpZy5j
OjY2OTogVElORk86IENPTkZJR19MQVRFTkNZVE9QIGtlcm5lbCBvcHRpb24gZGV0ZWN0ZWQgd2hp
Y2ggbWlnaHQgc2xvdyB0aGUgZXhlY3V0aW9uCj4gdHN0X3Rlc3QuYzoxNzI0OiBUSU5GTzogT3Zl
cmFsbCB0aW1lb3V0IHBlciBydW4gaXMgMGggMDJtIDAwcwo+IGh1Z2VtbWFwMzQuYzoxNTI6IFRJ
TkZPOiBzZWFyY2hpbmcgZm9yIGh1Z2UgcGFnZSBhbmQgY2hpbGQgc3RhY2sgcGxhY2VtZW50Cj4g
aHVnZW1tYXAzNC5jOjE3NTogVElORk86IHBvdGVudGlhbCBzdGFjayBhdCBhZGRyZXNzIDB4N2Vm
ZmZmMDAwMDAwCj4gaHVnZW1tYXAzNC5jOjE5MjogVElORk86IHN0YWNrID0gMHg3ZWZmZmYwMDAw
MDAtMHg3ZjAwMDAwMDAwMDAsIGh1Z2VwYWdlID0gMHg3ZGZmZmYwMDAwMDAtMHg3ZTAwMDAwMDAw
MDAKPiB0c3RfY29yZWR1bXAuYzozMjogVElORk86IEF2b2lkIGR1bXBpbmcgY29yZWZpbGUgZm9y
IHByb2Nlc3MocGlkPTIwNzE0KQo+IGh1Z2VtbWFwMzQuYzo1NjogVElORk86IENoaWxkIHByb2Nl
c3Mgc3RhcnRpbmcgd2l0aCB0b3Agb2Ygc3RhY2sgYXQgMHg3ZWZmZmZmZmZmODAKPgo+IHRzdF90
ZXN0LmM6MTc4NTogVElORk86IEtpbGxlZCB0aGUgbGVmdG92ZXIgZGVzY2VuZGFudCBwcm9jZXNz
ZXMKPiB0c3RfdGVzdC5jOjE3OTI6IFRJTkZPOiBJZiB5b3UgYXJlIHJ1bm5pbmcgb24gc2xvdyBt
YWNoaW5lLCB0cnkgZXhwb3J0aW5nIExUUF9USU1FT1VUX01VTCA+IDEKPiB0c3RfdGVzdC5jOjE3
OTM6IFRCUk9LOiBUZXN0IGtpbGxlZCEgKHRpbWVvdXQ/KQo+Cj4KPiA9PT1sb2cgd2l0aG91dCBD
RkxBR1M9Jy1mc3RhY2stY2xhc2gtcHJvdGVjdGlvbic9PT0KPiB0c3RfaHVnZXBhZ2UuYzo4NDog
VElORk86IDEgaHVnZXBhZ2UocykgcmVzZXJ2ZWQKPiB0c3RfdG1wZGlyLmM6MzE3OiBUSU5GTzog
VXNpbmcgL3RtcC9MVFBfaHVnanp0dm9YIGFzIHRtcGRpciAoYnRyZnMgZmlsZXN5c3RlbSkKPiB0
c3RfdGVzdC5jOjEwOTc6IFRJTkZPOiBNb3VudGluZyBub25lIHRvIC90bXAvTFRQX2h1Z2p6dHZv
WC9odWdldGxiZnMgZnN0eXA9aHVnZXRsYmZzIGZsYWdzPTAKPiB0c3RfdGVzdC5jOjE5MDA6IFRJ
TkZPOiBMVFAgdmVyc2lvbjogMjAyNDA5MzAKPiB0c3RfdGVzdC5jOjE5MDQ6IFRJTkZPOiBUZXN0
ZWQga2VybmVsOiA2LjQuMC0xNTA3MDAuNDAtZGVmYXVsdCAjMSBTTVAgVGh1IEphbiA5IDEyOjQz
OjMxIFVUQyAyMDI1IChmNzhmZDVlKSBwcGM2NGxlCj4gdHN0X2tjb25maWcuYzo4ODogVElORk86
IFBhcnNpbmcga2VybmVsIGNvbmZpZyAnL3Byb2MvY29uZmlnLmd6Jwo+IHRzdF9rY29uZmlnLmM6
NjY5OiBUSU5GTzogQ09ORklHX0xBVEVOQ1lUT1Aga2VybmVsIG9wdGlvbiBkZXRlY3RlZCB3aGlj
aCBtaWdodCBzbG93IHRoZSBleGVjdXRpb24KPiB0c3RfdGVzdC5jOjE3MjQ6IFRJTkZPOiBPdmVy
YWxsIHRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwMm0gMDBzCj4gaHVnZW1tYXAzNC5jOjE1MjogVElO
Rk86IHNlYXJjaGluZyBmb3IgaHVnZSBwYWdlIGFuZCBjaGlsZCBzdGFjayBwbGFjZW1lbnQKPiBo
dWdlbW1hcDM0LmM6MTc1OiBUSU5GTzogcG90ZW50aWFsIHN0YWNrIGF0IGFkZHJlc3MgMHg3ZWZm
ZmYwMDAwMDAKPiBodWdlbW1hcDM0LmM6MTkyOiBUSU5GTzogc3RhY2sgPSAweDdlZmZmZjAwMDAw
MC0weDdmMDAwMDAwMDAwMCwgaHVnZXBhZ2UgPSAweDdkZmZmZjAwMDAwMC0weDdlMDAwMDAwMDAw
MAo+IHRzdF9jb3JlZHVtcC5jOjMyOiBUSU5GTzogQXZvaWQgZHVtcGluZyBjb3JlZmlsZSBmb3Ig
cHJvY2VzcyhwaWQ9MjA3MDQpCj4gaHVnZW1tYXAzNC5jOjU2OiBUSU5GTzogQ2hpbGQgcHJvY2Vz
cyBzdGFydGluZyB3aXRoIHRvcCBvZiBzdGFjayBhdCAweDdlZmZmZmZmZmY4MAo+IGh1Z2VtbWFw
MzQuYzo3NzogVElORk86IENoaWxkIHByb2Nlc3MgZXh0ZW5kZWQgc3RhY2sgdXAgdG8gMHg3ZGZm
ZmZmZWZmODAsIGhhc24ndCByZWFjaGVkIDB4N2RmZmVmZmVmZjgwCj4gaHVnZW1tYXAzNC5jOjc5
OiBUUEFTUzogQ2hpbGQga2lsbGVkIGJ5IFNJR1NFR1YgYXMgZXhwZWN0ZWQKPgo+IFRoYW5rcy4K
PiBSZWdhcmRzCj4gR2FvIFdlaQo+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
