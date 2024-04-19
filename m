Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C1CC4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 01:50:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66E413CFC01
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 03:50:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C27D63CF3FC
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 03:50:19 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1B2F4200D0E
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 03:50:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713491417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CDzZEkj4fh7NZsXY0HfnPaZZVxAoekyBauFeC05AlOw=;
 b=LGtFNvWO5AO92/soYxes4WbkYhxa5WeNfJOByzHPDSii0fnC5UhaY3YOTLpt+6J69c2/Ks
 FNpHWOaak6wPc0xRJqvckXYmVsKxmWqePApNRjUb+vLnBbN9uL82htLBIATV1rafBtMU54
 e9NpLcc2Ki9gIlHKEDyjEzLRB74bbGI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-7Ujsq6LMMJiNZIG0C0D1yQ-1; Thu, 18 Apr 2024 21:50:15 -0400
X-MC-Unique: 7Ujsq6LMMJiNZIG0C0D1yQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5f7c0bb1b95so496433a12.0
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 18:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713491414; x=1714096214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CDzZEkj4fh7NZsXY0HfnPaZZVxAoekyBauFeC05AlOw=;
 b=ZF0Y9RZgCPjkAEi89Y+hYEfHFASoLoJLI/8MnN5DjRGOkY1wtUZMyyFKPN0P5Y4bGq
 AWuYMiCfhcg7oNxWb6WXtpmIsrKBXQdg4Ym1U1qsqu+fbiZkR9sDzUgGdwMxtq/bQwni
 hhCJgl/SEnnpn5Mw/RIJLKdbBiCyy7VLnU6FPUURARQujl5DbwlpQxyVHaFWqONwJllX
 KF290GQuTlRYsxki00EAzMXw2aMRD1IDVfpT76e4vnXb0cmaN9KLSxk/vZxDr8jZd30R
 +AQJsPS5tzDADiuNMNHIgFnrZXNwo6+OF7KxzhiLlhpotvr0+Zj9kipUnbZc/CarMR6F
 ZlUw==
X-Gm-Message-State: AOJu0YxyEGNJMW5RT3anejIgvUSboh9qFlps4t/cJhzHzlkjkdb4mqCs
 yeMTfOtD2wZzaOOz0CW+sgaIRjyY3S9sHwZsReceQBU/2KByxcY5IFq91w6oaCvjvCvfpdDepxY
 7J4UPpZ/MmlC0aUs9AECKi+dY+NFLaNQN1e4SdGNA5tFPvQdbVTWL10x/e1dN/moo/8QTuVbaIA
 bWsCJjMTKFSxcGUPZs13u/6IM=
X-Received: by 2002:a17:90a:cf04:b0:2a7:329c:7976 with SMTP id
 h4-20020a17090acf0400b002a7329c7976mr1214475pju.8.1713491414024; 
 Thu, 18 Apr 2024 18:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4BuoSz8YXbEyPFW0OGRdC0botnLbQcJMrIyAZRf1ulSf61fvvVaNvNds+unVl/LfoZ6pEP51NXUywvt6KgOw=
X-Received: by 2002:a17:90a:cf04:b0:2a7:329c:7976 with SMTP id
 h4-20020a17090acf0400b002a7329c7976mr1214464pju.8.1713491413682; Thu, 18 Apr
 2024 18:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240418185210.132137-1-pvorel@suse.cz>
 <20240418185210.132137-2-pvorel@suse.cz>
In-Reply-To: <20240418185210.132137-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Apr 2024 09:50:01 +0800
Message-ID: <CAEemH2dw83UCUg7tXnVuKqwDZtFfc8zEWq=SvLuRtzcA_4AV=w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/2] libswap: Add {SAFE_,
 }MAKE_MINIMAL_SWAPFILE() macros
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

SGkgUGV0ciwgQ3lyaWwsCgpUaGUgcGF0Y2hzZXQgZ2VuZXJhbGx5IGxvb2tzIGdvb2QuCgpCdXQg
SSBoYXZlIGEgY29uY2VybiBhYm91dCB0aGUgbWFjcm8gbmFtZSAiTUlOSU1BTCIgd29yZCwKd2hp
Y2ggbWlzbGVkIHBlb3BsZSB0byB0aGluayB0aGF0IGlzIHRoZSBtaW5pbWFsIHN3YXBmaWxlIHNp
emUgd2UKY2FuIG1ha2Ugb24gdGhlIHN5c3RlbSwgYnV0IG9idmlvdXNseSBpdCBpcyBub3QsIHdl
IGNvdWxkIGV2ZW4KY3JlYXRlIGEgc21hbGxlciBvbmUsIHJpZ2h0PwoKQ2FuIHdlIHJlbmFtZSBp
dCB3aXRoIGEgYmV0dGVyIG9uZT8KCgpPbiBGcmksIEFwciAxOSwgMjAyNCBhdCAyOjUy4oCvQU0g
UGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA2NTUzNiBieXRlcyB0cmlnZ2Vy
ZWQgd2FybmluZyBvbiBzeXN0ZW1zIHdpdGggNjRrYiBwYWdlIHNpemUgKGUuZy4gb24KPiBhYXJj
aDY0IHdpdGggQ09ORklHX0FSTTY0XzY0S19QQUdFUz15IG9yIG9uIHBwYzY0bGUgd2l0aAo+IENP
TkZJR19QQUdFX1NJWkVfNjRLQj15KToKPgo+ICAgICBUV0FSTjogU3dhcGZpbGUgc2l6ZSBpcyBs
ZXNzIHRoYW4gdGhlIHN5c3RlbSBwYWdlIHNpemUuIFVzaW5nIHBhZ2Ugc2l6ZQo+ICAgICAoNjU1
MzYgYnl0ZXMpIGluc3RlYWQgb2YgYmxvY2sgc2l6ZSAoNDA5NiBieXRlcykuCj4KPiAxIE1CIHNo
b3VsZCBiZSBvayBmb3IgbW9zdCBvZiB0aGUgc3lzdGVtcy4KPgo+IFN1Z2dlc3RlZC1ieTogQ3ly
aWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+Cj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8
cHZvcmVsQHN1c2UuY3o+Cj4gLS0tCj4gQ2hhbmdlcyB2MS0+djI6Cj4gKiBVc2UgMU1CIGZvciBt
aW5pbWFsIHN3YXAgZmlsZSBpbnN0ZWFkIG9mIHVzaW5nIGRpc2sgYmxvY2sgc2l6ZSBhcyBhCj4g
ICBiYXNlIG1lYXN1cmUgb2Ygc2l6ZSAoQ3lyaWwpCj4KPiAgaW5jbHVkZS9saWJzd2FwLmggfCAx
OCArKysrKysrKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykK
Pgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpYnN3YXAuaCBiL2luY2x1ZGUvbGlic3dhcC5oCj4g
aW5kZXggODdlMzIzMjhlLi4yOGNlNzg0MmQgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saWJzd2Fw
LmgKPiArKysgYi9pbmNsdWRlL2xpYnN3YXAuaAo+IEBAIC0yMyw2ICsyMywyNCBAQCBpbnQgbWFr
ZV9zd2FwZmlsZShjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLAo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKnN3YXBmaWxlLCB1bnNpZ25lZCBpbnQgbnVtLAo+
ICAgICAgICAgICAgICAgICAgICAgICAgIGludCBzYWZlLCBlbnVtIHN3YXBmaWxlX21ldGhvZCBt
ZXRob2QpOwo+Cj4gKy8qIDY1NTM2IGJ5dGVzIGlzIG1pbmltdW0gZm9yIDY0a2IgcGFnZSBzaXpl
LCBsZXQncyB1c2UgMSBNQiAqLwo+ICsjZGVmaW5lIE1JTklNQUxfU1dBUF9TSVpFX01CIDEKPiAr
Cj4gKy8qKgo+ICsgKiBNYWNybyB0byBjcmVhdGUgbWluaW1hbCBzd2FwZmlsZS4KPiArICovCj4g
KyNkZWZpbmUgTUFLRV9NSU5JTUFMX1NXQVBGSUxFKHN3YXBmaWxlKSBcCj4gKyAgICBtYWtlX3N3
YXBmaWxlKF9fRklMRV9fLCBfX0xJTkVfXywgc3dhcGZpbGUsIE1JTklNQUxfU1dBUF9TSVpFX01C
LCAwLCBcCj4gKyAgICAgICAgICAgICAgICAgU1dBUEZJTEVfQllfU0laRSkKPiArCj4gKy8qKgo+
ICsgKiBNYWNybyB0byBjcmVhdGUgbWluaW1hbCBzd2FwZmlsZS4KPiArICogSW5jbHVkZXMgc2Fm
ZXR5IGNoZWNrcyB0byBoYW5kbGUgcG90ZW50aWFsIGVycm9ycy4KPiArICovCj4gKyNkZWZpbmUg
U0FGRV9NQUtFX01JTklNQUxfU1dBUEZJTEUoc3dhcGZpbGUpIFwKPiArICAgIG1ha2Vfc3dhcGZp
bGUoX19GSUxFX18sIF9fTElORV9fLCBzd2FwZmlsZSwgTUlOSU1BTF9TV0FQX1NJWkVfTUIsIDEs
IFwKPiArICAgICAgICAgICAgICAgICBTV0FQRklMRV9CWV9TSVpFKQo+ICsKPiAgLyoqCj4gICAq
IE1hY3JvIHRvIGNyZWF0ZSBzd2FwZmlsZSBzaXplIGluIG1lZ2FieXRlcyAoTUIpLgo+ICAgKi8K
PiAtLQo+IDIuNDMuMAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
