Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E39C02196
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 09:50:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0215C3C938E
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 10:49:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 907C53C92F4
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 10:49:42 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A5BC41400207
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 10:49:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738921779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hIaDMwnfefNe2C5jP1rXBY0igL3WC7VrYUrZdZ11tDQ=;
 b=ddLiIeWfYAOYCteWW3RHdAtux33izMp2Ut5+is88Iqmgff5nMAnw0SeLIeZWnLwGMMSlap
 pl6VYXyz8yx1szedh3ikRm+vqEA4PixTxzhUzKZ07fY0M2+IAjnsk9VqQwyZIABa5B/+F7
 YB3IYus846w5//VRtiPrdvamPZZt6v4=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-hW3NfzglPMSCl5Hbk0I6_Q-1; Fri, 07 Feb 2025 04:49:38 -0500
X-MC-Unique: hW3NfzglPMSCl5Hbk0I6_Q-1
X-Mimecast-MFC-AGG-ID: hW3NfzglPMSCl5Hbk0I6_Q
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3eb8947aa78so1385491b6e.3
 for <ltp@lists.linux.it>; Fri, 07 Feb 2025 01:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738921778; x=1739526578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hIaDMwnfefNe2C5jP1rXBY0igL3WC7VrYUrZdZ11tDQ=;
 b=J3axuDwSTz+ppb2/9iDtxcnI1et+F53jE2X/Aplx4SI/BcEQ3HPDOIuQeTI8eNg2dj
 2/+BZTMUiFC5sRLSvuntEl7jcOhRHeXbR4smJ5OwMtlgBFpNeMJWIEbXRNG27P8ngwjr
 i0YbXXw9TdrgofJqBQ/hbjnbaUAvvhm8GqyPyZLSFneUqzhOwb0H+9M+YO3icUIpFg6m
 r5yxTQDcUKNnDFkw34tW+IIiuXcFlDkrkPgtZFcySs8mmBJJh0DdeqJAgzSoBAYP9riL
 QC+LE414IJNDpO/EJAlaD5Z/aKI5Uq9Jrjufvq1bVLmwhJ1McKPVO73caE9ahXzwYnP8
 VPrw==
X-Gm-Message-State: AOJu0YzzjrBtPAuoNr3g8jm/dFKUFiuChFWPvLYk7BFZVkX8y6QfpMkE
 68hn5diM/hKq4tSkjArJizcaLb/Graym7zxM9r7V2b23GVDV95B9dVI1CDTrbhuodsUp/17IGsg
 75LrQPeQMDB+4Ly3Cfou98SF9Idm5kkauQFMFVGfJLdSUwtuFo24h/D/5HkfhR2iSXyKMqMym80
 HxfAxd/s2dLaAQQPrGgCHr0KZukXvdqAo=
X-Gm-Gg: ASbGnctslKeNMRrU4UWO1fYYWGXOMIuARNx+ISJ9w/3Y8VfcrxJ2UoxczVEUymorwiL
 M3E729+JFJ1duYpq1NGEP4LU0yHfxEIdbCisOFuSMDtTFGIgVOZLiWEFj55PuiQ==
X-Received: by 2002:a05:6808:18a9:b0:3e6:14a6:4288 with SMTP id
 5614622812f47-3f39227835dmr1769048b6e.11.1738921777776; 
 Fri, 07 Feb 2025 01:49:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFl/DFTa0w5xIODNXFM4VhO/egUF1Uc+ALpzvjkG/y1OjVA+o3Wx9rIIBCcJyWPDpQjcBLDEAm0s4tWW65QJM=
X-Received: by 2002:a05:6808:18a9:b0:3e6:14a6:4288 with SMTP id
 5614622812f47-3f39227835dmr1769044b6e.11.1738921777529; Fri, 07 Feb 2025
 01:49:37 -0800 (PST)
MIME-Version: 1.0
References: <700f4d3bc73f0deebe7fe0e41305d365135c53eb.1738835278.git.jstancek@redhat.com>
 <Z6Sux-uScF-o3g7W@yuki.lan>
 <CAASaF6zuFMWJhph-8U4RRMhd0uHt1_mOVU5Bu0pZ=CVoLf+igw@mail.gmail.com>
 <Z6S3sYucYPK6DuZu@yuki.lan>
In-Reply-To: <Z6S3sYucYPK6DuZu@yuki.lan>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 7 Feb 2025 10:49:20 +0100
X-Gm-Features: AWEUYZnW7P3lznyr4_J8e4v6MxeKOU3NWnkzUEWpZ20g_YS_j3X0s-wTMQtf4ys
Message-ID: <CAASaF6xeWkrSLab=A3J9MFWG-=-9aLTnSw=YVgPcxiwU=bcKLg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -BMccw3-E0yj8kSP83WjvtZOO4EsdgeMAThHD9sd60o_1738921778
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mallinfo02: introduce LTP_VAR_USED to
 avoid optimization
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

T24gVGh1LCBGZWIgNiwgMjAyNSBhdCAyOjIz4oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgo+Cj4gSGkhCj4gPiA+ID4gZ2NjIDE1IGlzIGEgYml0IG1vcmUgY2xldmVy
IGFuZCBub3RpY2VkIHRoYXQgJ2J1ZicgaXNuJ3QgdXNlZAo+ID4gPiA+IGZvciBhbnl0aGluZyBz
byBpdCBvcHRpbWl6ZWQgaXQgb3V0LCBpbmNsdWRpbmcgY2FsbCB0byBtYWxsb2MuCj4gPiA+ID4g
U28sIHRoZXJlJ3MgYWxzbyBubyBtbWFwKCkgY2FsbCBiZWhpbmQgaXQgYW5kIHRlc3QgZmFpbHMs
Cj4gPiA+ID4gYmVjYXVzZSBub3RoaW5nIHdhcyBhbGxvY2F0ZWQuCj4gPiA+Cj4gPiA+IEh1aCwg
dGhhdCBzb3VuZHMgbGlrZSB0aGUgb3B0aW1pemF0aW9ucyBhcmUgZ2V0dGluZyBtb3JlIGFuZCBt
b3JlIGV2aWwKPiA+ID4gb3ZlciB0aGUgdGltZS4KPiA+Cj4gPiBBbHNvIHNlZSB0aGUgbmV4dCBw
YXRjaCBmb3IgYnBmLgo+Cj4gU2lnaC4uLgo+Cj4gPiA+ID4gSW50cm9kdWNlIExUUF9WQVJfVVNF
RCBtYWNybywgdGhhdCBtYWtlcyBjb21waWxlciBhd2FyZSBvZiB0aGUKPiA+ID4gPiB2YXJpYWJs
ZSBhbmQgZG9lc24ndCBvcHRpbWl6ZSBpdCBvdXQuCj4gPiA+ID4KPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBKYW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4KPiA+ID4gPiAtLS0KPiA+ID4g
PiAgaW5jbHVkZS90c3RfY29tbW9uLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAy
ICsrCj4gPiA+ID4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWFsbGluZm8yL21hbGxpbmZv
Ml8wMS5jIHwgMiArLQo+ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQo+ID4gPiA+Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHN0X2Nv
bW1vbi5oIGIvaW5jbHVkZS90c3RfY29tbW9uLmgKPiA+ID4gPiBpbmRleCBiMTRiYmFlMDQwNzcu
LjNkZTgyNmFjZDBlYyAxMDA2NDQKPiA+ID4gPiAtLS0gYS9pbmNsdWRlL3RzdF9jb21tb24uaAo+
ID4gPiA+ICsrKyBiL2luY2x1ZGUvdHN0X2NvbW1vbi5oCj4gPiA+ID4gQEAgLTEzLDYgKzEzLDgg
QEAKPiA+ID4gPiAgI2RlZmluZSBMVFBfQVRUUklCVVRFX1VOVVNFRCAgICAgICAgIF9fYXR0cmli
dXRlX18oKHVudXNlZCkpCj4gPiA+ID4gICNkZWZpbmUgTFRQX0FUVFJJQlVURV9VTlVTRURfUkVT
VUxUICBfX2F0dHJpYnV0ZV9fKCh3YXJuX3VudXNlZF9yZXN1bHQpKQo+ID4gPiA+Cj4gPiA+ID4g
KyNkZWZpbmUgTFRQX1ZBUl9VU0VEKHApIGFzbSB2b2xhdGlsZSgiIiA6OiAibSIocCkpOyBwCj4g
PiA+Cj4gPiA+IFNob3VsZG4ndCBfX2F0dHJpYnV0ZV9fKCh1c2VkKSkgc3VmZmljZT8KPiA+Cj4g
PiBJdCdzIGlnbm9yZWQgZm9yIGxvY2FsIHZhcmlhYmxlcy4gSXQgZG9lcyB3b3JrIGZvciBnbG9i
YWwgb25lcy4KPgo+IE1heWJlIG1lbnRpb24gdGhhdCBpbiB0aGUgY29tbWl0IGRlc2NyaXB0aW9u
Li4uCgpQdXNoZWQgd2l0aCB1cGRhdGVkIGRlc2NyaXB0aW9uLgoKPgo+IFJldmlld2VkLWJ5OiBD
eXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPgo+IC0tCj4gQ3lyaWwgSHJ1YmlzCj4gY2hy
dWJpc0BzdXNlLmN6Cj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
