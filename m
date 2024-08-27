Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6669C52D6F
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 08:03:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA4093D2717
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 10:03:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D696A3C7A13
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 10:03:10 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A43B2203C5A
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 10:03:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724745788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ffMGKoiHs0yZ815x5dyOzgYe6p4XSSyZPbsnLGfo48c=;
 b=ahcyZ4ZMC7x4Rf3mcFlzBLh94TdViHaq0kUeqwNqSCFih9Z3CcVhlmLKbkSJ6CrhUq7bsd
 f3xqd/pr2zwHhEbUZFuvKZCAHFgvQHCWpVwqBf1HqWA5msvIhlyicEMaqJpnEcK/EIMkq9
 cLTZ4aT0R7Vuomk0CqlkLC2D9guJltw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-KTObZSHIPayr0M-JizF_dA-1; Tue, 27 Aug 2024 04:03:06 -0400
X-MC-Unique: KTObZSHIPayr0M-JizF_dA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2d3bbfcc5dbso5367888a91.0
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 01:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724745785; x=1725350585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ffMGKoiHs0yZ815x5dyOzgYe6p4XSSyZPbsnLGfo48c=;
 b=P8nbVFY/mynHUwdDwUkLiyN7i44Sj2CIuT81qkjbhMxLzSX0f7xWSSyU/OL/7/KB7o
 38WMS7ck19wS6fqGxIZZ9uwgI9F1HaGa6aOOeI0m+95Kxno886sqR48uuMoZ6sFcB1fw
 h+7H/6eUsE8auxP3Tw9UpRS+FhMvWFuDs6Ib/PgMh6z8sbdsTp+hOfwtv6yBPIE4RWIK
 Z4NMajFvVEsHKICO+2og2BQ3ugG3BDUQp2sdIFnfz67iUZmw6TFri0mgqDQ1C3ezoqfA
 dvx3fxnuOhiD30gw2DWIQSGVwVsvsEwsEA4b+YKfux1Va54l85PF07+BbNike/88YKt1
 PgJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIAzlcZ9qhBK+B5vTyvHf4/xABhbb7xf0GD27XccUU79dnctyHyeG/zOiFkM6mrNd4AaY=@lists.linux.it
X-Gm-Message-State: AOJu0YyUqpkBMDyiSArzzXtsc0qaAwbJUmwT6HxaUMH0bhPZgqUcmQV6
 552rW4pAnsfyKXBHRxgZDrJR7GL3cf3TwiopLO0mUW5OsZOo/e8UiR3kgK9SGY3pU0SfLo5ltGW
 6UwER3RKeiE1vOG5Ey4Ajv+j4L9qZpvkRpAJo76CmywUdyK4xe/hJFcxP1zR3tHeATGk+8HMkdd
 JAz7hc6zVSntxOpXLF6oP0WmQ=
X-Received: by 2002:a17:90a:394c:b0:2c9:e24d:bbaa with SMTP id
 98e67ed59e1d1-2d8259d4663mr2250660a91.27.1724745785151; 
 Tue, 27 Aug 2024 01:03:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCZ0HUn8POci1+wrCfZMzm6mS4ZeB+DcoBO5sIlJ8wwnpW4tPy+dcsyOe2ekJNdcposI/b7etWYGnF60z08I4=
X-Received: by 2002:a17:90a:394c:b0:2c9:e24d:bbaa with SMTP id
 98e67ed59e1d1-2d8259d4663mr2250612a91.27.1724745783995; Tue, 27 Aug 2024
 01:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240827032218.34744-1-liwang@redhat.com>
 <8694fd51-67a2-45e2-bda4-f6816e1d612c@oracle.com>
 <CAEemH2djkWMtuTN2=Y5MXZVOACeCm32_Hh0zAJxH7X4Ss1MSuQ@mail.gmail.com>
 <d431a0a3-a12d-4da0-b8cb-dd349aee8d4d@oracle.com>
In-Reply-To: <d431a0a3-a12d-4da0-b8cb-dd349aee8d4d@oracle.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Aug 2024 16:02:51 +0800
Message-ID: <CAEemH2d9uzDv030eYRs_hsu_PcbVTXR75YPyN4Ux2v9AVxd5Lg@mail.gmail.com>
To: John Garry <john.g.garry@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] loop: Increase bsize variable from unsigned short
 to unsigned int
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
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Sm9obiBHYXJyeSA8am9obi5nLmdhcnJ5QG9yYWNsZS5jb20+IHdyb3RlOgoKPiBPbiAyNy8wOC8y
MDI0IDA4OjM1LCBMaSBXYW5nIHdyb3RlOgo+ID4gT24gVHVlLCBBdWcgMjcsIDIwMjQgYXQgMzoy
MOKAr1BNIEpvaG4gR2FycnkgPGpvaG4uZy5nYXJyeUBvcmFjbGUuY29tPiB3cm90ZToKPiA+Pgo+
ID4+IE9uIDI3LzA4LzIwMjQgMDQ6MjIsIExpIFdhbmcgd3JvdGU6Cj4gPj4KPiA+PiArbGludXgt
YmxvY2ssIEplbnMKPiA+Pgo+ID4+PiBUaGlzIGNoYW5nZSBhbGxvd3MgdGhlIGxvb3BiYWNrIGRy
aXZlciB0byBoYW5kbGUgbGFyZ2VyIGJsb2NrIHNpemVzCj4gPj4KPiA+PiBsYXJnZXIgdGhhbiB3
aGF0PyBQQUdFX1NJWkU/Cj4gPgo+ID4gWWVzLAo+Cj4gUGxlYXNlIHRoZW4gZXhwbGljaXRseSBt
ZW50aW9uIHRoYXQKClN1cmUuCgo+Cj4gPiBzeXN0ZW0gc2hvdWxkIHJldHVybiBFSU5WQUwgd2hl
biB0aGUgdGVzdGVkIGJzaXplIGlzIGxhcmdlciB0aGFuIFBBR0VfU0laRS4KPiA+IEJ1dCBkdWUg
dG8gdGhlIGxvb3BfcmVjb25maWd1cmVfbGltaXRzKCkgY2FzdCBpdCB0byAndW5zaW5lZCBzaG9y
dCcgdGhhdAo+ICA+IG5ldmVyIGdldHMgYW4gZXhwZWN0ZWQgZXJyb3Igd2hlbiB0ZXN0aW5nIGlu
dmFsaWQgbG9naWNhbCBibG9jayBzaXplLj4KPiA+IFRoYXQncyB3aHkgTFRQL2lvY3RsX2xvb3Aw
NiBmYWlsZWQgb24gYSBzeXN0ZW0gd2l0aCA2NGsgKHBwYzY0bGUpIHBhZ2VzaXplCj4gPiAoc2lu
Y2Uga2VybmVsLXY2LjExLXJjMSB3aXRoIHBhdGNoZXMpOgo+ID4KPiA+ICAgIDk0MjNjNjUzZmU2
MTEwICgibG9vcDogRG9uJ3QgYm90aGVyIHZhbGlkYXRpbmcgYmxvY2tzaXplIikKPiA+ICAgIGZl
M2Q1MDhiYTk1YmM2ICgiYmxvY2s6IFZhbGlkYXRlIGxvZ2ljYWwgYmxvY2sgc2l6ZSBpbiBibGtf
dmFsaWRhdGVfbGltaXRzKCkiKQo+ID4KPiA+Cj4gPgo+Cj4gSSBmZWVsIHRoYXQgeW91IHNob3Vs
ZCBiZSBhZGRpbmcgYSBmaXhlcyB0YWcsIGJ1dCBpdCBzZWVtcyB0aGF0IHRob3NlCj4gY29tbWl0
cyBvbmx5IGV4cG9zZSB0aGUgaXNzdWUsIGFuZCB3aGF0ZXZlciBpbnRyb2R1Y2VkIHVuc2lnbmVk
IHNob3J0Cj4gdXNhZ2Ugd2FzIG5vdCByaWdodC4gTWF5YmUgeW91IGNhbiBqdXN0IGdldCB0aGlz
IGluY2x1ZGVkIGZvciA2LjExLAo+IHdoZXJlIDk0MjNjNjUzZmU2MTEwIHdhcyBpbnRyb2R1Y2Vk
LgoKT2ssIHdlIGNhbiBtZW50aW9uIHRoYXQgdHdvIGNvbW1pdHMgZXhwb3NlZCB0aGUgcHJvYmxl
bSBzaW5jZSB2Ni4xMS1yYzEuCkkgd2lsbCBzZW5kIFYyIGluY2x1ZGluZyB0aGF0LiBUaGFua3Mh
CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
