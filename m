Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEA5C3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 09:38:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 381623D3835
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 11:38:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D17D03D3822
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 11:37:48 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C41E9601BD8
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 11:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720604265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B+yIUaLlMH2JVJlcOr1W9F5rmjqTv8ToCj3GlvW3+QM=;
 b=P7hFFikKvtJCs3cEU52562V+QJbBLMx0TlWLvvHkwlF00rGjDCTubjEaIxGBwsLg42BOwc
 p6g7LymWr0z9scfrVJmXp6nRoyutELzrxrAepMMeqUAXNQzYjDfV7RWKyM4Nf6HQQ9Re5+
 NZGupZV3TTdWz+buQKEqtHba41cdXGM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-CRDXPOPMNOWHZzT_pjF3YQ-1; Wed, 10 Jul 2024 05:37:43 -0400
X-MC-Unique: CRDXPOPMNOWHZzT_pjF3YQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-6818fa37eecso4834375a12.1
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 02:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720604262; x=1721209062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B+yIUaLlMH2JVJlcOr1W9F5rmjqTv8ToCj3GlvW3+QM=;
 b=su13xAMWNRHc2f9feaVKpPErGi4ogD/HgJ0K5GJTjdK9C20JaHUd7eYktvulMrToQ1
 BKbYefkx5bdrcthofWykkcMRzu6cQoh9zuGNyjF0Pd9E3Z9wiUTMCYaYf5qQwmgYEA0i
 X46k+jjBM6QLvljimUVtqIhsdQNdl6RN0B9rTWIe8wynMAuApRH4rNYluqMQhgYv0UfA
 EfGVkNSSyajOYO3peruL5+maWaLZ4gBRC2rTD0igSzUfJYDRIyRvgVt+5M8UzpVnYzFj
 6tU2Hz9Sx3uw6AhuK2Z/yzoPuH8MFZ+F/fcBi0d4l2PJa0WKdgyY4i1RjOpD9qSuKF0Q
 sIrA==
X-Gm-Message-State: AOJu0YzdX06JCaDWX18ZnH/daowHcFuw1kfmh9uxoHdEtIPiRE1X+1g+
 cw8QnxJMNSHskTe9Hxz6ghlRrBbfDTUakpkSZFxuc3ix1vqBs05N8n20fooTmdnkQAWvCtN6YHj
 A2LqSoLmBHv0vJqgGKozCUGZo/nf2EkVpN13SQQgZIJB0P9TNAU5ZkeG1Eu29yXIaN8CZA7FLW8
 rTFTL/hZDcnaT75gq1N18Liaw=
X-Received: by 2002:a17:90a:bb82:b0:2ca:4fca:2892 with SMTP id
 98e67ed59e1d1-2ca4fca2a0amr2580835a91.7.1720604261861; 
 Wed, 10 Jul 2024 02:37:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL0Xv+JDFWymWPif6DzBmW+5Rdar4JyGS/kxXqOUcz530RQrjT30B/4vLX/s/tUTvQCILZSgKMv0HSb9JYDeU=
X-Received: by 2002:a17:90a:bb82:b0:2ca:4fca:2892 with SMTP id
 98e67ed59e1d1-2ca4fca2a0amr2580824a91.7.1720604261357; Wed, 10 Jul 2024
 02:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240710-stat04-v3-0-c68a2324ad94@suse.com>
 <20240710-stat04-v3-4-c68a2324ad94@suse.com>
In-Reply-To: <20240710-stat04-v3-4-c68a2324ad94@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 10 Jul 2024 17:37:28 +0800
Message-ID: <CAEemH2dAR=M0X1t7Ntwb+COeMOJ3wfX4BEa9PAOeiY7M-36Gmg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 4/4] Add open15 test
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

T24gV2VkLCBKdWwgMTAsIDIwMjQgYXQgNDo1NuKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5kZT4Kd3JvdGU6Cgo+IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFu
ZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4KPiBUaGlzIHRlc3QgaGFzIGJlZW4gZXh0cmFjdGVk
IGZyb20gc3ltbGluazAxIGFuZCBpdCB2ZXJpZmllcyB0aGF0Cj4gb3BlbigpIGlzIHdvcmtpbmcg
Y29ycmVjdGx5IG9uIHN5bWxpbmsoKSBnZW5lcmF0ZWQgZmlsZXMuCj4KPiBTaWduZWQtb2ZmLWJ5
OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+CgpJdCBpcyBh
IGJpdCBkaWZmZXJlbnQgZnJvbSBzb21ldGhpbmcgaW4gbXkgaW1hZ2luYXRpb24sIGJ1dCBhbnl3
YXkKdGhpcyBhbHNvIGxvb2tzIGdvb2QuCgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJl
ZGhhdC5jb20+CgotLS0KPiAgcnVudGVzdC9zeXNjYWxscyAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMiArLQo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL29wZW4vLmdpdGlnbm9yZSB8
ICAxICsKPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9vcGVuL29wZW4xNS5jICAgfCA3NQo+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgMyBmaWxlcyBjaGFuZ2VkLCA3NyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvcnVudGVzdC9zeXNj
YWxscyBiL3J1bnRlc3Qvc3lzY2FsbHMKPiBpbmRleCA0MGMwZGQwNzAuLjRkZmRmMzc4MiAxMDA2
NDQKPiAtLS0gYS9ydW50ZXN0L3N5c2NhbGxzCj4gKysrIGIvcnVudGVzdC9zeXNjYWxscwo+IEBA
IC05MjMsNyArOTIzLDYgQEAgbmljZTA0IG5pY2UwNAo+ICBuaWNlMDUgbmljZTA1Cj4KPiAgb3Bl
bjAxIG9wZW4wMQo+IC1vcGVuMDFBIHN5bWxpbmswMSAtVCBvcGVuMDEKPiAgb3BlbjAyIG9wZW4w
Mgo+ICBvcGVuMDMgb3BlbjAzCj4gIG9wZW4wNCBvcGVuMDQKPiBAQCAtOTM2LDYgKzkzNSw3IEBA
IG9wZW4xMSBvcGVuMTEKPiAgb3BlbjEyIG9wZW4xMgo+ICBvcGVuMTMgb3BlbjEzCj4gIG9wZW4x
NCBvcGVuMTQKPiArb3BlbjE1IG9wZW4xNQo+Cj4gIG9wZW5hdDAxIG9wZW5hdDAxCj4gIG9wZW5h
dDAyIG9wZW5hdDAyCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3Bl
bi8uZ2l0aWdub3JlCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL29wZW4vLmdpdGlnbm9y
ZQo+IGluZGV4IDAwMWQ4NzRkNi4uYWY1OTk3NTcyIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvb3Blbi8uZ2l0aWdub3JlCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9vcGVuLy5naXRpZ25vcmUKPiBAQCAtMTIsMyArMTIsNCBAQAo+ICAvb3BlbjEyX2No
aWxkCj4gIC9vcGVuMTMKPiAgL29wZW4xNAo+ICsvb3BlbjE1Cj4gZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvb3Blbi9vcGVuMTUuYwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9vcGVuL29wZW4xNS5jCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAw
MDAwMDAuLjA5ZDdhMWYzYgo+IC0tLSAvZGV2L251bGwKPiArKysgYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL29wZW4vb3BlbjE1LmMKPiBAQCAtMCwwICsxLDc1IEBACj4gKy8vIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4gKy8qCj4gKyAqIENvcHlyaWdodCAo
YykgMjAwMCBTaWxpY29uIEdyYXBoaWNzLCBJbmMuICBBbGwgUmlnaHRzIFJlc2VydmVkLgo+ICsg
KiAgICBBdXRob3I6IERhdmlkIEZlbm5lcgo+ICsgKiAgICBDb3BpbG90OiBKb24gSGVuZHJpY2tz
b24KPiArICogQ29weXJpZ2h0IChDKSAyMDI0IEFuZHJlYSBDZXJ2ZXNhdG8gYW5kcmVhLmNlcnZl
c2F0b0BzdXNlLmNvbQo+ICsgKi8KPiArCj4gKy8qXAo+ICsgKiBbRGVzY3JpcHRpb25dCj4gKyAq
Cj4gKyAqIFRoaXMgdGVzdCB2ZXJpZmllcyB0aGF0IG9wZW4oKSBpcyB3b3JraW5nIGNvcnJlY3Rs
eSBvbiBzeW1saW5rKCkKPiArICogZ2VuZXJhdGVkIGZpbGVzLiBXZSBnZW5lcmF0ZSBhIGZpbGUg
dmlhIHN5bWxpbmssIHRoZW4gd2UgcmVhZCBib3RoCj4gZnJvbSBmaWxlCj4gKyAqIGFuZCBzeW1s
aW5rLCBjb21wYXJpbmcgdGhhdCBkYXRhIGhhcyBiZWVuIGNvcnJlY3RseSB3cml0dGVuLgo+ICsg
Ki8KPiArCj4gKyNpbmNsdWRlICJ0c3RfdGVzdC5oIgo+ICsKPiArI2RlZmluZSBGSUxFTkFNRSAi
bXlmaWxlLnR4dCIKPiArI2RlZmluZSBTWU1CTkFNRSAibXlmaWxlX3N5bWxpbmsiCj4gKyNkZWZp
bmUgQklHX1NUUklORyAiYWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXphYmNkZWZnaGlqa2xtbm9w
cXJzdHV2d3h5eiIKPiArCj4gK3N0YXRpYyBjaGFyIGJ1ZmZfZmlsZVsxMjhdOwo+ICtzdGF0aWMg
Y2hhciBidWZmX3N5bWJbMTI4XTsKPiArc3RhdGljIGludCBzdHJfc2l6ZTsKPiArCj4gK3N0YXRp
YyB2b2lkIHJ1bih2b2lkKQo+ICt7Cj4gKyAgICAgICBpbnQgZmRfZmlsZSwgZmRfc3ltYjsKPiAr
Cj4gKyAgICAgICBtZW1zZXQoYnVmZl9maWxlLCAwLCBzaXplb2YoYnVmZl9maWxlKSk7Cj4gKyAg
ICAgICBtZW1zZXQoYnVmZl9zeW1iLCAwLCBzaXplb2YoYnVmZl9zeW1iKSk7Cj4gKwo+ICsgICAg
ICAgdHN0X3JlcyhUSU5GTywgIkNyZWF0ZSBzeW1saW5rIik7Cj4gKyAgICAgICBTQUZFX1RPVUNI
KEZJTEVOQU1FLCAwNzc3LCBOVUxMKTsKPiArICAgICAgIFNBRkVfU1lNTElOSyhGSUxFTkFNRSwg
U1lNQk5BTUUpOwo+ICsKPiArICAgICAgIGZkX2ZpbGUgPSBTQUZFX09QRU4oRklMRU5BTUUsIE9f
UkRPTkxZLCAwNzc3KTsKPiArICAgICAgIGZkX3N5bWIgPSBTQUZFX09QRU4oU1lNQk5BTUUsIE9f
UkRXUiwgMDc3Nyk7Cj4gKwo+ICsgICAgICAgdHN0X3JlcyhUSU5GTywgIldyaXRlIGRhdGEgdmlh
IHN5bWxpbmsiKTsKPiArICAgICAgIFNBRkVfV1JJVEUoU0FGRV9XUklURV9BTEwsIGZkX3N5bWIs
IEJJR19TVFJJTkcsIHN0cl9zaXplKTsKPiArICAgICAgIFNBRkVfTFNFRUsoZmRfc3ltYiwgMCwg
MCk7Cj4gKwo+ICsgICAgICAgdHN0X3JlcyhUSU5GTywgIlJlYWQgZGF0YSB2aWEgZmlsZSIpOwo+
ICsgICAgICAgU0FGRV9SRUFEKDEsIGZkX2ZpbGUsIGJ1ZmZfZmlsZSwgc3RyX3NpemUpOwo+ICsg
ICAgICAgU0FGRV9MU0VFSyhmZF9maWxlLCAwLCAwKTsKPiArCj4gKyAgICAgICB0c3RfcmVzKFRJ
TkZPLCAiUmVhZCBkYXRhIHZpYSBzeW1saW5rIik7Cj4gKyAgICAgICBTQUZFX1JFQUQoMSwgZmRf
c3ltYiwgYnVmZl9zeW1iLCBzdHJfc2l6ZSk7Cj4gKyAgICAgICBTQUZFX0xTRUVLKGZkX3N5bWIs
IDAsIDApOwo+ICsKPiArICAgICAgIFRTVF9FWFBfRVhQUighc3RybmNtcChidWZmX2ZpbGUsIEJJ
R19TVFJJTkcsIHN0cl9zaXplKSwKPiArICAgICAgICAgICAgICAgImZpbGUgZGF0YSBoYXMgYmVl
biBjb3JyZWN0bHkgd3JpdHRlbiIpOwo+ICsKPiArICAgICAgIFRTVF9FWFBfRVhQUighc3RybmNt
cChidWZmX2ZpbGUsIGJ1ZmZfc3ltYiwgc3RyX3NpemUpLAo+ICsgICAgICAgICAgICAgICAiZmls
ZSBkYXRhIGlzIHRoZSBlcXVpdmFsZW50IHRvIHN5bWxpbmsgZ2VuZXJhdGVkIGZpbGUKPiBkYXRh
Iik7Cj4gKwo+ICsgICAgICAgU0FGRV9DTE9TRShmZF9maWxlKTsKPiArICAgICAgIFNBRkVfQ0xP
U0UoZmRfc3ltYik7Cj4gKwo+ICsgICAgICAgU0FGRV9VTkxJTksoU1lNQk5BTUUpOwo+ICsgICAg
ICAgU0FGRV9VTkxJTksoRklMRU5BTUUpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCBzZXR1cCh2
b2lkKQo+ICt7Cj4gKyAgICAgICBzdHJfc2l6ZSA9IHN0cmxlbihCSUdfU1RSSU5HKTsKPiArfQo+
ICsKPiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICsgICAgICAgLnRlc3RfYWxs
ID0gcnVuLAo+ICsgICAgICAgLnNldHVwID0gc2V0dXAsCj4gKyAgICAgICAubmVlZHNfdG1wZGly
ID0gMSwKPiArfTsKPgo+IC0tCj4gMi40My4wCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJlZ2FyZHMsCkxp
IFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
