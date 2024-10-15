Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9C8CFC283
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 10:10:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6964E3C6713
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 12:10:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A20943C5ACF
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 12:10:34 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 41D4F1414C43
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 12:10:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728987031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jM+FxdbUrWOIhSbpeJ8RVYv4d2AXspDk9kmAb+p+Ss4=;
 b=MFbCxxpbSpfipncxOGOz1EU66zWDH3nOMVSYP0rhYKvO+QiM4zcJgYkvVf+n0o4LgvEGAF
 MZypKoG9no1HLi32lQZZ+4rESGhlPe1Xx0C6yGXwnwXv8SgdmtYHQV13I2xPC5FzHT/As9
 tNT7rm/T34VaNCFIHYL0DBX1lt8VKl0=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-0YV9DXQkOlarSXUd2WXheA-1; Tue, 15 Oct 2024 06:10:30 -0400
X-MC-Unique: 0YV9DXQkOlarSXUd2WXheA-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-288ba66682dso497004fac.2
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 03:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728987029; x=1729591829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jM+FxdbUrWOIhSbpeJ8RVYv4d2AXspDk9kmAb+p+Ss4=;
 b=VD5I45vw0xJXj7ETNyJTV7zOLPHHTp7Rdkb8oy67UadDZ+4eheDMX3LunjcA4FoLSm
 0efCCTv+356ZOnM7N73jPV8cfb9yHuNs2qKvyMYqBrDym2puZjmZnX4N2AgAMiXlxIvg
 P19awrTM+tDSLon4S0dtREr746OjdXFyhziJ63jxG3GERw+BclZDqbkHKVIozNVnXIBj
 nFL0GXZnJzdADRK//v4EMI2gnPPzc+J/M8ILuDyICx2SOBa+VYHGUa2qyHGoUTxcDkwY
 bEyCGooQZKLA2YzhZfDU8QWa4SGhAKgEJFwtxUViXGBFyJ/N8TXkbRwpJTmyv76gWShZ
 S+Mw==
X-Gm-Message-State: AOJu0YxnelO+9ID9Hk4VHNItYbsTA+fALKPKU9F4rnZyZI72QPuVOOCB
 hp/XTj2Kp3gFhoHWZSRqdOqxAO7OeSHLcmOp5X3451mgWbwX+XF2aIOD0h8wa236OpQqvx0mufg
 pLZ1sywNVHQDoOXx0XqJqSrm2fGeQKFtRP9Jf3SBTFDDCLvJO6r7lKYG6UX3wbLbMDicVnNjCbu
 GAvz4wPP4QKOfS9h1hb/J82m0=
X-Received: by 2002:a05:6870:ac1f:b0:278:22d3:53 with SMTP id
 586e51a60fabf-28887330a75mr6273435fac.12.1728987029415; 
 Tue, 15 Oct 2024 03:10:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/s9Eu9K28qc58fP+BUwnebBRW04GpNVL4ero0kZnuz5yqM86wWmq3hBuLnFOv8+IuuGBobRq/0x6DDEBBwhw=
X-Received: by 2002:a05:6870:ac1f:b0:278:22d3:53 with SMTP id
 586e51a60fabf-28887330a75mr6273422fac.12.1728987029001; Tue, 15 Oct 2024
 03:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <892adc7c5b174221bf10e796ad29adaaf1559e5c.1728978957.git.jstancek@redhat.com>
 <Zw46_xyBaWFPMShv@yuki.lan>
In-Reply-To: <Zw46_xyBaWFPMShv@yuki.lan>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 15 Oct 2024 12:10:04 +0200
Message-ID: <CAASaF6wY8AHH76YVf+UtJrcXtRL9d+UcR4rDf6S96EJiroPnKg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statmount07: drop "invalid buffer size"
 test
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

T24gVHVlLCBPY3QgMTUsIDIwMjQgYXQgMTE6NTLigK9BTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cj4KPiBIaSEKPiA+IFRoZSBtYW5wYWdlIGRvZXNuJ3Qgc2F5IHRoYXQg
J3NtYnVmJyBuZWVkcyB0byBiZSB2YWxpZAo+ID4gZm9yIGVudGlyZSByYW5nZSBvZiAnYnVmc2l6
ZScuCj4gPgo+ID4gVGhpcyBjaGVjayByZWxpZXMgb24gYWNjZXNzX29rKCkgY2hlY2ssIHdoaWNo
IGNhbiBiZSBza2lwcGVkCj4gPiBvbiBzb21lIGFyY2hlcy9jb25maWdzLCBmb3IgZXhhbXBsZSBv
biBzMzkweCB3aXRoCj4gPiBDT05GSUdfQUxURVJOQVRFX1VTRVJfQUREUkVTU19TUEFDRT15LiBU
ZXN0IHRoZW4gZmFpbHMgd2l0aDoKPiA+ICAgc3RhdG1vdW50MDcuYzoxMTc6IFRGQUlMOiBpbnZh
bGlkIGJ1ZmZlciBzaXplIHN1Y2NlZWRlZAo+Cj4gQW5kIGRvZXMgaXQgZmFpbCBsYXRlciBvbiBp
biB0aGUgY29weV90b191c2VyKCkgaWYgdGhlIGJ1ZmZlciBpcwo+IHBoeXNpY2FsbHkgbm90IGFj
Y2VzaWJsZT8KPgo+IFdlIG1heSBhZGQgYSB0ZXN0IHRoYXQgd291bGQgbG9vayBsaWtlOgo+Cj4g
fCBwYWdlIG1hcHBlZCBydyB8IHBhZ2UgbWFwcGVkIHJlYWQgb25seSB8Cj4gICAgICAgICAgICAg
IF4KPiAgICAgICAgICAgICAgYnVmIHBvaW50ZXIgc3RhcnRzIGhlcmUKPgo+IFdoYXQgZG8geW91
IHRoaW5rPwoKd2UgY2FuIGFkZCB0aGF0LCBpdCB3b3VsZCBiZSB2YXJpYXRpb24gb2YgImludmFs
aWQgYnVmZmVyIHBvaW50ZXIiIHRlc3QKCj4KPiAtLQo+IEN5cmlsIEhydWJpcwo+IGNocnViaXNA
c3VzZS5jego+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
